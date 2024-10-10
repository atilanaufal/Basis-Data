CREATE DATABASE DB6;

CREATE TABLE mhs(
  nim char(12),
  nama varchar(25),
  prodi varchar(25)
);

INSERT INTO mhs VALUES('2023071002', 'Athillah Naufal Al-Falah', 'INF');
INSERT INTO mhs VALUES('2023071010', 'Junior RB', 'INF');
INSERT INTO mhs VALUES('2023081007', 'Alaya nurhan', 'SIF');
INSERT INTO mhs VALUES('2023091002', 'Aditya Surya', 'ARS');
INSERT INTO mhs VALUES('2023091028', 'Surya Fidhan', 'ARS');
INSERT INTO mhs VALUES('2023081020', 'Fadhil Gustiawan', 'SIF');
INSERT INTO mhs VALUES('2023061011', 'Yasmin Yahati', 'DP');


INSERT INTO mhs VALUES('2023081012', 'Rheno', 'SIF');
INSERT INTO mhs VALUES('2023081003', 'Bayu', 'SIF');
INSERT INTO mhs VALUES('2023081000', 'Damar', 'SIF');
INSERT INTO mhs VALUES('202308134', 'Sepuh', 'SIF');
INSERT INTO mhs VALUES('2023071078', 'Robert', 'INF');


SELECT prodi, count(*) jml_mhs
from mhs
group by prodi;

SELECT * 
from mhs
order by nim;


SELECT prodi, count(*) jml_mhs
from mhs
WHERE prodi = "INF"
group by prodi;

SELECT prodi, count(*) AS jml_mhs
FROM mhs
GROUP BY prodi
HAVING count(*) >= 3;

ALTER TABLE mhs
ADD nilai NUMERIC(2,2);

SELECT * FROM mhs;

SELECT MAX(nama) as max_nama_inf from mhs
where prodi = "inf";

SELECT MIN(nama) as min_nama_inf from mhs
where prodi = "inf";



 


-- lanjutan ebook



CREATE TABLE nomor (
  nilai_angka decimal(6,3),
  nilai_bulat int,
  nilai_kecil smallint,
  nilai_besar bigint,
  nilai_float float,
  nilai_numeric numeric(6,3),
  nilai_real real
);
create table huruf (
  kata char(12),
  kalimat varchar(25),
  paragraf text(50)
);

create table tanggal (
  tgl date,
  waktu_lengkap datetime,
  waktu_lengkap2 datetime,
  jam time,
  bol bool
);

INSERT INTO nomor values(10.00, 10, 1, 100, 100.0000, 100.00, 3.14);
INSERT INTO huruf values('nama', 'nama lengkap', 'nama saya adalah athillah naufal alfalah');
insert into tanggal values ("2023-07-10", "2023-07-10 10:20:00", "1970-07-10 12:30:00", "10:20:00", True );


select * from nomor;
select * from huruf;
select * from tanggal;




