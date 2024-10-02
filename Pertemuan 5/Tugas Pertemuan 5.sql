CREATE DATABASE akademik;

CREATE TABLE dosen (
  Nip varchar(15) PRIMARY KEY NOT NULL,
  Nama_Dosen varchar(99) NOT NULL
);

CREATE TABLE mahasiswa (
  Nim varchar(99) PRIMARY KEY NOT NULL,
  Nama_Mhs varchar(99) NOT NULL,
  Tgl_Lahir date NOT NULL,
  Alamat varchar(50) NOT NULL,
  Jenis_Kelamin enum("Laki-laki","Perempuan") NOT NULL,
  IPK decimal (10,2)
);

CREATE TABLE matakuliah (
  Kode_MK varchar(8) PRIMARY KEY NOT NULL,
  Nama_MK varchar(35) NOT NULL,
  Sks int(2) NOT NULL
); 

CREATE TABLE perkuliahan (
  Nim varchar(99) DEFAULT NULL,
  Kode_MK varchar(8) DEFAULT NULL,
  Nip varchar(15) DEFAULT NULL,
  Kehadiran decimal(6,2), 
  Nilai_Bobot char(1) DEFAULT '-',
  Nilai_Angka decimal(6,2), 
  Poin varchar(1) DEFAULT '-',
  KEY Nip (Nip),
  KEY Nim (Nim),
  KEY Kode_MK (Kode_MK),
  CONSTRAINT perkuliahan_ibfk_1 FOREIGN KEY (Nip) REFERENCES dosen (Nip) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT perkuliahan_ibfk_2 FOREIGN KEY (Nim) REFERENCES mahasiswa (Nim) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT perkuliahan_ibfk_3 FOREIGN KEY (Kode_MK) REFERENCES matakuliah (Kode_MK) ON DELETE CASCADE ON UPDATE CASCADE
); 

INSERT INTO Dosen(Nip, Nama_Dosen)
VALUES('0429038801', 'Mariana, S.Kom., MMSI.');

INSERT INTO Dosen(Nip, Nama_Dosen)
VALUES('0425031203', 'Bu Ida');

INSERT INTO Dosen(Nip, Nama_Dosen)
VALUES('0425032952', 'Pa Hendi');

INSERT INTO Dosen(Nip, Nama_Dosen)
VALUES('0426035605', 'Pa Prio');

INSERT INTO Mahasiswa(Nim, Nama_Mhs, Tgl_Lahir, Alamat, Jenis_Kelamin, IPK)
VALUES('2023071001', 'Shavalino Fayola Pangaribuan', '2005-07-06', 'Jakarta Barat', 'Laki-Laki', 3.67 );

INSERT INTO Mahasiswa(Nim, Nama_Mhs, Tgl_Lahir, Alamat, Jenis_Kelamin, IPK)
VALUES('2023071002', 'Athillah Naufal Al-Falah', '2005-08-12', 'Jakarta Selatan', 'Laki-Laki', 3.47 );

INSERT INTO Mahasiswa(Nim, Nama_Mhs, Tgl_Lahir, Alamat, Jenis_Kelamin, IPK)
VALUES('2023071003', 'Rexzy Febriano Chasan', '2004-12-01', 'Depok', 'Laki-Laki', 3.8 );

INSERT INTO Mahasiswa(Nim, Nama_Mhs, Tgl_Lahir, Alamat, Jenis_Kelamin, IPK)
VALUES('2023071004', 'Muhammad Elbendl Satria', '2005-03-22', 'Yogyakarta', 'Laki-Laki', 3.5 );

INSERT INTO Mahasiswa(Nim, Nama_Mhs, Tgl_Lahir, Alamat, Jenis_Kelamin, IPK)
VALUES('2023071005', 'Muhammad Afif AlFatih', '2005-08-12', 'Bekasi', 'Laki-Laki', 3.55 );

SELECT * FROM Dosen;

SELECT * FROM Dosen
WHERE Nip = '0429038801';

SELECT * FROM Mahasiswa;

SELECT * FROM Mahasiswa
WHERE Nim = '2023071002';

UPDATE Dosen SET Nama_Dosen = 'Nurita, S.Kom., MMSI.'
WHERE Nip = '0429038801';

