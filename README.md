# supr-demo-target-alpha

A Node.js/Express backend API for a B2B SaaS platform.

## Issues

### Issue #1: Implement Rate Limiting for Login API
The `/api/auth/login` endpoint has no rate limiting. Brute-force attacks are possible.
We need to:
1. Create a `Rate_Limits` table in the database to track login attempts per IP
2. Add middleware to check and enforce limits (max 5 attempts per 15 minutes per IP)
3. Return 429 Too Many Requests when limit is exceeded

### Issue #2: Update Dashboard UI Colors
The dashboard uses legacy hex colors. Update to the new brand color palette:
- Primary: `#6C63FF`
- Secondary: `#48BB78`
- Danger: `#F56565`
