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
    VALUES ('data_anak', NEW.id_anak, 'INSERT', NEW.id_user, 'user', JSON_OBJECT('id_anak', NEW.id_anak, 'nama_anak', NEW.nama_anak, 'tanggal_lahir', NEW.tanggal_lahir, 'umur', NEW.umur, 'jenis_kelamin', NEW.jenis_kelamin,  'berat_badan_kg', NEW.berat_badan_kg, 'tinggi_badan_cm', NEW.tinggi_badan_cm));
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
            JSON_OBJECT('id_anak', OLD.id_anak, 'nama_anak', OLD.nama_anak, 'tanggal_lahir', OLD.tanggal_lahir, 'umur', OLD.umur, 'jenis_kelamin', OLD.jenis_kelamin,  'berat_badan_kg', OLD.berat_badan_kg, 'tinggi_badan_cm', OLD.tinggi_badan_cm),
            JSON_OBJECT('id_anak', NEW.id_anak, 'nama_anak', NEW.nama_anak, 'tanggal_lahir', NEW.tanggal_lahir, 'umur', NEW.umur, 'jenis_kelamin', NEW.jenis_kelamin,  'berat_badan_kg', NEW.berat_badan_kg, 'tinggi_badan_cm', NEW.tinggi_badan_cm));
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
