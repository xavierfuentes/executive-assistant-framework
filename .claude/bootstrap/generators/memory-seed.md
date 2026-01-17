# Memory Seed Generator

Seeds the memory graph with initial entities from onboarding data.

## Purpose

The memory graph is the persistent knowledge store that grows over time. Seeding it during onboarding:
- Establishes the relationship network
- Provides context for future interactions
- Enables relationship-aware assistance from day one

## Entity Types Created

| Type | Source | Purpose |
|------|--------|---------|
| `person` | People section | Individual profiles |
| `relationship` | Inferred from roles | Connections between people |
| `user` | Identity section | The user themselves |

## Relationship Type Schema

| Type | From | To | Inverse | Read As | Use When |
|------|------|----|---------|---------|----------|
| `reports-to` | subordinate | superior | `manages` | "X reports to Y" | Formal reporting line |
| `manages` | superior | subordinate | `reports-to` | "X manages Y" | Formal reporting line |
| `works-with` | person | peer | `works-with` | "X works with Y" | Peer at same level, regular interaction |
| `collaborates-with` | person | collaborator | `collaborates-with` | "X collaborates with Y" | Cross-functional partner on specific responsibilities |

**Relationship Type Guidance:**

- **`works-with`**: Use for peers at the same organisational level with broad, ongoing interaction. Examples: fellow VPs, leadership team members, adjacent team leads.

- **`collaborates-with`**: Use for people you work with on specific responsibilities or projects, regardless of level. Examples: the Talent partner for your hiring responsibility, the Finance lead for your budget planning.

**Bidirectional Rule:** For all relationship types, create BOTH directions:
- User → Manager: `reports-to`
- Manager → User: `manages`

## Entity Naming Convention

### Slug Rules
- Lowercase only
- Hyphens for word separation
- Maximum 50 characters
- Must match: `^[a-z][a-z0-9-]{0,48}[a-z0-9]?$`

### Handling Name Collisions
If two entities would have the same name:
1. Append role: `john-smith-engineering`
2. Add disambiguation observation

---

## Entity Templates

### User Entity

One entity for the user themselves:

```
Entity name: {user-slug}
Type: user
Observations:
  - "Role: {title} at {company}"
  - "Reports to: {manager_name}"
  - "Timezone: {timezone}"
  - "Onboarded: {date}"
```

**Example:**
```
Entity name: sarah-chen
Type: user
Observations:
  - "Role: VP Engineering at Acme Corp"
  - "Reports to: James Wright (CTO)"
  - "Timezone: Europe/London"
  - "Onboarded: 2024-01-15"
```

### Manager Entity

```
Entity name: {manager-slug}
Type: person
Observations:
  - "Role: {title}"
  - "Company: {company}"
  - "Relationship: {user}'s manager"
  - "Priorities: {priorities}"
  - "Update preference: {preference}"
  - "Profile: people/manager.md"
```

**Example:**
```
Entity name: james-wright
Type: person
Observations:
  - "Role: CTO"
  - "Company: Acme Corp"
  - "Relationship: sarah-chen's manager"
  - "Priorities: Platform scalability, team growth, tech debt"
  - "Update preference: Weekly async, brief bullets"
  - "Profile: people/manager.md"
```

### Direct Report Entity

```
Entity name: {person-slug}
Type: person
Observations:
  - "Role: {role}"
  - "Company: {company}"
  - "Relationship: Reports to {user}"
  - "Tenure: {tenure}"
  - "Focus: {current_focus}"
  - "Development: {development_areas}"
  - "Profile: people/team/{slug}.md"
```

**Example:**
```
Entity name: mike-johnson
Type: person
Observations:
  - "Role: Senior Engineering Manager"
  - "Company: Acme Corp"
  - "Relationship: Reports to sarah-chen"
  - "Tenure: 18 months"
  - "Focus: Backend platform, API redesign"
  - "Development: Cross-team collaboration"
  - "Profile: people/team/mike-johnson.md"
```

### Stakeholder Entity

```
Entity name: {person-slug}
Type: person
Observations:
  - "Role: {role}"
  - "Company: {company}"
  - "Relationship: {relationship_type} to {user}"
  - "Context: {what_we_interact_about}"
  - "Communication: {preferences}"
  - "Profile: people/stakeholders/{slug}.md"
```

