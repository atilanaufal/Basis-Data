
INSERT INTO daftar(id_mhs, nama, tanggal_lahir, prodi, no_pendaftaran, status_pembayaran)
VALUES (1, 'Athillah Naufal Al-Falah', '2005-08-12', 'Informatika', 'REG2024MHS01', 'Belum Lunas');

INSERT INTO pembayaran(id_bayar, jumlah, tanggal_bayar, cek)
VALUES (1, 10000000.00, '2024-10-10', 'selesai');


UPDATE daftar
SET status_pembayaran = 'Sudah Lunas'
WHERE no_pendaftaran = 'REG2024MHS01';


INSERT INTO data_hasil_tes (id_tes, nilai, nilai_bobot,hasil)
VALUES (1, 93.2, 'A', 'Kamu Lulus');

INSERT INTO mhs(nim, nama, tanggal_lahir, prodi, tahun_masuk)
VALUES (2024071001, 'Athillah Naufal Al-Falah', '2005-08-12', 'Informatika', 2024);

