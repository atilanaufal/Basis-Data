-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: parentwatch
-- ------------------------------------------------------
-- Server version	8.0.39

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Temporary view structure for view `jadwal_harian_anak`
--

DROP TABLE IF EXISTS `jadwal_harian_anak`;
/*!50001 DROP VIEW IF EXISTS `jadwal_harian_anak`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `jadwal_harian_anak` AS SELECT 
 1 AS `id_anak`,
 1 AS `nama_anak`,
 1 AS `waktu_sarapan`,
 1 AS `menu_sarapan`,
 1 AS `waktu_makan_siang`,
 1 AS `menu_makan_siang`,
 1 AS `waktu_makan_malam`,
 1 AS `menu_makan_malam`,
 1 AS `waktu_tidur`,
 1 AS `waktu_bangun`,
 1 AS `nama_kegiatan`,
 1 AS `waktu_mulai`,
 1 AS `waktu_selesai`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `aktivitas_user`
--

DROP TABLE IF EXISTS `aktivitas_user`;
/*!50001 DROP VIEW IF EXISTS `aktivitas_user`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `aktivitas_user` AS SELECT 
 1 AS `changed_at`,
 1 AS `table_name`,
 1 AS `operation_type`,
 1 AS `user_terlibat`,
 1 AS `old_data`,
 1 AS `new_data`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `data_anak_lengkap`
--

DROP TABLE IF EXISTS `data_anak_lengkap`;
/*!50001 DROP VIEW IF EXISTS `data_anak_lengkap`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `data_anak_lengkap` AS SELECT 
 1 AS `id_user`,
 1 AS `id_anak`,
 1 AS `nama_anak`,
 1 AS `tanggal_lahir`,
 1 AS `umur`,
 1 AS `jenis_kelamin`,
 1 AS `berat_badan_kg`,
 1 AS `tinggi_badan_cm`,
 1 AS `nama_user`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `riwayat_kesehatan_lengkap`
--

DROP TABLE IF EXISTS `riwayat_kesehatan_lengkap`;
/*!50001 DROP VIEW IF EXISTS `riwayat_kesehatan_lengkap`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `riwayat_kesehatan_lengkap` AS SELECT 
 1 AS `id_kesehatan`,
 1 AS `nama_penyakit`,
 1 AS `nama_obat`,
 1 AS `tanggal_mulai_sakit`,
 1 AS `tanggal_selesai_sakit`,
 1 AS `nama_anak`,
 1 AS `umur`,
 1 AS `nama_orang_tua`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `user_list`
--

DROP TABLE IF EXISTS `user_list`;
/*!50001 DROP VIEW IF EXISTS `user_list`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `user_list` AS SELECT 
 1 AS `id_admin`,
 1 AS `nama_admin`,
 1 AS `email`,
 1 AS `role`,
 1 AS `hak_akses`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `aktivitas_admin`
--

DROP TABLE IF EXISTS `aktivitas_admin`;
/*!50001 DROP VIEW IF EXISTS `aktivitas_admin`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `aktivitas_admin` AS SELECT 
 1 AS `changed_at`,
 1 AS `table_name`,
 1 AS `operation_type`,
 1 AS `admin_terlibat`,
 1 AS `old_data`,
 1 AS `new_data`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `jadwal_harian_anak`
--

/*!50001 DROP VIEW IF EXISTS `jadwal_harian_anak`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `jadwal_harian_anak` AS select `da`.`id_anak` AS `id_anak`,`da`.`nama_anak` AS `nama_anak`,`jm`.`waktu_sarapan` AS `waktu_sarapan`,`jm`.`menu_sarapan` AS `menu_sarapan`,`jm`.`waktu_makan_siang` AS `waktu_makan_siang`,`jm`.`menu_makan_siang` AS `menu_makan_siang`,`jm`.`waktu_makan_malam` AS `waktu_makan_malam`,`jm`.`menu_makan_malam` AS `menu_makan_malam`,`jt`.`waktu_tidur` AS `waktu_tidur`,`jt`.`waktu_bangun` AS `waktu_bangun`,`ka`.`nama_kegiatan` AS `nama_kegiatan`,`ka`.`waktu_mulai` AS `waktu_mulai`,`ka`.`waktu_selesai` AS `waktu_selesai` from (((`data_anak` `da` left join `jadwal_makan` `jm` on((`da`.`id_anak` = `jm`.`id_anak`))) left join `jadwal_tidur` `jt` on((`da`.`id_anak` = `jt`.`id_anak`))) left join `kegiatan_anak` `ka` on((`da`.`id_anak` = `ka`.`id_anak`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `aktivitas_user`
--

/*!50001 DROP VIEW IF EXISTS `aktivitas_user`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `aktivitas_user` AS select `al`.`changed_at` AS `changed_at`,`al`.`table_name` AS `table_name`,`al`.`operation_type` AS `operation_type`,`au`.`nama_user` AS `user_terlibat`,`al`.`old_data` AS `old_data`,`al`.`new_data` AS `new_data` from (`audit_logs` `al` join `akun_user` `au` on((`al`.`changed_by` = `au`.`id_user`))) where (`al`.`role` = 'user') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `data_anak_lengkap`
--

/*!50001 DROP VIEW IF EXISTS `data_anak_lengkap`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `data_anak_lengkap` AS select `au`.`id_user` AS `id_user`,`da`.`id_anak` AS `id_anak`,`da`.`nama_anak` AS `nama_anak`,`da`.`tanggal_lahir` AS `tanggal_lahir`,`da`.`umur` AS `umur`,`da`.`jenis_kelamin` AS `jenis_kelamin`,`da`.`berat_badan_kg` AS `berat_badan_kg`,`da`.`tinggi_badan_cm` AS `tinggi_badan_cm`,`au`.`nama_user` AS `nama_user` from (`data_anak` `da` join `akun_user` `au` on((`da`.`id_user` = `au`.`id_user`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `riwayat_kesehatan_lengkap`
--

/*!50001 DROP VIEW IF EXISTS `riwayat_kesehatan_lengkap`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `riwayat_kesehatan_lengkap` AS select `rk`.`id_kesehatan` AS `id_kesehatan`,`rk`.`nama_penyakit` AS `nama_penyakit`,`rk`.`nama_obat` AS `nama_obat`,`rk`.`tanggal_mulai_sakit` AS `tanggal_mulai_sakit`,`rk`.`tanggal_selesai_sakit` AS `tanggal_selesai_sakit`,`da`.`nama_anak` AS `nama_anak`,`da`.`umur` AS `umur`,`au`.`nama_user` AS `nama_orang_tua` from ((`riwayat_kesehatan` `rk` join `data_anak` `da` on((`rk`.`id_anak` = `da`.`id_anak`))) join `akun_user` `au` on((`da`.`id_user` = `au`.`id_user`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `user_list`
--

/*!50001 DROP VIEW IF EXISTS `user_list`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `user_list` AS select `a`.`id_admin` AS `id_admin`,`a`.`nama_admin` AS `nama_admin`,`a`.`email` AS `email`,'admin' AS `role`,'Semua hak akses' AS `hak_akses` from `akun_admin` `a` union all select `u`.`id_user` AS `id_user`,`u`.`nama_user` AS `nama_user`,`u`.`email` AS `email`,`u`.`tipe_user` AS `role`,(case when (`u`.`tipe_user` = 'orang_tua') then 'SELECT, INSERT, UPDATE, DELETE pada data anak, jadwal makan, jadwal tidur, kegiatan anak, dan riwayat kesehatan' when (`u`.`tipe_user` = 'pengasuh') then 'SELECT pada data anak, SELECT, UPDATE pada jadwal makan, jadwal tidur, kegiatan anak, dan riwayat kesehatan' else 'Tidak ada hak akses' end) AS `hak_akses` from `akun_user` `u` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `aktivitas_admin`
--

/*!50001 DROP VIEW IF EXISTS `aktivitas_admin`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `aktivitas_admin` AS select `al`.`changed_at` AS `changed_at`,`al`.`table_name` AS `table_name`,`al`.`operation_type` AS `operation_type`,`aa`.`nama_admin` AS `admin_terlibat`,`al`.`old_data` AS `old_data`,`al`.`new_data` AS `new_data` from (`audit_logs` `al` join `akun_admin` `aa` on((`al`.`changed_by` = `aa`.`id_admin`))) where (`al`.`role` = 'admin') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-28 21:30:22
