START TRANSACTION;

-- Menambahkan data admin
INSERT INTO akun_admin (nama_admin, email, password) 
VALUES ('Admin Utama', 'admin@example.com', 'password123');

-- Menambahkan data pengguna
INSERT INTO akun_user (nama_user, email, tipe_user, password) 
VALUES ('Budi', 'budi@example.com', 'orang_tua', 'password123');

-- Menambahkan data anak yang dimiliki oleh pengguna
INSERT INTO data_anak (id_user, nama_anak, tanggal_lahir, umur, jenis_kelamin, hobi, berat_badan_kg, tinggi_badan_cm) 
VALUES (1, 'Dita', '2015-05-10', 8, 'perempuan', 'Menyanyi', 30.5, 120.4);

-- Menambahkan jadwal makan anak
INSERT INTO jadwal_makan (id_anak, waktu_sarapan, menu_sarapan, waktu_makan_siang, menu_makan_siang, waktu_makan_malam, menu_makan_malam) 
VALUES (1, '07:00:00', 'Nasi Goreng', '12:00:00', 'Ayam Goreng', '18:00:00', 'Sup Ikan');

-- Menambahkan riwayat kesehatan anak
INSERT INTO riwayat_kesehatan (id_anak, nama_penyakit, nama_obat, tanggal_mulai_sakit, tanggal_selesai_sakit) 
VALUES (1, 'Flu', 'Paracetamol', '2024-01-01', '2024-01-05');

COMMIT;



-- User Kedua
START TRANSACTION;

-- Menambahkan data pengguna
INSERT INTO akun_user (nama_user, email, tipe_user, password) 
VALUES ('Maya', 'bmaya@example.com', 'orang_tua', 'password123');

-- Menambahkan data anak yang dimiliki oleh pengguna
INSERT INTO data_anak (id_user, nama_anak, tanggal_lahir, umur, jenis_kelamin, hobi, berat_badan_kg, tinggi_badan_cm) 
VALUES (2, 'Yerenika', '2015-05-10', 8, 'perempuan', 'Menyanyi', 30.5, 120.4);

-- Menambahkan jadwal makan anak
INSERT INTO jadwal_makan (id_anak, waktu_sarapan, menu_sarapan, waktu_makan_siang, menu_makan_siang, waktu_makan_malam, menu_makan_malam) 
VALUES (1, '07:00:00', 'Udang', '12:00:00', 'Ikan Tuna', '18:00:00', 'Sup Iga');

-- Menambahkan riwayat kesehatan anak
INSERT INTO riwayat_kesehatan (id_anak, nama_penyakit, nama_obat, tanggal_mulai_sakit, tanggal_selesai_sakit) 
VALUES (1, 'Flu', 'Bodrex', '2024-01-01', '2024-01-05');

COMMIT;


-- Lihat Data Tabel
SELECT * FROM data_anak;

-- Hapus Data Anak
DELETE FROM data_anak
WHERE nama_anak = 'Dita';
