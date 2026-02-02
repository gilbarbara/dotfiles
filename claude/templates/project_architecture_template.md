# Project Architecture

> **Related Documentation**: [Database Schema](./database_schema.md) | [API Integration](./api_integration.md) | [SOPs](../SOP/)

## Overview

**Project Goal**: [Brief 1-2 sentence description of what this project does and why it exists]

**Project Type**: [Monorepo/Single Service/Microservices/Library/etc.]

**Key Capabilities**:
- [Capability 1]
- [Capability 2]
- [Capability 3]

## Tech Stack

### Core Technologies
- **Language**: [e.g., TypeScript, Python, Go]
- **Runtime**: [e.g., Node.js 20.x, Python 3.11]
- **Framework**: [e.g., Express.js, FastAPI, Gin]

### Database & Storage
- **Primary Database**: [e.g., PostgreSQL 15, MongoDB]
- **ORM/Query Layer**: [e.g., Sequelize, Prisma, SQLAlchemy]
- **Caching**: [e.g., Redis, none]
- **Object Storage**: [e.g., S3, local filesystem]

### Infrastructure
- **Containerization**: [e.g., Docker, none]
- **Orchestration**: [e.g., Docker Compose, Kubernetes, none]
- **CI/CD**: [e.g., GitHub Actions, GitLab CI]
- **Cloud Provider**: [e.g., AWS, GCP, self-hosted]

### Observability
- **Logging**: [e.g., Winston, structured JSON logs]
- **Metrics**: [e.g., Prometheus, OpenTelemetry]
- **Tracing**: [e.g., Jaeger, Zipkin, SigNoz]
- **Monitoring**: [e.g., Grafana, Datadog]

## Project Structure

\`\`\`
[Paste tree output or describe folder structure]

Examples:
- src/
  - api/           # REST API routes
  - services/      # Business logic
  - database/      # Models, migrations
  - utils/         # Helper functions
- tests/           # Test files
- docs/            # Documentation
\`\`\`

**Key Directories**:
- **`[directory]`**: [Brief description]
- **`[directory]`**: [Brief description]

## Architecture Overview

\`\`\`mermaid
graph TD
    A[Client] --> B[API Gateway]
    B --> C[Service 1]
    B --> D[Service 2]
    C --> E[(Database)]
    D --> E
    C --> F[External API]
\`\`\`

**Architecture Type**: [e.g., Monolith, Microservices, Event-driven]

**Key Components**:
1. **[Component Name]**: [Brief description of responsibility]
2. **[Component Name]**: [Brief description of responsibility]

## Services (if applicable)

### [Service Name 1]
- **Purpose**: [What this service does]
- **Port**: [e.g., 3000]
- **Dependencies**: [Other services/databases it depends on]
- **Key Features**: [Brief list]

### [Service Name 2]
- **Purpose**: [What this service does]
- **Port**: [e.g., 3001]
- **Dependencies**: [Other services/databases it depends on]
- **Key Features**: [Brief list]

## Integration Points

### External APIs
| Service | Purpose | Auth Method | Docs |
|---------|---------|-------------|------|
| [API Name] | [Brief description] | [API Key/OAuth/JWT] | [Link] |

### Message Queues / Event Buses
- **[Queue/Topic Name]**: [What events/messages flow through it]

### Webhooks
- **[Webhook Name]**: [What triggers it, what it does]

## Data Flow

\`\`\`mermaid
sequenceDiagram
    participant Client
    participant API
    participant Service
    participant DB

    Client->>API: Request
    API->>Service: Process
    Service->>DB: Query
    DB-->>Service: Data
    Service-->>API: Result
    API-->>Client: Response
\`\`\`

**Key Flows**:
1. **[Flow Name]**: [Brief description of the data path]
2. **[Flow Name]**: [Brief description of the data path]

## Configuration

**Environment Variables** (see `.env.example`):
- **Required**:
  - `[VAR_NAME]`: [Description]
  - `[VAR_NAME]`: [Description]
- **Optional**:
  - `[VAR_NAME]`: [Description, default value]

**Config Files**:
- `[filename]`: [What it configures]

## Development Setup

\`\`\`bash
# Quick start
[commands to get up and running]

# Example:
npm install
npm run build:common  # If monorepo
docker-compose up -d  # Start dependencies
npm run migrate       # Setup database
npm run dev           # Start development server
\`\`\`

## Key Patterns & Conventions

### Code Organization
- [Pattern 1: e.g., "Services handle business logic, controllers handle HTTP"]
- [Pattern 2: e.g., "Database models use Sequelize with TypeScript strict mode"]

### Error Handling
- [How errors are handled: e.g., "All errors throw custom AppError class"]

### Authentication & Authorization
- [How auth works: e.g., "JWT tokens with Firebase validation"]

### Testing Strategy
- [Testing approach: e.g., "Unit tests with Vitest, integration tests with Supertest"]

## Common Tasks

> For detailed step-by-step guides, see [SOPs](../SOP/)

- **Add new endpoint**: [Brief 1-line summary or link to SOP]
- **Add database migration**: [Brief 1-line summary or link to SOP]
- **Deploy changes**: [Brief 1-line summary or link to SOP]

## Known Complexities

> Document any non-obvious or complex parts that new engineers should be aware of

**[Complex Area 1]**: [Why it's complex, where to look for details]

**[Complex Area 2]**: [Why it's complex, where to look for details]

## Additional Resources

- [Link to main README](../../README.md)
- [Link to API docs if separate]
- [Link to deployment docs if separate]
