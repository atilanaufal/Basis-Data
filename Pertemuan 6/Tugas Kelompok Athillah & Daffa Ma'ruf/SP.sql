DELIMITER //
CREATE PROCEDURE updateStatusPembayaran(IN p_no_pendaftaran VARCHAR(50), IN p_status ENUM('Belum Lunas', 'Sudah Lunas'))
BEGIN
    UPDATE daftar
    SET status_pembayaran = p_status
    WHERE no_pendaftaran = p_no_pendaftaran;
END //

DELIMITER ;


CALL updateStatusPembayaran('REG2024MHS01', 'Sudah Lunas');
