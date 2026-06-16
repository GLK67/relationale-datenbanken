# Routine: Template-Repositories aktuell halten

Diese Routine richtet sich an Lehrkräfte oder Teams, die aus diesem Repository ein eigenes Template-Repository erzeugt haben.

## Ziel

Neue Verbesserungen aus dem Original-Repository regelmäßig als Pull verfügbar machen.

## Einmalig einrichten

1. In deinem abgeleiteten Repository das Original als zusätzliche Remote-Quelle eintragen:

```bash
git remote add upstream https://github.com/ChristineJanischek/edu-code-course-rdb.git
```

2. Prüfen, ob die Remote vorhanden ist:

```bash
git remote -v
```

## Regelmäßige Sync-Routine

```bash
git fetch upstream
git checkout main
git merge --no-ff upstream/main
git push origin main
```

## Empfehlung für den Unterrichtsbetrieb

- Führe die Sync-Routine mindestens 1x pro Woche aus.
- Führe sie zusätzlich vor Beginn einer neuen Klassenarbeits- oder Übungsphase aus.
- Nach dem Merge kurz prüfen:
  - `generated/informationen/begrifflichkeiten/`
  - `generated/informationen/teil-b/`
  - `generated/informationen/teil-c/`

## Optional: Team-Standard festlegen

Wenn mehrere Personen am Schul-Repository arbeiten, die Routine als festen Termin in den Teamkalender aufnehmen (z. B. Montag 07:30 Uhr).
