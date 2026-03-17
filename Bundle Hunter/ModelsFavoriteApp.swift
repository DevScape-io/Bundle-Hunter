//
//  FavoriteApp.swift
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
