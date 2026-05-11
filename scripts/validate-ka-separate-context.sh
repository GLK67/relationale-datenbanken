#!/usr/bin/env bash
set -euo pipefail

echo "[ka-separate-context] Starte Validierung fuer getrennten SQL-Kontext..."

fail=0

note_fail() {
  echo "[ka-separate-context] FAIL: $1"
  fail=1
}

check_file_exists() {
  local file="$1"
  if [[ ! -f "$file" ]]; then
    note_fail "Fehlendes Artefakt: $file"
  fi
}

check_mwb_container() {
  local file="$1"
  if [[ -f "$file" ]] && ! unzip -tqq "$file" >/dev/null 2>&1; then
    note_fail "Kein gueltiger .mwb-Container (ZIP erwartet): $file"
  fi
}

for md in generated/klassenarbeiten/*_Muster_EERM_SQL.md; do
  [[ -e "$md" ]] || continue

  base_name="${md##*/}"
  prefix="${base_name%_Muster_EERM_SQL.md}"
  dir="generated/klassenarbeiten"

  sql_dump="$dir/${prefix}_schema_data_dump.sql"
  model_part_b="$dir/${prefix}_EERM.mwb"
  sql_model="$dir/${prefix}_SQLDB_EERM.mwb"
  sql_png="$dir/${prefix}_SQLDB_EERM.png"

  check_file_exists "$sql_dump"
  check_file_exists "$model_part_b"
  check_file_exists "$sql_model"
  check_mwb_container "$model_part_b"
  check_mwb_container "$sql_model"

  if ! grep -qi "separater sql-kontext" "$md"; then
    note_fail "$md: Hinweis auf separaten SQL-Kontext fehlt"
  fi

  if ! grep -qi "anderen kontext" "$md"; then
    note_fail "$md: didaktische Trennung Teil B/Teil C nicht klar benannt"
  fi

  if ! grep -qi "3nf" "$md"; then
    note_fail "$md: 3NF-Anforderung fuer SQL-Kontext fehlt"
  fi

  if [[ -f "$sql_png" ]]; then
    echo "[ka-separate-context] INFO: Workbench-Grafik gefunden: $sql_png"
  else
    echo "[ka-separate-context] INFO: Keine Workbench-Grafik gefunden, versuche Generator: $sql_png"
    python3 scripts/plugins/eerm_grafik_generator/generate_eerm_png.py --input-dir "$dir" || true
    if [[ -f "$sql_png" ]]; then
      echo "[ka-separate-context] INFO: Grafik per Generator erstellt: $sql_png"
    else
      echo "[ka-separate-context] WARN: Keine Workbench-Grafik gefunden (optional): $sql_png"
    fi
  fi

done

if [[ $fail -ne 0 ]]; then
  echo "[ka-separate-context] Validierung fehlgeschlagen"
  exit 1
fi

echo "[ka-separate-context] Validierung erfolgreich"
