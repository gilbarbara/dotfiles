# 📚 Documentation Index

This `.agent` folder contains comprehensive documentation for understanding and working with this project. All critical information for engineers to gain full context is organized here.

## Documentation Structure

### System Documentation

Technical architecture, current state of the system, project structure, tech stack, integration points, database schema, and core functionalities.

### Stories Documentation

Feature PRDs and implementation plans. Each story document includes problem statements, requirements, technical design, implementation phases, and post-launch reviews.

### SOP (Standard Operating Procedures)

Best practices and procedures for common development tasks. Includes failure logs to track and learn from incidents.

---

## 🗂️ System Documentation

Current technical architecture and system configuration.

| Document                 | Description                                                               | Path                                                             |
| ------------------------ | ------------------------------------------------------------------------- | ---------------------------------------------------------------- |
| **Project Architecture** | System overview, tech stack, structure, integration points, and data flow | [System/project_architecture.md](System/project_architecture.md) |
| **Database Schema**      | Tables, relationships, ERD, migrations, and query patterns                | [System/database_schema.md](System/database_schema.md)           |
| **API Integration**      | API endpoints, external integrations, authentication flows, OpenAPI specs | [System/api_integration.md](System/api_integration.md)           |

---

## 📋 Stories Documentation

Feature PRDs and implementation plans.

| Document           | Description                                      | Path                                               |
| ------------------ | ------------------------------------------------ | -------------------------------------------------- |
| **[Feature Name]** | [One-line description of what this feature does] | [Stories/feature-name.md](Stories/feature-name.md) |

**When adding new stories:**

- Use the [story template](~/.claude/templates/story_template.md)
- Include Created, Target Completion, and Actual Completion dates
- Update this table with a concise one-line description.
- Track progress in the Implementation Log section
- Complete Post-Launch Review after deployment

---

## 📝 SOP (Standard Operating Procedures)

Best practices and procedures for common development tasks.

| Document             | Description                                        | Path                                           |
| -------------------- | -------------------------------------------------- | ---------------------------------------------- |
| **[Procedure Name]** | [One-line description of what this procedure does] | [SOP/procedure-name.md](SOP/procedure-name.md) |

**When adding new SOPs:**

- Use the [SOP template](~/.claude/templates/sop_template.md)
- Include Created, Last Updated, and Last Reviewed dates
- Update Failure Log section when incidents occur
- Add this entry to the table above

---

## 🚀 Quick Start Guide

### For New Engineers

1. **Start with [Project Architecture](System/project_architecture.md)** to understand the overall system, tech stack, and project structure
2. **Review the database schema** if working with data models or APIs
3. **Check relevant SOPs** for common tasks you'll be performing
4. **Reference `CLAUDE.md`** in the root directory for AI-assisted development guidelines
5. **Review active stories** to see what features are currently in development

### For Adding New Documentation

**Creating a new System document:**

1. Use the appropriate template from `~/.claude/templates/`
2. Follow the format and sections in the template
3. Add an entry to the System Documentation table above
4. Link to it from related documents

**Creating a new Story:**

1. Copy `~/.claude/templates/story_template.md`
2. Fill in all metadata (dates, status, owner)
3. Complete at least the Problem Statement and Requirements sections
4. Add to the Stories Documentation table above
5. Update Implementation Log throughout development
6. Complete Post-Launch Review after deployment

**Creating a new SOP:**

1. Copy `~/.claude/templates/sop_template.md`
2. Include all dates (Created, Last Updated, Last Reviewed)
3. Write clear step-by-step procedures
4. Add to the SOP table above
5. **Update Failure Log** whenever this SOP is needed due to an incident
6. Review and update quarterly or after major incidents

---

## 🔧 Maintenance

### When to Update This README

- **Immediately** when adding new documentation files
- When removing or consolidating documentation
- When document descriptions change significantly
- Quarterly review to ensure accuracy

### Document Organization Guidelines

**Start consolidated:**

- Default to single comprehensive document (e.g., just `project_architecture.md`)
- Only split when files exceed ~800 lines or topics are independently maintained

**Keep consolidated when:**

- Total content under ~500 lines
- Topics are tightly coupled
- Frequent cross-referencing needed

**Split when:**

- Single file exceeds ~800 lines
- Topics maintained by different teams
- Sections rarely referenced together
- Clear separation improves navigation

### Using Templates

Templates are available at `~/.claude/templates/`:

| Template                             | When to Use                                       | Key Features                                      |
| ------------------------------------ | ------------------------------------------------- | ------------------------------------------------- |
| **project_architecture_template.md** | Documenting system overview, tech stack, services | Mermaid diagrams, integration points, dev setup   |
| **database_schema_template.md**      | Documenting database structure                    | ERD diagrams, table specs, migrations, indexes    |
| **sop_template.md**                  | Creating step-by-step procedures                  | Prerequisites, steps, failure log, rollback       |
| **story_template.md**                | Planning features/initiatives                     | PRD, technical design, phases, post-launch review |
| **api_integration_template.md**      | Documenting APIs and integrations                 | OpenAPI specs, auth flows, endpoints, webhooks    |

**Template Best Practices:**

- Remove unused sections (keep it concise!)
- Customize based on project needs
- Include "Related Documentation" links at the top
- Use Mermaid for diagrams (text-based, version-controllable)
- Keep tables in markdown format

---

## 📐 Documentation Standards

**Format Preferences:**

- **Architecture diagrams**: Mermaid (C4, sequence, flowchart)
- **Database schemas**: Mermaid ERD + markdown tables
- **API docs**: OpenAPI/Swagger specs when applicable
- **Data tables**: Markdown tables
- **All formats**: Text-based and version-controllable

**Why these formats?**

- Version controllable (plain text)
- Render in GitHub/modern editors
- No external tools needed
- AI-friendly for updates

**Core Principle**: Keep documentation **CONCISE**. No huge documents unless complexity demands it. Start minimal, expand only when necessary.

---

## 🤖 AI-Assisted Documentation

When using Claude Code or other AI tools:

- Reference this README to understand existing documentation
- Use `/track` command to initialize or update documentation
- Templates are automatically referenced by AI tools
- Keep the AI context focused (specify scope: "document the API service" vs "document everything")

---

## 📞 Questions?

If you can't find what you're looking for:

1. Check the [Project Architecture](System/project_architecture.md) for system overview
2. Review the main project `README.md` for setup instructions
3. Check `CLAUDE.md` in the root for development guidelines
4. Ask in [team channel/Slack/Discord]

---

**Last Updated**: [YYYY-MM-DD]

**Maintained By**: [Team/Person]
