//
//
//  AppDetailView.swift
//  Bundle Hunter
//
//  Created by Parker Howell on 2/26/26.
//
//  Copyright 2026 Bundle Hunter
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import SwiftUI
import SwiftData

struct AppDetailView: View {
    let app: AppInfo
    @Environment(\.modelContext) private var modelContext
    @Query private var favorites: [FavoriteApp]
    
    @State private var copiedField: String?
    @State private var showingScreenshots = false
    
    var isFavorite: Bool {
        favorites.contains { $0.bundleId == app.bundleId }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                // Header with app icon and basic info
                headerSection
                    .padding(.horizontal, 32)
                    .padding(.top, 32)
                    .padding(.bottom, 24)
                
                Divider()
                    .padding(.horizontal, 32)
                
                // Bundle ID (Primary focus)
                bundleIDSection
                    .padding(.horizontal, 32)
                    .padding(.vertical, 24)
                
                Divider()
                    .padding(.horizontal, 32)
                
                // Technical Information
                technicalInfoSection
                    .padding(.horizontal, 32)
                    .padding(.vertical, 24)
                
                Divider()
                    .padding(.horizontal, 32)
                
                // App Store Information
                appStoreSection
                    .padding(.horizontal, 32)
                    .padding(.vertical, 24)
                
                // Ratings & Reviews
                if app.averageUserRating != nil {
                    Divider()
                        .padding(.horizontal, 32)
                    
                    ratingsSection
                        .padding(.horizontal, 32)
                        .padding(.vertical, 24)
                }
                
                // Screenshots
                if !app.allScreenshots.isEmpty {
                    Divider()
                        .padding(.horizontal, 32)
                    
                    screenshotsSection
                        .padding(.horizontal, 32)
                        .padding(.vertical, 24)
                }
                
                // Release Notes
                if let notes = app.releaseNotes {
                    Divider()
                        .padding(.horizontal, 32)
                    
                    releaseNotesSection(notes: notes)
                        .padding(.horizontal, 32)
                        .padding(.vertical, 24)
                }
                
                Divider()
                    .padding(.horizontal, 32)
                
                // Description
                descriptionSection
                    .padding(.horizontal, 32)
                    .padding(.vertical, 24)
                
                Divider()
                    .padding(.horizontal, 32)
                
                // Privacy & Languages
                privacySection
                    .padding(.horizontal, 32)
                    .padding(.vertical, 24)
                    .padding(.bottom, 32)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color(nsColor: .textBackgroundColor))
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(action: toggleFavorite) {
                    Label(isFavorite ? "Remove from Favorites" : "Add to Favorites",
                          systemImage: isFavorite ? "star.fill" : "star")
                }
                .help(isFavorite ? "Remove from Favorites" : "Add to Favorites")
            }
        }
    }
    
    private var headerSection: some View {
        HStack(alignment: .top, spacing: 20) {
            // App Icon
            AsyncImage(url: URL(string: app.artworkUrl512)) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 128, height: 128)
                        .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
                        .shadow(color: .black.opacity(0.15), radius: 12, y: 6)
                default:
                    RoundedRectangle(cornerRadius: 28, style: .continuous)
                        .fill(Color(nsColor: .quaternaryLabelColor).opacity(0.3))
                        .frame(width: 128, height: 128)
                        .overlay {
                            Image(systemName: "app.dashed")
                                .font(.system(size: 40))
                                .foregroundStyle(.quaternary)
                        }
                }
            }
            
            VStack(alignment: .leading, spacing: 12) {
                // App name with copy button
                HStack(alignment: .firstTextBaseline, spacing: 8) {
                    Text(app.trackName)
                        .font(.system(size: 28, weight: .bold))
                        .textSelection(.enabled)
                    
                    Button(action: { copyToClipboard(app.trackName, field: "appName") }) {
                        Image(systemName: copiedField == "appName" ? "checkmark.circle.fill" : "doc.on.doc")
                            .foregroundStyle(copiedField == "appName" ? .green : .secondary)
                            .font(.system(size: 14))
                            .contentTransition(.symbolEffect(.replace))
                    }
                    .buttonStyle(.plain)
                    .help("Copy app name")
                }
                
                // Developer name with copy button
                HStack(alignment: .firstTextBaseline, spacing: 6) {
                    Text(app.artistName)
                        .font(.system(size: 15))
                        .foregroundStyle(.secondary)
                        .textSelection(.enabled)
                    
                    Button(action: { copyToClipboard(app.artistName, field: "developer") }) {
                        Image(systemName: copiedField == "developer" ? "checkmark.circle.fill" : "doc.on.doc")
                            .foregroundStyle(copiedField == "developer" ? .green : .secondary)
                            .font(.system(size: 12))
                            .contentTransition(.symbolEffect(.replace))
                    }
                    .buttonStyle(.plain)
                    .help("Copy developer name")
                }
                
                // Metadata row
                HStack(spacing: 16) {
                    // Rating
                    if let rating = app.averageUserRating {
                        HStack(spacing: 4) {
                            Image(systemName: "star.fill")
                                .foregroundStyle(.yellow)
                                .font(.system(size: 12))
                            Text(String(format: "%.1f", rating))
                                .font(.system(size: 13, weight: .semibold))
                            if let count = app.userRatingCount {
                                Text("(\(count.formatted()))")
                                    .font(.system(size: 13))
                                    .foregroundStyle(.tertiary)
                            }
                        }
                    }
                    
                    // Category
                    HStack(spacing: 4) {
                        Image(systemName: "tag")
                            .foregroundStyle(.secondary)
                            .font(.system(size: 11))
                        Text(app.primaryGenreName)
                            .font(.system(size: 13))
                            .foregroundStyle(.secondary)
                    }
                    
                    // Price
                    Text(app.formattedPrice)
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(app.price == 0 ? .green : .primary)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 3)
                        .background(app.price == 0 ? Color.green.opacity(0.1) : Color.primary.opacity(0.06))
                        .clipShape(Capsule())
                }
                .padding(.top, 2)
                
                // View on App Store link
                Link(destination: URL(string: app.trackViewUrl)!) {
                    HStack(spacing: 6) {
                        Image(systemName: "arrow.up.forward.app.fill")
                            .font(.system(size: 11))
                        Text("View on App Store")
                            .font(.system(size: 13, weight: .medium))
                    }
                }
                .buttonStyle(.plain)
                .foregroundStyle(.blue)
                .padding(.top, 4)
            }
            
            Spacer()
        }
    }
    
    private var bundleIDSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Bundle Identifier")
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(.secondary)
                .textCase(.uppercase)
                .tracking(0.5)
            
            HStack(spacing: 12) {
                Text(app.bundleId)
                    .font(.system(size: 15, weight: .medium, design: .monospaced))
                    .textSelection(.enabled)
                    .foregroundStyle(.primary)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(Color(nsColor: .controlBackgroundColor))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .strokeBorder(Color(nsColor: .separatorColor).opacity(0.5), lineWidth: 1)
                    )
                
                Button(action: { copyToClipboard(app.bundleId, field: "bundleId") }) {
                    HStack(spacing: 6) {
                        Image(systemName: copiedField == "bundleId" ? "checkmark" : "doc.on.doc")
                            .contentTransition(.symbolEffect(.replace))
                        Text(copiedField == "bundleId" ? "Copied" : "Copy")
                    }
                    .font(.system(size: 13, weight: .medium))
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
            }
        }
    }
    
    private var technicalInfoSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Technical Information")
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(.secondary)
                .textCase(.uppercase)
                .tracking(0.5)
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], alignment: .leading, spacing: 12) {
                CopyableInfoField(
                    label: "Platform",
                    value: app.platformDisplayText,
                    copiedField: $copiedField,
                    fieldId: "platform",
                    onCopy: copyToClipboard
                )
                
                CopyableInfoField(
                    label: "Version",
                    value: app.version,
                    monospaced: true,
                    copiedField: $copiedField,
                    fieldId: "version",
                    onCopy: copyToClipboard
                )
                
                CopyableInfoField(
                    label: "File Size",
                    value: app.formattedFileSize,
                    copiedField: $copiedField,
                    fieldId: "fileSize",
                    onCopy: copyToClipboard
                )
                
                if let minOS = app.minimumOsVersion {
                    CopyableInfoField(
                        label: "Minimum OS",
                        value: minOS,
                        monospaced: true,
                        copiedField: $copiedField,
                        fieldId: "minOS",
                        onCopy: copyToClipboard
                    )
                }
                
                CopyableInfoField(
                    label: "Track ID",
                    value: "\(app.trackId)",
                    monospaced: true,
                    copiedField: $copiedField,
                    fieldId: "trackId",
                    onCopy: copyToClipboard
                )
                
                if let seller = app.sellerName {
                    CopyableInfoField(
                        label: "Seller",
                        value: seller,
                        copiedField: $copiedField,
                        fieldId: "seller",
                        onCopy: copyToClipboard
                    )
                }
                
                if let rating = app.contentAdvisoryRating {
                    CopyableInfoField(
                        label: "Content Rating",
                        value: rating,
                        copiedField: $copiedField,
                        fieldId: "contentRating",
                        onCopy: copyToClipboard
                    )
                }
            }
        }
    }
    
    private var appStoreSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("App Store Details")
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(.secondary)
                .textCase(.uppercase)
                .tracking(0.5)
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], alignment: .leading, spacing: 12) {
                CopyableInfoField(
                    label: "Release Date",
                    value: app.formattedReleaseDate,
                    copiedField: $copiedField,
                    fieldId: "releaseDate",
                    onCopy: copyToClipboard
                )
                
                if let versionDate = app.formattedCurrentVersionDate {
                    CopyableInfoField(
                        label: "Current Version Date",
                        value: versionDate,
                        copiedField: $copiedField,
                        fieldId: "versionDate",
                        onCopy: copyToClipboard
                    )
                }
                
                CopyableInfoField(
                    label: "Category",
                    value: app.primaryGenreName,
                    copiedField: $copiedField,
                    fieldId: "category",
                    onCopy: copyToClipboard
                )
                
                CopyableInfoField(
                    label: "Price",
                    value: app.formattedPrice,
                    copiedField: $copiedField,
                    fieldId: "price",
                    onCopy: copyToClipboard
                )
                
                if let genres = app.genres, genres.count > 1 {
                    CopyableInfoField(
                        label: "All Genres",
                        value: genres.joined(separator: ", "),
                        copiedField: $copiedField,
                        fieldId: "genres",
                        onCopy: copyToClipboard
                    )
                }
            }
        }
    }
    
    private var ratingsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Ratings & Reviews")
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(.secondary)
                .textCase(.uppercase)
                .tracking(0.5)
            
            if let rating = app.averageUserRating {
                HStack(spacing: 24) {
                    VStack(spacing: 6) {
                        Text(String(format: "%.1f", rating))
                            .font(.system(size: 56, weight: .bold, design: .rounded))
                        
                        HStack(spacing: 3) {
                            ForEach(1...5, id: \.self) { star in
                                Image(systemName: star <= Int(rating.rounded()) ? "star.fill" : "star")
                                    .foregroundStyle(.yellow)
                                    .font(.system(size: 14))
                            }
                        }
                        
                        if let count = app.userRatingCount {
                            Text("\(count.formatted()) Ratings")
                                .font(.system(size: 12))
                                .foregroundStyle(.secondary)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 8)
                }
                .padding(20)
                .background(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(Color(nsColor: .controlBackgroundColor))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .strokeBorder(Color(nsColor: .separatorColor).opacity(0.3), lineWidth: 1)
                )
            }
        }
    }
    
    private var screenshotsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Screenshots")
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(.secondary)
                .textCase(.uppercase)
                .tracking(0.5)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(Array(app.allScreenshots.prefix(10).enumerated()), id: \.offset) { index, urlString in
                        AsyncImage(url: URL(string: urlString)) { phase in
                            switch phase {
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 240)
                                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                                    .shadow(color: .black.opacity(0.12), radius: 8, y: 4)
                            case .empty:
                                RoundedRectangle(cornerRadius: 12, style: .continuous)
                                    .fill(Color(nsColor: .quaternaryLabelColor).opacity(0.2))
                                    .frame(width: 140, height: 240)
                                    .overlay {
                                        ProgressView()
                                            .controlSize(.small)
                                    }
                            case .failure:
                                RoundedRectangle(cornerRadius: 12, style: .continuous)
                                    .fill(Color(nsColor: .quaternaryLabelColor).opacity(0.2))
                                    .frame(width: 140, height: 240)
                                    .overlay {
                                        Image(systemName: "photo")
                                            .font(.system(size: 24))
                                            .foregroundStyle(.quaternary)
                                    }
                            @unknown default:
                                EmptyView()
                            }
                        }
                    }
                }
            }
            
            if app.allScreenshots.count > 10 {
                Text("Showing 10 of \(app.allScreenshots.count) screenshots")
                    .font(.system(size: 11))
                    .foregroundStyle(.tertiary)
            }
        }
    }
    
    private func releaseNotesSection(notes: String) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("What's New")
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(.secondary)
                .textCase(.uppercase)
                .tracking(0.5)
            
            Text(notes)
                .font(.system(size: 14))
                .foregroundStyle(.primary)
                .textSelection(.enabled)
                .lineSpacing(4)
                .padding(16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(Color(nsColor: .controlBackgroundColor))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .strokeBorder(Color(nsColor: .separatorColor).opacity(0.3), lineWidth: 1)
                )
        }
    }
    
    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Description")
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(.secondary)
                .textCase(.uppercase)
                .tracking(0.5)
            
            Text(app.description)
                .font(.system(size: 14))
                .foregroundStyle(.primary)
                .textSelection(.enabled)
                .lineSpacing(4)
                .padding(16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(Color(nsColor: .controlBackgroundColor))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .strokeBorder(Color(nsColor: .separatorColor).opacity(0.3), lineWidth: 1)
                )
        }
    }
    
    private var privacySection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Additional Information")
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(.secondary)
                .textCase(.uppercase)
                .tracking(0.5)
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], alignment: .leading, spacing: 12) {
                CopyableInfoField(
                    label: "Supported Languages",
                    value: app.supportedLanguages,
                    copiedField: $copiedField,
                    fieldId: "languages",
                    onCopy: copyToClipboard
                )
                
                CopyableInfoField(
                    label: "App Store URL",
                    value: app.trackViewUrl,
                    monospaced: false,
                    copiedField: $copiedField,
                    fieldId: "storeUrl",
                    onCopy: copyToClipboard
                )
            }
            
            HStack(spacing: 6) {
                Image(systemName: "info.circle")
                    .font(.system(size: 11))
                    .foregroundStyle(.tertiary)
                Text("Privacy information can be viewed on the App Store page")
                    .font(.system(size: 11))
                    .foregroundStyle(.tertiary)
            }
            .padding(.top, 8)
        }
    }
    
    private func copyToClipboard(_ text: String, field: String) {
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.setString(text, forType: .string)
        
        copiedField = field
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if copiedField == field {
                copiedField = nil
            }
        }
    }
    
    private func toggleFavorite() {
        if let favorite = favorites.first(where: { $0.bundleId == app.bundleId }) {
            modelContext.delete(favorite)
        } else {
            let favorite = FavoriteApp(
                bundleId: app.bundleId,
                appName: app.trackName,
                artistName: app.artistName,
                artworkUrl: app.artworkUrl512,
                trackId: app.trackId,
                kind: app.kind
            )
            modelContext.insert(favorite)
        }
    }
}

