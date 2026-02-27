# Bundle Hunter - Complete Feature Guide 🎯

## iTunes Search API Explanation

### What is it?
The **iTunes Search API** is Apple's free, public REST API that provides access to App Store metadata. No authentication required!

### How it Works

**Search by Name:**
```
https://itunes.apple.com/search?term=xcode&country=us&entity=software&limit=25
```

**Lookup by ID:**
```
https://itunes.apple.com/lookup?id=497799835&country=us&entity=software
```

### What Data You Get

The API returns comprehensive app information in JSON format:

```json
{
  "resultCount": 1,
  "results": [{
    "bundleId": "com.apple.dt.Xcode",
    "trackName": "Xcode",
    "artistName": "Apple Inc.",
    "version": "15.0",
    "description": "...",
    "fileSizeBytes": "10000000000",
    "averageUserRating": 4.5,
    "userRatingCount": 1000,
    "screenshotUrls": ["..."],
    "artworkUrl512": "...",
    // ... and much more!
  }]
}
```

### Data Included:
✅ **Basic Info:** App name, developer, bundle ID  
✅ **Technical:** Version, file size, minimum OS  
✅ **Visual:** App icon (60px, 100px, 512px), Screenshots  
✅ **Store Data:** Price, currency, release date  
✅ **Reviews:** Average rating, rating count  
✅ **Content:** Description, release notes  
✅ **Categories:** Primary genre, all genres  
✅ **Localization:** Supported languages  
✅ **Age Rating:** Content advisory rating  

### What's NOT Included:
❌ Detailed privacy labels (only available via App Store page)  
❌ In-app purchase details  
❌ Historical version information  
❌ Developer contact information  

---

## 🌟 Complete Feature List

### 1. Smart Search
- **By App Name:** Type "Safari", "Xcode", "Microsoft Word"
- **By App Store URL:** Paste any App Store link
  - `https://apps.apple.com/us/app/xcode/id497799835`
  - `https://itunes.apple.com/us/app/app-name/id123456`
- **Multiple Results:** Shows all matching apps, you select the one you want
- **Regional Search:** Search different App Store regions (Settings)

### 2. One-Click Copy for Every Field

Every piece of information has a copy button that:
- Copies to clipboard instantly
- Shows ✓ confirmation for 2 seconds
- Works with single click
- Individual tooltips for each field

**Copyable Fields:**
- App Name
- Developer Name
- Bundle ID (prominent button)
- Version
- File Size
- Minimum OS
- Track ID
- Seller Name
- Content Rating
- Release Date
- Current Version Date
- Category
- All Genres
- Price
- Supported Languages
- App Store URL

### 3. Comprehensive Information Display

#### Header Section
- 512×512 high-resolution app icon
- App name (copyable)
- Developer name (copyable)
- Star rating with count
- Primary category
- Price (Free or formatted with currency)
- Direct "View on App Store" link

#### Technical Information
- Version number
- File size (formatted: GB/MB)
- Minimum OS requirement
- Track ID (App Store identifier)
- Seller name
- Content/Age rating

#### App Store Details
- Initial release date
- Current version release date
- Primary category
- All categories/genres
- Price and currency
- Rating count

#### Ratings & Reviews
- Large rating display (e.g., 4.5)
- Visual star representation (★★★★☆)
- Total number of ratings
- Formatted as "1,234 Ratings"

#### Screenshots
- Horizontal scrolling gallery
- iPhone screenshots
- iPad screenshots (if available)
- Apple TV screenshots (if available)
- Shows first 10 with count indicator
- Rounded corners with shadows
- Loading states and error handling

#### What's New (Release Notes)
- Current version release notes
- Formatted text display
- Selectable text for copying

#### Description
- Full app description from App Store
- Selectable text
- Properly formatted

#### Privacy & Languages
- Number of supported languages
- App Store URL (copyable)
- Note about privacy details on App Store
- All categories

### 4. Search History
- **Automatic Saving:** Every app you view is saved
- **Smart Updates:** Re-viewing updates timestamp
- **Display Info:**
  - App name
  - Bundle ID
  - Relative time ("5 minutes ago", "2 hours ago")
- **Management:**
  - Swipe to delete individual items
  - "Clear All" with confirmation dialog
  - Sorted by most recent first
- **Quick Access:** Click any history item to re-search

### 5. Favorites System
- **Star Icon:** Add/remove favorites from detail view toolbar
- **Persistent Storage:** Saved with SwiftData
- **Rich Display:**
  - App icon thumbnail
  - App name
  - Developer name
  - Bundle ID
- **Management:**
  - Swipe to delete
  - Sorted by date added
- **Quick Access:** Click to instantly search and view

### 6. Three-Tab Interface

**Results Tab:**
- Shows search results (up to 25 apps)
- Multiple results when name matches several apps
- Select the exact app you want
- Loading indicator during search
- Error messages if search fails
- Empty state with helpful instructions

**History Tab:**
- All previously viewed apps
- Chronological order (newest first)
- Quick re-search functionality
- Delete management

**Favorites Tab:**
- Starred apps for quick access
- Visual grid with icons
- One-click access to any favorite
- Delete management

### 7. Modern macOS Design

#### Interface
- **Unified Toolbar:** Hidden title bar, modern look
- **Split View:** Sidebar (280-400px) + Detail pane
- **Responsive:** Adapts to window resizing
- **Minimum Size:** 900×600px
- **Default Size:** 1100×700px

