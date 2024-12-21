-- Membuat database ParentWatch
START TRANSACTION;
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

-- Tabel Audit Logs
CREATE TABLE IF NOT EXISTS audit_logs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    table_name VARCHAR(255),
    record_id INT,
    operation_type ENUM('INSERT', 'UPDATE', 'DELETE'),
    changed_by INT,
    role ENUM('admin', 'user'),
    changed_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    old_data JSON,
    new_data JSON
);




CREATE OR REPLACE VIEW data_anak_lengkap AS
SELECT
    au.id_user,
    da.id_anak,
    da.nama_anak,
    da.tanggal_lahir,
    da.umur,
    da.jenis_kelamin,
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

-- Cursor untuk menampilkan data anak dan user yang terkait
DELIMITER //
CREATE PROCEDURE data_anak_cursor()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_id_anak INT;
    DECLARE v_nama_anak VARCHAR(255);
    DECLARE v_nama_user VARCHAR(255);
    
    DECLARE anak_cursor CURSOR FOR
        SELECT da.id_anak, da.nama_anak, au.nama_user
        FROM data_anak da
        JOIN akun_user au ON da.id_user = au.id_user;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN anak_cursor;

    read_loop: LOOP
        FETCH anak_cursor INTO v_id_anak, v_nama_anak, v_nama_user;
        IF done THEN
            LEAVE read_loop;
        END IF;
        SELECT v_id_anak, v_nama_anak, v_nama_user;
    END LOOP;

    CLOSE anak_cursor;
END //


-- Cursor untuk menampilkan data user 
CREATE PROCEDURE tampilkan_semua_user()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_id_user INT;
    DECLARE v_nama_user VARCHAR(255);
    DECLARE v_email VARCHAR(255);
    DECLARE v_tipe_user ENUM('orang_tua', 'pengasuh');

    DECLARE user_cursor CURSOR FOR
        SELECT id_user, nama_user, email, tipe_user FROM akun_user;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN user_cursor;

    read_loop: LOOP
        FETCH user_cursor INTO v_id_user, v_nama_user, v_email, v_tipe_user;
        IF done THEN
            LEAVE read_loop;
        END IF;
        SELECT v_id_user, v_nama_user, v_email, v_tipe_user;
    END LOOP;

    CLOSE user_cursor;
END //
DELIMITER ;


-- Cursor untuk menampilkan kegiatan_anak yang terkait
DELIMITER //
CREATE PROCEDURE kegiatan_anak_cursor()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_id_kegiatan INT;
    DECLARE v_nama_kegiatan VARCHAR(255);
    DECLARE v_waktu_mulai TIME;
    DECLARE v_waktu_selesai TIME;
    
    DECLARE anak_cursor CURSOR FOR
        SELECT id_kegiatan, nama_kegiatan, waktu_mulai, waktu_selesai
        FROM kegiatan_anak;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN anak_cursor;

    read_loop: LOOP
        FETCH anak_cursor INTO v_id_kegiatan, v_nama_kegiatan, v_waktu_mulai, v_waktu_selesai;
        IF done THEN
            LEAVE read_loop;
        END IF;
        SELECT v_id_kegiatan, v_nama_kegiatan, v_waktu_mulai, v_waktu_selesai;
    END LOOP;

    CLOSE anak_cursor;
END //

-- Trigger BEFORE INSERT pada tabel data_anak
DELIMITER //
CREATE TRIGGER before_data_anak_insert
BEFORE INSERT ON data_anak
FOR EACH ROW
BEGIN
    -- Validasi umur anak harus lebih dari 0 tahun
    IF NEW.umur <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Umur anak tidak valid.';
    END IF;
END //
DELIMITER ;

