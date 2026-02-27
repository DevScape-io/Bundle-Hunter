//
//  AppStoreService.swift
//  Bundle Hunter
//
//  Created by Parker Howell on 2/26/26.
//

import Foundation
import Observation
import Combine

@MainActor
@Observable
class AppStoreService {
    var searchResults: [AppInfo] = []
    var isLoading = false
    var errorMessage: String?
    var platformFilter: PlatformFilter = .all
    
    enum PlatformFilter: String, CaseIterable {
        case all = "All Platforms"
        case iOS = "iOS & iPadOS"
        case macOS = "macOS"
        
        var entity: String {
            switch self {
            case .all:
                return "software,macSoftware"
            case .iOS:
                return "software"
            case .macOS:
                return "macSoftware"
            }
        }
    }
    
    /// Search for apps by name or extract App Store ID from URL
    func search(query: String, country: String = "US") async {
        isLoading = true
        errorMessage = nil
        
        defer { isLoading = false }
        
        // Check if query is an App Store URL
        if let appId = extractAppId(from: query) {
            await lookupApp(id: appId, country: country)
        } else {
            await searchByName(query: query, country: country)
        }
    }
    
    /// Extract App Store ID from URL
    private func extractAppId(from urlString: String) -> String? {
        // Handle various App Store URL formats:
        // https://apps.apple.com/us/app/app-name/id123456789
        // https://itunes.apple.com/us/app/app-name/id123456789
        
        let patterns = [
            #"id(\d+)"#,
            #"/app/id(\d+)"#,
            #"/(\d+)\?mt=8"#
        ]
        
        for pattern in patterns {
            if let regex = try? NSRegularExpression(pattern: pattern),
               let match = regex.firstMatch(in: urlString, range: NSRange(urlString.startIndex..., in: urlString)),
               let range = Range(match.range(at: 1), in: urlString) {
                return String(urlString[range])
            }
        }
        
        return nil
    }
    
    /// Look up app by ID (more accurate)
    private func lookupApp(id: String, country: String) async {
        let entity = platformFilter.entity
        let urlString = "https://itunes.apple.com/lookup?id=\(id)&country=\(country)&entity=\(entity)"
        
        guard let url = URL(string: urlString) else {
            errorMessage = "Invalid URL"
            return
        }
        
        print("🌐 Attempting to fetch: \(urlString)")
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            if let httpResponse = response as? HTTPURLResponse {
                print("✅ HTTP Status: \(httpResponse.statusCode)")
            }
            
            print("📦 Received \(data.count) bytes")
            
            let searchResponse = try JSONDecoder().decode(iTunesSearchResponse.self, from: data)
            
            if searchResponse.results.isEmpty {
                errorMessage = "No app found with this ID"
            } else {
                print("🎉 Successfully parsed \(searchResponse.results.count) result(s)")
                searchResults = searchResponse.results
            }
        } catch let error as NSError {
            print("❌ Network Error: \(error)")
            print("   Domain: \(error.domain)")
            print("   Code: \(error.code)")
            print("   Description: \(error.localizedDescription)")
            errorMessage = "Failed to fetch app information: \(error.localizedDescription)"
        }
    }
    
    /// Search by app name
    private func searchByName(query: String, country: String) async {
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? query
        let entity = platformFilter.entity
        let urlString = "https://itunes.apple.com/search?term=\(encodedQuery)&country=\(country)&entity=\(entity)&limit=25"
        
        guard let url = URL(string: urlString) else {
            errorMessage = "Invalid search query"
            return
        }
        
        print("🔍 Searching for: \(query)")
        print("🌐 URL: \(urlString)")
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            if let httpResponse = response as? HTTPURLResponse {
                print("✅ HTTP Status: \(httpResponse.statusCode)")
            }
            
            print("📦 Received \(data.count) bytes")
            
            let searchResponse = try JSONDecoder().decode(iTunesSearchResponse.self, from: data)
            
            if searchResponse.results.isEmpty {
                errorMessage = "No apps found matching '\(query)'"
            } else {
                print("🎉 Found \(searchResponse.results.count) result(s)")
                searchResults = searchResponse.results
            }
        } catch let error as NSError {
            print("❌ Search Error: \(error)")
            print("   Domain: \(error.domain)")
            print("   Code: \(error.code)")
            print("   Description: \(error.localizedDescription)")
            errorMessage = "Search failed: \(error.localizedDescription)"
        }
    }
}
