# UI Testing Checklist

Use this checklist to verify all the UI improvements are working correctly.

## ✅ Sidebar Testing

### Search Field
- [ ] Search field has a subtle border
- [ ] Search field uses proper system colors
- [ ] Magnifying glass icon is visible and tertiary colored
- [ ] Placeholder text is visible
- [ ] Clear button (X) appears when typing
- [ ] Clear button removes text when clicked
- [ ] Text is 13pt and readable

### Platform Filter
- [ ] Three segments: "All Platforms", "iOS & iPadOS", "macOS"
- [ ] Filter is between search field and view tabs
- [ ] Selecting a filter triggers re-search if results exist
- [ ] Selected segment is highlighted properly
- [ ] Filter is disabled during loading

### View Tabs
- [ ] Three segments: Results, History, Favorites
- [ ] Tabs switch between different views
- [ ] Selected tab is highlighted
- [ ] Tabs are disabled during loading
- [ ] Proper spacing below the tabs

### Overall Sidebar
- [ ] Consistent 12pt horizontal padding
- [ ] Dividers are properly placed
- [ ] No cramped spacing
- [ ] Everything is vertically aligned
- [ ] Sidebar width is appropriate (280-400pt)

## ✅ App List Items

### Icon Display
- [ ] Icons are 52x52pt
- [ ] Continuous corner radius (12pt)
- [ ] Subtle shadow on icons
- [ ] Loading state shows small progress indicator
- [ ] Error state shows app.dashed icon
- [ ] Icons are properly aligned

### Text Display
- [ ] App name is 13pt medium weight
- [ ] Developer name is 12pt secondary
- [ ] Bundle ID is 11pt monospaced tertiary
- [ ] All text truncates properly with ellipsis
- [ ] Vertical spacing is 5pt between lines

### Platform Badges
- [ ] macOS badge is blue with light blue background
- [ ] iOS badge is green with light green background
- [ ] Badges are 8pt semibold font
- [ ] Badges have rounded corners (4pt continuous)
- [ ] Badges appear next to app name

### Item Layout
- [ ] 6pt vertical padding
- [ ] 4pt horizontal padding
- [ ] Icon and text properly spaced (12pt)
- [ ] Items are clickable
- [ ] Selection state is visible

## ✅ App Detail Header

### App Icon
- [ ] Icon is 128x128pt
- [ ] Corner radius is 28pt continuous
- [ ] Shadow is visible (15% opacity, 12pt radius)
- [ ] Loading state shows placeholder
- [ ] Error state shows app.dashed icon

### App Name & Developer
- [ ] App name is 28pt bold
- [ ] Copy button next to app name
- [ ] Developer name is 15pt secondary
- [ ] Copy button next to developer name
- [ ] Both copy buttons show checkmark when clicked
- [ ] Symbol transitions are smooth

### Metadata Row
- [ ] Star icon is yellow and 12pt
- [ ] Rating format is correct (X.X)
- [ ] Rating count shows in parentheses
- [ ] Tag icon appears before category
- [ ] Category is 13pt secondary
- [ ] Price has colored background pill
- [ ] Free apps show green pill
- [ ] Paid apps show appropriate color

### App Store Link
- [ ] Link is blue
- [ ] Arrow icon is visible
- [ ] Text is 13pt medium
- [ ] Link opens in browser when clicked

### Overall Header
- [ ] 20pt spacing between icon and text
- [ ] Proper alignment
- [ ] 32pt horizontal padding
- [ ] 32pt top padding, 24pt bottom padding

## ✅ Bundle ID Section

### Display
- [ ] Section header is uppercase with tracking
- [ ] Section header is 13pt semibold secondary
- [ ] Bundle ID is 15pt monospaced medium
- [ ] Text selection works
- [ ] Card has controlBackgroundColor
- [ ] Card has subtle border
- [ ] Corner radius is 8pt continuous
- [ ] 16pt internal padding

### Copy Button
- [ ] Button is .borderedProminent style
- [ ] Shows "Copy" or "Copied" text
- [ ] Shows appropriate icon
- [ ] Symbol transition is smooth
- [ ] Clicking copies to clipboard
- [ ] Returns to "Copy" after 2 seconds

## ✅ Information Cards

