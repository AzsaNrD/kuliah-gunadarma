--1--
CREATE DATABASE KELAS_kelompok;

USE KELAS_kelompok;

--2--
--2a--
CREATE TABLE MHS
(NPM char(8), NAMA varchar(40)not null, KELAS char(5) not null,
  TEMPAT_L varchar(30), TGL_L date, ALAMAT varchar(30), KOTA varchar(25));

--2b--
CREATE TABLE MATKUL
(KDMK char(8), NAMAMK varchar(30), SKS smallint, JENIS char(1));

--2c--
CREATE TABLE NILAI
(NPM char(8), KDMK char(8), UTS smallint, UAS smallint, RERATA smallint,
GRADE char(1), SEM char(1));

--3--
--3a--
INSERT INTO MHS VALUES
('10122044', 'ADHITYA WISNU WARDHANA', '2KA17', 'MALANG', '2004-09-01', 'JL. Pantura', 'DEPOK'),
('10122257', 'AZSA NURWAHYUDI', '2KA17', 'BOGOR', '2003-10-12', 'JL. Juanda', 'JAKARTA'),
('10122727', 'MAHARANI SHOFA', '2KA17', 'BREBES', '2004-07-08', 'JL. Mampang', 'BEKASI'),
('10122977', 'MUHAMMAD RENGGALA AFRIANSYAH', '2KA17', 'JAKARTA', '2004-04-06', 'JL. Paso', 'BOGOR'),
('11122281', 'RIO PRANOTO HARJO', '2KA17', 'DEPOK', '2003-12-09', 'JL. Kahfi', 'JAKARTA');

--3b--
INSERT INTO MATKUL VALUES 
('AK011317', 'Sistem Basis Data 1', 3, 'W'),
('IT000203', 'Komputasi Big Data', 2, 'W'),
('IT011212', 'Matematika Lanjut 1', 2, 'U'),
('IT011214', 'Matematika Sistem informasi 1', 2, 'W'),
('IT000104', 'Praktikum Kompitasi Big Data', 1, 'W');

 SELECT * FROM MATKUL

--3c--
INSERT INTO NILAI VALUES
('10122044', 'AK011317', 80, 60, ' ', ' ', 3),
('10122257', 'IT000203', 70, 55, ' ', ' ', 3),
('10122727', 'IT011212', 45, 90, ' ', ' ', 3),
('10122977', 'IT011214', 75, 70, ' ', ' ', 3),
('11122281', 'IT000104', 80, 90, ' ', ' ', 3);

SELECT * FROM NILAI

--4--
SELECT MAX(UAS) FROM NILAI

--5--
SELECT MIN(UTS) FROM NILAI

--6--
SELECT MIN(UAS) AS UAS_Terendah, MAX(UAS) AS UAS_Tertinggi
FROM NILAI;

--7--
SELECT AVG(UTS) AS RataRata_UTS, AVG(UAS) AS RataRata_UAS
FROM NILAI;

--8--
UPDATE NILAI
SET RERATA = ROUND(0.7 * UTS + 0.3 * UAS, 0);
SELECT * FROM NILAI

--9--
SELECT NAMA
FROM MHS
WHERE NAMA LIKE 'A%' OR NAMA LIKE '%R%';

--10--
SELECT *
FROM MHS
WHERE NAMA LIKE '%i%'
ORDER BY NAMA DESC;

--11--
SELECT NPM, KDMK, UTS
FROM NILAI
WHERE UTS BETWEEN 70 AND 90;

--12--
SELECT MHS.NPM, MHS.NAMA, MATKUL.KDMK, NILAI.UTS
FROM MHS
CROSS JOIN NILAI
CROSS JOIN MATKUL
WHERE MHS.NPM = NILAI.NPM
  AND MATKUL.KDMK = NILAI.KDMK
  AND NILAI.UTS BETWEEN 70 AND 90;
  
--13--
SELECT MHS.NPM, MHS.NAMA, MATKUL.KDMK, NILAI.UTS
FROM MHS, MATKUL, NILAI
WHERE MHS.NPM = NILAI.NPM
  AND MATKUL.KDMK = NILAI.KDMK
  AND NILAI.UTS BETWEEN 70 AND 90;
  
--14--
SELECT MHS.NPM, MHS.NAMA, MATKUL.KDMK, MATKUL.NAMAMK, NILAI.UTS
FROM MHS
INNER JOIN NILAI ON MHS.NPM = NILAI.NPM
INNER JOIN MATKUL ON MATKUL.KDMK = NILAI.KDMK
WHERE NILAI.UTS BETWEEN 70 AND 90;

--15--
SELECT MHS.NPM, MHS.NAMA, MATKUL.KDMK, MATKUL.NAMAMK, NILAI.UTS
FROM MHS
JOIN NILAI ON MHS.NPM = NILAI.NPM
JOIN MATKUL ON MATKUL.KDMK = NILAI.KDMK
WHERE NILAI.UTS BETWEEN 70 AND 90;

--16--
SELECT MHS.NPM, MHS.NAMA, MATKUL.KDMK, MATKUL.NAMAMK, NILAI.UTS, NILAI.UAS
FROM MHS
INNER JOIN NILAI ON MHS.NPM = NILAI.NPM
INNER JOIN MATKUL ON MATKUL.KDMK = NILAI.KDMK;

--17--
SELECT NPM, NAMA, KOTA
FROM MHS
WHERE KOTA = 'BEKASI' OR KOTA = 'BOGOR' OR KOTA = 'JAKARTA';

--18--
SELECT NPM, NAMA, KOTA
FROM MHS
WHERE KOTA IN ('BEKASI', 'BOGOR', 'JAKARTA');

--19--
SELECT MHS.NAMA AS NAMA_MAHASISWA, MATKUL.NAMAMK, NILAI.UTS, NILAI.UAS
FROM MHS
JOIN NILAI ON MHS.NPM = NILAI.NPM
JOIN MATKUL ON MATKUL.KDMK = NILAI.KDMK
WHERE NILAI.UTS > 60 AND NILAI.UAS > 60;

--20--
ALTER TABLE MHS
ADD COLUMN FAK VARCHAR(30) AFTER NAMA;

SELECT * FROM MHS;

--21--
ALTER TABLE MHS
ADD COLUMN USIA SMALLINT;

--22--
UPDATE MHS
SET USIA = ROUND(DATEDIFF(NOW(), TGL_L) / 365);

--23--
SELECT NPM, NAMA, USIA
FROM MHS
WHERE USIA < (SELECT AVG(USIA) FROM MHS);

--25--
LOAD DATA INFILE 
'D:/Documents/Gunadarma/My GitHub Repository/kuliah-gunadarma/semester-3/sistem-basis-data-1/tugas/kelompok/ddl-dml/mhs1.txt'
INTO TABLE MHS
FIELDS TERMINATED BY ';'

SELECT * FROM MHS;