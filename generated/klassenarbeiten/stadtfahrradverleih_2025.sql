-- KA02 BG12 2025 - 60 Minuten - SQL-Teil (separater 3NF-Kontext)
-- Kontext Teil C: Stadtfahrradverleih (nicht identisch mit Teil-B-Modellierung)
-- Parent-Tabellen mit ca. 20 Datensaetzen: kunden, mitarbeitende

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

-- Parent-Tabelle kunden: 20 Datensaetze
INSERT INTO kunden VALUES
(1,'Lena','Mayer','Stuttgart','2024-01-10',1),
(2,'Noah','Klein','Esslingen','2024-01-12',1),
(3,'Mia','Schuster','Ludwigsburg','2024-01-15',1),
(4,'Elias','Bauer','Waiblingen','2024-01-18',1),
(5,'Lea','Wolf','Stuttgart','2024-01-20',1),
(6,'Finn','Schmidt','Fellbach','2024-02-01',1),
(7,'Emma','Wagner','Esslingen','2024-02-03',1),
(8,'Paul','Haas','Backnang','2024-02-06',1),
(9,'Lina','Keller','Waiblingen','2024-02-10',1),
(10,'Jonas','Beck','Stuttgart','2024-02-14',1),
(11,'Nina','Richter','Esslingen','2024-02-18',1),
(12,'Tim','Neumann','Ludwigsburg','2024-02-22',1),
(13,'Sara','Huber','Stuttgart','2024-03-01',1),
(14,'Ben','Graf','Waiblingen','2024-03-04',1),
(15,'Anna','Lorenz','Fellbach','2024-03-08',1),
(16,'Luca','Seidel','Stuttgart','2024-03-12',1),
(17,'Clara','Pfeifer','Esslingen','2024-03-15',1),
(18,'Max','Brandt','Ludwigsburg','2024-03-18',1),
(19,'Julia','Voss','Backnang','2024-03-21',1),
(20,'David','Krueger','Stuttgart','2024-03-25',1);

-- Parent-Tabelle mitarbeitende: 20 Datensaetze
INSERT INTO mitarbeitende VALUES
(1,'Martin','Kurz','Service','martin.kurz@citybike.de'),
(2,'Petra','Lang','Disposition','petra.lang@citybike.de'),
(3,'Uwe','Stein','Service','uwe.stein@citybike.de'),
(4,'Heike','Graf','Leitung','heike.graf@citybike.de'),
(5,'Thomas','Berg','Service','thomas.berg@citybike.de'),
(6,'Mona','Brand','Disposition','mona.brand@citybike.de'),
(7,'Nils','Wolf','Service','nils.wolf@citybike.de'),
(8,'Karin','Otto','Leitung','karin.otto@citybike.de'),
(9,'Jana','Winkler','Service','jana.winkler@citybike.de'),
(10,'Dirk','Herz','Disposition','dirk.herz@citybike.de'),
(11,'Sven','Schulz','Service','sven.schulz@citybike.de'),
(12,'Nora','Simon','Service','nora.simon@citybike.de'),
(13,'Ralf','Koch','Leitung','ralf.koch@citybike.de'),
(14,'Iris','Ackermann','Disposition','iris.ackermann@citybike.de'),
(15,'Timo','Arndt','Service','timo.arndt@citybike.de'),
(16,'Eva','Lenz','Service','eva.lenz@citybike.de'),
(17,'Sascha','Jung','Disposition','sascha.jung@citybike.de'),
(18,'Maren','Kuhn','Service','maren.kuhn@citybike.de'),
(19,'Olaf','Reuter','Leitung','olaf.reuter@citybike.de'),
(20,'Rita','Moser','Service','rita.moser@citybike.de');

INSERT INTO stationen VALUES
(101,'Hauptbahnhof','Mitte',40,1),
(102,'Universitaet Nord','Nord',32,1),
(103,'Marktplatz','Mitte',28,1),
(104,'Kulturpark','West',24,1),
(105,'Bad Cannstatt','Ost',26,1),
(106,'Rathaus','Mitte',18,1);

