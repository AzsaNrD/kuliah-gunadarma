-- Active: 1700029485149@@127.0.0.1@3306

--1--
CREATE DATABASE 2ka17_kelompok2;

--2--
USE 2ka17_kelompok2;

--2a--
CREATE TABLE MHS
( 
  NPM CHAR(8),
  NAMA VARCHAR(40) NOT NULL, 
  KELAS CHAR(5) NOT NULL,
  TEMPAT_L VARCHAR(30),
  TGL_L DATE,
  ALAMAT VARCHAR(30), 
  KOTA VARCHAR(25)
);

--2b--
CREATE TABLE MATKUL
(
  KDMK CHAR(8),
  NAMAMK VARCHAR(30),
  SKS SMALLINT,
  JENIS CHAR(1)
);

--2c--
CREATE TABLE NILAI
(
  NPM CHAR(8),
  KDMK CHAR(8),
  UTS SMALLINT,
  UAS SMALLINT,
  RERATA SMALLINT,
  GRADE CHAR(1),
  SEM CHAR(1)
);

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

--3c--
INSERT INTO NILAI VALUES
('10122044', 'AK011317', 80, 60, null, null, 3),
('10122257', 'IT000203', 70, 55, null, null, 3),
('10122727', 'IT011212', 45, 90, null, null, 3),
('10122977', 'IT011214', 75, 70, null, null, 3),
('11122281', 'IT000104', 80, 90, null, null, 3);

--4--
SELECT MAX(UAS) FROM NILAI;

--5--
SELECT MIN(UTS) FROM NILAI;

--6--
SELECT MIN(UAS) AS UAS_Terendah, MAX(UAS) AS UAS_Tertinggi
FROM NILAI;

--7--
SELECT AVG(UTS) AS RataRata_UTS, AVG(UAS) AS RataRata_UAS
FROM NILAI;

--8--
UPDATE NILAI
SET RERATA = ROUND(0.7 * UTS + 0.3 * UAS, 0);

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
WHERE NILAI.UTS >= 70 AND NILAI.UTS <= 90;

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

-- tampilkan hasilnya
SELECT * FROM MHS;

--27--
LOAD DATA INFILE 
'D:/Documents/Gunadarma/My GitHub Repository/kuliah-gunadarma/semester-3/sistem-basis-data-1/tugas/kelompok/ddl-dml/mtkul1.txt'
INTO TABLE MATKUL
FIELDS TERMINATED BY ';';

-- tampilkan hasilnya
SELECT * FROM MATKUL;

--29--
LOAD DATA INFILE 
'D:/Documents/Gunadarma/My GitHub Repository/kuliah-gunadarma/semester-3/sistem-basis-data-1/tugas/kelompok/ddl-dml/nilai1.txt'
INTO TABLE NILAI
FIELDS TERMINATED BY ';';

-- tampilkan hasilnya
SELECT * FROM NILAI;

--30--
-- Update FIKTI untuk NPM = '1'
UPDATE MHS
SET FAK = 'FIKTI'
WHERE SUBSTRING(NPM, 3, 1) = '1';

-- Update FE untuk NPM = '2'
UPDATE MHS
SET FAK = 'FE'
WHERE SUBSTRING(NPM, 3, 1) = '2';

-- Update FTSP untuk NPM = '3'
UPDATE MHS
SET FAK = 'FTSP'
WHERE SUBSTRING(NPM, 3, 1) = '3';

-- Update FTI untuk NPM = '4'
UPDATE MHS
SET FAK = 'FTI'
WHERE SUBSTRING(NPM, 3, 1) = '4';

-- Update FPSI untuk NPM = '5'
UPDATE MHS
SET FAK = 'FPSI'
WHERE SUBSTRING(NPM, 3, 1) = '5';

-- Update FSAS untuk NPM = '6'
UPDATE MHS
SET FAK = 'FSAS'
WHERE SUBSTRING(NPM, 3, 1) = '6';

-- Update FKES untuk NPM = '7'
UPDATE MHS
SET FAK = 'FKES'
WHERE SUBSTRING(NPM, 3, 1) = '7';

-- Update FKOMU untuk NPM = '8'
UPDATE MHS
SET FAK = 'FKOMU'
WHERE SUBSTRING(NPM, 3, 1) = '8';

