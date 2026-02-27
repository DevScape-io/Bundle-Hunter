# macOS App Support & Platform Filtering

## Overview

Bundle Hunter now supports searching for both iOS and macOS applications from the App Store, with filtering capabilities to narrow searches by platform.

## Key Features

### 1. Platform Filtering

A new segmented control has been added to the search interface with three options:

- **All Platforms** - Searches both iOS and macOS apps
- **iOS & iPadOS** - Only searches iOS/iPadOS apps
- **macOS** - Only searches macOS apps

The filter is located below the search bar and above the view tabs (Results/History/Favorites).

### 2. Platform Detection

Apps are automatically categorized by platform using:

- The `kind` field from the iTunes Search API (most reliable for macOS apps)
- The `supportedDevices` array for iOS apps
- Fallback logic for legacy data

### 3. Visual Platform Indicators

Platform badges are displayed in:

- **Search results list** - Small colored badges next to app names
  - Blue badge for macOS
  - Green badge for iOS
- **App detail view** - Platform field in the Technical Information section

### 4. Enhanced Search Capabilities

The iTunes Search API now queries both:
- `software` entity (iOS apps)
- `macSoftware` entity (macOS apps)

Based on the selected platform filter.

## Technical Details

### Modified Files

1. **ModelsAppInfo.swift**
   - Added `supportedDevices` and `kind` properties
   - Added `supportedPlatforms` computed property for platform detection
   - Added `platformDisplayText` for UI display
   - Added `Platform` enum (iOS, macOS)

2. **ServicesAppStoreService.swift**
   - Added `PlatformFilter` enum with three filter options
   - Modified search URLs to include appropriate entity types
   - Updated `lookupApp` and `searchByName` methods

3. **ContentView.swift**
   - Added platform filter picker to the sidebar
   - Added automatic re-search when filter changes (if results exist)

4. **ViewsAppDetailView.swift**
   - Added platform field to Technical Information section
   - Updated preview with new required fields

5. **ViewsAppListItemView.swift**
   - Added platform badges next to app names
   - Color-coded badges (blue for macOS, green for iOS)

### iTunes Search API Parameters

**All Platforms:**
```
entity=software,macSoftware
```

**iOS Only:**
```
entity=software
```

**macOS Only:**
```
entity=macSoftware
```

## Usage Examples

### Searching for macOS Apps

1. Select "macOS" from the platform filter
2. Search for "Xcode" or paste an App Store URL
3. Results will only show macOS applications

### Searching All Platforms

1. Select "All Platforms" (default)
2. Search for "Safari"
3. Results may include both iOS and macOS versions

### Filtering Existing Results

If you have search results displayed:
- Changing the platform filter automatically re-runs the search
- This allows quick filtering without re-typing the search term

## Platform Detection Logic

```swift
// Priority 1: Check kind field
if kind == "mac-software" {
    return [.macOS]
}

// Priority 2: Check supportedDevices array
if devices contains iPhone/iPad devices {
    return [.iOS]
}

// Fallback: Assume iOS
return [.iOS]
```

## Future Enhancements

Potential improvements for consideration:

1. **tvOS Support** - Add Apple TV apps
2. **watchOS Support** - Add Apple Watch apps  
3. **Universal Apps** - Better detection of apps available on multiple platforms
4. **Platform-Specific Screenshots** - Group screenshots by platform
5. **Minimum OS Badges** - Show minimum OS version in badges
6. **Advanced Filters** - Combine platform with price, rating, etc.

## Known Limitations

1. **Cross-Platform Apps**: Some apps available on both platforms may only show once depending on the API response
2. **Historical Data**: Apps in search history won't automatically update their platform information
3. **Universal Purchase**: Apps supporting universal purchase may require multiple API calls to get complete info

## Testing

To test macOS app support:

1. Search for known macOS apps:
   - Xcode
   - Final Cut Pro
   - Logic Pro
   - GarageBand
   - Pages, Numbers, Keynote

2. Test the platform filter:
   - Search "GarageBand" with "All Platforms"
   - Switch to "macOS" only
   - Switch to "iOS & iPadOS" only

3. Verify badges appear correctly in results

## API Reference

For more information on the iTunes Search API:
- [Apple iTunes Search API Documentation](https://developer.apple.com/library/archive/documentation/AudioVideo/Conceptual/iTuneSearchAPI/)
