-- SQL-Daten Teil C (Version 3)
USE ka02_bg12_2025_sqlteil_v3;

INSERT INTO kunden VALUES
(1,'Lina','Berg','Silber','2024-09-01',1),
(2,'Mika','Hahn','Bronze','2024-09-02',1),
(3,'Nele','Voigt','Gold','2024-09-03',1),
(4,'Oskar','Kurz','Silber','2024-09-04',1),
(5,'Lea','Sander','Bronze','2024-09-05',1),
(6,'Timo','Reich','Gold','2024-09-06',1),
(7,'Mara','Klein','Silber','2024-09-07',1),
(8,'Jan','Pape','Bronze','2024-09-08',1),
(9,'Emma','Krug','Silber','2024-09-09',1),
(10,'Noah','Riedel','Gold','2024-09-10',1),
(11,'Lia','Wirth','Bronze','2024-09-11',1),
(12,'Paul','Schramm','Silber','2024-09-12',1);

INSERT INTO mitarbeitende VALUES
(1,'Sven','Arndt','Service','sven.arndt@truck.example'),
(2,'Nora','Baum','Kueche','nora.baum@truck.example'),
(3,'Aylin','Drescher','Service','aylin.drescher@truck.example'),
(4,'Benedikt','Ehlers','Leitung','benedikt.ehlers@truck.example'),
(5,'Tara','Fischer','Kueche','tara.fischer@truck.example'),
(6,'Yasin','Grau','Service','yasin.grau@truck.example');

INSERT INTO standorte VALUES
(101,'Uni Plaza','Mitte',1),
(102,'Technikpark','Nord',1),
(103,'Rheinpromenade','West',1),
(104,'Campus Süd','Sued',1);

INSERT INTO trucks VALUES
(201,101,'ByteBite','offen'),
(202,102,'DataDeli','offen'),
(203,103,'AlgoGrill','pause'),
(204,104,'SQLSnack','offen');

INSERT INTO produktkategorien VALUES
(1,'Bowl'),
(2,'Burger'),
(3,'Getraenk'),
(4,'Dessert');

INSERT INTO produkte VALUES
(301,201,1,'Campus Bowl',8.90,1),
(302,201,3,'Mango Limo',3.20,1),
(303,202,2,'Stack Burger',9.50,1),
(304,202,3,'Iced Tea',2.90,1),
(305,203,1,'Green Bowl',8.40,0),
(306,203,4,'Cookie Trio',4.20,1),
(307,204,2,'Veggie Burger',8.80,1),
(308,204,3,'Spark Water',2.60,1);

INSERT INTO bestellungen VALUES
(401,1,201,'2026-05-03 11:05:00','abgeschlossen'),
(402,2,202,'2026-05-03 11:20:00','abgeschlossen'),
(403,3,204,'2026-05-03 11:40:00','abgeschlossen'),
(404,4,201,'2026-05-03 12:10:00','storniert'),
(405,5,202,'2026-05-04 12:15:00','abgeschlossen'),
(406,6,204,'2026-05-04 12:45:00','abgeschlossen'),
(407,1,202,'2026-05-04 13:05:00','abgeschlossen'),
(408,2,201,'2026-05-05 11:10:00','abgeschlossen'),
(409,7,204,'2026-05-05 11:50:00','abgeschlossen'),
(410,8,201,'2026-05-05 12:00:00','abgeschlossen'),
(411,9,202,'2026-05-05 12:15:00','abgeschlossen'),
(412,10,204,'2026-05-05 12:40:00','abgeschlossen');

INSERT INTO bestellpositionen VALUES
(501,401,301,1,8.90),(502,401,302,1,3.20),
(503,402,303,1,9.50),(504,402,304,1,2.90),
(505,403,307,1,8.80),(506,403,308,1,2.60),
(507,405,303,2,9.50),(508,406,307,1,8.80),
(509,407,304,2,2.90),(510,408,301,1,8.90),
(511,409,308,2,2.60),(512,410,302,1,3.20),
(513,411,303,1,9.50),(514,412,307,1,8.80);

INSERT INTO schichten VALUES
(601,1,201,'2026-05-03','Frueh'),
(602,2,201,'2026-05-03','Frueh'),
(603,3,202,'2026-05-03','Mittel'),
(604,4,202,'2026-05-04','Mittel'),
(605,5,204,'2026-05-04','Spaet');

INSERT INTO zahlungen VALUES
(701,401,12.10,'App','2026-05-03 11:10:00','bezahlt'),
(702,402,12.40,'Karte','2026-05-03 11:25:00','bezahlt'),
(703,403,11.40,'App','2026-05-03 11:45:00','bezahlt'),
(704,405,19.00,'Karte','2026-05-04 12:20:00','bezahlt'),
(705,406,8.80,'Bar','2026-05-04 12:50:00','bezahlt'),
(706,407,5.80,'App','2026-05-04 13:10:00','bezahlt'),
(707,408,8.90,'Karte','2026-05-05 11:12:00','bezahlt'),
(708,409,5.20,'Bar','2026-05-05 11:55:00','bezahlt'),
(709,410,3.20,'App','2026-05-05 12:03:00','bezahlt'),
(710,411,9.50,'Karte','2026-05-05 12:20:00','bezahlt'),
(711,412,8.80,'App','2026-05-05 12:42:00','bezahlt');