-- tampilkan hasilnya
SELECT * FROM MHS;

--31--
UPDATE MHS
SET FAK = 
    CASE SUBSTRING(NPM, 3, 1)
        WHEN '1' THEN 'FIKTI'
        WHEN '2' THEN 'FE'
        WHEN '3' THEN 'FTSP'
        WHEN '4' THEN 'FTI'
        WHEN '5' THEN 'FPSI'
        WHEN '6' THEN 'FSAS'
        WHEN '7' THEN 'FKES'
        WHEN '8' THEN 'FKOMU'
        ELSE NULL
    END;

--32--
UPDATE MHS
SET FAK = 
    IF(SUBSTRING(NPM, 3, 1) = '1', 'FIKTI', IF(SUBSTRING(NPM, 3, 1) = '2', 'FE',
    IF(SUBSTRING(NPM, 3, 1) = '3', 'FTSP', IF(SUBSTRING(NPM, 3, 1) = '4', 'FTI',
    IF(SUBSTRING(NPM, 3, 1) = '5', 'FPSI', IF(SUBSTRING(NPM, 3, 1) = '6', 'FSAS', 
    IF(SUBSTRING(NPM, 3, 1) = '7', 'FKES', IF(SUBSTRING(NPM, 3, 1) = '8', 'FKOMU', NULL)
)))))));

--33--
SELECT FAK, COUNT(*) AS JumlahMahasiswa
FROM MHS
GROUP BY FAK;

--34--
SELECT MATKUL.KDMK, MATKUL.NAMAMK, COUNT(*) AS JumlahMahasiswa
FROM MATKUL
INNER JOIN NILAI ON MATKUL.KDMK = NILAI.KDMK
GROUP BY MATKUL.KDMK, MATKUL.NAMAMK;


--35--
SELECT KDMK, ROUND(AVG(UTS), 2) AS RerataUTS
FROM NILAI
GROUP BY KDMK;

--36--
UPDATE NILAI
SET GRADE = 'A'
WHERE RERATA >= 85;

UPDATE NILAI
SET GRADE = 'B'
WHERE RERATA >= 65 AND RERATA <= 84;

UPDATE NILAI
SET GRADE = 'C'
WHERE RERATA >= 55 AND RERATA <= 64;

UPDATE NILAI
SET GRADE = 'D'
WHERE RERATA >= 40 AND RERATA <= 54;

UPDATE NILAI
SET GRADE = 'E'
WHERE RERATA < 40;

--37--
UPDATE NILAI
SET GRADE = 
    CASE 
        WHEN RERATA >= 85 THEN 'A'
        WHEN RERATA BETWEEN 65 AND 84 THEN 'B'
        WHEN RERATA BETWEEN 55 AND 64 THEN 'C'
        WHEN RERATA BETWEEN 40 AND 54 THEN 'D'
        ELSE 'E'
    END;

--38--
UPDATE NILAI
SET GRADE = 
    IF(RERATA >= 85, 'A', IF(RERATA BETWEEN 65 AND 84, 'B',
    IF(RERATA BETWEEN 55 AND 64, 'C', IF(RERATA BETWEEN 40 AND 54, 'D', 'E'))));

--39--
SELECT MATKUL.NAMAMK, ROUND(AVG(NILAI.UTS), 2) AS rata_rata_UTS, ROUND(AVG(NILAI.UAS), 2) AS rata_rata_UAS
FROM NILAI
INNER JOIN MATKUL ON NILAI.KDMK = MATKUL.KDMK
GROUP BY MATKUL.NAMAMK;

--40--
SELECT MHS.KELAS, NILAI.NPM, MHS.NAMA, MATKUL.KDMK, MATKUL.NAMAMK, NILAI.GRADE 
INTO OUTFILE 
'D:/Documents/Gunadarma/My GitHub Repository/kuliah-gunadarma/semester-3/sistem-basis-data-1/tugas/kelompok/ddl-dml/hasil_nil.txt'
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
FROM MHS
INNER JOIN NILAI ON NILAI.NPM = MHS.NPM
INNER JOIN MATKUL ON MATKUL.KDMK = NILAI.KDMK;