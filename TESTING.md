# Testing the Executive Assistant Framework

## What This Is

An AI command centre that learns your role, responsibilities, and working style, then helps you more effectively over time.

## Setup

1. Clone the repo:
   ```bash
   git clone [repo-url]
   cd executive-assistant-framework
   ```

2. Make sure you have:
   - Claude Code CLI installed
   - MCP memory server configured (for knowledge graph)

## To Test

1. Open Claude Code in the project directory

2. Start onboarding:
   ```
   Say "let's start onboarding" or "/onboarding"
   ```

3. You'll be asked for your preferred language first (Spanish is supported!)

4. Then either:
   - Paste your CV/job description (fastest)
   - Or answer the questions directly

5. After completing onboarding, generate your command centre:
   ```
   /generate ./my-assistant
   ```

6. Navigate to that directory and try:
   ```
   /resume
   ```

## What to Test

- Does onboarding flow naturally?
- Are the extracted details correct?
- Does the generated CLAUDE.md make sense?
- Do the skills match your responsibilities?

## Feedback Needed

- Anything confusing?
- Missing features?
- Language/translation issues?

Takes about 15-20 minutes to complete onboarding.

---

# Probando el Executive Assistant Framework

## Qué Es Esto

Un centro de comando de IA que aprende tu rol, responsabilidades y estilo de trabajo, y te ayuda de manera más efectiva con el tiempo.

## Configuración

1. Clona el repositorio:
   ```bash
   git clone [repo-url]
   cd executive-assistant-framework
   ```

2. Asegúrate de tener:
   - Claude Code CLI instalado
   - Servidor MCP memory configurado (para el grafo de conocimiento)

## Para Probar

1. Abre Claude Code en el directorio del proyecto

2. Inicia el onboarding:
   ```
   Di "let's start onboarding" o "/onboarding"
   ```

3. Primero te preguntará tu idioma preferido (¡Español está soportado!)

4. Luego puedes:
   - Pegar tu CV/descripción del puesto (más rápido)
   - O responder las preguntas directamente

5. Después de completar el onboarding, genera tu centro de comando:
   ```
   /generate ./mi-asistente
   ```

6. Navega a ese directorio y prueba:
   ```
   /resume
   ```

## Qué Probar

- ¿El onboarding fluye naturalmente?
- ¿Son correctos los detalles extraídos?
- ¿Tiene sentido el CLAUDE.md generado?
- ¿Las habilidades corresponden a tus responsabilidades?

## Feedback Necesario

- ¿Algo confuso?
- ¿Funciones que faltan?
- ¿Problemas con el idioma/traducción?

Toma unos 15-20 minutos completar el onboarding.
