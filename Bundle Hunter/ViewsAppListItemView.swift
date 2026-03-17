//
//  AppListItemView.swift
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

struct AppListItemView: View {
    let app: AppInfo
    
    var body: some View {
        HStack(spacing: 12) {
            // App Icon
            AsyncImage(url: URL(string: app.artworkUrl100)) { phase in
                switch phase {
                case .empty:
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(Color(nsColor: .quaternaryLabelColor).opacity(0.2))
                        .frame(width: 52, height: 52)
                        .overlay {
                            ProgressView()
                                .controlSize(.small)
                        }
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 52, height: 52)
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        .shadow(color: .black.opacity(0.08), radius: 3, y: 2)
                case .failure:
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(Color(nsColor: .quaternaryLabelColor).opacity(0.2))
                        .frame(width: 52, height: 52)
                        .overlay {
                            Image(systemName: "app.dashed")
                                .font(.system(size: 20))
                                .foregroundStyle(.quaternary)
                        }
                @unknown default:
                    EmptyView()
                }
            }
            
            VStack(alignment: .leading, spacing: 5) {
                HStack(spacing: 6) {
                    Text(app.trackName)
                        .font(.system(size: 13, weight: .medium))
                        .lineLimit(1)
                        .foregroundStyle(.primary)
                    
                    // Platform badge
                    ForEach(app.supportedPlatforms, id: \.self) { platform in
                        platformBadge(for: platform)
                    }
                }
                
                Text(app.artistName)
                    .font(.system(size: 12))
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
                
                Text(app.bundleId)
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundStyle(.tertiary)
                    .lineLimit(1)
            }
            
            Spacer(minLength: 0)
        }
        .padding(.vertical, 6)
        .padding(.horizontal, 4)
    }
    
    private func platformBadge(for platform: AppInfo.Platform) -> some View {
        Text(platform.rawValue)
            .font(.system(size: 8, weight: .semibold))
            .padding(.horizontal, 5)
            .padding(.vertical, 2)
            .background(platform == .macOS ? Color.blue.opacity(0.15) : Color.green.opacity(0.15))
            .foregroundStyle(platform == .macOS ? .blue : .green)
            .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
    }
}
