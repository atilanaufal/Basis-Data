-- Perintah Untuk Mengelola Hak Akses

-- Memberikan Hak Akses Untuk User
CREATE USER 'user1'@'localhost' IDENTIFIED BY 'pw1';
GRANT SELECT, INSERT ON ParentWatch.* TO 'user1'@'localhost';

-- Menampilkan Hak Akses User
SHOW GRANTS FOR 'user1'@'localhost';

-- Mengganti Password User Untuk Versi Lama
SET PASSWORD FOR 'user1'@'localhost' = PASSWORD('newpassword');

-- Mengganti Password User Untuk Versi Terbaru
ALTER USER 'user1'@'host' IDENTIFIED BY 'new_password';

-- Mencabut Hak Akses
REVOKE SELECT, INSERT ON ParentWatch.* FROM 'user1'@'localhost';

-- Menghapus User
DROP USER 'user1'@'localhost';





-- Perintah Mengelola Akses Secara Spesifik

-- Hak Akses Tingkat Global
GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost';

-- Hak Akses Tingkat Database
GRANT SELECT, UPDATE ON ParentWatch.* TO 'user1'@'localhost';

-- Hak Akses Tingkat Tabel
GRANT SELECT, UPDATE ON ParentWatch.data_anak TO 'user1'@'localhost';

-- Hak Akses Tingkat Kolom
GRANT SELECT (nama_anak, umur) ON ParentWatch.data_anak TO 'user1'@'localhost';
