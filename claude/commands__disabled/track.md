# Track Project Knowledge

Update and maintain the `.agent` knowledge base with current system state and architecture.

## Usage
```
/track              # Update existing .agent documentation
/track init         # Initialize .agent from scratch
/track [scope]      # Update specific area (e.g., /track api-service)
```

## Purpose
Maintain comprehensive, AI-friendly documentation in `.agent/` folder to:
- Keep architecture docs current with code changes
- Document new features and integrations
- Update SOPs based on learnings
- Ensure new engineers have accurate context

## What /track Does

**When initializing** (`/track init`):
1. Scan codebase structure (package.json, docker-compose, etc.)
2. Identify services, database schema, integrations
3. Generate comprehensive documentation in `.agent/`:
   - README.md (central index)
   - System/project_architecture.md
   - System/database_schema.md
   - System/integration_points.md
   - System/observability.md
   - SOP/*.md (common procedures)

**When updating** (`/track`):
1. Read existing `.agent/README.md` to understand current docs
2. Identify what changed since last update
3. Update relevant System docs or SOPs
4. Keep README.md index current
5. Remove outdated information

**When updating specific scope** (`/track api-service`):
1. Focus scan on specified area
2. Update only relevant documentation sections
3. Faster than full update

## Documentation Structure

`.agent/` folder contains:
- **README.md**: Central index with navigation tables
- **System/**: Technical architecture, database, integrations, observability
- **Tasks/**: Feature PRDs and implementation plans
- **SOP/**: Standard operating procedures for common tasks

## Smart Scanning Strategy

Focuses on high-value files that reveal architecture:
- Package manager files (package.json, etc.)
- Docker/config files (docker-compose.yml, tsconfig.json)
- Database models and migrations
- Main entry points (src/server.ts, src/index.ts)
- Existing documentation (README, docs/, etc.)

## Format Standards

All documentation uses text-based, version-controllable formats:
- **Architecture diagrams**: Mermaid (C4, sequence, flowchart)
- **Database schemas**: Mermaid ERD + markdown tables
- **API docs**: OpenAPI/Swagger specs when applicable
- **Tables/data**: Markdown tables

## Documentation Principles

- **Concise**: No huge docs unless complexity demands it
- **Consolidated**: Start with few files, split only when >800 lines
- **Current**: Remove outdated info (stale docs worse than no docs)
- **Cross-referenced**: Link related documents
- **Dated**: Include Created/Updated dates for tracking

## When to Use /track

**After major changes**:
- Added/removed services
- Database schema changes
- New integrations
- Architecture refactoring

**Periodic reviews**:
- Quarterly to ensure accuracy
- After completing major features
- When onboarding new team members

**Before handing off**:
- Ensure knowledge is captured
- Document decisions made
- Update SOPs based on learnings

## Example Usage

```bash
# Initialize .agent folder for new project
/track init

# Update after adding new service
/track

# Update only API service docs
/track api-service

# Update after database schema changes
/track database
```

## Integration with /recall

Use together for complete knowledge management:
- **`/track`**: Maintain/update .agent documentation
- **`/recall`**: Load context from .agent when needed

See: `/recall` command for retrieving knowledge
