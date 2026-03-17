//
//  SettingsView.swift
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

struct SettingsView: View {
    @AppStorage("searchCountry") private var searchCountry = "US"
    
    private let countries = [
        ("US", "United States"),
        ("GB", "United Kingdom"),
        ("CA", "Canada"),
        ("AU", "Australia"),
        ("DE", "Germany"),
        ("FR", "France"),
        ("JP", "Japan"),
        ("CN", "China"),
        ("IN", "India"),
    ]
    
    var body: some View {
        Form {
            Section {
                Picker("App Store Region:", selection: $searchCountry) {
                    ForEach(countries, id: \.0) { code, name in
                        Text(name).tag(code)
                    }
                }
                .pickerStyle(.menu)
                
                Text("Choose which regional App Store to search")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            } header: {
                Text("Search Settings")
            }
            
            Section {
                HStack {
                    Text("Version:")
                    Spacer()
                    Text("1.0")
                        .foregroundStyle(.secondary)
                }
                
                HStack {
                    Text("Build:")
                    Spacer()
                    Text("1")
                        .foregroundStyle(.secondary)
                }
            } header: {
                Text("About")
            }
        }
        .formStyle(.grouped)
        .frame(width: 450, height: 300)
    }
}

#Preview {
    SettingsView()
}
