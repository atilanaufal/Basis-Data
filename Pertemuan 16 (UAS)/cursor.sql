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
DELIMITER ;

DELIMITER //

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

DELIMITER ;
