-- INSERT --
-- Memanggil stored procedure tambah_akun_admin
CALL tambah_akun_admin('admin1', 'admin1@gmail.com', 'admin123');

-- Memanggil stored procedure tambah_akun_user
CALL tambah_akun_user('Daffa', 'daffa@gmail.com', 'orang_tua', 'user123');

-- Memanggil stored procedure tambah_akun_user
CALL tambah_akun_user('budi', 'budi@gmail.com', 'pengasuh', 'user123');

-- Memanggil stored procedure tambah_data_anak
CALL tambah_data_anak(1, "Ma'ruf", '2020-01-15', 'laki-laki', 20.5, 90.2);
CALL tambah_data_anak(1, "Mina", '2017-08-12', 'perempuan', 45, 125);

-- Memanggil stored procedure tambah_jadwal_makan
CALL tambah_jadwal_makan(1, '07:00:00', 'Roti', '12:00:00', 'Nasi Goreng', '19:00:00', 'Sayur Sop');
CALL tambah_jadwal_makan(2, '07:00:00', 'Bubur Ayam', '12:00:00', 'Udang Goreng', '19:00:00', 'Sayur Sop');

-- Memanggil stored procedure tambah_jadwal_tidur
CALL tambah_jadwal_tidur(1, '19:00:00', '06:00:00');
CALL tambah_jadwal_tidur(2, '21:00:00', '04:30:00');

-- Memanggil stored procedure tambah_kegiatan_anak
CALL tambah_kegiatan_anak(1, 'Sekolah', '08:00:00', '10:00:00');
CALL tambah_kegiatan_anak(2, 'Ngaji', '05:00:00', '05:45:00');

-- Memanggil stored procedure tambah_riwayat_kesehatan
CALL tambah_riwayat_kesehatan(1, 'Demam', 'Paracetamol', '2023-12-18 08:00:00', '2023-12-20 10:00:00');


-- DELETE --
-- Menghapus akun admin 
CALL hapus_akun_admin('admin1@gmail.com');

-- Menghapus akun user 
CALL hapus_akun_user('daffa@gmail.com');

-- Menghapus akun user dengan id_user = 2
CALL hapus_akun_user('budi@gmail.com');

-- Menghapus data anak dengan id_anak = 3
CALL hapus_data_anak(1);

-- Menghapus jadwal makan dengan id_jadwal = 4
CALL hapus_jadwal_makan(1);

-- Menghapus jadwal tidur dengan id_jadwal = 5
CALL hapus_jadwal_tidur(1);

-- Menghapus kegiatan anak dengan id_kegiatan = 6
CALL hapus_kegiatan_anak(1);

-- Menghapus riwayat kesehatan dengan id_kesehatan = 7
CALL hapus_riwayat_kesehatan(1);


-- UPDATE --
-- Memanggil stored procedure update_akun_admin
CALL update_akun_admin(1, 'Admin Baru', 'admin1@gmail.com', 'passwordbaru');

-- Memanggil stored procedure update_akun_user
CALL update_akun_user(1, 'Daffa Ortu', 'daffa@gmail.com',  'passwordbaru');

CALL update_akun_user(1, 'Budi Pengasuh', 'daffa@gmail.com',  'passwordbaru');

-- Memanggil stored procedure update_data_anak
CALL update_data_anak(1, 1, 'Reno', '2020-02-10', 'laki-laki', 22.8, 95.7);

-- Memanggil stored procedure update_jadwal_makan
CALL update_jadwal_makan(1, 1, '07:30:00', 'Energen', '12:30:00', 'Nasi Padang', '19:30:00', 'Telur');

-- Memanggil stored procedure update_jadwal_tidur
CALL update_jadwal_tidur(1, 1, '21:30:00', '06:30:00');

-- Memanggil stored procedure update_kegiatan_anak
CALL update_kegiatan_anak(1, 1, 'Menggambar', '09:00:00', '11:00:00');

-- Memanggil stored procedure update_riwayat_kesehatan
CALL update_riwayat_kesehatan(1, 1, 'Batuk', 'Obat Batuk', '2023-12-20 09:00:00', '2023-12-22 11:00:00');


-- SELECT --
-- Memanggil stored procedure lihat_data_anak
CALL lihat_data_anak(1);
