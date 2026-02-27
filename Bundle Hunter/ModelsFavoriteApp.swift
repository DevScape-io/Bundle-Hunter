//
//  FavoriteApp.swift
//  Bundle Hunter
//
//  Created by Parker Howell on 2/26/26.
//

import Foundation
import SwiftData

@Model
final class FavoriteApp {
    var bundleId: String
    var appName: String
    var artistName: String
    var artworkUrl: String
    var timestamp: Date
    var trackId: Int
    var kind: String? // "software" for iOS, "mac-software" for macOS
    
    init(bundleId: String, appName: String, artistName: String, artworkUrl: String, trackId: Int, kind: String? = nil) {
        self.bundleId = bundleId
        self.appName = appName
        self.artistName = artistName
        self.artworkUrl = artworkUrl
        self.timestamp = Date()
        self.trackId = trackId
        self.kind = kind
    }
}
