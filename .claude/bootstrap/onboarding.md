# Onboarding Workflow

Guide for onboarding a new executive to generate their personalised command centre.

## Philosophy

- **Document-first**: Extract from existing materials before asking questions
- **Confirm, don't interrogate**: Present extracted data for validation
- **Gap-fill only**: Ask questions only for missing information
- **Explain the why**: Every question states what it generates

---

## Phase 0: Document Collection

**Purpose:** Gather existing materials to minimise questions.

### Script

```
Welcome! I'm going to help you set up your AI command centre.

To make this quick, share any of these you have - just paste text or drop files:

1. **Your CV/resume** - I'll extract your background, skills, career history
2. **Your job description** (or a similar one for your role) - I'll extract responsibilities and expectations
3. **Company overview** - About page, investor deck, internal wiki - helps me understand context
4. **Org chart** (screenshot or description) - I'll map your reporting relationships

Paste what you have, or type "skip" to answer questions instead.
```

### Processing

For each document provided:
1. Run appropriate extraction prompt (see `extraction-prompts.md`)
2. Store raw extraction in working memory
3. Move to Phase 1 for confirmation

If no documents provided:
1. Mark all fields as "needs question"
2. Move to Phase 1 with full question set

---

## Phase 1: Identity & Role

**Purpose:** Establish who the user is and their position.
**Generates:** CLAUDE.md header, file paths, timezone settings.

### If Documents Provided

```
Here's what I extracted from your documents:

**Name:** {extracted_name}
**Title:** {extracted_title}
**Company:** {extracted_company}
**Reports to:** {extracted_manager} ({extracted_manager_title})
**Location/Timezone:** {extracted_location}

Please correct anything that's wrong, or say "confirmed" to continue.
```

### Gap-Fill Questions

Only ask if not extracted:

| Question | Why Asked | Generates |
|----------|-----------|-----------|
| What's your full name? | Used in command centre header | CLAUDE.md: "Helping **{Name}**" |
| What's your job title? | Determines file paths and context | Skill paths, CLAUDE.md header |
| What company do you work for? | Context for all interactions | CLAUDE.md: "{Company} Command Centre" |
| Who do you report to? (Name and title) | Establishes reporting line | `people/manager.md`, memory graph |
| What timezone are you in? | Scheduling, date formatting | CLAUDE.md rules, calendar handling |

### Validation

- [ ] Name captured (not empty)
- [ ] Title captured (not empty)
- [ ] Company captured (not empty)
- [ ] Manager name and title captured (or "N/A" for founders/CEOs)
- [ ] Timezone captured (valid IANA timezone)

---

## Phase 2: Responsibilities Discovery

**Purpose:** Identify core responsibilities that become skills.
**Generates:** Skills, workflows, data structures.

### If Job Description Provided

```
From your job description, I identified these core responsibilities:

1. **{responsibility_1}**
2. **{responsibility_2}**
3. **{responsibility_3}**
...

For the initial setup, I'll create detailed skills for your top 5-7. We can add the rest as we work together.

Which of these are your **highest priority** right now? (List numbers, or say "all" if under 7)
```

### Gap-Fill Questions

If no JD or incomplete extraction:

```
What are your core responsibilities?

List the main areas you're accountable for. Examples:
- "Engineering hiring and team growth"
- "Product roadmap and delivery"
- "Investor relations and fundraising"
- "Customer success and retention"

Don't worry about being exhaustive - we'll discover more as we work together.
```

### Responsibility Deep-Dive

For each priority responsibility (top 5-7):

```
Let's dig into **{responsibility_name}**:

1. **What does success look like?**
   (Specific, measurable if possible - e.g., "90-day retention above 85%")

2. **Who do you collaborate with on this?**
   (Names or roles - e.g., "Talent team, hiring managers")

3. **What data do you track?**
   (Metrics, documents, systems - e.g., "Pipeline in Greenhouse, offer acceptance rate")

4. **What are the recurring tasks?**
   (Things you do weekly/monthly - e.g., "Weekly pipeline review, monthly hiring retro")
```