/// Reusable component for displaying copyable information fields
struct CopyableInfoField: View {
    let label: String
    let value: String
    var monospaced: Bool = false
    @Binding var copiedField: String?
    let fieldId: String
    let onCopy: (String, String) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label)
                .font(.system(size: 11, weight: .medium))
                .foregroundStyle(.tertiary)
                .textCase(.uppercase)
                .tracking(0.3)
            
            HStack(alignment: .top, spacing: 8) {
                Text(value)
                    .font(.system(size: 14, weight: .regular, design: monospaced ? .monospaced : .default))
                    .textSelection(.enabled)
                    .foregroundStyle(.primary)
                    .lineLimit(3)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Button(action: { onCopy(value, fieldId) }) {
                    Image(systemName: copiedField == fieldId ? "checkmark.circle.fill" : "doc.on.doc")
                        .foregroundStyle(copiedField == fieldId ? .green : .secondary)
                        .font(.system(size: 13))
                        .contentTransition(.symbolEffect(.replace))
                }
                .buttonStyle(.plain)
                .help("Copy \(label)")
            }
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(Color(nsColor: .controlBackgroundColor))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .strokeBorder(Color(nsColor: .separatorColor).opacity(0.3), lineWidth: 0.5)
        )
    }
}

#Preview {
    AppDetailView(app: AppInfo(
        trackId: 497799835,
        bundleId: "com.apple.dt.Xcode",
        trackName: "Xcode",
        artistName: "Apple Inc.",
        primaryGenreName: "Developer Tools",
        artworkUrl100: "",
        artworkUrl512: "",
        version: "15.0",
        releaseDate: "2023-09-18T07:00:00Z",
        description: "Xcode includes everything developers need to create great applications for Mac, iPhone, iPad, Apple TV, and Apple Watch.",
        fileSizeBytes: "10000000000",
        averageUserRating: 4.5,
        userRatingCount: 1000,
        trackViewUrl: "https://apps.apple.com/app/xcode/id497799835",
        minimumOsVersion: "13.5",
        price: 0,
        currency: "USD",
        contentAdvisoryRating: "4+",
        sellerName: "Apple Inc.",
        screenshotUrls: [],
        ipadScreenshotUrls: [],
        appletvScreenshotUrls: [],
        genres: ["Developer Tools", "Productivity"],
        languageCodesISO2A: ["EN"],
        currentVersionReleaseDate: "2023-09-18T07:00:00Z",
        releaseNotes: "Bug fixes and improvements",
        supportedDevices: nil,
        kind: "mac-software"
    ))
    .modelContainer(for: FavoriteApp.self, inMemory: true)
}

