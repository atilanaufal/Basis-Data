-- Stored Procedure untuk Menambah Akun Admin
DELIMITER //
CREATE PROCEDURE tambah_akun_admin (
    IN p_nama_admin VARCHAR(255),
    IN p_email VARCHAR(255),
    IN p_password VARCHAR(255)
)
BEGIN
    DECLARE EXIT HANDLER FOR 1062 -- Duplicate key error
    BEGIN
        SELECT 'Error: Email admin sudah terdaftar.' AS error_message;
    END;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Error: Terjadi kesalahan saat menambahkan akun admin.' AS error_message;
    END;

    INSERT INTO akun_admin (nama_admin, email, password)
    VALUES (p_nama_admin, p_email, p_password);

    SELECT 'Akun admin berhasil ditambahkan.' AS message;
END //
DELIMITER ;

-- Stored Procedure untuk Menambah Akun User
DELIMITER //
CREATE PROCEDURE tambah_akun_user (
    IN p_nama_user VARCHAR(255),
    IN p_email VARCHAR(255),
    IN p_tipe_user ENUM('orang_tua', 'pengasuh'),
    IN p_password VARCHAR(255)
)
BEGIN
    DECLARE EXIT HANDLER FOR 1062 -- Duplicate key error
    BEGIN
        SELECT 'Error: Email user sudah terdaftar.' AS error_message;
    END;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Error: Terjadi kesalahan saat menambahkan akun user.' AS error_message;
    END;

    INSERT INTO akun_user (nama_user, email, tipe_user, password)
    VALUES (p_nama_user, p_email, p_tipe_user, p_password);

    SELECT 'Akun user berhasil ditambahkan.' AS message;
END //
DELIMITER ;


-- Stored Procedure untuk Menambah Data Anak
DELIMITER //
CREATE PROCEDURE tambah_data_anak (
    IN p_id_user INT,
    IN p_nama_anak VARCHAR(255),
    IN p_tanggal_lahir DATE,
    IN p_jenis_kelamin ENUM('laki-laki', 'perempuan'),
    IN p_hobi TEXT,
    IN p_berat_badan DECIMAL(5,2),
    IN p_tinggi_badan DECIMAL(5,2)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Error: Terjadi kesalahan saat menambahkan data anak.' AS error_message;
    END;

    INSERT INTO data_anak (id_user, nama_anak, tanggal_lahir, umur, jenis_kelamin, hobi, berat_badan_kg, tinggi_badan_cm)
    VALUES (p_id_user, p_nama_anak, p_tanggal_lahir, TIMESTAMPDIFF(YEAR, p_tanggal_lahir, CURDATE()), p_jenis_kelamin, p_hobi, p_berat_badan, p_tinggi_badan);

    SELECT 'Data anak berhasil ditambahkan.' AS message;
END //
DELIMITER ;

-- Stored Procedure untuk Menambah Jadwal Makan
DELIMITER //
CREATE PROCEDURE tambah_jadwal_makan (
    IN p_id_anak INT,
    IN p_waktu_sarapan TIME,
    IN p_menu_sarapan TEXT,
    IN p_waktu_makan_siang TIME,
    IN p_menu_makan_siang TEXT,
    IN p_waktu_makan_malam TIME,
    IN p_menu_makan_malam TEXT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Error: Terjadi kesalahan saat menambahkan jadwal makan.' AS error_message;
    END;

    INSERT INTO jadwal_makan (id_anak, waktu_sarapan, menu_sarapan, waktu_makan_siang, menu_makan_siang, waktu_makan_malam, menu_makan_malam)
    VALUES (p_id_anak, p_waktu_sarapan, p_menu_sarapan, p_waktu_makan_siang, p_menu_makan_siang, p_waktu_makan_malam, p_menu_makan_malam);

    SELECT 'Jadwal makan berhasil ditambahkan.' AS message;
END //
DELIMITER ;

-- Stored Procedure untuk Menambah Jadwal Tidur
DELIMITER //
CREATE PROCEDURE tambah_jadwal_tidur (
    IN p_id_anak INT,
    IN p_waktu_tidur TIME,
    IN p_waktu_bangun TIME
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Error: Terjadi kesalahan saat menambahkan jadwal tidur.' AS error_message;
    END;

    INSERT INTO jadwal_tidur (id_anak, waktu_tidur, waktu_bangun)
    VALUES (p_id_anak, p_waktu_tidur, p_waktu_bangun);

    SELECT 'Jadwal tidur berhasil ditambahkan.' AS message;
END //
DELIMITER ;

-- Stored Procedure untuk Menambah Kegiatan Anak
DELIMITER //
CREATE PROCEDURE tambah_kegiatan_anak (
    IN p_id_anak INT,
    IN p_nama_kegiatan VARCHAR(255),
    IN p_waktu_mulai TIME,
    IN p_waktu_selesai TIME
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Error: Terjadi kesalahan saat menambahkan kegiatan anak.' AS error_message;
    END;

    INSERT INTO kegiatan_anak (id_anak, nama_kegiatan, waktu_mulai, waktu_selesai)
    VALUES (p_id_anak, p_nama_kegiatan, p_waktu_mulai, p_waktu_selesai);

    SELECT 'Kegiatan anak berhasil ditambahkan.' AS message;
END //
DELIMITER ;

-- Stored Procedure untuk Menambah riwayat kesehatan
DELIMITER //
CREATE PROCEDURE tambah_riwayat_kesehatan (
    IN p_id_anak INT,
    IN p_nama_penyakit VARCHAR(255),
    IN p_nama_obat TEXT,
    IN p_tanggal_mulai_sakit DATETIME,
    IN p_tanggal_selesai_sakit DATETIME
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Error: Terjadi kesalahan saat menambahkan riwayat kesehatan.' AS error_message;
    END;

    INSERT INTO riwayat_kesehatan (id_anak, nama_penyakit, nama_obat, tanggal_mulai_sakit, tanggal_selesai_sakit)
    VALUES (p_id_anak, p_nama_penyakit, p_nama_obat, p_tanggal_mulai_sakit, p_tanggal_selesai_sakit);

    SELECT 'Riwayat kesehatan berhasil ditambahkan.' AS message;
END //
DELIMITER ;



-- Membuat Stored Procedure untuk Melihat Data Anak Berdasarkan ID User
DELIMITER //
CREATE PROCEDURE lihat_data_anak (
    IN p_id_user INT
)
BEGIN
    SELECT * FROM data_anak WHERE id_user = p_id_user;
END //
DELIMITER ;