INSERT INTO fahrradtypen VALUES
(1,'City 7G','City',2.50),
(2,'Trekking 21G','Trekking',3.20),
(3,'E-City 500','E-Bike',5.90),
(4,'E-Trekking 700','E-Bike',6.40);

INSERT INTO fahrraeder VALUES
(2001,1,101,'CB-101-2001','verfuegbar'),
(2002,1,101,'CB-101-2002','vermietet'),
(2003,2,102,'CB-102-2003','verfuegbar'),
(2004,2,102,'CB-102-2004','wartung'),
(2005,3,103,'CB-103-2005','verfuegbar'),
(2006,3,103,'CB-103-2006','vermietet'),
(2007,4,104,'CB-104-2007','verfuegbar'),
(2008,4,104,'CB-104-2008','wartung'),
(2009,1,105,'CB-105-2009','verfuegbar'),
(2010,2,105,'CB-105-2010','verfuegbar'),
(2011,3,106,'CB-106-2011','vermietet'),
(2012,4,106,'CB-106-2012','verfuegbar');

INSERT INTO ausleihen VALUES
(3001,1,2002,101,103,'2026-05-02 08:10:00','2026-05-02 09:05:00','abgeschlossen'),
(3002,1,2005,103,101,'2026-05-04 14:15:00','2026-05-04 15:05:00','abgeschlossen'),
(3003,2,2003,102,106,'2026-05-03 10:00:00','2026-05-03 11:10:00','abgeschlossen'),
(3004,3,2006,103,104,'2026-05-03 16:00:00','2026-05-03 16:45:00','abgeschlossen'),
(3005,4,2001,101,105,'2026-05-05 07:30:00','2026-05-05 08:55:00','abgeschlossen'),
(3006,5,2011,106,103,'2026-05-05 17:00:00',NULL,'laufend'),
(3007,6,2009,105,101,'2026-05-06 09:20:00','2026-05-06 10:35:00','abgeschlossen'),
(3008,7,2012,106,102,'2026-05-06 11:00:00','2026-05-06 12:05:00','abgeschlossen'),
(3009,8,2010,105,104,'2026-05-07 12:00:00','2026-05-07 13:10:00','abgeschlossen'),
(3010,9,2007,104,103,'2026-05-07 15:20:00','2026-05-07 16:00:00','abgeschlossen'),
(3011,10,2005,103,106,'2026-05-08 08:45:00','2026-05-08 09:40:00','abgeschlossen'),
(3012,11,2003,102,101,'2026-05-08 17:35:00','2026-05-08 18:20:00','abgeschlossen'),
(3013,12,2001,101,104,'2026-05-09 07:55:00','2026-05-09 08:50:00','abgeschlossen'),
(3014,13,2011,106,105,'2026-05-09 13:10:00','2026-05-09 13:55:00','abgeschlossen'),
(3015,14,2009,105,102,'2026-05-10 09:00:00','2026-05-10 10:10:00','abgeschlossen'),
(3016,15,2006,103,101,'2026-05-10 18:10:00','2026-05-10 18:50:00','abgeschlossen'),
(3017,16,2007,104,106,'2026-05-11 06:55:00','2026-05-11 07:40:00','abgeschlossen'),
(3018,17,2012,106,103,'2026-05-11 14:20:00','2026-05-11 15:05:00','abgeschlossen'),
(3019,18,2010,105,101,'2026-05-12 11:40:00','2026-05-12 12:45:00','abgeschlossen'),
(3020,19,2002,101,105,'2026-05-12 16:15:00','2026-05-12 17:10:00','abgeschlossen'),
(3021,20,2005,103,102,'2026-05-12 19:00:00','2026-05-12 19:40:00','abgeschlossen');

