# Extraction Prompts

Prompts for extracting structured data from documents provided during onboarding.

---

## CV/Resume Extraction

### Prompt

```
Extract the following information from this CV/resume. Return ONLY the extracted data in the exact format shown. Use "NOT FOUND" for any field you cannot determine.

---

**Full name:**
**Current job title:**
**Current company:**
**Location:**
**Current role start date:**

**Career history (last 5 roles):**
- {Title} at {Company} ({dates})
- ...

**Key skills/expertise areas:**
- {skill}
- ...

**Education:**
- {degree} from {institution}
- ...

**Notable achievements in current role:**
- {achievement}
- ...

---

Document:
{cv_text}
```

### Expected Output

```markdown
**Full name:** Sarah Chen
**Current job title:** VP Engineering
**Current company:** Acme Corp
**Location:** London, UK
**Current role start date:** March 2022

**Career history (last 5 roles):**
- VP Engineering at Acme Corp (Mar 2022 - present)
- Engineering Director at TechStart (2019 - 2022)
- Senior Engineering Manager at BigCo (2016 - 2019)
- Engineering Manager at StartupX (2014 - 2016)
- Senior Software Engineer at Agency Ltd (2011 - 2014)

**Key skills/expertise areas:**
- Engineering leadership
- Platform architecture
- Hiring and team building
- Agile transformation

**Education:**
- MSc Computer Science from Imperial College London
- BSc Mathematics from University of Manchester

**Notable achievements in current role:**
- Scaled engineering team from 15 to 45
- Led platform migration reducing costs by 40%
- Established engineering career ladder
```

### Fields Populated

| Extracted | → Answers Field |
|-----------|-----------------|
| Full name | Identity > Name |
| Current job title | Identity > Title |
| Current company | Identity > Company |
| Location | Identity > Location/Timezone (infer) |
| Key skills/expertise | Responsibilities (candidates) |
| Notable achievements | Success criteria hints |

---

## Job Description Extraction

### Prompt

```
Extract the following information from this job description. Return ONLY the extracted data in the exact format shown. Use "NOT FOUND" for any field you cannot determine.

---

**Job title:**
**Department/Function:**
**Reports to:**
**Location:**

**Core responsibilities:**
1. {responsibility}
2. {responsibility}
...

**Key metrics/success measures (if stated):**
- {metric}
- ...

**Key stakeholders mentioned:**
- {stakeholder/team}
- ...

**Required skills:**
- {skill}
- ...

**Team size (if mentioned):**

---

Document:
{jd_text}
```

### Expected Output

```markdown
**Job title:** VP Engineering
**Department/Function:** Engineering / Technology
**Reports to:** CTO
**Location:** London (hybrid)

**Core responsibilities:**
1. Lead and grow the engineering organisation
2. Define technical strategy and architecture
3. Partner with Product on roadmap planning
4. Own engineering hiring and team development
5. Manage engineering budget and vendor relationships
6. Establish engineering processes and best practices
7. Represent engineering in leadership forums

**Key metrics/success measures (if stated):**
- Team growth targets
- Delivery velocity
- System reliability (uptime)
- Engineering satisfaction scores

**Key stakeholders mentioned:**
- CTO (manager)
- Product leadership
- Finance (budget)
- HR/Talent (hiring)
- Other engineering leaders

**Required skills:**
- 10+ years engineering experience
- 5+ years leadership experience
- Distributed systems expertise
- Track record of scaling teams

**Team size (if mentioned):** 40-60 engineers
```

### Fields Populated

| Extracted | → Answers Field |
|-----------|-----------------|
| Job title | Identity > Title (confirm) |
| Reports to | Identity > Reports to |
| Core responsibilities | Responsibilities (primary source) |
| Key metrics | Success criteria |
| Key stakeholders | People > Stakeholders |

---

## Company Overview Extraction

### Prompt

```
Extract the following information from this company overview. Return ONLY the extracted data in the exact format shown. Use "NOT FOUND" for any field you cannot determine.

---

**Company name:**
**Industry/Sector:**
**Company stage:** {startup / scaleup / enterprise / public}
**Employee count (approx):**
**Locations:**

**What the company does (1-2 sentences):**

**Key products/services:**
- {product}
- ...

**Business model:** {B2B / B2C / B2B2C / marketplace / other}

**Recent news/priorities (if mentioned):**
- {item}
- ...

**Company values (if stated):**
- {value}
- ...

---

Document:
{company_text}
```

### Expected Output

