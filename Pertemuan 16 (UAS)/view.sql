-- Membuat View untuk Laporan Data Anak
CREATE OR REPLACE VIEW laporan_data_anak AS
SELECT 
    da.id_anak, 
    da.nama_anak, 
    da.tanggal_lahir, 
    da.umur, 
    da.jenis_kelamin, 
    da.hobi, 
    da.berat_badan_kg, 
    da.tinggi_badan_cm, 
    au.nama_user AS pemilik
FROM data_anak da
JOIN akun_user au ON da.id_user = au.id_user;