**Example:**
```
Entity name: amanda-liu
Type: person
Observations:
  - "Role: VP Product"
  - "Company: Acme Corp"
  - "Relationship: Peer to sarah-chen"
  - "Context: Roadmap planning, capacity allocation"
  - "Communication: Slack for quick, meetings for decisions"
  - "Profile: people/stakeholders/amanda-liu.md"
```

---

## Relationships Created

After creating entities, establish relationships:

### Manager Relationship (Bidirectional)

Create both directions:
```
Relation:
  from: {user-slug}
  to: {manager-slug}
  type: reports-to

Relation:
  from: {manager-slug}
  to: {user-slug}
  type: manages
```

### Direct Report Relationships (Bidirectional)

For each direct report, create both directions:
```
Relation:
  from: {report-slug}
  to: {user-slug}
  type: reports-to

Relation:
  from: {user-slug}
  to: {report-slug}
  type: manages
```

### Peer Relationships (Bidirectional)

For stakeholders marked as peers, create BOTH directions:
```
Relation:
  from: {user-slug}
  to: {stakeholder-slug}
  type: works-with

Relation:
  from: {stakeholder-slug}
  to: {user-slug}
  type: works-with
```

Note: Although `works-with` is semantically symmetric, the memory graph stores directed edges. Creating both directions ensures queries from either entity return the peer relationship.

### Collaborator Relationships (Bidirectional)

For people identified as collaborators on specific responsibilities:
```
Relation:
  from: {user-slug}
  to: {collaborator-slug}
  type: collaborates-with

Relation:
  from: {collaborator-slug}
  to: {user-slug}
  type: collaborates-with
```

Note: `collaborates-with` is distinct from `works-with`. Use `collaborates-with` for responsibility-specific partnerships (e.g., "Talent team" for hiring), and `works-with` for general peer relationships (e.g., "VP Product").

---

## Generation Process

### Step 1: Create User Entity

```javascript
mcp__memory__create_entities([{
  name: "{user-slug}",
  entityType: "user",
  observations: [
    "Role: {title} at {company}",
    "Reports to: {manager_name}",
    "Timezone: {timezone}",
    "Onboarded: {date}"
  ]
}])
```

### Step 2: Create Person Entities

For manager + all direct reports + all stakeholders:

```javascript
mcp__memory__create_entities([
  {
    name: "{manager-slug}",
    entityType: "person",
    observations: [/* manager observations */]
  },
  {
    name: "{report-1-slug}",
    entityType: "person",
    observations: [/* report 1 observations */]
  },
  // ... all people
])
```

### Step 3: Create Relationships

```javascript
mcp__memory__create_relations([
  {
    from: "{user-slug}",
    to: "{manager-slug}",
    relationType: "reports-to"
  },
  {
    from: "{report-1-slug}",
    to: "{user-slug}",
    relationType: "reports-to"
  },
  // ... all relationships
])
```

---

## Full Example

### Input (from answers.md)

```markdown
## Identity
- **Name:** Sarah Chen
- **Title:** VP Engineering
- **Company:** Acme Corp
- **Reports to:** James Wright
- **Manager title:** CTO

## People

### Manager
- **Name:** James Wright
- **Title:** CTO
- **Priorities:** Scalability, team growth

### Direct Reports
#### Mike Johnson
- **Role:** Senior Engineering Manager
- **Tenure:** 18 months
- **Focus:** Backend platform

### Stakeholders
#### Amanda Liu
- **Role:** VP Product
- **Relationship:** Peer
```

### Generated Commands

