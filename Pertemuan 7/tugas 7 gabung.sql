CREATE DATABASE Basis7;
-- Membuat tabel 'mahasiswa'
CREATE TABLE IF NOT EXISTS mahasiswa (
    id INT PRIMARY KEY,
    nama VARCHAR(50),
    alamat VARCHAR(100)
);


-- Menambahkan data ke tabel 'mahasiswa'
INSERT INTO mahasiswa (id, nama, alamat) 
VALUES (1, 'Budi', 'Jakarta');

-- Menambahkan data ke tabel 'mahasiswa'
INSERT INTO siswa (id, nama, alamat) 
VALUES (2, 'siregar', 'Jakarta');

select* from siswa;

-- Mengubah data pada tabel 'mahasiswa'
UPDATE mahasiswa 
SET alamat = 'Bandung' 
WHERE id = 1;

-- Menghapus data dari tabel 'mahasiswa'
DELETE FROM mahasiswa 
WHERE id = 1;

select* from siswa;


-- Menambahkan kolom 'telepon' ke tabel 'mahasiswa'
ALTER TABLE mahasiswa 
ADD telepon VARCHAR(15);

-- Mengganti nama kolom 'telepon' menjadi 'no_telepon' di tabel 'mahasiswa'
ALTER TABLE mahasiswa 
CHANGE telepon no_telepon VARCHAR(15);

-- Menghapus kolom 'no_telepon' dari tabel 'mahasiswa'
ALTER TABLE mahasiswa 
DROP COLUMN no_telepon;

-- Mengganti nama tabel 'mahasiswa' menjadi 'siswa'
RENAME TABLE mahasiswa TO siswa;


-- Menampilkan daftar database yang ada
SHOW DATABASES;

-- Menampilkan struktur dari tabel 'mahasiswa'
SHOW CREATE TABLE siswa;

-- Membuat view 'mahasiswa_lokal' untuk menampilkan data mahasiswa yang beralamat di Jakarta
CREATE VIEW mahasiswa_lokal AS
SELECT nama, alamat 
FROM siswa 
WHERE alamat = 'Jakarta';

-- Menampilkan view mahasiswa_lokal
select * from  mahasiswa_lokal;

-- Mengubah view 'mahasiswa_lokal' untuk menambahkan id
CREATE OR REPLACE VIEW mahasiswa_lokal AS
SELECT id, nama, alamat 
FROM siswa 
WHERE alamat = 'Jakarta';

select * from  mahasiswa_lokal;

-- Menghapus database (sesuaikan nama_database dengan nama database yang ingin dihapus)
-- DROP DATABASE nama_database;

-- Menghapus tabel 'siswa'
DROP TABLE siswa;
