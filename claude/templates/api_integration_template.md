# API & Integration Documentation

> **Related Documentation**: [Project Architecture](./project_architecture.md) | [Database Schema](./database_schema.md)

## API Overview

**Base URL**: [e.g., `https://api.example.com/v1` or `http://localhost:3000/api`]

**API Version**: [e.g., v1, v2]

**Protocol**: [REST / GraphQL / gRPC / WebSocket]

**Authentication**: [JWT / API Key / OAuth 2.0 / None]

**Rate Limiting**: [e.g., "100 requests/minute per API key" or "None"]

---

## Authentication

### Method: [JWT / API Key / OAuth 2.0]

**How to authenticate**:
\`\`\`bash
# Example: JWT in Authorization header
curl -H "Authorization: Bearer YOUR_JWT_TOKEN" https://api.example.com/v1/resource
\`\`\`

**Getting credentials**:
1. [Step 1: e.g., "Register at /api/auth/register"]
2. [Step 2: e.g., "Login at /api/auth/login to get JWT token"]
3. [Step 3: e.g., "Include token in Authorization header"]

**Token lifecycle**:
- **Expiration**: [e.g., 24 hours]
- **Refresh**: [e.g., Use /api/auth/refresh with refresh token]
- **Revocation**: [e.g., Logout at /api/auth/logout]

**Authentication flow**:
\`\`\`mermaid
sequenceDiagram
    participant Client
    participant API
    participant AuthService
    participant DB

    Client->>API: POST /auth/login (email, password)
    API->>AuthService: Validate credentials
    AuthService->>DB: Check user
    DB-->>AuthService: User data
    AuthService->>AuthService: Generate JWT
    AuthService-->>API: JWT + Refresh token
    API-->>Client: 200 with tokens

    Note over Client: Future requests
    Client->>API: GET /resource (with JWT)
    API->>AuthService: Validate JWT
    AuthService-->>API: Valid
    API-->>Client: 200 with data
\`\`\`

---

## API Endpoints

### Authentication Endpoints

#### POST /api/auth/register
**Purpose**: Create a new user account

**Request**:
\`\`\`json
{
  "email": "user@example.com",
  "password": "SecurePass123!",
  "name": "John Doe"
}
\`\`\`

**Response** (201):
\`\`\`json
{
  "user": {
    "id": "uuid",
    "email": "user@example.com",
    "name": "John Doe",
    "createdAt": "2024-01-15T10:30:00Z"
  },
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "refreshToken": "refresh_token_here"
}
\`\`\`

**Errors**:
- `400` - Invalid email format, weak password
- `409` - Email already exists

---

#### POST /api/auth/login
**Purpose**: Authenticate existing user

**Request**:
\`\`\`json
{
  "email": "user@example.com",
  "password": "SecurePass123!"
}
\`\`\`

**Response** (200): [Same as register]

**Errors**:
- `401` - Invalid credentials
- `404` - User not found

---

### Resource Endpoints

#### GET /api/resources
**Purpose**: List all resources with pagination

**Auth**: Required

**Query Parameters**:
- `page` (integer, default: 1) - Page number
- `limit` (integer, default: 20, max: 100) - Items per page
- `sort` (string, default: "createdAt") - Sort field
- `order` (string, default: "desc") - Sort order (asc/desc)
- `filter[status]` (string) - Filter by status

**Request**:
\`\`\`bash
curl -H "Authorization: Bearer TOKEN" \
  "https://api.example.com/v1/resources?page=1&limit=20&sort=createdAt&order=desc"
\`\`\`

**Response** (200):
\`\`\`json
{
  "data": [
    {
      "id": "uuid",
      "name": "Resource 1",
      "status": "active",
      "createdAt": "2024-01-15T10:30:00Z"
    }
  ],
  "pagination": {
    "page": 1,
    "limit": 20,
    "total": 150,
    "totalPages": 8
  }
}
\`\`\`

**Errors**:
- `401` - Unauthorized
- `400` - Invalid pagination parameters

---

#### GET /api/resources/:id
**Purpose**: Get a single resource by ID

**Auth**: Required

**Request**:
\`\`\`bash
curl -H "Authorization: Bearer TOKEN" \
  "https://api.example.com/v1/resources/uuid-here"
\`\`\`

**Response** (200):
\`\`\`json
{
  "id": "uuid",
  "name": "Resource 1",
  "description": "Detailed description",
  "status": "active",
  "metadata": {
    "key": "value"
  },
  "createdAt": "2024-01-15T10:30:00Z",
  "updatedAt": "2024-01-16T14:20:00Z"
}
\`\`\`

**Errors**:
- `404` - Resource not found
- `401` - Unauthorized

---

#### POST /api/resources
**Purpose**: Create a new resource

**Auth**: Required

**Request**:
\`\`\`json
{
  "name": "New Resource",
  "description": "Description here",
  "status": "draft",
  "metadata": {
    "key": "value"
  }
}
\`\`\`

**Response** (201):
\`\`\`json
{
  "id": "uuid",
  "name": "New Resource",
  "description": "Description here",
  "status": "draft",
  "createdAt": "2024-01-17T09:15:00Z"
}
\`\`\`

**Errors**:
- `400` - Validation error (missing required fields)
- `401` - Unauthorized

---

#### PATCH /api/resources/:id
**Purpose**: Update an existing resource (partial update)

**Auth**: Required (must be resource owner)

**Request**:
\`\`\`json
{
  "name": "Updated Name",
  "status": "active"
}
\`\`\`

**Response** (200): [Full resource object with updates]

**Errors**:
- `404` - Resource not found
- `403` - Not authorized to update this resource
- `400` - Validation error

---

#### DELETE /api/resources/:id
**Purpose**: Delete a resource

**Auth**: Required (must be resource owner)

**Response** (204): No content

**Errors**:
- `404` - Resource not found
- `403` - Not authorized to delete this resource

---

## External Integrations

### [Integration 1 Name] (e.g., Stripe, SendGrid, Twilio)

**Purpose**: [What this integration does]

**Documentation**: [Link to external API docs]

**Authentication**: [API Key / OAuth / etc.]

**Base URL**: `https://api.external-service.com/v1`

