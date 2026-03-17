//
//  Bundle_HunterApp.swift
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

@main
struct Bundle_HunterApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            SearchHistory.self,
            FavoriteApp.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
        .windowStyle(.hiddenTitleBar)
        .windowToolbarStyle(.unified)
        .defaultSize(width: 1100, height: 700)
        .commands {
            CommandGroup(replacing: .newItem) {
                // Remove default New command
            }
            
            CommandMenu("Search") {
                Button("Focus Search Field") {
                    // This would be handled by the ContentView
                }
                .keyboardShortcut("f", modifiers: .command)
                
                Divider()
                
                Button("Clear Search Results") {
                    NotificationCenter.default.post(name: .clearSearchResults, object: nil)
                }
                .keyboardShortcut("k", modifiers: [.command, .shift])
            }
            
            CommandMenu("History") {
                Button("Show History") {
                    NotificationCenter.default.post(name: .showHistory, object: nil)
                }
                .keyboardShortcut("h", modifiers: [.command, .shift])
                
                Button("Clear History") {
                    NotificationCenter.default.post(name: .clearHistory, object: nil)
                }
                .keyboardShortcut(.delete, modifiers: [.command, .option])
            }
        }
        
        Settings {
            SettingsView()
        }
    }
}
// Notification names for menu commands
extension Notification.Name {
    static let clearSearchResults = Notification.Name("clearSearchResults")
    static let showHistory = Notification.Name("showHistory")
    static let clearHistory = Notification.Name("clearHistory")
}

