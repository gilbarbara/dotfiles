# Recall Project Knowledge

Load relevant context from the `.agent` knowledge base to inform current work.

## Usage
```
/recall                           # Show .agent documentation index
/recall [topic]                   # Load specific topic context
/recall database schema           # Load database schema doc
/recall fromSat                   # Find and load info about fromSat pattern
/recall how to add a service      # Load adding_new_service.md SOP
/recall debugging                 # Load debugging SOP
/recall api architecture          # Load API service details
/recall signalwire integration    # Load SignalWire integration info
```

## Purpose
Quickly inject relevant context from `.agent/` documentation into the current conversation to:
- Understand system architecture before making changes
- Review database schema before queries
- Follow established procedures (SOPs)
- Learn critical patterns (e.g., fromSat flag)
- Understand integration points

## How /recall Works

1. **Search .agent files** for the requested topic
2. **Load relevant sections** into conversation context
3. **Provide summary** with option to dive deeper
4. **Suggest related docs** for complete understanding

## What to Recall

### System Architecture
```
/recall architecture              # Load project_architecture.md
/recall services                  # Load service descriptions
/recall data flow                 # Load data flow diagrams
```

### Database
```
/recall database                  # Load database_schema.md
/recall schema                    # Same as above
/recall migrations                # Load migration info
/recall [table name]              # Load specific table details
```

### Integrations
```
/recall signalwire               # SignalWire integration
/recall aws                      # AWS services integration
/recall firebase                 # Firebase auth integration
/recall protobuf                 # Protocol Buffers usage
```

### Patterns & Concepts
```
/recall fromSat                  # Critical routing pattern
/recall redis streams            # Redis Streams architecture
/recall e2e encryption           # End-to-end encryption
```

### Procedures (SOPs)
```
/recall migrations               # Database migration SOP
/recall adding service           # Adding new service SOP
/recall debugging                # Debugging services SOP
```

### Observability
```
/recall telemetry               # OpenTelemetry setup
/recall logging                 # Logging configuration
/recall monitoring              # SigNoz dashboards
```

## Smart Context Loading

Instead of manually:
1. Reading .agent/README.md
2. Finding the right file
3. Reading the entire file
4. Extracting relevant parts

Just use: **`/recall [topic]`** and get focused context immediately.

## Example Workflow

**Scenario**: Need to add a new field to database

```bash
User: I need to add a timezone field to the Numbers table

You: /recall database migrations

[System loads .agent/SOP/database_migrations.md]

Claude: Based on the database migrations SOP, here's what you need to do:
1. Create migration: `npx sequelize-cli migration:generate --name add-timezone-to-numbers`
2. Edit migration file to add column
3. Update model in common/src/db/models/number.ts
4. Build common package: `npm run build:common`
5. Run migration: `npm run migrate`
...
```

## Integration with /track

Work together for complete knowledge management:
- **`/track`**: Update .agent when things change
- **`/recall`**: Load .agent context when needed

**Workflow**:
1. `/recall` - Load context before starting work
2. [Do the work]
3. `/track` - Update documentation after completion

## Benefits

**vs. Manual File Reading**:
- ✅ Faster - No multi-step navigation
- ✅ Focused - Only loads relevant info
- ✅ Natural language - No need to remember file paths
- ✅ Smart search - Finds info across multiple files

**vs. Generic Questions**:
- ✅ Accurate - Based on actual project docs
- ✅ Current - Reflects latest tracked state
- ✅ Complete - Includes all architectural context

## Tips

- **Be specific**: `/recall signalwire webhooks` vs `/recall signalwire`
- **Use natural language**: `/recall how to debug websockets` works
- **Combine topics**: `/recall api database schema`
- **Check index first**: `/recall` shows what's available
