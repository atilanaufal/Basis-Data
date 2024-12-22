CREATE INDEX idx_ripe_user ON akun_user (tipe_user);

CREATE INDEX idx_umur ON data_anak (umur);

CREATE INDEX idx_menu_sarapan ON jadwal_makan (menu_sarapan(100));

CREATE INDEX idx_waktu_bangun ON jadwal_tidur (waktu_bangun);

CREATE INDEX idx_nama_kegiatan ON kegiatan_anak (nama_kegiatan);

CREATE INDEX idx_nama_penyakit ON riwayat_kesehatan (nama_penyakit);
