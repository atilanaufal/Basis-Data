-- Mencari semua user dengan tipe 'orang_tua'
SELECT * FROM akun_user WHERE tipe_user = 'orang_tua';

-- Mencari semua anak dengan umur 5 tahun
SELECT * FROM data_anak WHERE umur = 5;

-- Mencari semua anak dengan umur antara 3 dan 7 tahun
SELECT * FROM data_anak WHERE umur BETWEEN 3 AND 7;

-- Mencari jadwal makan dengan menu sarapan 'Nasi Goreng'
SELECT * FROM jadwal_makan WHERE menu_sarapan = 'Nasi Goreng';

-- Mencari jadwal makan dengan menu sarapan yang mengandung kata 'Roti'
SELECT * FROM jadwal_makan WHERE menu_sarapan LIKE '%Roti%';

-- Mencari jadwal tidur dengan waktu bangun jam 7 pagi
SELECT * FROM jadwal_tidur WHERE waktu_bangun = '07:00:00';

-- Mencari jadwal tidur dengan waktu bangun sebelum jam 6 pagi
SELECT * FROM jadwal_tidur WHERE waktu_bangun < '06:00:00';

-- Mencari kegiatan anak dengan nama 'Belajar'
SELECT * FROM kegiatan_anak WHERE nama_kegiatan = 'Belajar';

-- Mencari riwayat kesehatan dengan nama penyakit 'Demam'
SELECT * FROM riwayat_kesehatan WHERE nama_penyakit = 'Demam';
