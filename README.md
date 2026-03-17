# Bundle Hunter 🎯

A modern, award-winning macOS application for discovering bundle IDs and detailed information about iOS and macOS applications available on the App Store.

## Features ✨

### Core Functionality
- **🔍 Smart Search**: Search by app name or paste App Store links directly
- **📦 Bundle ID Discovery**: Quickly find and copy bundle identifiers
- **📊 Comprehensive Details**: View technical specs, pricing, ratings, and more
- **⏰ Search History**: Automatically tracks your searches for quick access
- **🌍 Multi-Region Support**: Search across different App Store regions

### Technical Information Displayed
- Bundle Identifier (easily copyable)
- App Version & Track ID
- File Size & Minimum OS Version
- Release Date & Last Update
- Price & Currency
- Developer/Seller Name
- Content Rating
- User Ratings & Review Count
- Full App Description
- High-resolution App Icon

### Design Highlights
- **Native macOS Design**: Follows Apple's Human Interface Guidelines
- **Split View Layout**: Efficient sidebar and detail view
- **Unified Toolbar**: Modern window chrome with integrated search
- **System Materials**: Proper use of macOS visual effects
- **Responsive**: Adapts to window resizing gracefully
- **Dark Mode**: Full support for light and dark appearances

## Architecture 🏗️

The app is built using modern Apple frameworks and follows best practices:

### Technology Stack
- **SwiftUI**: Modern, declarative UI
- **Swift Data**: Persistent search history storage
- **Swift Concurrency**: Async/await for network calls
- **iTunes Search API**: Official Apple API for app metadata

### Project Structure
```
Bundle Hunter/
├── Models/
│   ├── AppInfo.swift          # App data model
│   └── SearchHistory.swift    # Search history persistence
├── Services/
│   └── AppStoreService.swift  # API communication layer
├── Views/
│   ├── ContentView.swift      # Main app view
│   ├── SearchView.swift       # Search bar component
│   ├── AppListItemView.swift  # Sidebar list items
│   ├── AppDetailView.swift    # Detail view with all info
│   ├── EmptyStateView.swift   # Empty state displays
│   └── SettingsView.swift     # App settings
└── Bundle_HunterApp.swift     # App entry point
```

## How to Use 📖

1. **Search by Name**: Type any app name in the search bar and press Enter
2. **Search by Link**: Paste an App Store URL (works with various formats)
3. **View Details**: Click any result to see full information
4. **Copy Bundle ID**: Use the prominent "Copy" button to copy the bundle ID
5. **Access History**: Toggle to the "History" tab to revisit previous searches
6. **Settings**: Use ⌘, to access settings and change the App Store region

### Supported URL Formats
- `https://apps.apple.com/us/app/app-name/id123456789`
- `https://itunes.apple.com/us/app/app-name/id123456789`
- Any URL containing an App Store ID

## API Usage 🌐

Bundle Hunter uses the public iTunes Search API, which doesn't require authentication:
- Endpoint: `https://itunes.apple.com/search`
- Rate Limits: Apple's standard rate limiting applies
- Privacy: All searches are direct to Apple's servers

## Requirements 📋

- macOS 14.0 or later
- Swift 5.9+
- Xcode 15.0+

## Building & Running 🚀

1. Clone the repository
2. Open `Bundle Hunter.xcodeproj` in Xcode
3. Select your Mac as the target
4. Press ⌘R to build and run

No additional dependencies or setup required!

## Privacy 🔒

- No analytics or tracking
- No user data collected
- Search history stored locally only (using SwiftData)
- All API calls go directly to Apple's servers
- No third-party services

## Future Enhancements 💡

Potential features for future versions:
- Export search results to CSV/JSON
- Bulk bundle ID lookup
- Compare multiple apps side-by-side
- App Store Connect integration
- Custom keyboard shortcuts
- Share sheet integration
- Spotlight integration

## Credits 👏

Built with love using:
- SwiftUI for the interface
- iTunes Search API for data
- SF Symbols for icons
- SwiftData for persistence

## License 📄

[Your chosen license here]

---

**Made with ❤️ for macOS developers**
