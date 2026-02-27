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
    
    init(bundleId: String, appName: String, artistName: String, artworkUrl: String, trackId: Int) {
        self.bundleId = bundleId
        self.appName = appName
        self.artistName = artistName
        self.artworkUrl = artworkUrl
        self.timestamp = Date()
        self.trackId = trackId
    }
}
