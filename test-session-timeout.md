# Session Timeout Functionality Test Guide

## Overview
The session timeout functionality has been enabled across all JSP pages. It provides automatic session management with user-friendly warnings and automatic logout.

## Configuration
- **Server Session Timeout**: 15 minutes (configured in `application.properties`)
- **Warning Time**: 14 minutes (1 minute before timeout, shows warning modal)
- **Countdown**: 60 seconds in the warning modal
- **Heartbeat Endpoint**: `/swarajtraders/heartbeat` (extends session)

## Features Enabled

### ✅ Bootstrap Integration
- Added Bootstrap CSS and JS to all JSP pages
- Required for the session timeout modal to work properly

### ✅ Session Timeout Script
- Automatically loaded on all JSP pages
- Monitors user activity (mouse, keyboard, touch, scroll)
- Shows warning modal 1 minute before session expires
- Provides countdown timer in the modal
- Sends heartbeat requests to extend session

### ✅ Heartbeat Endpoint
- Available at `/swarajtraders/heartbeat`
- Extends session when called
- Returns "OK" response

## How to Test Session Timeout

### Test 1: Basic Session Timeout
1. **Start the application**
   ```bash
   ./mvnw spring-boot:run
   ```

2. **Login to the application**
   - Go to `http://localhost:8080/swarajtraders/login`
   - Login with `admin/admin`

3. **Navigate to any page**
   - Go to Dashboard, Party List, or any other page

4. **Wait for timeout**
   - **Don't interact** with the page for 14 minutes
   - After 14 minutes, you should see a warning modal
   - The modal will show a 60-second countdown

5. **Test the warning modal**
   - **Continue Session**: Click "Continue Session" to extend your session
   - **Logout Now**: Click "Logout Now" to logout immediately
   - **Let it expire**: Don't click anything and let the countdown reach 0

### Test 2: Activity Detection
1. **Login and navigate to a page**

2. **Interact with the page**
   - Move your mouse
   - Click on elements
   - Scroll the page
   - Type in form fields

3. **Verify session extension**
   - The session should be extended with each activity
   - You should not see the warning modal while actively using the page

### Test 3: Heartbeat Functionality
1. **Open browser developer tools**
   - Press F12 to open developer tools
   - Go to the Network tab

2. **Trigger session extension**
   - Click "Continue Session" in the warning modal
   - Or interact with the page after seeing the warning

3. **Check network requests**
   - Look for a POST request to `/swarajtraders/heartbeat`
   - The request should return "OK"

### Test 4: Automatic Logout
1. **Let session expire**
   - Don't interact with the page for 15 minutes
   - Or let the countdown in the warning modal reach 0

2. **Verify automatic logout**
   - You should be redirected to the login page
   - The URL should include `?expired` parameter
   - You should see a message: "Your session has expired. Please login again."

## Expected Behavior

### ✅ Warning Modal
- Appears 14 minutes after inactivity (1 minute before timeout)
- Shows 60-second countdown
- Has "Continue Session" and "Logout Now" buttons
- Uses Bootstrap styling

### ✅ Activity Detection
- Resets session timer on mouse movement
- Resets session timer on keyboard input
- Resets session timer on touch events
- Resets session timer on scrolling

### ✅ Session Extension
- Heartbeat requests sent to server
- Session extended when "Continue Session" clicked
- Modal disappears after session extension

### ✅ Automatic Logout
- Redirects to login page after timeout
- Shows appropriate message
- Requires re-authentication

## Troubleshooting

### If warning modal doesn't appear:
1. Check browser console for JavaScript errors
2. Verify Bootstrap is loaded (check Network tab)
3. Ensure session-timeout.js is loaded
4. Check if there are any JavaScript conflicts

### If session doesn't extend:
1. Check browser console for network errors
2. Verify heartbeat endpoint is accessible
3. Check server logs for any errors

### If modal styling is broken:
1. Verify Bootstrap CSS is loaded
2. Check if custom CSS is overriding Bootstrap styles
3. Ensure Bootstrap JS is loaded after CSS

## Files Modified

### JSP Files (Added Bootstrap):
- `dashboard.jsp`
- `partyList.jsp`
- `addParty.jsp`
- `editParty.jsp`
- `addItem.jsp` (already had Bootstrap)
- `itemList.jsp` (already had Bootstrap)

### JavaScript:
- `session-timeout.js` (updated timeout values)

### Server:
- `WebController.java` (heartbeat endpoint already exists)

## Session Timeout Flow

```
User Activity → Reset Timer
     ↓
No Activity for 14 min → Show Warning Modal
     ↓
User clicks "Continue Session" → Send Heartbeat → Extend Session
     ↓
User clicks "Logout Now" → Redirect to Login
     ↓
Countdown reaches 0 → Redirect to Login with expired message
```

The session timeout functionality is now fully enabled and ready for testing! 🎉