-- Trigger AFTER INSERT pada tabel data_anak
DELIMITER //
CREATE TRIGGER after_data_anak_insert
AFTER INSERT ON data_anak
FOR EACH ROW
BEGIN
    -- Insert log audit setelah data anak ditambahkan
    INSERT INTO audit_logs (table_name, record_id, operation_type, changed_by, role, new_data)
    VALUES ('data_anak', NEW.id_anak, 'INSERT', NEW.id_user, 'user', JSON_OBJECT('id_anak', NEW.id_anak, 'nama_anak', NEW.nama_anak, 'tanggal_lahir', NEW.tanggal_lahir, 'umur', NEW.umur, 'jenis_kelamin', NEW.jenis_kelamin, 'berat_badan_kg', NEW.berat_badan_kg, 'tinggi_badan_cm', NEW.tinggi_badan_cm));
END //
DELIMITER ;

-- Trigger AFTER UPDATE pada tabel data_anak
DELIMITER //
CREATE TRIGGER after_data_anak_update
AFTER UPDATE ON data_anak
FOR EACH ROW
BEGIN
    -- Insert log audit setelah data anak diubah
    INSERT INTO audit_logs (table_name, record_id, operation_type, changed_by, role, old_data, new_data)
    VALUES ('data_anak', NEW.id_anak, 'UPDATE', NEW.id_user, 'user',
            JSON_OBJECT('id_anak', OLD.id_anak, 'nama_anak', OLD.nama_anak, 'tanggal_lahir', OLD.tanggal_lahir, 'umur', OLD.umur, 'jenis_kelamin', OLD.jenis_kelamin, 'berat_badan_kg', OLD.berat_badan_kg, 'tinggi_badan_cm', OLD.tinggi_badan_cm),
            JSON_OBJECT('id_anak', NEW.id_anak, 'nama_anak', NEW.nama_anak, 'tanggal_lahir', NEW.tanggal_lahir, 'umur', NEW.umur, 'jenis_kelamin', NEW.jenis_kelamin, 'berat_badan_kg', NEW.berat_badan_kg, 'tinggi_badan_cm', NEW.tinggi_badan_cm));
END //
DELIMITER ;

-- Trigger AFTER DELETE pada tabel data_anak
DELIMITER //
CREATE TRIGGER after_data_anak_delete
AFTER DELETE ON data_anak
FOR EACH ROW
BEGIN
    -- Insert log audit setelah data anak dihapus
    INSERT INTO audit_logs (table_name, record_id, operation_type, changed_by, role, old_data)
    VALUES ('data_anak', OLD.id_anak, 'DELETE', OLD.id_user, 'user', JSON_OBJECT('id_anak', OLD.id_anak, 'nama_anak', OLD.nama_anak, 'tanggal_lahir', OLD.tanggal_lahir, 'umur', OLD.umur, 'jenis_kelamin', OLD.jenis_kelamin,  'berat_badan_kg', OLD.berat_badan_kg, 'tinggi_badan_cm', OLD.tinggi_badan_cm));
END //
DELIMITER ;

-- Trigger AFTER INSERT pada tabel jadwal_makan
DELIMITER //
CREATE TRIGGER after_jadwal_makan_insert
AFTER INSERT ON jadwal_makan
FOR EACH ROW
BEGIN
    -- Insert log audit setelah data jadwal makan ditambahkan
    INSERT INTO audit_logs (table_name, record_id, operation_type, changed_by, new_data)
	VALUES ('jadwal_makan', NEW.id_jadwal, 'INSERT', (SELECT id_user FROM data_anak WHERE id_anak = NEW.id_anak), JSON_OBJECT('id_jadwal', NEW.id_jadwal, 'id_anak', NEW.id_anak, 'waktu_sarapan', NEW.waktu_sarapan, 'menu_sarapan', NEW.menu_sarapan));

END //
DELIMITER ;

-- Trigger BEFORE UPDATE pada tabel riwayat_kesehatan
DELIMITER //
CREATE TRIGGER before_riwayat_kesehatan_update
BEFORE UPDATE ON riwayat_kesehatan
FOR EACH ROW
BEGIN
    -- Validasi tanggal selesai sakit harus lebih dari tanggal mulai sakit
    IF NEW.tanggal_selesai_sakit <= NEW.tanggal_mulai_sakit THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tanggal selesai sakit tidak valid.';
    END IF;
