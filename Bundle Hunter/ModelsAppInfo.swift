//
//  AppInfo.swift
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

import Foundation

/// Represents an iOS or macOS application from the App Store
struct AppInfo: Identifiable, Codable, Hashable {
    let trackId: Int
    let bundleId: String
    
    // Identifiable conformance - use trackId as the id
    var id: Int { trackId }
    let trackName: String
    let artistName: String
    let primaryGenreName: String
    let artworkUrl100: String
    let artworkUrl512: String
    let version: String
    let releaseDate: String
    let description: String
    let fileSizeBytes: String?
    let averageUserRating: Double?
    let userRatingCount: Int?
    let trackViewUrl: String
    let minimumOsVersion: String?
    let price: Double
    let currency: String
    let contentAdvisoryRating: String?
    let sellerName: String?
    let screenshotUrls: [String]?
    let ipadScreenshotUrls: [String]?
    let appletvScreenshotUrls: [String]?
    let genres: [String]?
    let languageCodesISO2A: [String]?
    let currentVersionReleaseDate: String?
    let releaseNotes: String?
    let supportedDevices: [String]?
    let kind: String?
    
    var formattedFileSize: String {
        guard let bytes = fileSizeBytes, let bytesInt = Int(bytes) else {
            return "Unknown"
        }
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = [.useGB, .useMB]
        formatter.countStyle = .file
        return formatter.string(fromByteCount: Int64(bytesInt))
    }
    
    var formattedReleaseDate: String {
        let formatter = ISO8601DateFormatter()
        if let date = formatter.date(from: releaseDate) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateStyle = .medium
            displayFormatter.timeStyle = .none
            return displayFormatter.string(from: date)
        }
        return releaseDate
    }
    
    var formattedCurrentVersionDate: String? {
        guard let currentVersionDate = currentVersionReleaseDate else { return nil }
        let formatter = ISO8601DateFormatter()
        if let date = formatter.date(from: currentVersionDate) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateStyle = .medium
            displayFormatter.timeStyle = .none
            return displayFormatter.string(from: date)
        }
        return currentVersionDate
    }
    
    var formattedPrice: String {
        if price == 0 {
            return "Free"
        }
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currency
        return formatter.string(from: NSNumber(value: price)) ?? "\(currency) \(price)"
    }
    
    var allScreenshots: [String] {
        var screenshots: [String] = []
        if let urls = screenshotUrls {
            screenshots.append(contentsOf: urls)
        }
        if let urls = ipadScreenshotUrls {
            screenshots.append(contentsOf: urls)
        }
        if let urls = appletvScreenshotUrls {
            screenshots.append(contentsOf: urls)
        }
        return screenshots
    }
    
    var supportedLanguages: String {
        guard let languages = languageCodesISO2A else { return "Unknown" }
        return "\(languages.count) languages"
    }
    
    /// Determine the primary platform(s) this app supports
    var supportedPlatforms: [Platform] {
        var platforms: [Platform] = []
        
        // Check kind field first (most reliable)
        if let kind = kind {
            if kind == "mac-software" {
                return [.macOS]
            }
        }
        
        // Fall back to supportedDevices analysis
        guard let devices = supportedDevices, !devices.isEmpty else {
            // If no device info, assume iOS (legacy behavior)
            return [.iOS]
        }
        
        let deviceSet = Set(devices.map { $0.lowercased() })
        
        // Check for iPhone/iPad devices
        let hasIPhoneOrIPad = deviceSet.contains { device in
            device.contains("iphone") || device.contains("ipad") || device.contains("ipod")
        }
        
        if hasIPhoneOrIPad {
            platforms.append(.iOS)
        }
        
        // Note: macOS apps typically don't have supportedDevices array
        // They're identified by kind == "mac-software"
        
        return platforms.isEmpty ? [.iOS] : platforms
    }
    
    var platformDisplayText: String {
        let platforms = supportedPlatforms
        if platforms.count == 1 {
            return platforms[0].rawValue
        } else {
            return platforms.map { $0.rawValue }.joined(separator: ", ")
        }
    }
    
    enum Platform: String {
        case iOS = "iOS"
        case macOS = "macOS"
    }
}

/// Response from iTunes Search API
struct iTunesSearchResponse: Codable {
    let resultCount: Int
    let results: [AppInfo]
}
