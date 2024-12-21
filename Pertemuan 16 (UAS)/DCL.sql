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
