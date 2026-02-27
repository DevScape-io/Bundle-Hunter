//
//  QUICK_START.md
//  Bundle Hunter
//
//  Created by Parker Howell on 2/26/26.
//

# Quick Start Guide

## 🚀 Getting Started

Your Bundle Hunter app is ready to run! Here's what you need to know:

## Project Files Overview

### Core App Files
- **Bundle_HunterApp.swift** - Main app entry point with window configuration
- **ContentView.swift** - Main interface with split view layout

### Models
- **AppInfo.swift** - Represents an app from the App Store with all its metadata
- **SearchHistory.swift** - SwiftData model for persisting search history

### Services
- **AppStoreService.swift** - Handles all iTunes Search API communication
  - Supports both app name searches and App Store URL parsing
  - Extracts app IDs from various URL formats

### Views
- **AppDetailView.swift** - Beautiful detail view showing all app information
- **AppListItemView.swift** - Sidebar list item with icon and info
- **SearchView.swift** - Search bar component (integrated into ContentView)
- **EmptyStateView.swift** - Reusable empty state component
- **SettingsView.swift** - Settings window for region selection

## Key Features Implemented

### ✅ Search Functionality
```swift
// Search by app name
"Xcode"

// Or paste an App Store URL
"https://apps.apple.com/us/app/xcode/id497799835"
```

### ✅ Keyboard Shortcuts
- `⌘F` - Focus search field
- `⌘⇧K` - Clear search results
- `⌘⇧H` - Show history
- `⌘⌥⌫` - Clear history (with confirmation)
- `⌘,` - Open settings

### ✅ Data Display
The detail view shows:
- High-resolution app icon (512x512)
- Bundle ID with prominent copy button
- Version, file size, minimum OS
- Track ID, seller name, content rating
- Release date, category, price
- User rating and review count
- Full app description
- Link to App Store

### ✅ Search History
- Automatically saved when you view an app
- Accessible via the History tab
- Shows relative time (e.g., "5 minutes ago")
- Swipe to delete individual entries
- Clear all history option with confirmation

### ✅ Settings
- Choose App Store region (US, UK, Canada, etc.)
- Affects search results for regional apps
- Persisted using @AppStorage

## Design Principles Used

### 🎨 Apple Human Interface Guidelines
1. **Native Controls** - Uses standard macOS components
2. **System Colors** - Adapts to light/dark mode automatically
3. **SF Symbols** - Consistent iconography
4. **Typography** - System fonts with proper hierarchy
5. **Spacing** - Comfortable padding and margins

### 🏗️ Architecture
1. **MVVM Pattern** - Models, Views, and ViewModels (via @StateObject)
2. **Swift Concurrency** - Async/await for network calls
3. **SwiftData** - Modern persistence layer
4. **Dependency Injection** - Environment for model context

## Testing the App

### Quick Test Steps
1. Build and run the app (⌘R)
2. Type "Xcode" in the search bar and press Enter
3. Click on the result to see details
4. Click "Copy" button next to Bundle ID
5. Check History tab to see your search
6. Try pasting an App Store URL

### Example Searches to Try
- **Popular Apps**: "Safari", "Pages", "GarageBand"
- **App Store URLs**: Paste any link from apps.apple.com
- **Multi-word**: "Microsoft Word", "Adobe Photoshop"

## Customization Ideas

### Easy Modifications
1. **Add More Countries**: Edit `SettingsView.swift` countries array
2. **Change Window Size**: Modify `.defaultSize()` in app file
3. **Adjust Colors**: Modify background colors in views
4. **Add Export Feature**: Implement CSV/JSON export of search results

### Advanced Enhancements
1. **Bulk Lookup**: Add ability to search multiple apps at once
2. **Comparison View**: Compare specs between multiple apps
3. **Favorites**: Star apps for quick access
4. **App Store Connect**: Integrate with App Store Connect API
5. **Widget**: Create a widget for quick bundle ID lookup

## Troubleshooting

### Common Issues

**Problem**: Search returns no results
- **Solution**: Check your internet connection
- **Solution**: Try searching in a different region (Settings)
- **Solution**: Verify the app exists on that regional App Store

**Problem**: App Store URL not recognized
- **Solution**: Make sure the URL contains an app ID (e.g., id123456789)
- **Solution**: Try searching by app name instead

**Problem**: Build errors
- **Solution**: Make sure you're targeting macOS 14.0+
- **Solution**: Clean build folder (⌘⇧K) and rebuild

## API Information

### iTunes Search API
- **Documentation**: https://developer.apple.com/library/archive/documentation/AudioVideo/Conceptual/iTuneSearchAPI/
- **Base URL**: https://itunes.apple.com/search
- **Rate Limits**: Approximately 20 calls per minute (Apple's limit)
- **Authentication**: None required (public API)

### Response Data
The API returns JSON with these key fields:
- `bundleId` - The bundle identifier
- `trackName` - App name
- `artistName` - Developer name
- `artworkUrl100/512` - App icons
- `version` - Current version
- `releaseDate` - ISO 8601 date
- And many more fields (see AppInfo.swift)

## Next Steps

1. **Run the app** - Press ⌘R in Xcode
2. **Try different searches** - Test various apps and URLs
3. **Customize** - Adjust colors, spacing, or add features
4. **Deploy** - Archive and distribute your app

## Support & Resources

- Apple Human Interface Guidelines: https://developer.apple.com/design/human-interface-guidelines/macos
- SwiftUI Documentation: https://developer.apple.com/documentation/swiftui
- SwiftData Documentation: https://developer.apple.com/documentation/swiftdata

---

**Happy coding! 🎉**

If you have questions or want to add features, the code is well-commented and follows standard SwiftUI patterns.