```markdown
**Company name:** Acme Corp
**Industry/Sector:** Enterprise SaaS / Developer Tools
**Company stage:** scaleup
**Employee count (approx):** 200-300
**Locations:** London (HQ), New York, Berlin

**What the company does (1-2 sentences):**
Acme Corp provides developer productivity tools that help engineering teams ship faster. Their platform includes CI/CD, code review, and deployment automation.

**Key products/services:**
- Acme Pipeline (CI/CD)
- Acme Review (code review)
- Acme Deploy (deployment automation)

**Business model:** B2B

**Recent news/priorities (if mentioned):**
- Series C funding announced
- Expanding into enterprise market
- Building AI-assisted features

**Company values (if stated):**
- Ship fast, learn faster
- Customer obsession
- Transparency by default
```

### Fields Populated

| Extracted | → Answers Field |
|-----------|-----------------|
| Company name | Identity > Company (confirm) |
| Company stage | Context for skill generation |
| What company does | CLAUDE.md context |
| Recent priorities | Context for responsibilities |

---

## LinkedIn Profile Extraction (Screenshot/PDF)

### Prompt

```
Extract the following information from this LinkedIn profile. Return ONLY the extracted data in the exact format shown. Use "NOT FOUND" for any field you cannot determine.

---

**Full name:**
**Current title:**
**Current company:**
**Location:**
**Headline:**

**About/Summary (key points):**
- {point}
- ...

**Current role description (if visible):**

**Previous roles (last 3):**
- {Title} at {Company}
- ...

**Skills endorsed:**
- {skill}
- ...

**Connection to user (if apparent):**

---

Profile:
{linkedin_content}
```

### Expected Output

```markdown
**Full name:** James Wright
**Current title:** Chief Technology Officer
**Current company:** Acme Corp
**Location:** London, United Kingdom
**Headline:** CTO at Acme Corp | Building the future of developer tools

**About/Summary (key points):**
- 20+ years in technology leadership
- Previously founded two startups
- Passionate about engineering culture

**Current role description (if visible):**
Leading technology strategy and engineering organisation at Acme Corp. Responsible for platform architecture, engineering team, and technical partnerships.

**Previous roles (last 3):**
- CTO at TechStart (acquired)
- VP Engineering at BigCo
- Co-founder/CTO at StartupX

**Skills endorsed:**
- Engineering Leadership
- Cloud Architecture
- Team Building
- Strategic Planning

**Connection to user (if apparent):**
NOT FOUND
```

### Fields Populated

| Extracted | → Answers Field |
|-----------|-----------------|
| Full name | People > {person} > Name |
| Current title | People > {person} > Role |
| Headline | People > {person} > Notes |
| About/Summary | People > {person} > Context |
| Connection to user | People > {person} > Relationship |

---

## Org Chart Extraction (Screenshot/Description)

### Prompt

```
Extract the organisational structure from this org chart. Return ONLY the extracted data in the exact format shown. Use "NOT FOUND" for any field you cannot determine.

Focus on the user's position and their direct relationships (manager, direct reports, peers).

---

**User's position in org:**
**User's manager:**
**User's direct reports:**
- {name} - {title}
- ...

**User's peers (same level):**
- {name} - {title}
- ...

**User's skip-level (manager's manager, if visible):**

**Team/Department name:**
**Total org size (if determinable):**

---

Org chart:
{org_chart_content}
```

### Expected Output

```markdown
**User's position in org:** VP Engineering
**User's manager:** James Wright (CTO)

**User's direct reports:**
- Sarah Chen - Senior Engineering Manager
- Mike Johnson - Senior Engineering Manager
- Lisa Park - Engineering Manager
- Tom Wilson - Staff Engineer (Tech Lead)

**User's peers (same level):**
- Amanda Liu - VP Product
- David Kim - VP Design
- Rachel Green - VP Data

**User's skip-level (manager's manager, if visible):** CEO

**Team/Department name:** Engineering
**Total org size (if determinable):** ~45 in Engineering
```

### Fields Populated

| Extracted | → Answers Field |
|-----------|-----------------|
| User's manager | Identity > Reports to |
| Direct reports | People > Direct Reports |
| Peers | People > Stakeholders |
| Team name | Context |

---

## Handling Extraction Failures

### Low Confidence

If extraction confidence is low for any field:
1. Mark as "UNCERTAIN: {best guess}"
2. Flag for confirmation in Phase 1
3. Include source text that was ambiguous

### Missing Documents

If a document type wasn't provided:
1. Mark all related fields as "NEEDS QUESTION"
2. Trigger gap-fill questions in appropriate phase

### Conflicting Information

If documents contain conflicting information:
1. Note both values: "CONFLICT: {value1} vs {value2}"
2. Ask user to clarify in Phase 1
3. Prefer more recent document if dates are available

---

## Extraction Quality Checklist

Before presenting extracted data to user:

- [ ] All "NOT FOUND" fields have corresponding gap-fill questions ready
- [ ] No placeholder text remaining (e.g., "{name}")
- [ ] Dates are in consistent format (Month Year or YYYY)
- [ ] Names are properly capitalised
- [ ] Job titles match common conventions
- [ ] No sensitive data extracted unintentionally (salary, personal contact info)