### Card Styling
- [ ] All cards have consistent design
- [ ] 12pt internal padding
- [ ] 8pt continuous corner radius
- [ ] controlBackgroundColor background
- [ ] Subtle border (0.5pt, 30% opacity)
- [ ] 12pt spacing between cards in grid

### Label & Value
- [ ] Label is 11pt tertiary uppercase
- [ ] Label has 0.3pt letter tracking
- [ ] Value is 14pt primary
- [ ] Monospaced values use monospaced font
- [ ] Text selection works
- [ ] Values can wrap to 3 lines

### Copy Buttons
- [ ] Icon is 13pt
- [ ] Shows checkmark when copied
- [ ] Green color on success
- [ ] Symbol transition is smooth
- [ ] Help tag shows on hover

### Grid Layout
- [ ] Two columns
- [ ] Left aligned content
- [ ] Flexible width distribution
- [ ] No overlapping

## ✅ Section Headers

All section headers should:
- [ ] Be 13pt semibold
- [ ] Use secondary color
- [ ] Be uppercase
- [ ] Have 0.5pt letter tracking
- [ ] Be consistent across all sections

Sections to check:
- [ ] "BUNDLE IDENTIFIER"
- [ ] "TECHNICAL INFORMATION"
- [ ] "APP STORE DETAILS"
- [ ] "RATINGS & REVIEWS"
- [ ] "SCREENSHOTS"
- [ ] "WHAT'S NEW"
- [ ] "DESCRIPTION"
- [ ] "ADDITIONAL INFORMATION"

## ✅ Technical Information

### Fields Present
- [ ] Platform field shows first
- [ ] Version field visible
- [ ] File Size calculated correctly
- [ ] Minimum OS shown if available
- [ ] Track ID visible
- [ ] Seller shown if available
- [ ] Content Rating shown if available

### Platform Display
- [ ] Shows "iOS" or "macOS" or "iOS, macOS"
- [ ] Copyable
- [ ] Properly detected from app data

## ✅ Ratings Section

### Display
- [ ] Rating number is 56pt rounded bold
- [ ] Star icons are 14pt
- [ ] Star spacing is 3pt
- [ ] Filled stars for rating value
- [ ] Empty stars for remainder
- [ ] Yellow color on stars
- [ ] Rating count shows below

### Card Styling
- [ ] 20pt padding all sides
- [ ] 12pt continuous corner radius
- [ ] controlBackgroundColor
- [ ] Subtle border (30% opacity)
- [ ] Section header above card

## ✅ Screenshots

### Display
- [ ] Screenshots are 240pt height
- [ ] 16pt spacing between images
- [ ] 12pt continuous corner radius
- [ ] Subtle shadow (12% opacity, 8pt radius)
- [ ] Horizontal scroll works smoothly
- [ ] Shows up to 10 screenshots
- [ ] Count text if more than 10

### States
- [ ] Loading shows progress indicator
- [ ] Error shows photo icon
- [ ] Success shows image
- [ ] Images maintain aspect ratio

## ✅ Description & Release Notes

### Card Design
- [ ] 16pt internal padding
- [ ] 10pt continuous corner radius
- [ ] controlBackgroundColor
- [ ] Subtle border
- [ ] Text is primary color (not secondary)

### Typography
- [ ] 14pt body text
- [ ] 4pt line spacing
- [ ] Text selection works
- [ ] Proper text wrapping
- [ ] Maintains left alignment

### Sections
- [ ] "What's New" section if release notes exist
- [ ] "Description" section always present
- [ ] Proper spacing between sections

## ✅ Additional Information

### Fields
- [ ] Supported Languages count
- [ ] App Store URL (full URL)
- [ ] Both fields copyable
- [ ] Grid layout (2 columns)

### Footer
- [ ] Info icon visible (11pt)
- [ ] Privacy text visible (11pt tertiary)
- [ ] Icon and text aligned

## ✅ Spacing & Padding

### Section Spacing
- [ ] 32pt horizontal padding on all sections
- [ ] 24pt vertical padding between sections
- [ ] Dividers extend with 32pt horizontal insets
- [ ] No sections feel cramped
- [ ] No excessive whitespace

### Internal Spacing
- [ ] VStack spacing is 0 in main body
- [ ] Individual sections control their own spacing
- [ ] 16pt spacing within sections
- [ ] 8-12pt spacing for related elements

