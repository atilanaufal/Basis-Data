-- Membuat Stored Procedure untuk Menambah Data Anak
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
    INSERT INTO data_anak (
        id_user, nama_anak, tanggal_lahir, umur, jenis_kelamin, hobi, berat_badan_kg, tinggi_badan_cm
    ) VALUES (
        p_id_user, p_nama_anak, p_tanggal_lahir, 
        TIMESTAMPDIFF(YEAR, p_tanggal_lahir, CURDATE()), 
        p_jenis_kelamin, p_hobi, p_berat_badan, p_tinggi_badan
    );
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
