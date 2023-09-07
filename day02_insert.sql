/*========================================
        VERI GIRISI - INSERT 
========================================*/
-- INSERT INTO + tablo adi + VALUES + (std_id CHAR(4),std_name VARCHAR(25),std_age int)
-- Degerleri girerken dikkat edilmesi gereken Tabloyu 
-- olustururken degerleri atadigimiz veri cinsinden olmasi
-- String ifadeleri tek tirnak icinde yaziyoruz.
-- Date data tipi de String gibi tek tirnak icine yazilir,
-- ayrica MySQL 'in default tarih formati YYYY-MM-DD seklindedir.

/*******************************************************
-> Bir field'a kaydedilecek verileri UNIQUE yapmak icin 
 table olustururken field isminin yanina UNIQUE yaziyoruz.
-> Bir field'a kaydedilecek verilerde null olmasin istiyorsak 
table olustururken field isminin yanina NOT NULL yaziyoruz.
*********************************************************/

-- UNIQUE olarak belirledigimiz bir field'a istedigimiz kadar NULL deger kaydedebiliriz
-- ancak data tipi String ise hiclik ifadesini sadece 1 kere kaydeder, 
-- diger kayitlarda duplicate hatasi verir.

-- *** 1062 ikinci kez ayni ifade girildi hatasi

create table fen_lisesi(
okul_no  int unique,
isim varchar(20) not null,
derece double,
adres varchar(20),
son_degisiklik_tarihi date
);

select * from fen_lisesi;
INSERT INTO fen_lisesi VALUES (101,'Mertkan Serefoglu',4.3,'Hatay','2023-09-06');
INSERT INTO fen_lisesi VALUES (102,'Mertkan Serefoglu',4.3,'Hatay','2023-09-06');
INSERT INTO fen_lisesi VALUES (103,'Arif Emre Comert',4.5,'Nigde','2023-09-06');
INSERT INTO fen_lisesi VALUES (104,'Resul Acar',4.3,'Istanbul','2023-09-06');
INSERT INTO fen_lisesi VALUES (105,'Gulay Gumus',4.8,'Ankara','2023-09-06');
INSERT INTO fen_lisesi VALUES (106,'Hilal Ciftci',4.9,'Istanbul','2023-09-06');
INSERT INTO fen_lisesi VALUES (107,'Gulsah Ozkan',5.0,'Leeds','2023-09-06');
INSERT INTO fen_lisesi VALUES (108,'Yusuf Ihsan Esen',3.2,'Istanbul','2023-09-06');
INSERT INTO fen_lisesi VALUES (109,NULL,3.2,'Istanbul','2023-09-06');-- isim degeri null oldugu icin kayit yapmaz
INSERT INTO fen_lisesi VALUES (109,'Ramazan Kacmaz',3.2,NULL,'2023-09-06');
INSERT INTO fen_lisesi VALUES (NULL,'Ramazan Kacmaz',4.3,'Sivas','2023-09-06');
INSERT INTO fen_lisesi VALUES (NULL,'Samet Ari',4.5,'Balikesir','2023-09-06');

/* ----------------------------------------------
Q1 : okul_no , isim , adres, derece fieldlari olan 
anadolu lisesi table olusturun. okul_no CHAR ve UNIQUE, 
isim NOT NULL olacak.
------------------------------------------------- */
CREATE TABLE anadolu_lisesi1(
okul_no CHAR(8) UNIQUE,
isim VARCHAR(20) NOT NULL,
adres VARCHAR(40),
derece DOUBLE
);
SELECT * FROM anadolu_lisesi1;

INSERT INTO anadolu_lisesi1 VALUES ('1001','Esat Fatih','Ankara',4.7);
INSERT INTO anadolu_lisesi1 VALUES ('1002','Yusuf Rahman','Ankara',4.8);
INSERT INTO anadolu_lisesi1 VALUES ('1003','Sevda Bagci','Istanbul',3.5);
INSERT INTO anadolu_lisesi1 VALUES ('1004','Muhammet Ozyon','Ankara',4.3);
INSERT INTO anadolu_lisesi1 VALUES ('1005','Saida Aliyeva','Ankara',4.1);
INSERT INTO anadolu_lisesi1 VALUES ('1006','Cemil Cetin','Mardin',4.9);
INSERT INTO anadolu_lisesi1 VALUES ('','Cemil Cetin','Mardin',4.9);
INSERT INTO anadolu_lisesi1 VALUES ('','Cemil Cetin','Mardin',4.9);-- hicligi bir kere kaydeder
INSERT INTO anadolu_lisesi1 (okul_no , isim ) VALUES (1007,'Dilek Kacar');
INSERT INTO anadolu_lisesi1 (isim,okul_no,derece ) VALUES ('Ipek Kacmaz', 1008,4.7);
INSERT INTO anadolu_lisesi1 (okul_no,derece ) VALUES ( 1008,4.7);-- isim degeri not null belirtildigi icin defaul atanmaz ve hata verir
