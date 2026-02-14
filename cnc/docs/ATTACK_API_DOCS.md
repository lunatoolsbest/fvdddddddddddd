# Attack API Documentation

## Base URL
`http://localhost:{API_PORT}/api/attack`

## Authentication
All endpoints require user credentials passed as query parameters:
- `username`: Your username
- `password`: Your password

## Attack Endpoint

### Launch Attack
**Method:** GET  
**URL:** `/api/attack?username={username}&password={password}&target={target}&port={port}&time={duration}&method={method}&cons={concurrent_count}`

**Required Parameters:**
- `username`: Your account username
- `password`: Your account password  
- `target`: Target IP address or hostname
- `port`: Target port number (1-65535)
- `time`: Attack duration in seconds
- `method`: Attack method name

**Optional Parameters:**
- `cons`: Number of concurrent attacks to launch (always defaults to 1, max: configurable)

**Examples:**
```
GET /api/attack?username=myuser&password=mypass&target=1.2.3.4&port=80&time=60&method=TCP

GET /api/attack?username=myuser&password=mypass&target=1.2.3.4&port=80&time=60&method=TCP&cons=3
```

## Response Format

### Success Response
```json
{
  "status": "success",
  "message": "Attack launched successfully",
  "target": "1.2.3.4",
  "port": "80", 
  "duration": "60",
  "method": "TCP"
}
```

### Error Responses
```json
{
  "status": "error",
  "message": "Error description"
}
```

**Common Error Messages:**
- "Invalid credentials"
- "API access is denied"
- "Account has expired"
- "Attacks are disabled"
- "Method not found"
- "Method is disabled"
- "Target type not allowed for this method"
- "Invalid port number"
- "Attack duration exceeds maximum allowed time"
- "User has reached maximum concurrent attacks"
- "User is on cooldown"
- "Target is blacklisted"

## Requirements

- Account must have API access enabled
- Account must not be expired
- Attacks must be enabled globally (unless admin)
- Method must exist and be enabled
- Target must be valid for the chosen method
- Port must be in valid range (1-65535)
- Duration must not exceed user's maximum time limit
- User must not exceed concurrent attack limit
- User must not be on cooldown
- Target must not be blacklisted (unless bypass enabled)
- For `cons` parameter: must have sufficient concurrent slots available

## Concurrent Attacks (cons parameter)

The `cons` parameter allows launching multiple concurrent attacks with a single API call:

- **Default behavior**: If `cons` is not specified, 1 attack is launched (always defaults to 1)
- **Maximum value**: Configurable via server configuration (default: 10)
- **Slot validation**: The system ensures sufficient concurrent slots are available
- **Example usage**: `cons=3` will launch 3 concurrent attacks to the same target
- **Each concurrent attack**: Counts toward your concurrent attack limit
- **Logging**: Each concurrent attack is logged separately

## Notes

- All attacks are logged
- Some methods may be restricted to CNC-only access
- Blacklist checking applies unless user has bypass permission
- Spam protection applies unless user has bypass permission
- Rate limiting may apply based on user permissions
- Multicon feature can be disabled via server configuration
