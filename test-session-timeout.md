# Testing Session Timeout Functionality

This document outlines how to test the newly implemented session timeout system.

## Prerequisites
- Java 21 installed
- Maven installed
- Application running

## Configuration

The session timeout is configured in `application.properties`:
```properties
# Session timeout configuration (in minutes)
# Change this value to adjust session timeout (e.g., 10m for 10 minutes, 30m for 30 minutes)
server.servlet.session.timeout=5m
spring.session.timeout=5m
```

**Default timeout: 5 minutes**

## Test Steps

### 1. Start the Application
```bash
./mvnw spring-boot:run
```

### 2. Test Session Timeout Warning
1. **Login to the application**
   - Go to: http://localhost:8080/swarajtraders/dashboard
   - Login with: admin/admin

2. **Wait for warning (4 minutes)**
   - After 4 minutes of inactivity, a warning modal should appear
   - Modal shows: "Your session will expire in 60 seconds"
   - Countdown timer should be visible

3. **Test warning modal options**
   - **Continue Session**: Click to extend the session
   - **Logout Now**: Click to logout immediately

### 3. Test Session Expiration
1. **Let session expire**
   - After 5 minutes of inactivity, session should expire
   - User should be redirected to login page with "?expired" parameter

2. **Verify session cleanup**
   - Try to access any protected page after expiration
   - Should redirect to login page

### 3. Test Activity Detection
1. **Move mouse or type**
   - Any user activity should reset the inactivity timer
   - Session should not expire if user is active

2. **Test different activities**
   - Mouse movement
   - Keyboard input
   - Scrolling
   - Clicking

### 4. Test Heartbeat Functionality
1. **Check browser console**
   - Look for heartbeat requests to `/swarajtraders/heartbeat`
   - Should see "OK" response

2. **Monitor network requests**
   - Heartbeat requests should be sent when continuing session

### 5. Test Configuration Changes
1. **Modify timeout in application.properties**
   ```properties
   server.servlet.session.timeout=2m
   spring.session.timeout=2m
   ```

2. **Restart application**
   - Warning should appear after 1 minute (1 minute before timeout)
   - Session should expire after 2 minutes

## Expected Results

### Session Timeout Warning (4 minutes)
- ✅ Modal appears with countdown timer
- ✅ "Continue Session" button works
- ✅ "Logout Now" button works
- ✅ Countdown decreases every second

### Session Expiration (5 minutes)
- ✅ User redirected to login page
- ✅ URL includes "?expired" parameter
- ✅ Session data cleared
- ✅ Cannot access protected pages

### Activity Detection
- ✅ Timer resets on user activity
- ✅ Session extends with activity
- ✅ No false timeouts during active use

### Heartbeat System
- ✅ Heartbeat requests sent to server
- ✅ Server responds with "OK"
- ✅ Session extended on heartbeat

## Troubleshooting

### Session doesn't timeout
- Check `application.properties` configuration
- Verify Spring Session JDBC dependency is included
- Check application logs for session-related errors

### Warning modal doesn't appear
- Check browser console for JavaScript errors
- Verify `session-timeout.js` is loaded
- Check if Bootstrap modal is working

### Heartbeat fails
- Check network tab for failed requests
- Verify `/heartbeat` endpoint is accessible
- Check server logs for errors

### Configuration not working
- Restart application after changing properties
- Verify property names are correct
- Check Spring Boot version compatibility

## Advanced Testing

### Multiple Browser Sessions
1. Open application in multiple browser tabs
2. Login to each tab
3. Let one session expire
4. Verify other sessions remain active

### Database Session Storage
1. Check H2 console for `SPRING_SESSION` table
2. Verify session data is stored
3. Check session cleanup cron job

### Performance Testing
1. Monitor memory usage during long sessions
2. Test with multiple concurrent users
3. Verify session cleanup doesn't impact performance

## Security Considerations

- ✅ CSRF protection maintained
- ✅ Session fixation protection
- ✅ Secure session management
- ✅ Proper logout handling
- ✅ Session invalidation on timeout