### Validation

- [ ] At least 2 responsibilities captured
- [ ] Priority 5-7 identified for initial skill generation
- [ ] Each priority responsibility has:
  - [ ] Success criteria defined
  - [ ] At least one collaborator identified
  - [ ] At least one data source identified
  - [ ] At least one recurring task identified

---

## Phase 3: People & Relationships

**Purpose:** Map the user's professional network.
**Generates:** `people/` directory, memory graph entities.

### Entry Question

```
Do you manage people directly? (yes/no)
```

If yes → Ask direct reports questions
If no → Skip to stakeholders

### Direct Reports

```
Tell me about your direct reports. For each person, I need:
- Name
- Role/title
- How long they've been in the role
- Their current focus areas or challenges

You can paste LinkedIn screenshots, share their CVs, or just describe them.
```

For each direct report mentioned:
```
For **{name}** ({role}):
- What are they currently focused on?
- Any development areas or challenges I should know about?
- How do you typically communicate? (Slack, email, frequency)
```

### Stakeholders

```
Who are your key stakeholders outside your direct team?

Think about:
- Peers you collaborate with regularly
- Senior leaders you update or get input from
- Cross-functional partners (finance, legal, HR, etc.)
- External relationships (board members, investors, key customers)

List names and their relationship to you.
```

For each stakeholder (top 10):
```
For **{name}**:
- What's their role/title?
- What do you typically interact about?
- Any preferences for how they like to communicate or receive updates?
```

### Manager Deep-Dive

```
Tell me more about your relationship with {manager_name}:

1. What are their current priorities?
2. How do they prefer to receive updates from you?
3. How often do you meet?
4. Anything specific they care about that I should always consider?
```

### Validation

- [ ] Manager relationship documented
- [ ] If manages people: at least 1 direct report captured with context
- [ ] At least 2 stakeholders identified
- [ ] Key people have communication preferences noted

---

## Phase 4: Operational Cadence

**Purpose:** Understand recurring rhythms of work.
**Generates:** Workflows, agents, calendar patterns.

### Meetings

```
What recurring meetings drive your week?

For each, tell me:
- Type (1:1 with report, 1:1 with manager, team meeting, cross-functional, etc.)
- Frequency (weekly, fortnightly, monthly)
- Who's involved
- What's the purpose

Example: "Weekly 1:1 with each direct report - coaching, blockers, priorities"
```

#### Meeting Type Reference

| Type | You're Meeting With | Typical Purpose |
|------|---------------------|-----------------|
| 1:1 (your reports) | Direct reports | Coaching, blockers, development |
| 1:1 (your manager) | Your manager | Updates, alignment, support |
| 1:1 (peers/upward) | Peers, skip-levels | Visibility, cross-functional |
| Team meeting | Your full team | Coordination, announcements |
| Cross-functional | Other teams | Projects, dependencies |
| All-hands | Large group | Company updates |
| Leadership/Exec | Senior leadership | Strategic decisions |
| External | Customers, vendors, candidates | Varies |

### Reporting Cycles

```
What regular reports or updates do you produce?

Examples:
- "Weekly engineering update to leadership"
- "Monthly board deck section"
- "Quarterly OKR review"

For each: what's it called, how often, who's the audience?
```

### Key Dates

```
Are there any key dates or recurring deadlines I should know about?

Examples:
- Board meetings (quarterly)
- Performance review cycles
- Budget planning periods
- Product launches or milestones
```

### Validation

- [ ] At least 2 recurring meetings captured
- [ ] Meeting types and participants documented
- [ ] Any regular reporting cycles captured
- [ ] Key dates noted (if any)

---

## Phase 5: Personal Preferences

**Purpose:** Understand working style and preferences.
**Generates:** CLAUDE.md rules, tone settings, behavioural guidelines.

### Communication Style

