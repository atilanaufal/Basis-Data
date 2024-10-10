CREATE DATABASE Kampus;

CREATE TABLE daftar (
    id_mhs INT PRIMARY KEY AUTO_INCREMENT,
    nama VARCHAR(100),
    tanggal_lahir DATE not null,
    prodi char(15),
    tahun_masuk int,
    no_pendaftaran VARCHAR(50),
    status_pembayaran ENUM('Belum Lunas', 'Sudah Lunas')
);

CREATE TABLE mhs (
    nim INT PRIMARY KEY AUTO_INCREMENT,
    nama VARCHAR(100),
    tanggal_lahir DATE not null,
    prodi char(15),
    tahun_masuk int
);


CREATE TABLE data_hasil_tes (
    id_tes INT PRIMARY KEY AUTO_INCREMENT,
    id_mhs INT,
    nilai DECIMAL(5,2),
    nilai_bobot char(3),
    hasil varchar(25),
    FOREIGN KEY (id_mhs) REFERENCES daftar(id_mhs)
);


CREATE TABLE pembayaran (
    id_bayar INT PRIMARY KEY AUTO_INCREMENT,
    id_mhs INT,
    jumlah DECIMAL(10,2),
    tanggal_bayar DATE,
    cek ENUM('Pending', 'Selesai'),
    FOREIGN KEY (id_mhs) REFERENCES daftar(id_mhs)
);
