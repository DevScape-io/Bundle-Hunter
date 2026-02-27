//
//  SearchHistory.swift
//  Bundle Hunter
//
//  Created by Parker Howell on 2/26/26.
//

import Foundation
import SwiftData

@Model
final class SearchHistory {
    var searchTerm: String
    var timestamp: Date
    var bundleId: String
    var appName: String
    var artworkUrl: String
    
    init(searchTerm: String, timestamp: Date, bundleId: String, appName: String, artworkUrl: String) {
        self.searchTerm = searchTerm
        self.timestamp = timestamp
        self.bundleId = bundleId
        self.appName = appName
        self.artworkUrl = artworkUrl
    }
}