```javascript
// Step 1: Create all entities
mcp__memory__create_entities([
  {
    name: "sarah-chen",
    entityType: "user",
    observations: [
      "Role: VP Engineering at Acme Corp",
      "Reports to: James Wright (CTO)",
      "Timezone: Europe/London",
      "Onboarded: 2024-01-15"
    ]
  },
  {
    name: "james-wright",
    entityType: "person",
    observations: [
      "Role: CTO",
      "Company: Acme Corp",
      "Relationship: sarah-chen's manager",
      "Priorities: Scalability, team growth",
      "Profile: people/manager.md"
    ]
  },
  {
    name: "mike-johnson",
    entityType: "person",
    observations: [
      "Role: Senior Engineering Manager",
      "Company: Acme Corp",
      "Relationship: Reports to sarah-chen",
      "Tenure: 18 months",
      "Focus: Backend platform",
      "Profile: people/team/mike-johnson.md"
    ]
  },
  {
    name: "amanda-liu",
    entityType: "person",
    observations: [
      "Role: VP Product",
      "Company: Acme Corp",
      "Relationship: Peer to sarah-chen",
      "Profile: people/stakeholders/amanda-liu.md"
    ]
  },
  {
    name: "talent-team-lead",
    entityType: "person",
    observations: [
      "Role: Talent Acquisition Lead",
      "Collaborates on: Engineering Hiring responsibility",
      "Profile: people/stakeholders/talent-team-lead.md"
    ]
  }
])

// Step 2: Create relationships (bidirectional for reporting lines)
mcp__memory__create_relations([
  // User → Manager (reports-to)
  {
    from: "sarah-chen",
    to: "james-wright",
    relationType: "reports-to"
  },
  // Manager → User (manages) - inverse direction
  {
    from: "james-wright",
    to: "sarah-chen",
    relationType: "manages"
  },
  // Direct report → User (reports-to)
  {
    from: "mike-johnson",
    to: "sarah-chen",
    relationType: "reports-to"
  },
  // User → Direct report (manages) - inverse direction
  {
    from: "sarah-chen",
    to: "mike-johnson",
    relationType: "manages"
  },
  // Peer relationship (bidirectional for query completeness)
  {
    from: "sarah-chen",
    to: "amanda-liu",
    relationType: "works-with"
  },
  {
    from: "amanda-liu",
    to: "sarah-chen",
    relationType: "works-with"
  },
  // Collaborator relationship (responsibility-specific partnership)
  {
    from: "sarah-chen",
    to: "talent-team-lead",
    relationType: "collaborates-with"
  },
  {
    from: "talent-team-lead",
    to: "sarah-chen",
    relationType: "collaborates-with"
  }
])
```

---

## Verification Checklist

After seeding memory:

- [ ] User entity exists with correct role
- [ ] Manager entity exists with priorities
- [ ] All direct report entities exist
- [ ] All key stakeholder entities exist
- [ ] reports-to relationships correct (user→manager, reports→user)
- [ ] works-with relationships for peers
- [ ] All entities have profile file path in observations

## Edge Cases

### No Manager

If user is CEO/founder with no manager:
- Skip manager entity creation
- Skip reports-to relationship for user

### Duplicate Names

If two people have the same name:
- Append role to slug: `john-smith-product`, `john-smith-engineering`
- Add distinguishing observation: "Note: Not to be confused with John Smith (Engineering)"

### Partial Data

If person data is incomplete:
- Create entity with available observations
- Add observation: "Profile incomplete - needs enrichment"
- Entity can be updated later via `add_observations`

**Partial Entity Relationships:**

When an entity is created with incomplete data (marked "Profile incomplete - needs enrichment"):
- **Still create relationships** for that entity if the relationship is known
- Add observation to the relationship context: "Note: Related entity has incomplete profile"
- The relationship enables discovery even if full details are missing

Example:
```javascript
// Entity with partial data
{
  name: "incomplete-stakeholder",
  entityType: "person",
  observations: [
    "Role: Unknown - needs enrichment",
    "Profile incomplete - needs enrichment"
  ]
}

// Relationship still created
{
  from: "sarah-chen",
  to: "incomplete-stakeholder",
  relationType: "works-with"
}
```

This ensures the knowledge graph captures known connections even when entity details are sparse.

---

## Ongoing Maintenance

The memory graph grows over time. After initial seeding:

**Add observations** when learning new facts:
```javascript
mcp__memory__add_observations([{
  entityName: "mike-johnson",
  contents: ["Promoted to Director: 2024-03-01"]
}])
```

**Create new entities** when discovering new people:
```javascript
mcp__memory__create_entities([{
  name: "new-person",
  entityType: "person",
  observations: ["Discovered in context of X"]
}])
```

**The assistant does this organically** as part of the self-improvement protocol - no manual intervention needed.
