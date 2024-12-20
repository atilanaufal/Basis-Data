CREATE OR REPLACE VIEW data_anak_lengkap AS
SELECT
    au.id_user,
    da.id_anak,
    da.nama_anak,
    da.tanggal_lahir,
    da.umur,
    da.jenis_kelamin,
    da.hobi,
    da.berat_badan_kg,
    da.tinggi_badan_cm,
    au.nama_user
FROM data_anak da
JOIN akun_user au ON da.id_user = au.id_user;

CREATE OR REPLACE VIEW riwayat_kesehatan_lengkap AS
SELECT 
    rk.id_kesehatan,
    rk.nama_penyakit,
    rk.nama_obat,
    rk.tanggal_mulai_sakit,
    rk.tanggal_selesai_sakit,
    da.nama_anak,
    da.umur,
    au.nama_user AS nama_orang_tua
FROM riwayat_kesehatan rk
JOIN data_anak da ON rk.id_anak = da.id_anak
JOIN akun_user au ON da.id_user = au.id_user;

CREATE OR REPLACE VIEW jadwal_harian_anak AS
SELECT 
    da.id_anak,
    da.nama_anak,
    jm.waktu_sarapan,
    jm.menu_sarapan,
    jm.waktu_makan_siang,
    jm.menu_makan_siang,
    jm.waktu_makan_malam,
    jm.menu_makan_malam,
    jt.waktu_tidur,
    jt.waktu_bangun,
    ka.nama_kegiatan,
    ka.waktu_mulai,
    ka.waktu_selesai
FROM data_anak da
LEFT JOIN jadwal_makan jm ON da.id_anak = jm.id_anak
LEFT JOIN jadwal_tidur jt ON da.id_anak = jt.id_anak
LEFT JOIN kegiatan_anak ka ON da.id_anak = ka.id_anak;

CREATE OR REPLACE VIEW aktivitas_user AS
SELECT
    al.changed_at,
    al.table_name,
    al.operation_type,
    au.nama_user AS user_terlibat,
    al.old_data,
    al.new_data
FROM audit_logs al
JOIN akun_user au ON al.changed_by = au.id_user
WHERE al.role = 'user';

CREATE OR REPLACE VIEW aktivitas_admin AS
SELECT
    al.changed_at,
    al.table_name,
    al.operation_type,
    aa.nama_admin AS admin_terlibat,
    al.old_data,
    al.new_data
FROM audit_logs al
JOIN akun_admin aa ON al.changed_by = aa.id_admin
WHERE al.role = 'admin';
