-- Indeks untuk kolom id_user pada tabel data_anak
CREATE INDEX idx_id_user ON data_anak (id_user);

-- Indeks untuk kolom nama_anak pada tabel data_anak
CREATE INDEX idx_nama_anak ON data_anak (nama_anak);

-- Indeks untuk kolom id_anak pada tabel jadwal_makan
CREATE INDEX idx_id_anak_makan ON jadwal_makan (id_anak);

-- Indeks untuk kolom id_anak pada tabel jadwal_tidur
CREATE INDEX idx_id_anak_tidur ON jadwal_tidur (id_anak);

-- Indeks untuk kolom id_anak pada tabel kegiatan_anak
CREATE INDEX idx_id_anak_kegiatan ON kegiatan_anak (id_anak);

-- Indeks untuk kolom nama_penyakit pada tabel riwayat_kesehatan
CREATE INDEX idx_nama_penyakit ON riwayat_kesehatan (nama_penyakit);