## ✅ Interactive Elements

### Copy Functionality
- [ ] All copy buttons work
- [ ] Text is actually copied to clipboard
- [ ] Visual feedback (checkmark) shows
- [ ] State resets after 2 seconds
- [ ] Multiple copies in sequence work

### Buttons
- [ ] All buttons show hover states
- [ ] Cursor changes to pointer on hover
- [ ] Buttons are not too small
- [ ] Button press feels responsive
- [ ] Help tags appear on hover

### Text Selection
- [ ] App name is selectable
- [ ] Developer name is selectable
- [ ] Bundle ID is selectable
- [ ] All information field values are selectable
- [ ] Description and release notes are selectable

## ✅ Colors & Appearance

### Light Mode
- [ ] All text is readable
- [ ] Cards have proper contrast
- [ ] Borders are visible but subtle
- [ ] Colors look natural
- [ ] No harsh contrasts

### Dark Mode
- [ ] All text is readable
- [ ] Cards adapt properly
- [ ] Borders are visible
- [ ] Colors invert correctly
- [ ] Maintains hierarchy

### Semantic Colors
- [ ] Blue for links and macOS badges
- [ ] Green for free prices and iOS badges
- [ ] Yellow for star ratings
- [ ] Primary, secondary, tertiary hierarchy works
- [ ] System colors adapt to appearance

## ✅ Responsive Behavior

### Sidebar
- [ ] Resizes from 280pt to 400pt
- [ ] Content stays aligned during resize
- [ ] No text gets cut off inappropriately
- [ ] Scroll works when needed

### Detail View
- [ ] Scrolls smoothly
- [ ] Wide windows don't stretch content too much
- [ ] Narrow windows maintain readability
- [ ] Grid layouts adapt appropriately
- [ ] Screenshots scroll horizontally

### Window Resize
- [ ] No layout breaks at minimum size
- [ ] No layout breaks at maximum size
- [ ] Smooth transitions during resize
- [ ] Split view divider works properly

## ✅ Edge Cases

### Empty States
- [ ] No app selected shows proper message
- [ ] Empty search results show proper message
- [ ] Empty history shows proper message
- [ ] Empty favorites shows proper message

### Optional Data
- [ ] App without ratings doesn't crash
- [ ] App without screenshots doesn't crash
- [ ] App without release notes doesn't crash
- [ ] Missing optional fields handled gracefully

### Long Text
- [ ] Long app names truncate properly
- [ ] Long bundle IDs truncate properly
- [ ] Long descriptions wrap properly
- [ ] Long genre lists wrap properly

### Special Characters
- [ ] Emojis in app names display correctly
- [ ] Special characters in bundle IDs work
- [ ] International characters display properly
- [ ] Text selection works with special chars

## ✅ Performance

### Loading
- [ ] Images load asynchronously
- [ ] Progress indicators show during load
- [ ] No UI freezing during searches
- [ ] Smooth scrolling
- [ ] No lag when switching apps

### Animations
- [ ] Symbol transitions are smooth
- [ ] No janky animations
- [ ] Consistent animation timing
- [ ] Animations complete properly

## ✅ Accessibility

### VoiceOver
- [ ] All buttons have labels
- [ ] All images have alt text
- [ ] Navigation is logical
- [ ] Interactive elements are announced

### Keyboard
- [ ] Tab navigation works
- [ ] Return submits search
- [ ] Escape clears search field
- [ ] All interactive elements are reachable

### Visual
- [ ] Text is large enough
- [ ] Contrast ratios are good
- [ ] Color is not only indicator
- [ ] Touch targets are adequate size

## 🎯 Final Checks

- [ ] App launches without errors
- [ ] No console warnings about layout
- [ ] No memory leaks during use
- [ ] CPU usage is reasonable
- [ ] Battery impact is minimal
- [ ] Respects system appearance settings
- [ ] Works on macOS 14.0+
- [ ] Respects reduced motion settings

## 📝 Notes

Use this space to note any issues found:

```
Issue 1: [Description]
Expected: [What should happen]
Actual: [What actually happens]
Steps to reproduce: [Steps]

Issue 2: ...
```

---

**Once all items are checked, your UI refactoring is complete and ready for production!** ✨