**Environment Variables**:
- `INTEGRATION_API_KEY` - API key for authentication
- `INTEGRATION_WEBHOOK_SECRET` - Webhook signature verification

**Key Endpoints Used**:

#### Send Email (Example)
\`\`\`typescript
// Internal usage
await emailService.send({
  to: 'user@example.com',
  subject: 'Welcome',
  template: 'welcome',
  data: { name: 'John' }
});
\`\`\`

**External API call**:
\`\`\`bash
POST https://api.sendgrid.com/v3/mail/send
Authorization: Bearer API_KEY
Content-Type: application/json

{
  "personalizations": [{"to": [{"email": "user@example.com"}]}],
  "from": {"email": "noreply@example.com"},
  "subject": "Welcome",
  "content": [{"type": "text/html", "value": "<p>Welcome!</p>"}]
}
\`\`\`

**Rate Limits**: [e.g., 100 emails/second]

**Error Handling**:
- Retry with exponential backoff on 5xx errors
- Log and alert on 4xx errors (config issues)

**Webhook Configuration**:
- **Endpoint**: `https://your-api.com/webhooks/sendgrid`
- **Events**: email.delivered, email.bounced, email.opened
- **Signature Verification**: HMAC-SHA256 with webhook secret

---

### [Integration 2 Name]

[Same structure as above]

---

## Webhooks (Incoming)

### Webhook: [Event Name] (e.g., Payment Received)

**Endpoint**: `POST /webhooks/payment-received`

**Source**: [External service name]

**Authentication**: HMAC signature in `X-Signature` header

