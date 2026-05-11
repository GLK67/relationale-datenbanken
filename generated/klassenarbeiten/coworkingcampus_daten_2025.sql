-- SQL-Daten Teil C (Version 2)
USE ka02_bg12_2025_sqlteil_v2;

INSERT INTO kunden VALUES
(1,'Mila','Sommer','Wirtschaftsinformatik','2024-10-01',1),
(2,'Leon','Seifert','Informatik','2024-10-02',1),
(3,'Nora','Pohl','Data Science','2024-10-03',1),
(4,'Jan','Graf','Informatik','2024-10-05',1),
(5,'Sina','Reuter','Wirtschaftsinformatik','2024-10-06',1),
(6,'Tom','Brandt','Informatik','2024-10-08',1),
(7,'Lia','Mohr','Data Science','2024-10-10',1),
(8,'Noel','Heinz','Informatik','2024-10-11',1),
(9,'Emma','Schade','Wirtschaftsinformatik','2024-10-12',1),
(10,'Luca','Jansen','Informatik','2024-10-14',1),
(11,'Nina','Wolf','Data Science','2024-10-15',1),
(12,'Paul','Mayer','Informatik','2024-10-16',1);

INSERT INTO betreuende VALUES
(1,'Klara','Dietz','Support','klara.dietz@campus.example'),
(2,'Rene','Ott','Support','rene.ott@campus.example'),
(3,'Boris','Lenz','Betrieb','boris.lenz@campus.example'),
(4,'Mara','Kuhn','Leitung','mara.kuhn@campus.example'),
(5,'Eda','Voigt','Support','eda.voigt@campus.example'),
(6,'Ivo','Seiler','Betrieb','ivo.seiler@campus.example');

INSERT INTO standorte VALUES
(101,'Campus Mitte','A-Bau',1,1),
(102,'Campus Nord','B-Bau',2,1),
(103,'Campus West','C-Bau',0,1),
(104,'Campus Ost','D-Bau',1,1);

INSERT INTO tarifmodelle VALUES
(1,'Flex 1h',3.50,1),
(2,'Team 2h',5.90,4),
(3,'Projekt 4h',9.80,6);

INSERT INTO arbeitsplaetze VALUES
(201,101,1,'A1-01','frei'),
(202,101,2,'A1-02','belegt'),
(203,102,1,'B2-01','frei'),
(204,102,3,'B2-02','gesperrt'),
(205,103,2,'C0-01','belegt'),
(206,103,3,'C0-02','frei'),
(207,104,1,'D1-01','frei'),
(208,104,2,'D1-02','belegt');

INSERT INTO buchungen VALUES
(301,1,202,'2026-04-01 08:00:00','2026-04-01 10:00:00','abgeschlossen'),
(302,2,203,'2026-04-01 09:00:00','2026-04-01 10:30:00','abgeschlossen'),
(303,3,205,'2026-04-01 11:00:00',NULL,'laufend'),
(304,4,201,'2026-04-02 08:15:00','2026-04-02 09:10:00','abgeschlossen'),
(305,5,208,'2026-04-02 12:00:00','2026-04-02 14:00:00','abgeschlossen'),
(306,6,206,'2026-04-03 10:00:00','2026-04-03 12:30:00','abgeschlossen'),
(307,1,207,'2026-04-03 14:00:00','2026-04-03 15:00:00','abgeschlossen'),
(308,2,205,'2026-04-04 09:30:00','2026-04-04 11:00:00','abgeschlossen'),
(309,7,202,'2026-04-04 13:00:00','2026-04-04 14:15:00','abgeschlossen'),
(310,8,203,'2026-04-05 08:45:00','2026-04-05 09:50:00','abgeschlossen'),
(311,9,208,'2026-04-05 11:00:00','2026-04-05 12:40:00','abgeschlossen'),
(312,10,201,'2026-04-05 13:00:00','2026-04-05 14:00:00','abgeschlossen');

INSERT INTO supporttickets VALUES
(401,1,301,1,'2026-04-01 08:30:00','mittel','geloest'),
(402,3,303,2,'2026-04-01 11:20:00','hoch','in_bearbeitung'),
(403,5,305,1,'2026-04-02 12:30:00','niedrig','geloest'),
(404,7,309,5,'2026-04-04 13:10:00','mittel','offen'),
(405,9,311,NULL,'2026-04-05 11:30:00','hoch','offen');

INSERT INTO zahlungen VALUES
(501,301,11.80,'App','2026-04-01 10:01:00','bezahlt'),
(502,302,7.90,'Karte','2026-04-01 10:31:00','bezahlt'),
(503,304,5.50,'App','2026-04-02 09:11:00','bezahlt'),
(504,305,11.80,'Lastschrift','2026-04-02 14:01:00','bezahlt'),
(505,306,14.70,'Karte','2026-04-03 12:31:00','bezahlt'),
(506,307,3.50,'App','2026-04-03 15:01:00','bezahlt'),
(507,308,8.90,'Karte','2026-04-04 11:01:00','bezahlt'),
(508,309,7.20,'Lastschrift','2026-04-04 14:16:00','bezahlt'),
(509,310,6.10,'App','2026-04-05 09:51:00','bezahlt'),
(510,311,9.70,'Karte','2026-04-05 12:41:00','bezahlt'),
(511,312,4.20,'Lastschrift','2026-04-05 14:01:00','bezahlt');