#### Visual Design
- **System Materials:** Proper semantic colors
- **Dark Mode:** Full support, automatic switching
- **SF Symbols:** Professional icons throughout
- **Rounded Corners:** 6-8px radius on cards
- **Shadows:** Subtle depth on images
- **Padding:** Comfortable 12-24px spacing

#### Typography
- **Headings:** System Bold, 16-24pt
- **Body:** System Regular, 13-14pt
- **Monospace:** Used for Bundle IDs, version numbers
- **Labels:** UPPERCASE, Secondary color, 11pt

### 8. Keyboard Shortcuts
- `⌘F` - Focus search field
- `⌘⇧K` - Clear search results
- `⌘⇧H` - Show history tab
- `⌘⌥⌫` - Clear all history
- `⌘,` - Open settings
- `Return` - Perform search

### 9. Settings
- **App Store Region:** Choose which regional store to search
  - United States, United Kingdom, Canada
  - Australia, Germany, France
  - Japan, China, India
- **About Section:** Version and build info

### 10. Error Handling
- Network errors with clear messages
- No results found indication
- Invalid URL detection
- Loading states for all async operations
- Graceful image loading fallbacks

---

## 🎓 How to Use

### Basic Search
1. Type an app name in the search bar
2. Press Enter or click search
3. Browse multiple results in the sidebar
4. Click any result to view details

### URL Search
1. Go to apps.apple.com in your browser
2. Find any app you want
3. Copy the URL from your browser
4. Paste into Bundle Hunter's search bar
5. Press Enter

### Copying Information
1. View any app's details
2. Click the copy icon (📄) next to any field
3. Get instant confirmation (✓)
4. Paste anywhere you need it

### Managing Favorites
1. Search and view an app
2. Click the star icon in the toolbar
3. Switch to Favorites tab to see all starred apps
4. Click any favorite for quick access
5. Swipe to remove from favorites

### Using History
1. Your searches are automatically saved
2. Switch to History tab
3. Click any previous search to re-run it
4. Swipe to delete individual entries
5. Use menu for "Clear All History"

---

## 🔍 Example Searches

### Popular macOS Apps
- "Xcode"
- "Safari"
- "Final Cut Pro"
- "Logic Pro"
- "Pages"
- "Keynote"

### Popular iOS Apps
- "Instagram"
- "WhatsApp"
- "TikTok"
- "Spotify"

### By URL
```
https://apps.apple.com/us/app/xcode/id497799835
https://apps.apple.com/app/pages/id409201541
```

---

## 💾 Data Storage

### What's Stored Locally:
- Search history (app name, bundle ID, timestamp)
- Favorite apps (app name, developer, bundle ID, icon URL)
- Settings preferences (selected region)

### What's NOT Stored:
- Full app data (always fetched fresh)
- Screenshots (loaded on demand)
- Personal information
- Search queries sent to Apple

### Privacy:
- ✅ No analytics or tracking
- ✅ No third-party services
- ✅ All API calls direct to Apple
- ✅ All data stored locally only
- ✅ No user account required

---

## 🏆 Design Awards

This app follows Apple's Human Interface Guidelines:
- Native macOS controls and patterns
- Proper use of system materials
- Accessibility support (VoiceOver, text selection)
- Keyboard navigation
- Standard menu structure
- Settings window pattern
- Unified toolbar design
- Split view navigation
- Context-appropriate empty states

---

## 🚀 Building & Running

### Requirements
- macOS 14.0 or later
- Xcode 15.0 or later
- Swift 5.9+

### Steps
1. Open `Bundle Hunter.xcodeproj` in Xcode
2. Select your Mac as the target
3. Press ⌘R to build and run
4. No additional configuration needed!

---

## 📱 API Rate Limits

Apple's iTunes Search API has approximate limits:
- **~20 calls per minute** per IP address
- **No authentication** required
- **Free** to use
- **No request signing** needed

Bundle Hunter respects these limits by:
- Only searching when you press Enter
- Not auto-completing as you type
- Caching nothing (always fresh data)

---

## 🎯 Pro Tips

1. **Multiple Results:** If you search "Mail", you'll see Apple Mail, Gmail, Outlook, etc. Click the exact one you want.

2. **URL Flexibility:** You can paste app.store.com shortened URLs, they'll be expanded automatically.

3. **Quick Copy:** The Bundle ID has a prominent copy button, but every field is copyable with one click.

4. **Favorites for Developers:** Star apps you frequently reference for instant access.

5. **Regional Differences:** Same app might have different info in different regions (pricing, availability).

6. **Screenshots:** The API provides actual screenshot URLs - Bundle Hunter displays them in a beautiful gallery.

7. **Text Selection:** Most text can be selected and copied manually if you prefer.

---

## 🔮 Future Enhancement Ideas

Want to contribute? Consider adding:
- [ ] Export results to CSV/JSON
- [ ] Compare multiple apps side-by-side
- [ ] App Store Connect integration
- [ ] Bulk lookup from list
- [ ] Custom collection organization
- [ ] Share sheet integration
- [ ] Quick Look preview
- [ ] Spotlight integration
- [ ] Menu bar mode

---

**Made with ❤️ for macOS developers and App Store researchers**

Questions? Check the code - it's well-commented and follows modern Swift patterns!