UPDATE Dosen SET Nama_Dosen = 'Hendi, S.Kom., MMSI.'
WHERE Nip = '0425032952';

UPDATE Dosen SET Nama_Dosen = 'Prio Handoko, S.Kom., MMSI.'
WHERE Nip = '0426035605';

UPDATE Dosen SET Nama_Dosen = 'Ida Nurhaida, S.Kom., MMSI.'
WHERE Nip = '0425031203';

SELECT * FROM Dosen;

SELECT * FROM Dosen
WHERE Nip = '0429038801';

SELECT * FROM Mahasiswa;

SELECT * FROM Mahasiswa
WHERE Nim = '2023071002';

DELETE FROM Dosen
WHERE Nip = '0429038801';

DELETE FROM Dosen
WHERE Nama_Dosen = 'Ida Nurhaida, S.Kom., MMSI.';

DELETE FROM Dosen
WHERE Nip = '0426035605';

INSERT INTO Matakuliah(Kode_MK, Nama_MK, SKS) 
VALUES('INF-001', 'Basis Data', 3),
('INF-002', 'English', 2),
('INF-003', 'Komputasi Web', 3),
('INF-004', 'Desain Analisis dan Algoritma', 3),
('INF-005', 'Psikologi Menyimpang Sosial', 2);

INSERT INTO Perkuliahan(Nim, Kode_Mk, Nip, Kehadiran, Nilai_Angka)
VALUES('2023071001', 'INF-001', '0425032952', 90, 93.59 );

INSERT INTO Perkuliahan(Nim, Kode_Mk, Nip, Kehadiran, Nilai_Angka)
VALUES('2023071001', 'INF-002', '0425032952', 65, 82.71 );

INSERT INTO Perkuliahan(Nim, Kode_Mk, Nip, Kehadiran, Nilai_Angka)
VALUES('2023071001', 'INF-003', '0425032952', 75, 90.00 );

INSERT INTO Perkuliahan(Nim, Kode_Mk, Nip, Kehadiran, Nilai_Angka)
VALUES('2023071001', 'INF-004', '0425032952', 70, 85.00 );

INSERT INTO Perkuliahan(Nim, Kode_Mk, Nip, Kehadiran, Nilai_Angka)
VALUES('2023071001', 'INF-005', '0425032952', 80, 75.00 );

INSERT INTO Perkuliahan(Nim, Kode_Mk, Nip, Kehadiran, Nilai_Angka)
VALUES('2023071002', 'INF-001', '0425032952', 100, 87.23 );

INSERT INTO Perkuliahan(Nim, Kode_Mk, Nip, Kehadiran, Nilai_Angka)
VALUES('2023071002', 'INF-002', '0425032952', 100, 90.00 );

INSERT INTO Perkuliahan(Nim, Kode_Mk, Nip, Kehadiran, Nilai_Angka)
VALUES('2023071002', 'INF-003', '0425032952', 40, 75.75 );

INSERT INTO Perkuliahan(Nim, Kode_Mk, Nip, Kehadiran, Nilai_Angka)
VALUES('2023071002', 'INF-004', '0425032952', 65, 98.67 );

INSERT INTO Perkuliahan(Nim, Kode_Mk, Nip, Kehadiran, Nilai_Angka)
VALUES('2023071002', 'INF-005', '0425032952', 85, 67.32 );

SELECT * FROM Perkuliahan;

SELECT * FROM Perkuliahan
Where Nim = "2023071002";

UPDATE Perkuliahan
SET Nilai_Angka = IF(Kehadiran < 75, Nilai_Angka * 0.65, Nilai_Angka);

UPDATE Perkuliahan
SET Nilai_Bobot = 
IF(Nilai_Angka >= 91, 'A',
IF(Nilai_Angka >= 81, 'B',
IF(Nilai_Angka >= 71, 'C',
IF(Nilai_Angka >= 61, 'D', 'E'))));


UPDATE Perkuliahan
SET Poin = 
IF(Nilai_Bobot = 'A', '4',
IF(Nilai_Bobot = 'B', '3',
IF(Nilai_Bobot = 'C', '2',
IF(Nilai_Bobot = 'D', '1', '0'))));


