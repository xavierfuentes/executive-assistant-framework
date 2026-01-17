# Onboarding State

Session tracking for incomplete onboarding.

## Status

- **Started:** {timestamp}
- **Last updated:** {timestamp}
- **Current phase:** {0-6 or "complete"}
- **Current phase step:** {step_number_within_phase or null}
- **Current item index:** {index_in_list or null}
- **Current item context:** {item_name_or_description or null}
- **Status:** {active | paused | error | complete}

## Phases Completed

- [ ] Phase 0: Document Collection
- [ ] Phase 1: Identity & Role
- [ ] Phase 2: Responsibilities Discovery
- [ ] Phase 3: People & Relationships
- [ ] Phase 4: Operational Cadence
- [ ] Phase 5: Personal Preferences
- [ ] Phase 6: Confirmation & Generation

## In-Progress Item Tracking

For phases that iterate over lists (responsibilities, people, meetings), track position:

| Phase | List Being Processed | Total Items | Current Index | Current Item |
|-------|---------------------|-------------|---------------|--------------|
| {n} | {list_name} | {total} | {current} | {item_name} |

**Index Convention:** 1-based (first item = 1). Index of 0 means "not started".

## Captured Data Summary

| Field | Status | Source |
|-------|--------|--------|
| Name | {captured/needs-question} | {source} |
| Title | {captured/needs-question} | {source} |
| Company | {captured/needs-question} | {source} |
| Timezone | {captured/needs-question} | {source} |
| Manager | {captured/needs-question} | {source} |
| Responsibilities | {captured/needs-question} | {source} |
| Direct Reports | {captured/needs-question} | {source} |
| Stakeholders | {captured/needs-question} | {source} |
| Meetings | {captured/needs-question} | {source} |
| Preferences | {captured/needs-question} | {source} |

## Documents Provided

- [ ] CV/Resume
- [ ] Job Description
- [ ] Company Overview
- [ ] Org Chart

## Error Log

| Timestamp | Phase | Error | Resolution |
|-----------|-------|-------|------------|

## Recovery Notes

Structured context for resuming interrupted sessions.

### Last Question Asked

- **Phase:** {phase_number}
- **Question:** {exact_question_text}
- **Context:** {any_setup_or_preamble_given}

### Partial Responses

| Field | Partial Value | Needs Clarification |
|-------|---------------|---------------------|
| {field_name} | {partial_value_or_empty} | {yes/no} |

### User Clarifications

Corrections or clarifications provided by user during session:

- **{timestamp}:** {clarification_text}

### Special Circumstances

- **Documents pending processing:** {list_or_none}
- **Validation warnings:** {list_or_none}
- **User-requested deferrals:** {list_or_none}

### Resume Instructions

Example format:
```
Continue from: Phase {n} - {phase_name}
Current progress: {completed_count}/{total_count} items in current list
Next action: {specific_next_step}
User context: {any_relevant_notes_about_user_preferences_or_state}
```

**Example:**
```
Continue from: Phase 2 - Responsibilities Discovery
Current progress: 2/5 responsibilities deep-dived
Next action: Ask about success criteria for "Technical Strategy"
User context: User prefers brief questions, mentioned time pressure
```