**Payload**:
\`\`\`json
{
  "event": "payment.received",
  "id": "evt_123",
  "data": {
    "amount": 1000,
    "currency": "usd",
    "customer": "cus_123"
  },
  "timestamp": "2024-01-17T10:00:00Z"
}
\`\`\`

**Verification**:
\`\`\`typescript
const signature = req.headers['x-signature'];
const payload = JSON.stringify(req.body);
const expectedSignature = crypto
  .createHmac('sha256', WEBHOOK_SECRET)
  .update(payload)
  .digest('hex');

if (signature !== expectedSignature) {
  throw new Error('Invalid signature');
}
\`\`\`

**Response** (200):
\`\`\`json
{
  "received": true
}
\`\`\`

**Event Processing**:
1. Verify signature
2. Check for duplicate events (idempotency)
3. Process event asynchronously
4. Return 200 immediately

---

## Data Models

### Request/Response Schemas

#### User Object
\`\`\`typescript
interface User {
  id: string;              // UUID
  email: string;           // Valid email format
  name: string;            // 1-255 characters
  role: 'user' | 'admin';  // Enum
  createdAt: string;       // ISO 8601 timestamp
  updatedAt: string;       // ISO 8601 timestamp
}
\`\`\`

#### Resource Object
\`\`\`typescript
interface Resource {
  id: string;
  name: string;
  description?: string;
  status: 'draft' | 'active' | 'archived';
  metadata: Record<string, any>;
  userId: string;          // Foreign key to User
  createdAt: string;
  updatedAt: string;
}
\`\`\`

#### Error Response
\`\`\`typescript
interface ErrorResponse {
  error: {
    code: string;          // Machine-readable error code
    message: string;       // Human-readable message
    details?: any;         // Additional context
    requestId: string;     // For support/debugging
  }
}
\`\`\`

---

## Error Codes

| HTTP Status | Error Code | Message | Resolution |
|-------------|------------|---------|------------|
| 400 | `VALIDATION_ERROR` | Request validation failed | Check request body against schema |
| 401 | `UNAUTHORIZED` | Authentication required | Provide valid JWT token |
| 403 | `FORBIDDEN` | Insufficient permissions | Request access or use different account |
| 404 | `NOT_FOUND` | Resource not found | Check resource ID |
| 409 | `CONFLICT` | Resource already exists | Use different identifier |
| 422 | `UNPROCESSABLE` | Business logic error | Fix data inconsistency |
| 429 | `RATE_LIMIT` | Too many requests | Wait before retrying |
| 500 | `INTERNAL_ERROR` | Server error | Retry or contact support |
| 503 | `SERVICE_UNAVAILABLE` | Service temporarily down | Retry with backoff |

---

## Rate Limiting

**Limits**:
- Authenticated: 1000 requests/hour per user
- Unauthenticated: 100 requests/hour per IP

**Headers**:
\`\`\`
X-RateLimit-Limit: 1000
X-RateLimit-Remaining: 950
X-RateLimit-Reset: 1705492800
\`\`\`

**Exceeded limit response** (429):
\`\`\`json
{
  "error": {
    "code": "RATE_LIMIT",
    "message": "Rate limit exceeded. Try again in 3600 seconds",
    "retryAfter": 3600
  }
}
\`\`\`

---

## OpenAPI Specification

**OpenAPI file location**: `docs/openapi.yaml`

**View interactive docs**:
- Local: `http://localhost:3000/api-docs`
- Production: `https://api.example.com/docs`