END //
DELIMITER ;

-- Trigger AFTER DELETE pada tabel kegiatan_anak
DELIMITER //
CREATE TRIGGER after_kegiatan_anak_delete
AFTER DELETE ON kegiatan_anak
FOR EACH ROW
BEGIN
    -- Insert log audit setelah data kegiatan anak dihapus
   INSERT INTO audit_logs (table_name, record_id, operation_type, changed_by, old_data)
   VALUES ('kegiatan_anak', OLD.id_kegiatan, 'DELETE', (SELECT id_user FROM data_anak WHERE id_anak = OLD.id_anak), JSON_OBJECT('id_kegiatan', OLD.id_kegiatan, 'id_anak', OLD.id_anak, 'nama_kegiatan', OLD.nama_kegiatan));
    
END //
DELIMITER ;


-- AKUN ADMIN TRIGGER --
-- Trigger AFTER INSERT pada tabel akun_admin
DELIMITER //
CREATE TRIGGER after_akun_admin_insert
AFTER INSERT ON akun_admin
FOR EACH ROW
BEGIN
    -- Insert log audit setelah data admin ditambahkan
    INSERT INTO audit_logs (table_name, record_id, operation_type, changed_by, role, new_data)
    VALUES ('akun_admin', NEW.id_admin, 'INSERT', NEW.id_admin, 'admin', JSON_OBJECT('id_admin', NEW.id_admin, 'nama_admin', NEW.nama_admin, 'email', NEW.email));
END //
DELIMITER ;

-- Trigger AFTER UPDATE pada tabel akun_admin
DELIMITER //
CREATE TRIGGER after_akun_admin_update
AFTER UPDATE ON akun_admin
FOR EACH ROW
BEGIN
    -- Insert log audit setelah data admin diubah
    INSERT INTO audit_logs (table_name, record_id, operation_type, changed_by, role, old_data, new_data)
    VALUES ('akun_admin', NEW.id_admin, 'UPDATE', NEW.id_admin, 'admin',
            JSON_OBJECT('id_admin', OLD.id_admin, 'nama_admin', OLD.nama_admin, 'email', OLD.email),
            JSON_OBJECT('id_admin', NEW.id_admin, 'nama_admin', NEW.nama_admin, 'email', NEW.email));
END //
DELIMITER ;

-- Trigger AFTER DELETE pada tabel akun_admin
DELIMITER //
CREATE TRIGGER after_akun_admin_delete
AFTER DELETE ON akun_admin
FOR EACH ROW
BEGIN
    -- Insert log audit setelah data admin dihapus
    INSERT INTO audit_logs (table_name, record_id, operation_type, changed_by, role, old_data)
    VALUES ('akun_admin', OLD.id_admin, 'DELETE', OLD.id_admin, 'admin', JSON_OBJECT('id_admin', OLD.id_admin, 'nama_admin', OLD.nama_admin, 'email', OLD.email));
END //
DELIMITER ;


-- AKUN USER TRIGGER --
-- Trigger AFTER INSERT pada tabel akun_user
DELIMITER //
CREATE TRIGGER after_akun_user_insert
AFTER INSERT ON akun_user
FOR EACH ROW
BEGIN
    -- Insert log audit setelah data user ditambahkan
    INSERT INTO audit_logs (table_name, record_id, operation_type, changed_by, role, new_data)
    VALUES ('akun_user', NEW.id_user, 'INSERT', NEW.id_user, 'user', JSON_OBJECT('id_user', NEW.id_user, 'nama_user', NEW.nama_user, 'email', NEW.email, 'tipe_user', NEW.tipe_user));
END //
DELIMITER ;