INSERT INTO wartungen VALUES
(4001,2004,1,'2026-05-02','Inspektion','Bremsen nachgestellt'),
(4002,2008,3,'2026-05-03','Reparatur','Schaltung ersetzt'),
(4003,2012,5,'2026-05-04','Sicherheitscheck','Lichtanlage geprueft'),
(4004,2001,7,'2026-05-05','Inspektion','Reifendruck korrigiert'),
(4005,2006,9,'2026-05-06','Reparatur','Kette gewechselt'),
(4006,2007,11,'2026-05-07','Sicherheitscheck','Rahmen geprueft'),
(4007,2009,12,'2026-05-08','Inspektion','Allgemeiner Check'),
(4008,2010,15,'2026-05-09','Inspektion','Bremsbelag getauscht'),
(4009,2003,16,'2026-05-10','Reparatur','Sattel ersetzt'),
(4010,2005,20,'2026-05-11','Sicherheitscheck','Softwareupdate E-Antrieb');

INSERT INTO zahlungen VALUES
(5001,3001,6.80,'App','2026-05-02 09:06:00','bezahlt'),
(5002,3002,5.90,'Karte','2026-05-04 15:06:00','bezahlt'),
(5003,3003,7.10,'Lastschrift','2026-05-03 11:12:00','bezahlt'),
(5004,3004,4.80,'App','2026-05-03 16:46:00','bezahlt'),
(5005,3005,8.20,'Karte','2026-05-05 08:56:00','bezahlt'),
(5006,3007,7.80,'Lastschrift','2026-05-06 10:37:00','bezahlt'),
(5007,3008,6.60,'App','2026-05-06 12:06:00','bezahlt'),
(5008,3009,7.30,'Karte','2026-05-07 13:12:00','bezahlt'),
(5009,3010,4.50,'App','2026-05-07 16:01:00','bezahlt'),
(5010,3011,5.70,'Lastschrift','2026-05-08 09:41:00','bezahlt'),
(5011,3012,4.90,'Karte','2026-05-08 18:21:00','bezahlt'),
(5012,3013,5.60,'App','2026-05-09 08:51:00','bezahlt'),
(5013,3014,4.70,'Lastschrift','2026-05-09 13:56:00','bezahlt'),
(5014,3015,7.40,'Karte','2026-05-10 10:11:00','bezahlt'),
(5015,3016,4.40,'App','2026-05-10 18:51:00','bezahlt'),
(5016,3017,4.90,'Lastschrift','2026-05-11 07:41:00','bezahlt'),
(5017,3018,4.80,'Karte','2026-05-11 15:06:00','bezahlt'),
(5018,3019,7.10,'App','2026-05-12 12:46:00','bezahlt'),
(5019,3020,6.90,'Lastschrift','2026-05-12 17:11:00','bezahlt'),
(5020,3021,4.60,'Karte','2026-05-12 19:41:00','bezahlt');

-- Beispielabfragen fuer Lehrkraefte
-- 1) Mehrtabellen-JOIN fuer abgeschlossene Ausleihen
-- SELECT k.nachname, k.vorname, f.seriennummer, ft.typname,
--        s_start.stationsname AS start_station,
--        s_ziel.stationsname AS ziel_station,
--        a.startzeit, z.betrag
-- FROM ausleihen a
-- JOIN kunden k ON k.kunde_id = a.kunde_id
-- JOIN fahrraeder f ON f.fahrrad_id = a.fahrrad_id
-- JOIN fahrradtypen ft ON ft.typ_id = f.typ_id
-- JOIN stationen s_start ON s_start.station_id = a.start_station_id
-- JOIN stationen s_ziel ON s_ziel.station_id = a.ziel_station_id
-- LEFT JOIN zahlungen z ON z.ausleihe_id = a.ausleihe_id
-- WHERE a.status = 'abgeschlossen'
-- ORDER BY k.nachname, a.startzeit;