**Generate client SDK**:
\`\`\`bash
# Using OpenAPI Generator
npx @openapitools/openapi-generator-cli generate \
  -i docs/openapi.yaml \
  -g typescript-fetch \
  -o ./generated/api-client
\`\`\`

---

## SDK & Client Libraries

### Official SDKs
- **JavaScript/TypeScript**: `npm install @example/api-client`
- **Python**: `pip install example-api-client`

### Usage Example (TypeScript)
\`\`\`typescript
import { ApiClient } from '@example/api-client';

const client = new ApiClient({
  baseUrl: 'https://api.example.com/v1',
  apiKey: 'your-api-key'
});

// Create resource
const resource = await client.resources.create({
  name: 'New Resource',
  status: 'draft'
});

// List resources
const { data, pagination } = await client.resources.list({
  page: 1,
  limit: 20
});
\`\`\`

---

## Testing the API

### Using cURL
\`\`\`bash
# Set token
export TOKEN="your-jwt-token"

# Create resource
curl -X POST https://api.example.com/v1/resources \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"name": "Test Resource", "status": "draft"}'

# Get resource
curl https://api.example.com/v1/resources/uuid-here \
  -H "Authorization: Bearer $TOKEN"
\`\`\`

### Using Postman
1. Import OpenAPI spec from `docs/openapi.yaml`
2. Set environment variable `baseUrl` to `https://api.example.com/v1`
3. Set `token` variable from login response
4. Use {{token}} in Authorization header

### Integration Tests
\`\`\`bash
# Run API integration tests
npm run test:integration:api
\`\`\`

---

## Monitoring & Observability

**Health Check**: `GET /health`

**Response** (200):
\`\`\`json
{
  "status": "healthy",
  "version": "1.2.3",
  "uptime": 3600,
  "dependencies": {
    "database": "healthy",
    "redis": "healthy",
    "external_api": "healthy"
  }
}
\`\`\`

**Metrics Endpoint**: `GET /metrics` (Prometheus format)

**Key Metrics**:
- Request rate (requests/second)
- Error rate (%)
- Response time (p50, p95, p99)
- Active connections

**Logging**:
- All requests logged with correlation ID
- Error logs include stack traces
- Logs sent to [CloudWatch / Datadog / etc.]

---

## Versioning

**Current version**: v1

**Versioning strategy**: URL path versioning (e.g., `/v1/`, `/v2/`)

**Deprecation policy**:
1. Announce deprecation 6 months in advance
2. Include `Deprecation` header in responses
3. Maintain deprecated versions for 12 months

**Migration guide**: [Link to version migration docs]

---

## Security

**HTTPS**: Required in production

**CORS**:
- Allowed origins: [List domains]
- Credentials: Allowed
- Max age: 86400 seconds

**Headers**:
\`\`\`
X-Content-Type-Options: nosniff
X-Frame-Options: DENY
X-XSS-Protection: 1; mode=block
Strict-Transport-Security: max-age=31536000; includeSubDomains
\`\`\`

**Input Validation**: All inputs sanitized and validated

**SQL Injection**: Prevented via parameterized queries (Sequelize ORM)

**XSS**: Outputs escaped, CSP headers enforced

---

## Best Practices

**For API Consumers**:
1. Always handle rate limits gracefully
2. Use exponential backoff for retries
3. Cache responses when appropriate
4. Validate webhook signatures
5. Store API keys securely (never commit to git)

**For API Developers**:
1. Keep backwards compatibility
2. Use semantic versioning
3. Document all breaking changes
4. Return meaningful error messages
5. Include request IDs in all responses

---

## Troubleshooting

### Common Issues

**Issue: 401 Unauthorized**
- Check token is not expired
- Verify `Bearer` prefix in Authorization header
- Ensure token format: `Authorization: Bearer <token>`

**Issue: Slow responses**
- Check pagination parameters (reduce page size)
- Enable caching for repeated requests
- Use field filtering to reduce payload size

**Issue: Webhook not received**
- Verify endpoint is publicly accessible
- Check firewall/security group settings
- Test with webhook testing tools (webhook.site)

---

## Support

**API Status**: [https://status.example.com]

**Support Email**: [api-support@example.com]

**Slack Channel**: [#api-support]

**GitHub Issues**: [Link to repo issues]