-- Trigger AFTER UPDATE pada tabel akun_user
DELIMITER //
CREATE TRIGGER after_akun_user_update
AFTER UPDATE ON akun_user
FOR EACH ROW
BEGIN
    -- Insert log audit setelah data user diubah
    INSERT INTO audit_logs (table_name, record_id, operation_type, changed_by, role, old_data, new_data)
    VALUES ('akun_user', NEW.id_user, 'UPDATE', NEW.id_user, 'user',
            JSON_OBJECT('id_user', OLD.id_user, 'nama_user', OLD.nama_user, 'email', OLD.email, 'tipe_user', OLD.tipe_user),
            JSON_OBJECT('id_user', NEW.id_user, 'nama_user', NEW.nama_user, 'email', NEW.email, 'tipe_user', NEW.tipe_user));
END //
DELIMITER ;

-- Trigger AFTER DELETE pada tabel akun_user
DELIMITER //
CREATE TRIGGER after_akun_user_delete
AFTER DELETE ON akun_user
FOR EACH ROW
BEGIN
    -- Insert log audit setelah data user dihapus
    INSERT INTO audit_logs (table_name, record_id, operation_type, changed_by, role, old_data)
    VALUES ('akun_user', OLD.id_user, 'DELETE', OLD.id_user, 'user', JSON_OBJECT('id_user', OLD.id_user, 'nama_user', OLD.nama_user, 'email', OLD.email, 'tipe_user', OLD.tipe_user));
END //
DELIMITER ;


