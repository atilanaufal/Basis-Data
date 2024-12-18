-- Membuat User dan Hak Akses
CREATE USER IF NOT EXISTS 'admin_user'@'localhost' IDENTIFIED BY 'admin_password';
CREATE USER IF NOT EXISTS 'parent_user'@'localhost' IDENTIFIED BY 'parent_password';
CREATE USER IF NOT EXISTS 'pengasuh_user'@'localhost' IDENTIFIED BY 'pengasuh_password';

GRANT ALL PRIVILEGES ON ParentWatch.* TO 'admin_user'@'localhost';

GRANT SELECT, INSERT, UPDATE, DELETE ON ParentWatch.data_anak TO 'parent_user'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON ParentWatch.jadwal_makan TO 'parent_user'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON ParentWatch.jadwal_tidur TO 'parent_user'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON ParentWatch.kegiatan_anak TO 'parent_user'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON ParentWatch.riwayat_kesehatan TO 'parent_user'@'localhost';

GRANT SELECT ON ParentWatch.data_anak TO 'pengasuh_user'@'localhost';
GRANT SELECT, UPDATE ON ParentWatch.jadwal_makan TO 'pengasuh_user'@'localhost';
GRANT SELECT, UPDATE ON ParentWatch.jadwal_tidur TO 'pengasuh_user'@'localhost';
GRANT SELECT, UPDATE ON ParentWatch.kegiatan_anak TO 'pengasuh_user'@'localhost';
GRANT SELECT, UPDATE ON ParentWatch.riwayat_kesehatan TO 'pengasuh_user'@'localhost';

FLUSH PRIVILEGES;
