-- Stored Procedure INSERT ---
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
	
    CALL hak_admin(p_email, p_password);
    
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

	CALL hak_user(p_email, p_tipe_user, p_password);

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
    IN p_berat_badan DECIMAL(5,2),
    IN p_tinggi_badan DECIMAL(5,2)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Error: Terjadi kesalahan saat menambahkan data anak.' AS error_message;
    END;

    INSERT INTO data_anak (id_user, nama_anak, tanggal_lahir, umur, jenis_kelamin, berat_badan_kg, tinggi_badan_cm)
    VALUES (p_id_user, p_nama_anak, p_tanggal_lahir, TIMESTAMPDIFF(YEAR, p_tanggal_lahir, CURDATE()), p_jenis_kelamin,  p_berat_badan, p_tinggi_badan);

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


-- Stored Procedure DELETE --
-- Membuat Stored Procedure untuk Menghapus Akun Admin
DELIMITER //
CREATE PROCEDURE hapus_akun_admin (
    IN p_email VARCHAR(255)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Error: Terjadi kesalahan saat menghapus akun admin.' AS error_message;
    END;

    DELETE FROM akun_admin WHERE email = p_email;
	
    CALL hapus_hak_admin(p_email);
    SELECT 'Akun admin berhasil dihapus.' AS message;
END //
DELIMITER ;

-- Membuat Stored Procedure untuk Menghapus Akun User
DELIMITER //
CREATE PROCEDURE hapus_akun_user (
    IN p_email VARCHAR(255)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Error: Terjadi kesalahan saat menghapus akun user.' AS error_message;
    END;

    DELETE FROM akun_user WHERE email = p_email;
	CALL hapus_hak_user(p_email);
    SELECT 'Akun user berhasil dihapus.' AS message;
END //
DELIMITER ;

-- Membuat Stored Procedure untuk Menghapus Data Anak
DELIMITER //
CREATE PROCEDURE hapus_data_anak (
    IN p_id_anak INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Error: Terjadi kesalahan saat menghapus data anak.' AS error_message;
    END;

    DELETE FROM data_anak WHERE id_anak = p_id_anak;

    SELECT 'Data anak berhasil dihapus.' AS message;
END //
DELIMITER ;

-- Membuat Stored Procedure untuk Menghapus Jadwal Makan
DELIMITER //
CREATE PROCEDURE hapus_jadwal_makan (
    IN p_id_jadwal INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Error: Terjadi kesalahan saat menghapus jadwal makan.' AS error_message;
    END;

    DELETE FROM jadwal_makan WHERE id_jadwal = p_id_jadwal;

    SELECT 'Jadwal makan berhasil dihapus.' AS message;
END //
DELIMITER ;

-- Membuat Stored Procedure untuk Menghapus Jadwal Tidur
DELIMITER //
CREATE PROCEDURE hapus_jadwal_tidur (
    IN p_id_jadwal INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Error: Terjadi kesalahan saat menghapus jadwal tidur.' AS error_message;
    END;

    DELETE FROM jadwal_tidur WHERE id_jadwal = p_id_jadwal;

    SELECT 'Jadwal tidur berhasil dihapus.' AS message;
END //
DELIMITER ;

-- Membuat Stored Procedure untuk Menghapus Kegiatan Anak
DELIMITER //
CREATE PROCEDURE hapus_kegiatan_anak (
    IN p_id_kegiatan INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Error: Terjadi kesalahan saat menghapus kegiatan anak.' AS error_message;
    END;

    DELETE FROM kegiatan_anak WHERE id_kegiatan = p_id_kegiatan;

    SELECT 'Kegiatan anak berhasil dihapus.' AS message;
END //
DELIMITER ;

-- Membuat Stored Procedure untuk Menghapus Riwayat Kesehatan
DELIMITER //
CREATE PROCEDURE hapus_riwayat_kesehatan (
    IN p_id_kesehatan INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Error: Terjadi kesalahan saat menghapus riwayat kesehatan.' AS error_message;
    END;

    DELETE FROM riwayat_kesehatan WHERE id_kesehatan = p_id_kesehatan;

    SELECT 'Riwayat kesehatan berhasil dihapus.' AS message;
END //
DELIMITER ;


-- Stored Procedure UPDATE ---
-- Membuat Stored Procedure untuk Meng-Update Akun Admin 
DELIMITER //
CREATE PROCEDURE update_akun_admin (
    IN p_id_admin INT,
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
        SELECT 'Error: Terjadi kesalahan saat mengubah akun admin.' AS error_message;
    END;

    UPDATE akun_admin 
    SET nama_admin = p_nama_admin,  password = p_password
    WHERE id_admin = p_id_admin;

	CALL ubah_password_hak_admin(p_email, p_password);
    
    SELECT 'Akun admin berhasil diubah.' AS message;
END //
DELIMITER ;

-- Membuat Stored Procedure untuk Meng-Update Akun User
DELIMITER //
CREATE PROCEDURE update_akun_user (
    IN p_id_user INT,
    IN p_nama_user VARCHAR(255),
    IN p_email VARCHAR(255),
    IN p_password VARCHAR(255)
)
BEGIN
    DECLARE EXIT HANDLER FOR 1062 -- Duplicate key error
    BEGIN
        SELECT 'Error: Email user sudah terdaftar.' AS error_message;
    END;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Error: Terjadi kesalahan saat mengubah akun user.' AS error_message;
    END;

    UPDATE akun_user 
    SET nama_user = p_nama_user, password = p_password
    WHERE id_user = p_id_user;
    
    CALL ubah_password_hak_user(p_email, p_password);

    SELECT 'Akun user berhasil diubah.' AS message;
END //
DELIMITER ;

-- Membuat Stored Procedure untuk Meng-Update Data Anak 
DELIMITER //
CREATE PROCEDURE update_data_anak (
    IN p_id_anak INT,
    IN p_id_user INT,
    IN p_nama_anak VARCHAR(255),
    IN p_tanggal_lahir DATE,
    IN p_jenis_kelamin ENUM('laki-laki', 'perempuan'),
    IN p_berat_badan DECIMAL(5,2),
    IN p_tinggi_badan DECIMAL(5,2)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Error: Terjadi kesalahan saat mengubah data anak.' AS error_message;
    END;

    UPDATE data_anak 
    SET id_user = p_id_user, nama_anak = p_nama_anak, tanggal_lahir = p_tanggal_lahir, 
        umur = TIMESTAMPDIFF(YEAR, p_tanggal_lahir, CURDATE()), jenis_kelamin = p_jenis_kelamin, 
        berat_badan_kg = p_berat_badan, tinggi_badan_cm = p_tinggi_badan
    WHERE id_anak = p_id_anak;

    SELECT 'Data anak berhasil diubah.' AS message;
END //
DELIMITER ;

-- Membuat Stored Procedure untuk Meng-Update Jadwal Makan
DELIMITER //
CREATE PROCEDURE update_jadwal_makan (
    IN p_id_jadwal INT,
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
        SELECT 'Error: Terjadi kesalahan saat mengubah jadwal makan.' AS error_message;
    END;

    UPDATE jadwal_makan 
    SET id_anak = p_id_anak, waktu_sarapan = p_waktu_sarapan, menu_sarapan = p_menu_sarapan, 
        waktu_makan_siang = p_waktu_makan_siang, menu_makan_siang = p_menu_makan_siang, 
        waktu_makan_malam = p_waktu_makan_malam, menu_makan_malam = p_menu_makan_malam
    WHERE id_jadwal = p_id_jadwal;

    SELECT 'Jadwal makan berhasil diubah.' AS message;
END //
DELIMITER ;

-- Membuat Stored Procedure untuk Meng-Update Jadwal Tidur 
DELIMITER //
CREATE PROCEDURE update_jadwal_tidur (
    IN p_id_jadwal INT,
    IN p_id_anak INT,
    IN p_waktu_tidur TIME,
    IN p_waktu_bangun TIME
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Error: Terjadi kesalahan saat mengubah jadwal tidur.' AS error_message;
    END;

    UPDATE jadwal_tidur 
    SET id_anak = p_id_anak, waktu_tidur = p_waktu_tidur, waktu_bangun = p_waktu_bangun
    WHERE id_jadwal = p_id_jadwal;

    SELECT 'Jadwal tidur berhasil diubah.' AS message;
END //
DELIMITER ;

-- Membuat Stored Procedure untuk Meng-Update Kegiatan Anak
DELIMITER //
CREATE PROCEDURE update_kegiatan_anak (
    IN p_id_kegiatan INT,
    IN p_id_anak INT,
    IN p_nama_kegiatan VARCHAR(255),
    IN p_waktu_mulai TIME,
    IN p_waktu_selesai TIME
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Error: Terjadi kesalahan saat mengubah kegiatan anak.' AS error_message;
    END;

    UPDATE kegiatan_anak 
    SET id_anak = p_id_anak, nama_kegiatan = p_nama_kegiatan, 
        waktu_mulai = p_waktu_mulai, waktu_selesai = p_waktu_selesai
    WHERE id_kegiatan = p_id_kegiatan;

    SELECT 'Kegiatan anak berhasil diubah.' AS message;
END //
DELIMITER ;

-- Membuat Stored Procedure untuk Meng-Update Riwayat Kesehatan
DELIMITER //
CREATE PROCEDURE update_riwayat_kesehatan (
    IN p_id_kesehatan INT,
    IN p_id_anak INT,
    IN p_nama_penyakit VARCHAR(255),
    IN p_nama_obat TEXT,
    IN p_tanggal_mulai_sakit DATETIME,
    IN p_tanggal_selesai_sakit DATETIME
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Error: Terjadi kesalahan saat mengubah riwayat kesehatan.' AS error_message;
    END;

    UPDATE riwayat_kesehatan 
    SET id_anak = p_id_anak, nama_penyakit = p_nama_penyakit, nama_obat = p_nama_obat,
        tanggal_mulai_sakit = p_tanggal_mulai_sakit, tanggal_selesai_sakit = p_tanggal_selesai_sakit
    WHERE id_kesehatan = p_id_kesehatan;

    SELECT 'Riwayat kesehatan berhasil diubah.' AS message;
END //
DELIMITER ;


-- Stored Procedure SELECT ---
-- Membuat Stored Procedure untuk Meng-Update Data Anak 
DELIMITER //
CREATE PROCEDURE lihat_data_anak (
    IN p_id_user INT
)
BEGIN
    SELECT * FROM data_anak WHERE id_user = p_id_user;
END //
DELIMITER ;