```
How should I communicate with you?

1. **Language:** British English, American English, or other?

2. **Tone:** How do you like information presented?
   - Direct and brief vs. thorough and detailed
   - Formal vs. casual
   - Just facts vs. with recommendations

3. **Format preferences:**
   - Bullet points vs. prose
   - Executive summary first vs. full context
   - How do you feel about tables?
```

### Working Patterns

```
Tell me about how you work:

1. **Working hours:** When are you typically working? Any protected time?

2. **Best times for focus work:** When do you do your deepest thinking?

3. **Communication response expectations:**
   - How quickly do you typically respond to messages?
   - How quickly do you expect responses from your team?
```

### Self-Awareness

```
A few questions to help me help you better:

1. **Where do you need the most help?**
   What tasks drain you, or where do you wish you had more support?

2. **What are your known blind spots?**
   Things you tend to miss or forget?

3. **What frustrates you?**
   Pet peeves, things that waste your time, communication patterns you dislike?

4. **What should I never do?**
   Any absolute no-gos?
```

### Validation

- [ ] Language preference captured
- [ ] Tone and format preferences captured
- [ ] Working hours/patterns noted
- [ ] At least one "needs help with" area identified
- [ ] Any "never do" rules captured

---

## Phase 6: Confirmation & Generation

**Purpose:** Confirm all captured data and generate the command centre.

### Summary Review

```
Here's everything I captured. Please review:

## Your Profile
- **Name:** {name}
- **Title:** {title}
- **Company:** {company}
- **Reports to:** {manager}
- **Timezone:** {timezone}

## Responsibilities (generating skills for starred items)
{list with priority items starred}

## Your Team
{direct reports summary}

## Key Stakeholders
{stakeholders summary}

## Recurring Meetings
{meetings summary}

## Preferences
- Language: {language}
- Style: {tone description}
- Working hours: {hours}

## Special Instructions
{blind spots, frustrations, never-do rules}

---

Say "generate" to create your command centre, or tell me what to change.
```

### Generation Sequence

On confirmation:
1. Create CLAUDE.md from template
2. Create `people/` structure
3. Create `work/actions.md` (empty Eisenhower matrix)
4. Create `reference/` structure
5. Generate skills for priority responsibilities (5-7)
6. Create universal skills (session, humanize)
7. Add self-improvement protocol to CLAUDE.md
8. Seed memory graph with person entities
9. Create hooks (check-actions, check-memory)
10. Run health check to verify structure

### Post-Generation

```
Your command centre is ready!

**Created:**
- CLAUDE.md - Your personalised instructions
- {n} skills based on your responsibilities
- People profiles for your team and stakeholders
- Action tracking system
- Self-improvement protocol (I'll learn as we work)

**What's next:**
- The remaining {m} responsibilities will become skills as we work together
- People profiles will get richer over time
- I'll observe patterns and propose improvements

Let's start working. What would you like to tackle first?
```

---

## Error Handling

### User Wants to Skip Sections

```
No problem. I'll work with what we have and fill in gaps as we work together.
You can always add more context later by saying "let's update my profile."
```

### User Provides Inconsistent Data

```
I noticed {inconsistency}. Which is correct:
- Option A: {interpretation_1}
- Option B: {interpretation_2}
```

### User Seems Overwhelmed

If more than 2 questions answered with minimal detail:
```
I've got enough to get started. We can fill in details as we work together -
the system learns over time. Want me to generate with what we have?
```

---

## Timing Guidance

| Phase | Target Duration | Notes |
|-------|-----------------|-------|
| Phase 0 | 2-3 min | Document upload or skip |
| Phase 1 | 1-2 min | Mostly confirmation if docs provided |
| Phase 2 | 5-7 min | Longest phase, core content |
| Phase 3 | 3-5 min | Depends on team size |
| Phase 4 | 2-3 min | Usually quick |
| Phase 5 | 2-3 min | Personal questions |
| Phase 6 | 1-2 min | Review and generate |
| **Total** | **15-20 min** | Can be shorter with good docs |
