# EERM Grafik Generator (Plugin)

Dieses Plugin erzeugt PNG-Modellgrafiken fuer SQL-Kontexte von Klassenarbeiten auf Basis des SQL-Dumps.

## Ziel

- Lesbare EERM-Referenzgrafik aus Tabellen und Fremdschluesseln des SQL-Dumps
- Stabiler Generator fuer `*_SQLDB_EERM.mwb` + `*_schema_data_dump.sql`

## Voraussetzung

- Python-Paket `Pillow` (PIL)
  - Installation: `pip install Pillow`

## Aufruf

Ein-Befehl-Variante (empfohlen):

```bash
bash scripts/generate-ka-eerm-assets.sh
```

Optional mit Ueberschreiben bestehender PNGs:

```bash
bash scripts/generate-ka-eerm-assets.sh --force
```

Manuell in zwei Schritten:

```bash
python3 scripts/plugins/eerm_grafik_generator/generate_eerm_png.py \
  --input-dir generated/klassenarbeiten
```

Danach PNG-Referenz automatisch in Klassenarbeits-Markdown einbetten:

```bash
python3 scripts/plugins/eerm_grafik_generator/embed_eerm_png_reference.py \
  --markdown-dir generated/klassenarbeiten
```

Optional:

```bash
python3 scripts/plugins/eerm_grafik_generator/generate_eerm_png.py \
  --input-dir generated/klassenarbeiten \
  --force
```

## Verhalten

- Sucht rekursiv nach `*_SQLDB_EERM.mwb`
- Liest zu jedem Modell den passenden Dump `*_schema_data_dump.sql`
- Rendert daraus Tabellenkarten und FK-Beziehungen als PNG
- Routed FK-Linien orthogonal um unbeteiligte Tabellen herum, statt Karten zu kreuzen
- Ueberschreibt bestehende PNGs nur mit `--force`
- Betroffene Markdown-Dateien erhalten (falls fehlend) einen Abschnitt "Modellgrafik Teil C" mit PNG-Einbettung

Hinweis: Falls MySQL Workbench verfuegbar ist, kann ein nativer Export weiterhin verwendet werden.
