-- Membuat database ParentWatch
CREATE DATABASE IF NOT EXISTS ParentWatch;
USE ParentWatch;

-- Tabel Admin
CREATE TABLE IF NOT EXISTS akun_admin (
    id_admin INT PRIMARY KEY AUTO_INCREMENT,
    nama_admin VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tabel Akun Pengguna (Orang Tua & Pengasuh)
CREATE TABLE IF NOT EXISTS akun_user (
    id_user INT PRIMARY KEY AUTO_INCREMENT,
    nama_user VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    tipe_user ENUM('orang_tua', 'pengasuh') NOT NULL, -- Hak akses user
    password VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tabel Data Anak
CREATE TABLE IF NOT EXISTS data_anak (
    id_anak INT PRIMARY KEY AUTO_INCREMENT,
    id_user INT NOT NULL,
    nama_anak VARCHAR(255) NOT NULL,
    tanggal_lahir DATE NOT NULL,
    umur INT NOT NULL,
    jenis_kelamin ENUM('laki-laki', 'perempuan') NOT NULL,
    hobi TEXT,
    berat_badan_kg DECIMAL(5,2), -- Berat badan (kg) dengan dua desimal
    tinggi_badan_cm DECIMAL(5,2), -- Tinggi badan (cm) dengan dua desimal
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_user) REFERENCES akun_user(id_user) ON DELETE CASCADE
);

-- Tabel Waktu Makan Anak
CREATE TABLE IF NOT EXISTS jadwal_makan (
    id_jadwal INT PRIMARY KEY AUTO_INCREMENT,
    id_anak INT NOT NULL,
    waktu_sarapan TIME,
    menu_sarapan TEXT,
    waktu_makan_siang TIME,
    menu_makan_siang TEXT,
    waktu_makan_malam TIME,
    menu_makan_malam TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_anak) REFERENCES data_anak(id_anak) ON DELETE CASCADE
);

-- Tabel Waktu Tidur Anak
CREATE TABLE IF NOT EXISTS jadwal_tidur (
    id_jadwal INT PRIMARY KEY AUTO_INCREMENT,
    id_anak INT NOT NULL,
    waktu_tidur TIME NOT NULL,
    waktu_bangun TIME NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_anak) REFERENCES data_anak(id_anak) ON DELETE CASCADE
);

-- Tabel Kegiatan Anak
CREATE TABLE IF NOT EXISTS kegiatan_anak (
    id_kegiatan INT PRIMARY KEY AUTO_INCREMENT,
    id_anak INT NOT NULL,
    nama_kegiatan VARCHAR(255) NOT NULL,
    waktu_mulai TIME NOT NULL,
    waktu_selesai TIME NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_anak) REFERENCES data_anak(id_anak) ON DELETE CASCADE
);

-- Tabel Kesehatan Anak
CREATE TABLE IF NOT EXISTS riwayat_kesehatan (
    id_kesehatan INT PRIMARY KEY AUTO_INCREMENT,
    id_anak INT NOT NULL,
    nama_penyakit VARCHAR(255) NOT NULL,
    nama_obat TEXT,
    tanggal_mulai_sakit DATETIME,
    tanggal_selesai_sakit DATETIME,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_anak) REFERENCES data_anak(id_anak) ON DELETE CASCADE
);
