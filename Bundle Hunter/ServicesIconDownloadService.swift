//
//  IconDownloadService.swift
//  Bundle Hunter
//
//  Created by Parker Howell on 3/17/26.
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

import AppKit
import Foundation
import UniformTypeIdentifiers

/// Service for downloading and saving app icons
@MainActor
class IconDownloadService {
    
    enum IconError: LocalizedError {
        case invalidURL
        case downloadFailed
        case imageConversionFailed
        case saveFailed
        
        var errorDescription: String? {
            switch self {
            case .invalidURL:
                return "Invalid icon URL"
            case .downloadFailed:
                return "Failed to download icon"
            case .imageConversionFailed:
                return "Failed to convert image to PNG format"
            case .saveFailed:
                return "Failed to save icon file"
            }
        }
    }
    
    /// Downloads the app icon and saves it as a 512x512 PNG file
    /// - Parameters:
    ///   - urlString: The URL string of the icon (typically artworkUrl512)
    ///   - appName: The app name to use for the filename
    /// - Returns: The URL of the saved file
    func downloadAndSaveIcon(from urlString: String, appName: String) async throws -> URL {
        // Validate URL
        guard let url = URL(string: urlString) else {
            throw IconError.invalidURL
        }
        
        // Download image data
        let (data, _) = try await URLSession.shared.data(from: url)
        
        guard let nsImage = NSImage(data: data) else {
            throw IconError.downloadFailed
        }
        
        // Convert to 512x512 PNG
        guard let pngData = createPNGData(from: nsImage, size: NSSize(width: 512, height: 512)) else {
            throw IconError.imageConversionFailed
        }
        
        // Create filename
        let sanitizedName = sanitizeFilename(appName)
        let filename = "\(sanitizedName)_icon_512x512.png"
        
        // Show save panel
        let savePanel = NSSavePanel()
        savePanel.allowedContentTypes = [.png]
        savePanel.canCreateDirectories = true
        savePanel.isExtensionHidden = false
        savePanel.nameFieldStringValue = filename
        savePanel.title = "Save App Icon"
        savePanel.message = "Choose where to save the app icon"
        
        let response = await savePanel.begin()
        
        guard response == .OK, let saveURL = savePanel.url else {
            throw IconError.saveFailed
        }
        
        // Write the file
        try pngData.write(to: saveURL)
        
        return saveURL
    }
    
    /// Creates PNG data from an NSImage at the specified size
    private func createPNGData(from image: NSImage, size: NSSize) -> Data? {
        // Create a bitmap representation
        let targetSize = size
        let bitmapRep = NSBitmapImageRep(
            bitmapDataPlanes: nil,
            pixelsWide: Int(targetSize.width),
            pixelsHigh: Int(targetSize.height),
            bitsPerSample: 8,
            samplesPerPixel: 4,
            hasAlpha: true,
            isPlanar: false,
            colorSpaceName: .deviceRGB,
            bytesPerRow: 0,
            bitsPerPixel: 0
        )
        
        guard let bitmap = bitmapRep else { return nil }
        
        bitmap.size = targetSize
        
        NSGraphicsContext.saveGraphicsState()
        NSGraphicsContext.current = NSGraphicsContext(bitmapImageRep: bitmap)
        
        // Draw the image at the target size
        image.draw(
            in: NSRect(origin: .zero, size: targetSize),
            from: NSRect(origin: .zero, size: image.size),
            operation: .copy,
            fraction: 1.0
        )
        
        NSGraphicsContext.restoreGraphicsState()
        
        // Convert to PNG data
        return bitmap.representation(using: .png, properties: [:])
    }
    
    /// Sanitizes a filename by removing invalid characters
    private func sanitizeFilename(_ name: String) -> String {
        let invalidCharacters = CharacterSet(charactersIn: ":/\\?%*|\"<>")
        return name
            .components(separatedBy: invalidCharacters)
            .joined(separator: "_")
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
