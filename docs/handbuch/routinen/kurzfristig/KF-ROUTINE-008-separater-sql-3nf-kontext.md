# KF-ROUTINE-008: Separater SQL-3NF-Kontext fuer Klassenarbeiten

## Metadata
- ID: KF-ROUTINE-008
- Kategorie: kurzfristig
- Status: aktiv
- Version: 1.0
- Gueltig ab: 10.05.2026
- Zielgruppe: Lehrkraefte und Autoren von Klassenarbeiten/Pruefungen

## Ziel
Sicherstellen, dass Modellierungsaufgaben (Teil B) und SQL-Abfragen (Teil C) didaktisch sauber getrennt sind. Teil C nutzt immer eine andere, bereits normalisierte 3NF-Datenbank mit eigenem Sachverhalt.

## Vorbedingungen
- Klassenarbeitsdatei basiert auf dem 60-Minuten-Template.
- Dateibenennung folgt dem KA-Schema im Verzeichnis generated/klassenarbeiten.

## Schritte
1. Teil-B-Kontext festlegen.
   - Sachverhalt fuer EERM-Modellierung formulieren.
   - Keine fertige Tabellenstruktur fuer Schueler ausgeben.
2. Teil-C-Kontext festlegen.
   - Andere Domaine als Teil B verwenden.
   - Konkreten Sachverhalt mit mehreren Entitaeten und Beziehungen definieren.
3. SQL-Datenbank in 3NF erstellen.
   - Struktur in dump-Datei dokumentieren: KAxx_..._schema_data_dump.sql.
   - Parent-Tabellen mit ca. 20 Datensaetzen befuellen.
4. EERM fuer SQL-Kontext erstellen.
   - Datei: KAxx_..._SQLDB_EERM.mwb (Workbench-Modellcontainer).
   - In Workbench Modell-Notation auf "Connect to columns" setzen.
   - Wenn Workbench verfuegbar: Grafik exportieren als KAxx_..._SQLDB_EERM.png.
5. Klassenarbeitsdokument aktualisieren.
   - Teil C explizit als separaten SQL-Kontext kennzeichnen.
   - SQL-Artefakte in der Abgabe auffuehren.
6. Qualitaetsgate ausfuehren.
   - bash scripts/validate-ka-separate-context.sh
   - bash scripts/validate-security.sh
   - bash scripts/validate-architecture.sh
   - bash scripts/validate-docs.sh

## Erfolgskriterien
- Teil B und Teil C sind unterschiedliche Kontexte.
- SQL-Dump (Teil C) vorhanden und konsistent.
- SQLDB-EERM (.mwb) als gueltiger Modellcontainer vorhanden.
- Wenn Workbench verfuegbar: SQLDB-EERM-Grafik (.png) vorhanden.
- Pflicht-Gates laufen ohne Fehler durch.

## LLM-Prompt-Baustein (verbindlich)
Bei der Generierung von Klassenarbeiten/Pruefungen immer ergaenzen:

"Teil B (Modellierung) und Teil C (SQL) muessen unterschiedliche Kontexte verwenden. Teil C basiert auf einer separaten, in 3NF normalisierten Datenbank mit eigenem Sachverhalt. Erzeuge fuer Teil C immer SQL-Dump, EERM (.mwb) und wenn moeglich Workbench-Grafik (.png) mit Notation 'Connect to columns'."

## Changelog
- 1.0 (10.05.2026): Initiale Routine fuer didaktisch getrennten SQL-3NF-Kontext eingefuehrt.
