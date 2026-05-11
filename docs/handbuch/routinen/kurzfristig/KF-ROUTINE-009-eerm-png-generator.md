# KF-ROUTINE-009: EERM-PNG-Generator fuer SQL-Kontexte

## Metadata
- ID: KF-ROUTINE-009
- Kategorie: kurzfristig
- Status: aktiv
- Version: 1.0
- Gueltig ab: 11.05.2026
- Zielgruppe: Lehrkraefte und Autoren von Klassenarbeiten/Pruefungen
- Abhaengigkeiten:
  - KF-ROUTINE-008-separater-sql-3nf-kontext.md

## Ziel
Sicherstellen, dass fuer den SQL-Teil (Teil C) eine einbettbare Modellgrafik als PNG verfuegbar ist, auch wenn kein manueller Workbench-Export vorliegt.
Die Generatorgrafik wird aus dem SQL-Dump gerendert (Tabellen + FKs), damit sie didaktisch brauchbar ist.
Die Linien werden so geroutet, dass unbeteiligte Entitaetstypen umfahren werden und nicht durchlaufen werden.

## Vorbedingungen
- Teil-C-Modell als `*_SQLDB_EERM.mwb` liegt im Verzeichnis `generated/klassenarbeiten`.
- Python 3 ist verfuegbar.

## Schritte
1. Ein-Befehl-Workflow ausfuehren:
  - `bash scripts/generate-ka-eerm-assets.sh`
  - optional mit Ueberschreiben bestehender PNGs: `bash scripts/generate-ka-eerm-assets.sh --force`
2. Ausgabe pruefen:
   - Fuer jede `*_SQLDB_EERM.mwb` existiert danach `*_SQLDB_EERM.png`.
3. Bei Bedarf manuell in zwei Schritten ausfuehren:
  - `python3 scripts/plugins/eerm_grafik_generator/generate_eerm_png.py --input-dir generated/klassenarbeiten`
  - `python3 scripts/plugins/eerm_grafik_generator/embed_eerm_png_reference.py --markdown-dir generated/klassenarbeiten`
4. In Aufgaben-/Lehrkraftvorlage Grafik einbetten (Template-Ebene):
  - `![EERM Teil C](../../../generated/klassenarbeiten/KAxx_..._SQLDB_EERM.png)`
5. Pflicht-Gates ausfuehren:
   - `bash scripts/validate-security.sh`
   - `bash scripts/validate-architecture.sh`
   - `bash scripts/validate-docs.sh`

## Erfolgskriterien
- PNG-Datei fuer Teil-C-Modell vorhanden.
- Einbettung im jeweiligen Dokument vorhanden.
- PNG ist aus dem SQL-Schema abgeleitet (nicht nur Platzhalter).
- Pflicht-Gates laufen erfolgreich durch.

## Fehlerbehandlung
- Kein `*_SQLDB_EERM.mwb` gefunden:
  - Dateibenennung und Ablagepfad korrigieren.
- PNG nicht erstellt:
  - Skript-Fehlermeldung pruefen und Dateirechte kontrollieren.
- Manuelle Workbench-Grafik vorhanden:
  - Diese darf die Generatorgrafik ersetzen (Workbench bleibt bevorzugt).
- Native .mwb-Designerdatei benoetigt:
  - Diese wird in Workbench gepflegt; der PNG-Generator erzeugt keine native Designerbearbeitung.

## LLM-Prompt-Baustein (verbindlich)
"Wenn fuer Teil C keine Workbench-Grafik vorliegt, erzeuge automatisch eine PNG-Grafik aus dem vorhandenen `*_SQLDB_EERM.mwb` ueber das Generator-Plugin und binde die Grafik in Aufgaben- und Lehrkraftvorlage ein."

## Verknuepfungen
- [KF-ROUTINE-008-separater-sql-3nf-kontext.md](./KF-ROUTINE-008-separater-sql-3nf-kontext.md)
- [../templates/KLASSENARBEIT-TEMPLATE-AUFGABEN-ARTEFAKTE-BPE6-BPE5.md](../../templates/KLASSENARBEIT-TEMPLATE-AUFGABEN-ARTEFAKTE-BPE6-BPE5.md)
- [../templates/KLASSENARBEIT-TEMPLATE-LOESUNG-ERWARTUNGSHORIZONT-BPE6-BPE5.md](../../templates/KLASSENARBEIT-TEMPLATE-LOESUNG-ERWARTUNGSHORIZONT-BPE6-BPE5.md)

## Changelog
- 1.0 (11.05.2026): Routine fuer automatisierte Bereitstellung von Teil-C-Modellgrafiken eingefuehrt.
