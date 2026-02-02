# Database Schema

> **Related Documentation**: [Project Architecture](./project_architecture.md)

## Overview

**Database Type**: [PostgreSQL/MySQL/MongoDB/etc.]

**ORM/Query Layer**: [Sequelize/Prisma/TypeORM/Raw SQL/etc.]

**Migration Tool**: [Sequelize Migrations/Prisma Migrate/Flyway/etc.]

## Entity Relationship Diagram

\`\`\`mermaid
erDiagram
    USER ||--o{ POST : creates
    USER ||--o{ COMMENT : writes
    POST ||--o{ COMMENT : has

    USER {
        uuid id PK
        string email UK
        string name
        timestamp createdAt
        timestamp updatedAt
    }

    POST {
        uuid id PK
        uuid userId FK
        string title
        text content
        enum status
        timestamp createdAt
        timestamp updatedAt
    }

    COMMENT {
        uuid id PK
        uuid userId FK
        uuid postId FK
        text content
        timestamp createdAt
    }
\`\`\`

## Tables

### [TableName1] (e.g., `users`)

**Purpose**: [Brief description of what this table stores]

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| `id` | UUID | PK, NOT NULL | Primary identifier |
| `email` | VARCHAR(255) | UNIQUE, NOT NULL | User email address |
| `name` | VARCHAR(255) | NOT NULL | User display name |
| `created_at` | TIMESTAMP | NOT NULL, DEFAULT NOW() | Record creation time |
| `updated_at` | TIMESTAMP | NOT NULL, DEFAULT NOW() | Last update time |

**Indexes**:
- `PRIMARY KEY (id)`
- `UNIQUE INDEX idx_users_email (email)`
- `INDEX idx_users_created_at (created_at)`

**Relationships**:
- One-to-many with `posts` (user can have multiple posts)
- One-to-many with `comments` (user can write multiple comments)

---

### [TableName2] (e.g., `posts`)

**Purpose**: [Brief description]

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| `id` | UUID | PK, NOT NULL | Primary identifier |
| `user_id` | UUID | FK, NOT NULL | Author reference |
| `title` | VARCHAR(500) | NOT NULL | Post title |
| `content` | TEXT | NOT NULL | Post content |
| `status` | ENUM | NOT NULL, DEFAULT 'draft' | publish/draft/archived |
| `created_at` | TIMESTAMP | NOT NULL, DEFAULT NOW() | Creation time |
| `updated_at` | TIMESTAMP | NOT NULL, DEFAULT NOW() | Last update time |

**Indexes**:
- `PRIMARY KEY (id)`
- `FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE`
- `INDEX idx_posts_user_id (user_id)`
- `INDEX idx_posts_status_created (status, created_at)`

**Relationships**:
- Many-to-one with `users` (post belongs to one user)
- One-to-many with `comments` (post can have multiple comments)

---

### [TableName3] (e.g., `comments`)

**Purpose**: [Brief description]

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| `id` | UUID | PK, NOT NULL | Primary identifier |
| `user_id` | UUID | FK, NOT NULL | Commenter reference |
| `post_id` | UUID | FK, NOT NULL | Post reference |
| `content` | TEXT | NOT NULL | Comment text |
| `created_at` | TIMESTAMP | NOT NULL, DEFAULT NOW() | Creation time |

**Indexes**:
- `PRIMARY KEY (id)`
- `FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE`
- `FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE`
- `INDEX idx_comments_post_id (post_id)`
- `INDEX idx_comments_user_id (user_id)`

**Relationships**:
- Many-to-one with `users`
- Many-to-one with `posts`

---

## Enums & Custom Types

### [EnumName] (e.g., `post_status`)
\`\`\`sql
CREATE TYPE post_status AS ENUM ('draft', 'published', 'archived');
\`\`\`

**Values**:
- `draft`: Post is being written
- `published`: Post is publicly visible
- `archived`: Post is hidden but preserved

---

## Key Relationships Summary

\`\`\`mermaid
graph LR
    U[Users] -->|1:N| P[Posts]
    U -->|1:N| C[Comments]
    P -->|1:N| C
\`\`\`

---

## Migrations

**Migration Location**: [e.g., `src/database/migrations/`]

**How to run migrations**:
\`\`\`bash
npm run migrate          # Run all pending migrations
npm run migrate:undo     # Rollback last migration
npm run migrate:create   # Create new migration file
\`\`\`

**Migration Naming Convention**: [e.g., `YYYYMMDDHHMMSS-description.js`]

**Recent Migrations** (last 5):
1. `20240115120000-create-users-table.js` - Initial user table
2. `20240116090000-create-posts-table.js` - Add posts
3. `20240117143000-add-posts-status-index.js` - Performance improvement
4. `20240118100000-create-comments-table.js` - Add commenting feature
5. `20240119160000-add-user-email-verification.js` - Add email verification

---

## Seeding

**Seed Location**: [e.g., `src/database/seeders/`]

**How to seed**:
\`\`\`bash
npm run seed           # Run all seeders
npm run seed:undo:all  # Clear all seeded data
\`\`\`

**Available Seeds**:
- `demo-users.js` - Creates test users
- `demo-posts.js` - Creates sample posts
- `demo-comments.js` - Creates sample comments

---

## Database Connection

**Connection Pool Settings**:
\`\`\`javascript
{
  max: 20,           // Maximum connections
  min: 5,            // Minimum connections
  idle: 10000,       // Idle timeout (ms)
  acquire: 30000     // Acquisition timeout (ms)
}
\`\`\`

**Environment Variables**:
- `DATABASE_URL` - Full connection string
- `DB_HOST` - Database host
- `DB_PORT` - Database port (default: 5432)
- `DB_NAME` - Database name
- `DB_USER` - Database user
- `DB_PASSWORD` - Database password

---

## Performance Considerations

### Indexes
- All foreign keys are indexed
- Composite indexes for common query patterns (e.g., `status + created_at`)
- Unique indexes on email, username, etc.

### Query Optimization Tips
- [Tip 1: e.g., "Use eager loading for user + posts queries"]
- [Tip 2: e.g., "Avoid N+1 queries when loading comments"]
- [Tip 3: e.g., "Use pagination for large result sets"]

---

## Common Queries

### [Query Purpose 1]
\`\`\`sql
-- Get user's recent published posts with comment count
SELECT p.*, COUNT(c.id) as comment_count
FROM posts p
LEFT JOIN comments c ON p.id = c.post_id
WHERE p.user_id = ? AND p.status = 'published'
GROUP BY p.id
ORDER BY p.created_at DESC
LIMIT 10;
\`\`\`

### [Query Purpose 2]
\`\`\`sql
-- Find active users (posted in last 30 days)
SELECT u.*, COUNT(p.id) as post_count
FROM users u
JOIN posts p ON u.id = p.user_id
WHERE p.created_at > NOW() - INTERVAL '30 days'
GROUP BY u.id
ORDER BY post_count DESC;
\`\`\`

---

## Database Maintenance

### Backups
- **Frequency**: [e.g., Daily at 2 AM UTC]
- **Retention**: [e.g., 30 days]
- **Location**: [e.g., S3 bucket `backups/database/`]

### Monitoring
- **Key Metrics**: Connection pool usage, slow queries (>100ms), deadlocks
- **Alerts**: [What triggers alerts]

---

## Known Issues & Gotchas

**[Issue 1]**: [Description and workaround]

**[Issue 2]**: [Description and workaround]

---

## Additional Resources

- [Database documentation link]
- [ORM documentation link]
- [Migration guide SOP](../SOP/database_migrations.md)
