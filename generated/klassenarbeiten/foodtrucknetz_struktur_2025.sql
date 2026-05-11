-- SQL-Struktur Teil C (Version 3)
DROP DATABASE IF EXISTS ka02_bg12_2025_sqlteil_v3;
CREATE DATABASE ka02_bg12_2025_sqlteil_v3 CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE ka02_bg12_2025_sqlteil_v3;

DROP TABLE IF EXISTS zahlungen;
DROP TABLE IF EXISTS bestellpositionen;
DROP TABLE IF EXISTS bestellungen;
DROP TABLE IF EXISTS schichten;
DROP TABLE IF EXISTS produkte;
DROP TABLE IF EXISTS produktkategorien;
DROP TABLE IF EXISTS standorte;
DROP TABLE IF EXISTS trucks;
DROP TABLE IF EXISTS mitarbeitende;
DROP TABLE IF EXISTS kunden;

CREATE TABLE kunden (
  kunde_id INT PRIMARY KEY,
  vorname VARCHAR(50) NOT NULL,
  nachname VARCHAR(50) NOT NULL,
  bonuslevel ENUM('Bronze','Silber','Gold') NOT NULL,
  registriert_am DATE NOT NULL,
  aktiv TINYINT(1) NOT NULL DEFAULT 1
);

CREATE TABLE mitarbeitende (
  mitarbeiter_id INT PRIMARY KEY,
  vorname VARCHAR(50) NOT NULL,
  nachname VARCHAR(50) NOT NULL,
  rolle ENUM('Service','Kueche','Leitung') NOT NULL,
  email VARCHAR(120) NOT NULL UNIQUE
);

CREATE TABLE standorte (
  standort_id INT PRIMARY KEY,
  standortname VARCHAR(100) NOT NULL,
  stadtteil VARCHAR(80) NOT NULL,
  aktiv TINYINT(1) NOT NULL DEFAULT 1
);

CREATE TABLE trucks (
  truck_id INT PRIMARY KEY,
  standort_id INT NOT NULL,
  truckname VARCHAR(100) NOT NULL,
  status ENUM('offen','pause','wartung') NOT NULL DEFAULT 'offen',
  CONSTRAINT fk_truck_standort FOREIGN KEY (standort_id) REFERENCES standorte(standort_id)
);

CREATE TABLE produktkategorien (
  kategorie_id INT PRIMARY KEY,
  bezeichnung VARCHAR(80) NOT NULL
);

CREATE TABLE produkte (
  produkt_id INT PRIMARY KEY,
  truck_id INT NOT NULL,
  kategorie_id INT NOT NULL,
  produktname VARCHAR(100) NOT NULL,
  preis DECIMAL(6,2) NOT NULL,
  verfuegbar TINYINT(1) NOT NULL DEFAULT 1,
  CONSTRAINT fk_produkt_truck FOREIGN KEY (truck_id) REFERENCES trucks(truck_id),
  CONSTRAINT fk_produkt_kategorie FOREIGN KEY (kategorie_id) REFERENCES produktkategorien(kategorie_id)
);

CREATE TABLE bestellungen (
  bestellung_id INT PRIMARY KEY,
  kunde_id INT NOT NULL,
  truck_id INT NOT NULL,
  bestellt_am DATETIME NOT NULL,
  status ENUM('neu','abgeschlossen','storniert') NOT NULL DEFAULT 'neu',
  CONSTRAINT fk_bestellung_kunde FOREIGN KEY (kunde_id) REFERENCES kunden(kunde_id),
  CONSTRAINT fk_bestellung_truck FOREIGN KEY (truck_id) REFERENCES trucks(truck_id)
);

CREATE TABLE bestellpositionen (
  position_id INT PRIMARY KEY,
  bestellung_id INT NOT NULL,
  produkt_id INT NOT NULL,
  menge INT NOT NULL,
  einzelpreis DECIMAL(6,2) NOT NULL,
  CONSTRAINT fk_position_bestellung FOREIGN KEY (bestellung_id) REFERENCES bestellungen(bestellung_id),
  CONSTRAINT fk_position_produkt FOREIGN KEY (produkt_id) REFERENCES produkte(produkt_id)
);

CREATE TABLE schichten (
  schicht_id INT PRIMARY KEY,
  mitarbeiter_id INT NOT NULL,
  truck_id INT NOT NULL,
  schichtdatum DATE NOT NULL,
  schichttyp ENUM('Frueh','Mittel','Spaet') NOT NULL,
  CONSTRAINT fk_schicht_mitarbeiter FOREIGN KEY (mitarbeiter_id) REFERENCES mitarbeitende(mitarbeiter_id),
  CONSTRAINT fk_schicht_truck FOREIGN KEY (truck_id) REFERENCES trucks(truck_id)
);

CREATE TABLE zahlungen (
  zahlung_id INT PRIMARY KEY,
  bestellung_id INT NOT NULL,
  betrag DECIMAL(7,2) NOT NULL,
  zahlart ENUM('Karte','App','Bar') NOT NULL,
  bezahlt_am DATETIME NOT NULL,
  status ENUM('offen','bezahlt','erstattet') NOT NULL DEFAULT 'bezahlt',
  CONSTRAINT fk_zahlung_bestellung FOREIGN KEY (bestellung_id) REFERENCES bestellungen(bestellung_id)
);
