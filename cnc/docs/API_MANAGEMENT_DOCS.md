# Management API Documentation

## Base URL
`http://localhost:{API_PORT}/api/manage`

## Authentication
All endpoints require admin credentials passed as query parameters:
- `username`: Admin username
- `password`: Admin password

## Endpoints

### 1. Add User
**Method:** GET  
**URL:** `/api/manage?username={admin_user}&password={admin_pass}&action=adduser&user={new_username}&pass={new_password}`

**Optional Parameters:**
- `admin`: true for admin, false for regular user (default: false)
- `vip`: true for VIP, false for regular user (default: false)
- `expiry`: Days until expiry (default: 30)
- `concurrents`: Max concurrent attacks (default: 1)
- `cooldown`: Cooldown between attacks in seconds (default: 30)
- `maxtime`: Max attack duration in seconds (default: 300)
- `api`: true to allow API access, false to deny (default: false)
- `powersaving`: true to bypass power saving restrictions (default: false)
- `bypassspam`: true to bypass spam protection (default: false)
- `bypassblacklist`: true to bypass soft blacklist (default: false)
- `roles`: Comma-separated list of roles (optional)

### 2. Use Preset
**Method:** GET  
**URL:** `/api/manage?username={admin_user}&password={admin_pass}&action=usepreset&user={new_username}&pass={new_password}&preset={preset_name}`

### 3. Edit User
**Method:** GET  
**URL:** `/api/manage?username={admin_user}&password={admin_pass}&action=edituser&user={target_username}`

**Optional Parameters (same as adduser):**
- `pass`: New password
- `admin`: true for admin, false for regular user
- `vip`: true for VIP, false for regular user
- `expiry`: Days until expiry
- `concurrents`: Max concurrent attacks
- `cooldown`: Cooldown between attacks in seconds
- `maxtime`: Max attack duration in seconds
- `api`: true to allow API access, false to deny
- `powersaving`: true to bypass power saving restrictions
- `bypassspam`: true to bypass spam protection
- `bypassblacklist`: true to bypass soft blacklist
- `roles`: Comma-separated list of roles

### 4. Remove User
**Method:** GET  
**URL:** `/api/manage?username={admin_user}&password={admin_pass}&action=removeuser&user={target_username}`

## Response Format
All endpoints return JSON in this format:
```json
{
  "success": true|false,
  "message": "Description of result"
}
```

**Note:** The `data` field has been removed for simplified responses. Success/error status and message are sufficient.

## Examples

### Add a basic user:
```bash
curl "http://localhost:8081/api/manage?username=admin&password=adminpass&action=adduser&user=testuser&pass=testpass&expiry=30&concurrents=1&maxtime=300"
```

### Add an admin user:
```bash
curl "http://localhost:8081/api/manage?username=admin&password=adminpass&action=adduser&user=newadmin&pass=adminpass123&admin=true&vip=true&api=true&expiry=90"
```

### Create user with preset:
```bash
curl "http://localhost:8081/api/manage?username=admin&password=adminpass&action=usepreset&user=vipuser&pass=vippass&preset=vip_user"
```

### Edit user (change password and extend expiry):
```bash
curl "http://localhost:8081/api/manage?username=admin&password=adminpass&action=edituser&user=testuser&pass=newpassword&expiry=60"
```

### Remove a user:
```bash
curl "http://localhost:8081/api/manage?username=admin&password=adminpass&action=removeuser&user=testuser"
```

### Add user with custom roles:
```bash
curl "http://localhost:8081/api/manage?username=admin&password=adminpass&action=adduser&user=customuser&pass=custompass&roles=premium,special&concurrents=3"
```

### Add user with all privileges:
```bash
curl "http://localhost:8081/api/manage?username=admin&password=adminpass&action=adduser&user=superuser&pass=superpass&admin=true&vip=true&api=true&powersaving=true&bypassspam=true&bypassblacklist=true&concurrents=5&maxtime=600"
```

**Note:** The API accepts both `true`/`false` and `1`/`0` for boolean parameters, but the examples use `true`/`false` for clarity.
