-- burasi yorum satiri
/*
alt satirlari kaydetme 
java daki yorum gibidir.
istediginiz kadar satir yazabiliriz
*/
-- 1046 database  secmediniz lutfen use kullanrak database secin calistirin
-- 1050 tabloyu schon kaydedildi tekrar kaydetmeye gerek yok
/*======================================
TABLO OLUSTURMA 1 (CRUD - Create )
=======================================*/
/*------------Syntax-------------------

create tabletable_name
(
field_name datatype,
field_name datatype,
field_name datatype,etc...
);
------------------------------------*/

-- id, isim, not ortlamasi, adres, ve son degistirme tarihi
-- fieldlari iceren bir ogrenci tal'i olusturunuz.
use sys;

create table genel_ogrenciler(
id char(4),
isim varchar (20),
not_ortlamasi double,
adres varchar(100),
son_degistirme_tarihi date
);

select* from genel_ogrenciler;

/*------------------------------------------------------------
Q1: "tedarikciler" isminde bir tablo olusturun.
   "tedarikci_id", "tedarikci_ismi", "tedarikci_adres" ve 
   "ulasim_tarihi" field'lari olsun.
-------------------------------------------------------------*/
create table tedarikciler(
tedarikci_id char(5),
tedarikci_ismi varchar(20),
tedarikci_adres varchar(40),
ulasim_tarihi date
);

select * from tedarikciler;
-- select tedarikci_id, tedarikci_ismi from tedarikciler; * hepsini getirir ama ozel olarak isim de cagiralbilir

/*========================================
    VAROLAN TABLODAN TABLO OLUSTURMA  
========================================
------------------Syntax------------------
CREATE TABLE table_name
AS
SELECT field1,field2
FROM other_table_name
========================================*/
-- ogrenciler1 tablosundan "isim" ve "not_ortalamasi" field'larini
-- alarak ogrenci_derece isimli yeni bir tablo olusturun.
create table ogrenci_derece
as
select isim,not_ortlamasi
from genel_ogrenciler;

select * from ogrenci_derece;

/*--------------------------------------------------------
Q2: "tedarikciler" table'indan "tedarikci_ismi" ve
 "ulasim_tarihi" field'lari olan "tedarikciler_son" 
 isimli yeni bir table olusturun.
---------------------------------------------------------*/
create table tedarikciler_son
as
select tedarikci_ismi,ulasim_tarihi
from tedarikciler;

select * from tedarikciler_son;


