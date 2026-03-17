//
//  SearchHistory.swift
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
