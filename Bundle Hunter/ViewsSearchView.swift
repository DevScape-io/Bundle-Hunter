//
//  SearchView.swift
//  Bundle Hunter
//
//  Created by Parker Howell on 2/26/26.
//

import SwiftUI

struct SearchView: View {
    @Binding var searchText: String
    let onSearch: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.secondary)
            
            TextField("Search by app name or paste App Store link", text: $searchText)
                .textFieldStyle(.plain)
                .font(.system(size: 14))
                .onSubmit(onSearch)
            
            if !searchText.isEmpty {
                Button(action: { searchText = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.secondary)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(10)
        .background(.quinary)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
