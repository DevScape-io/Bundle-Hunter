//
//  ContentView.swift
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

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var appStoreService = AppStoreService()
    
    @Query(sort: \FavoriteApp.timestamp, order: .reverse) private var favorites: [FavoriteApp]
    
    @State private var searchText = ""
    @State private var selectedApp: AppInfo?
    @FocusState private var searchFieldFocused: Bool
    
    var body: some View {
        NavigationSplitView {
            sidebarContent
        } detail: {
            detailContent
        }
        .frame(minWidth: 900, minHeight: 600)
        .onReceive(NotificationCenter.default.publisher(for: .clearSearchResults)) { _ in
            clearSearchResults()
        }
    }
    
    private var sidebarContent: some View {
        VStack(spacing: 0) {
            // Search bar
            searchBarSection
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .padding(.bottom, 12)
            
            // Platform filter - styled as pills
            platformFilterPillsSection
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
            
            Divider()
            
            // Content area - automatically shows favorites or search results
            contentArea
        }
        .navigationSplitViewColumnWidth(min: 280, ideal: 320, max: 400)
    }
    
    // MARK: - Content Area (Automatic Display)
    
    private var contentArea: some View {
        Group {
            // Automatically show favorites when search is empty, otherwise show search results
            if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                // Show favorites or empty state
                if !favorites.isEmpty {
                    filteredFavoritesList
                } else {
                    EmptyStateView(
                        icon: "magnifyingglass",
                        title: "Start Searching",
                        subtitle: "Enter an app name or paste an App Store link to find bundle information"
                    )
                }
            } else {
                // Show search results when user is typing
                searchResultsList
            }
        }
    }
    
    // MARK: - Filtered Favorites List
    
    private var filteredFavoritesList: some View {
        Group {
            let filtered = filteredFavorites
            
            if filtered.isEmpty {
                EmptyStateView(
                    icon: "star.slash",
                    title: "No Favorites for \(appStoreService.platformFilter.rawValue)",
                    subtitle: "You don't have any \(appStoreService.platformFilter.rawValue) apps favorited yet"
                )
            } else {
                List {
                    ForEach(filtered) { favorite in
                        Button(action: {
                            loadFromFavorite(favorite)
                        }) {
                            HStack(spacing: 12) {
                                AsyncImage(url: URL(string: favorite.artworkUrl)) { phase in
                                    switch phase {
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 40, height: 40)
                                            .clipShape(RoundedRectangle(cornerRadius: 8))
                                    default:
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(.quaternary)
                                            .frame(width: 40, height: 40)
                                    }
                                }
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(favorite.appName)
                                        .font(.system(size: 13, weight: .medium))
                                        .lineLimit(1)
                                    
                                    Text(favorite.artistName)
                                        .font(.system(size: 11))
                                        .foregroundStyle(.secondary)
                                        .lineLimit(1)
                                    
                                    Text(favorite.bundleId)
                                        .font(.system(size: 10, design: .monospaced))
                                        .foregroundStyle(.tertiary)
                                        .lineLimit(1)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .contentShape(Rectangle())
                        }
                        .buttonStyle(.plain)
                    }
                    .onDelete(perform: deleteFavorites)
                }
                .listStyle(.sidebar)
            }
        }
    }
    
    // MARK: - Filtered Favorites Computed Property
    
    private var filteredFavorites: [FavoriteApp] {
        switch appStoreService.platformFilter {
        case .all:
            return favorites
        case .iOS:
            // Filter for iOS apps using the kind property
            return favorites.filter { favorite in
                if let kind = favorite.kind {
                    // "software" is iOS, exclude "mac-software"
                    return kind == "software"
                } else {
                    // Fallback to bundle ID heuristic for older favorites without kind
                    return !favorite.bundleId.localizedCaseInsensitiveContains("mac") &&
                           !favorite.bundleId.localizedCaseInsensitiveContains("macos")
                }
            }
        case .macOS:
            // Filter for macOS apps using the kind property
            return favorites.filter { favorite in
                if let kind = favorite.kind {
                    // "mac-software" is macOS
                    return kind == "mac-software"
                } else {
                    // Fallback to bundle ID heuristic for older favorites without kind
                    return favorite.bundleId.localizedCaseInsensitiveContains("mac") ||
                           favorite.bundleId.localizedCaseInsensitiveContains("macos")
                }
            }
        }
    }
    
    // MARK: - Search Bar Section
    
    private var searchBarSection: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.tertiary)
                .font(.system(size: 13, weight: .medium))
            
            TextField("Search apps", text: $searchText, prompt: Text("Search by name or paste App Store link"))
                .textFieldStyle(.plain)
                .font(.system(size: 13))
                .focused($searchFieldFocused)
                .onSubmit(performSearch)
            
            if !searchText.isEmpty {
                Button(action: { 
                    withAnimation(.snappy(duration: 0.2)) {
                        searchText = ""
                    }
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.quaternary)
                        .font(.system(size: 14))
                }
                .buttonStyle(.plain)
                .transition(.scale.combined(with: .opacity))
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 7)
        .background(Color(nsColor: .controlBackgroundColor))
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .strokeBorder(Color(nsColor: .separatorColor).opacity(0.5), lineWidth: 0.5)
        )
    }
    
    // MARK: - Platform Filter Section (Pill Style)
    
    private var platformFilterPillsSection: some View {
        HStack(spacing: 6) {
            ForEach(AppStoreService.PlatformFilter.allCases, id: \.self) { filter in
                platformPill(filter: filter)
            }
        }
    }
    
    private func platformPill(filter: AppStoreService.PlatformFilter) -> some View {
        Button(action: {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                appStoreService.platformFilter = filter
                if !searchText.isEmpty && !appStoreService.searchResults.isEmpty {
                    performSearch()
                }
            }
        }) {
            Text(filter.rawValue)
                .font(.system(size: 12, weight: appStoreService.platformFilter == filter ? .semibold : .medium))
                .foregroundStyle(appStoreService.platformFilter == filter ? Color.white : Color.secondary)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .frame(maxWidth: .infinity)
                .background {
                    if appStoreService.platformFilter == filter {
                        RoundedRectangle(cornerRadius: 6, style: .continuous)
                            .fill(Color.accentColor)
                    } else {
                        RoundedRectangle(cornerRadius: 6, style: .continuous)
                            .fill(Color(nsColor: .controlBackgroundColor).opacity(0.5))
                    }
                }
        }
        .buttonStyle(.plain)
        .disabled(appStoreService.isLoading)
        .opacity(appStoreService.isLoading ? 0.5 : 1.0)
    }
    
    private var searchResultsList: some View {
        Group {
            if appStoreService.isLoading {
                VStack {
                    ProgressView()
                        .scaleEffect(0.8)
                    Text("Searching...")
                        .font(.system(size: 12))
                        .foregroundStyle(.secondary)
                        .padding(.top, 8)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let error = appStoreService.errorMessage {
                EmptyStateView(
                    icon: "exclamationmark.triangle",
                    title: "Search Failed",
                    subtitle: error
                )
            } else if appStoreService.searchResults.isEmpty {
                EmptyStateView(
                    icon: "magnifyingglass",
                    title: "No Results",
                    subtitle: "No apps found matching your search"
                )
            } else {
                List(selection: $selectedApp) {
                    ForEach(appStoreService.searchResults) { app in
                        AppListItemView(app: app)
                            .tag(app)
                            .onTapGesture {
                                selectedApp = app
                            }
                    }
                }
                .listStyle(.sidebar)
            }
        }
    }
    
    private var favoritesList: some View {
        Group {
            if favorites.isEmpty {
                EmptyStateView(
                    icon: "star",
                    title: "No Favorites",
                    subtitle: "Apps you favorite will appear here for quick access"
                )
            } else {
                List {
                    ForEach(favorites) { favorite in
                        Button(action: {
                            loadFromFavorite(favorite)
                        }) {
                            HStack(spacing: 12) {
                                AsyncImage(url: URL(string: favorite.artworkUrl)) { phase in
                                    switch phase {
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 40, height: 40)
                                            .clipShape(RoundedRectangle(cornerRadius: 8))
                                    default:
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(.quaternary)
                                            .frame(width: 40, height: 40)
                                    }
                                }
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(favorite.appName)
                                        .font(.system(size: 13, weight: .medium))
                                        .lineLimit(1)
                                    
                                    Text(favorite.artistName)
                                        .font(.system(size: 11))
                                        .foregroundStyle(.secondary)
                                        .lineLimit(1)
                                    
                                    Text(favorite.bundleId)
                                        .font(.system(size: 10, design: .monospaced))
                                        .foregroundStyle(.tertiary)
                                        .lineLimit(1)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .contentShape(Rectangle())
                        }
                        .buttonStyle(.plain)
                    }
                    .onDelete(perform: deleteFavorites)
                }
                .listStyle(.sidebar)
            }
        }
    }
    
    private var detailContent: some View {
        Group {
            if let app = selectedApp {
                AppDetailView(app: app)
            } else {
                EmptyStateView(
                    icon: "app.badge",
                    title: "No App Selected",
                    subtitle: "Search for an app to view its bundle ID and details"
                )
            }
        }
    }
    
    private func performSearch() {
        guard !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return
        }
        
        selectedApp = nil
        
        Task {
            await appStoreService.search(query: searchText)
        }
    }
    
    private func loadFromFavorite(_ favorite: FavoriteApp) {
        // Directly look up the app by its track ID (more accurate than searching by name)
        selectedApp = nil
        
        Task {
            await appStoreService.lookupById(String(favorite.trackId))
            
            // After lookup, if we got results, select the first one
            if let app = appStoreService.searchResults.first {
                selectedApp = app
            }
        }
    }
    
    private func deleteFavorites(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(favorites[index])
            }
        }
    }
    
    private func clearSearchResults() {
        withAnimation {
            searchText = ""
            selectedApp = nil
            appStoreService.searchResults = []
            appStoreService.errorMessage = nil
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: SearchHistory.self, inMemory: true)
}


