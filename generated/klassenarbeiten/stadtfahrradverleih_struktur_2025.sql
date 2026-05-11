-- KA02 BG12 2025 - 60 Minuten - SQL-Teil (separater 3NF-Kontext)
-- Kontext Teil C: Stadtfahrradverleih (nicht identisch mit Teil-B-Modellierung)
-- STRUKTUR-DEFINTION: Tabellenschema, Spalten, Datentypen und Constraints

DROP DATABASE IF EXISTS ka02_bg12_2025_sqlteil;
CREATE DATABASE ka02_bg12_2025_sqlteil CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE ka02_bg12_2025_sqlteil;

DROP TABLE IF EXISTS zahlungen;
DROP TABLE IF EXISTS wartungen;
DROP TABLE IF EXISTS ausleihen;
DROP TABLE IF EXISTS fahrraeder;
DROP TABLE IF EXISTS fahrradtypen;
DROP TABLE IF EXISTS stationen;
DROP TABLE IF EXISTS mitarbeitende;
DROP TABLE IF EXISTS kunden;

CREATE TABLE kunden (
  kunde_id INT PRIMARY KEY,
  vorname VARCHAR(50) NOT NULL,
  nachname VARCHAR(50) NOT NULL,
  wohnort VARCHAR(80) NOT NULL,
  registriert_am DATE NOT NULL,
  aktiv TINYINT(1) NOT NULL DEFAULT 1
);

CREATE TABLE mitarbeitende (
  mitarbeiter_id INT PRIMARY KEY,
  vorname VARCHAR(50) NOT NULL,
  nachname VARCHAR(50) NOT NULL,
  rolle ENUM('Service','Disposition','Leitung') NOT NULL,
  email VARCHAR(120) NOT NULL UNIQUE
);

CREATE TABLE stationen (
  station_id INT PRIMARY KEY,
  stationsname VARCHAR(120) NOT NULL,
  stadtteil VARCHAR(80) NOT NULL,
  kapazitaet INT NOT NULL,
  aktiv TINYINT(1) NOT NULL DEFAULT 1
);

CREATE TABLE fahrradtypen (
  typ_id INT PRIMARY KEY,
  typname VARCHAR(80) NOT NULL,
  kategorie ENUM('City','Trekking','E-Bike') NOT NULL,
  stundenpreis DECIMAL(6,2) NOT NULL
);

CREATE TABLE fahrraeder (
  fahrrad_id INT PRIMARY KEY,
  typ_id INT NOT NULL,
  station_id INT NOT NULL,
  seriennummer VARCHAR(60) NOT NULL UNIQUE,
  zustand ENUM('verfuegbar','vermietet','wartung') NOT NULL DEFAULT 'verfuegbar',
  CONSTRAINT fk_fahrraeder_typ FOREIGN KEY (typ_id) REFERENCES fahrradtypen(typ_id),
  CONSTRAINT fk_fahrraeder_station FOREIGN KEY (station_id) REFERENCES stationen(station_id)
);

CREATE TABLE ausleihen (
  ausleihe_id INT PRIMARY KEY,
  kunde_id INT NOT NULL,
  fahrrad_id INT NOT NULL,
  start_station_id INT NOT NULL,
  ziel_station_id INT NOT NULL,
  startzeit DATETIME NOT NULL,
  endzeit DATETIME,
  status ENUM('laufend','abgeschlossen','storniert') NOT NULL DEFAULT 'laufend',
  CONSTRAINT fk_ausleihen_kunde FOREIGN KEY (kunde_id) REFERENCES kunden(kunde_id),
  CONSTRAINT fk_ausleihen_fahrrad FOREIGN KEY (fahrrad_id) REFERENCES fahrraeder(fahrrad_id),
  CONSTRAINT fk_ausleihen_start_station FOREIGN KEY (start_station_id) REFERENCES stationen(station_id),
  CONSTRAINT fk_ausleihen_ziel_station FOREIGN KEY (ziel_station_id) REFERENCES stationen(station_id)
);

CREATE TABLE wartungen (
  wartung_id INT PRIMARY KEY,
  fahrrad_id INT NOT NULL,
  mitarbeiter_id INT NOT NULL,
  wartungsdatum DATE NOT NULL,
  wartungsart ENUM('Inspektion','Reparatur','Sicherheitscheck') NOT NULL,
  bemerkung VARCHAR(255) NOT NULL,
  CONSTRAINT fk_wartungen_fahrrad FOREIGN KEY (fahrrad_id) REFERENCES fahrraeder(fahrrad_id),
  CONSTRAINT fk_wartungen_mitarbeiter FOREIGN KEY (mitarbeiter_id) REFERENCES mitarbeitende(mitarbeiter_id)
);

CREATE TABLE zahlungen (
  zahlung_id INT PRIMARY KEY,
  ausleihe_id INT NOT NULL,
  betrag DECIMAL(7,2) NOT NULL,
  zahlart ENUM('Karte','Lastschrift','App') NOT NULL,
  bezahlt_am DATETIME NOT NULL,
  zahlstatus ENUM('offen','bezahlt','storniert') NOT NULL DEFAULT 'bezahlt',
  CONSTRAINT fk_zahlungen_ausleihe FOREIGN KEY (ausleihe_id) REFERENCES ausleihen(ausleihe_id)
);