-- Stored Procedure Grant Access
DELIMITER //
-- Stored Procedure untuk membuat user admin
CREATE PROCEDURE hak_admin(
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
        SELECT 'Error: Terjadi kesalahan saat membuat user admin.' AS error_message;
    END;

    -- Membuat user di MySQL dengan pernyataan dinamis
    SET @sql_create_user = CONCAT('CREATE USER IF NOT EXISTS ', QUOTE(p_email), '@\'localhost\' IDENTIFIED BY ', QUOTE(p_password), ';');
    PREPARE stmt_create_user FROM @sql_create_user;
    EXECUTE stmt_create_user;
    DEALLOCATE PREPARE stmt_create_user;

    -- Memberikan hak akses penuh ke database ParentWatch
    SET @sql_grant_privileges = CONCAT('GRANT ALL PRIVILEGES ON ParentWatch.* TO ', QUOTE(p_email), '@\'localhost\';');
    PREPARE stmt_grant_privileges FROM @sql_grant_privileges;
    EXECUTE stmt_grant_privileges;
    DEALLOCATE PREPARE stmt_grant_privileges;

    FLUSH PRIVILEGES;
END //

-- Stored Procedure untuk membuat user orang tua atau pengasuh
CREATE PROCEDURE hak_user(
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
        SELECT 'Error: Terjadi kesalahan saat membuat user.' AS error_message;
    END;

    -- Membuat user di MySQL dengan pernyataan dinamis
    SET @sql_create_user = CONCAT('CREATE USER IF NOT EXISTS ', QUOTE(p_email), '@\'localhost\' IDENTIFIED BY ', QUOTE(p_password), ';');
    PREPARE stmt_create_user FROM @sql_create_user;
    EXECUTE stmt_create_user;
    DEALLOCATE PREPARE stmt_create_user;

    -- Memberikan hak akses sesuai tipe user
    IF p_tipe_user = 'orang_tua' THEN
        SET @sql_grant_privileges = CONCAT('GRANT SELECT, INSERT, UPDATE, DELETE ON ParentWatch.data_anak TO ', QUOTE(p_email), '@\'localhost\';');
        PREPARE stmt_grant_privileges FROM @sql_grant_privileges;
        EXECUTE stmt_grant_privileges;
        DEALLOCATE PREPARE stmt_grant_privileges;

        SET @sql_grant_privileges = CONCAT('GRANT SELECT, INSERT, UPDATE, DELETE ON ParentWatch.jadwal_makan TO ', QUOTE(p_email), '@\'localhost\';');
        PREPARE stmt_grant_privileges FROM @sql_grant_privileges;
        EXECUTE stmt_grant_privileges;
        DEALLOCATE PREPARE stmt_grant_privileges;

        SET @sql_grant_privileges = CONCAT('GRANT SELECT, INSERT, UPDATE, DELETE ON ParentWatch.jadwal_tidur TO ', QUOTE(p_email), '@\'localhost\';');
        PREPARE stmt_grant_privileges FROM @sql_grant_privileges;
        EXECUTE stmt_grant_privileges;
        DEALLOCATE PREPARE stmt_grant_privileges;

        SET @sql_grant_privileges = CONCAT('GRANT SELECT, INSERT, UPDATE, DELETE ON ParentWatch.kegiatan_anak TO ', QUOTE(p_email), '@\'localhost\';');
        PREPARE stmt_grant_privileges FROM @sql_grant_privileges;
        EXECUTE stmt_grant_privileges;
        DEALLOCATE PREPARE stmt_grant_privileges;

        SET @sql_grant_privileges = CONCAT('GRANT SELECT, INSERT, UPDATE, DELETE ON ParentWatch.riwayat_kesehatan TO ', QUOTE(p_email), '@\'localhost\';');
        PREPARE stmt_grant_privileges FROM @sql_grant_privileges;
        EXECUTE stmt_grant_privileges;
        DEALLOCATE PREPARE stmt_grant_privileges;

        SET @sql_grant_privileges = CONCAT('GRANT SELECT, INSERT, UPDATE, DELETE ON ParentWatch.data_anak_lengkap TO ', QUOTE(p_email), '@\'localhost\';');
        PREPARE stmt_grant_privileges FROM @sql_grant_privileges;
        EXECUTE stmt_grant_privileges;
        DEALLOCATE PREPARE stmt_grant_privileges;
       
        SET @sql_grant_privileges = CONCAT('GRANT SELECT, INSERT, UPDATE, DELETE ON ParentWatch.riwayat_kesehatan_lengkap TO ', QUOTE(p_email), '@\'localhost\';');
        PREPARE stmt_grant_privileges FROM @sql_grant_privileges;
        EXECUTE stmt_grant_privileges;
        DEALLOCATE PREPARE stmt_grant_privileges;
        
       SET @sql_grant_privileges = CONCAT('GRANT SELECT, INSERT, UPDATE, DELETE ON ParentWatch.jadwal_harian_anak TO ', QUOTE(p_email), '@\'localhost\';');
        PREPARE stmt_grant_privileges FROM @sql_grant_privileges;
        EXECUTE stmt_grant_privileges;
        DEALLOCATE PREPARE stmt_grant_privileges;
    ELSEIF p_tipe_user = 'pengasuh' THEN
        SET @sql_grant_privileges = CONCAT('GRANT SELECT ON ParentWatch.data_anak TO ', QUOTE(p_email), '@\'localhost\';');
        PREPARE stmt_grant_privileges FROM @sql_grant_privileges;
        EXECUTE stmt_grant_privileges;
        DEALLOCATE PREPARE stmt_grant_privileges;

        SET @sql_grant_privileges = CONCAT('GRANT SELECT, UPDATE ON ParentWatch.jadwal_makan TO ', QUOTE(p_email), '@\'localhost\';');
        PREPARE stmt_grant_privileges FROM @sql_grant_privileges;
        EXECUTE stmt_grant_privileges;
        DEALLOCATE PREPARE stmt_grant_privileges;

        SET @sql_grant_privileges = CONCAT('GRANT SELECT, UPDATE ON ParentWatch.jadwal_tidur TO ', QUOTE(p_email), '@\'localhost\';');
        PREPARE stmt_grant_privileges FROM @sql_grant_privileges;
        EXECUTE stmt_grant_privileges;
        DEALLOCATE PREPARE stmt_grant_privileges;

        SET @sql_grant_privileges = CONCAT('GRANT SELECT, UPDATE ON ParentWatch.kegiatan_anak TO ', QUOTE(p_email), '@\'localhost\';');
        PREPARE stmt_grant_privileges FROM @sql_grant_privileges;
        EXECUTE stmt_grant_privileges;
        DEALLOCATE PREPARE stmt_grant_privileges;

        SET @sql_grant_privileges = CONCAT('GRANT SELECT, UPDATE ON ParentWatch.riwayat_kesehatan TO ', QUOTE(p_email), '@\'localhost\';');
        PREPARE stmt_grant_privileges FROM @sql_grant_privileges;
        EXECUTE stmt_grant_privileges;
        DEALLOCATE PREPARE stmt_grant_privileges;
    END IF;

    FLUSH PRIVILEGES;
END //

-- Stored Procedure untuk menghapus user admin
CREATE PROCEDURE hapus_hak_admin(
    IN p_email VARCHAR(255)  -- Parameter email admin yang akan dihapus
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Error: Terjadi kesalahan saat menghapus user admin.' AS error_message;
    END;

    -- Menghapus user di MySQL
    SET @sql_drop_user = CONCAT('DROP USER IF EXISTS ', QUOTE(p_email), '@\'localhost\';');
    PREPARE stmt_drop_user FROM @sql_drop_user;
    EXECUTE stmt_drop_user;
    DEALLOCATE PREPARE stmt_drop_user;

    SELECT 'User admin berhasil dihapus.' AS message;
END //

-- Stored Procedure untuk menghapus user orang tua atau pengasuh
CREATE PROCEDURE hapus_hak_user(
    IN p_email VARCHAR(255)  -- Parameter email user yang akan dihapus
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Error: Terjadi kesalahan saat menghapus user.' AS error_message;
    END;

    -- Menghapus user di MySQL
    SET @sql_drop_user = CONCAT('DROP USER IF EXISTS ', QUOTE(p_email), '@\'localhost\';');
    PREPARE stmt_drop_user FROM @sql_drop_user;
    EXECUTE stmt_drop_user;
    DEALLOCATE PREPARE stmt_drop_user;

    SELECT 'User berhasil dihapus.' AS message;
END //

-- Stored Procedure untuk mengubah password user admin
CREATE PROCEDURE ubah_password_hak_admin(
    IN p_email VARCHAR(255),  -- Parameter email admin
    IN p_password VARCHAR(255)  -- Parameter password baru
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Error: Terjadi kesalahan saat mengubah password admin.' AS error_message;
    END;

    -- Mengubah password user di MySQL
    SET @sql_set_password = CONCAT('ALTER USER ', QUOTE(p_email), '@\'localhost\' IDENTIFIED BY ', QUOTE(p_password), ';');
    PREPARE stmt_set_password FROM @sql_set_password;
    EXECUTE stmt_set_password;
    DEALLOCATE PREPARE stmt_set_password;

    SELECT 'Password admin berhasil diubah.' AS message;
END //


-- Stored Procedure untuk mengubah password user orang tua atau pengasuh
CREATE PROCEDURE ubah_password_hak_user(
    IN p_email VARCHAR(255),  -- Parameter email user
    IN p_password VARCHAR(255)  -- Parameter password baru
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Error: Terjadi kesalahan saat mengubah password user.' AS error_message;
    END;

    -- Mengubah password user di MySQL
    SET @sql_set_password = CONCAT('ALTER USER ', QUOTE(p_email), '@\'localhost\' IDENTIFIED BY ', QUOTE(p_password), ';');
    PREPARE stmt_set_password FROM @sql_set_password;
    EXECUTE stmt_set_password;
    DEALLOCATE PREPARE stmt_set_password;

    SELECT 'Password user berhasil diubah.' AS message;
END //

DELIMITER ;



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

DELIMITER ;
COMMIT;
