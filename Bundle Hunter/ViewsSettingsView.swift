//
//  SettingsView.swift
//  Bundle Hunter
//
//  Created by Parker Howell on 2/26/26.
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
