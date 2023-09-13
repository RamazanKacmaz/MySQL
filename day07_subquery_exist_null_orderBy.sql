/* ======================== EXISTS CONDITION ===========================
EXISTS Condition subquery'ler ile kullanilir. IN ifadesinin kullanimina
benzer olarak, EXISTS ve NOT EXISTS ifadeleri de alt sorgudan getirilen 
degerlerin icerisinde bir degerin olmasi veya olmamasi durumunda islem 
yapilmasini saglar.
======================================================================*/

CREATE TABLE mayis_satislar
(
urun_id int,
musteri_isim varchar(50),
urun_isim varchar(50)
);
INSERT INTO mayis_satislar VALUES (10, 'Mark', 'Honda');
INSERT INTO mayis_satislar VALUES (10, 'Mark', 'Honda');
INSERT INTO mayis_satislar VALUES (20, 'John', 'Toyota');
INSERT INTO mayis_satislar VALUES (30, 'Amy', 'Ford');
INSERT INTO mayis_satislar VALUES (20, 'Mark', 'Toyota');
INSERT INTO mayis_satislar VALUES (10, 'Adem', 'Honda');
INSERT INTO mayis_satislar VALUES (40, 'John', 'Hyundai');
INSERT INTO mayis_satislar VALUES (20, 'Eddie', 'Toyota');



CREATE TABLE nisan_satislar
(
urun_id int,
musteri_isim varchar(50),
urun_isim varchar(50)
);
INSERT INTO nisan_satislar VALUES (10, 'Hasan', 'Honda');
INSERT INTO nisan_satislar VALUES (10, 'Kemal', 'Honda');
INSERT INTO nisan_satislar VALUES (20, 'Ayse', 'Toyota');
INSERT INTO nisan_satislar VALUES (50, 'Yasar', 'Volvo');
INSERT INTO nisan_satislar VALUES (20, 'Mine', 'Toyota');

select*from mayis_satislar;
select*from nisan_satislar;
/*----------------------------------------------------------------
SORU 1 : Her iki ayda da ayni id ile satilan urunlerin urun_id'lerini
ve urunleri mayis ayinda alanlarin isimlerini getiren bir query yaziniz.
----------------------------------------------------------------*/ 
select urun_id, musteri_isim
from mayis_satislar
where urun_id IN (select urun id
				  from nisan_satislar
                  where mayis_satislar.urun_id = nisan_satislar.urun_id);
                  
                  
/*----------------------------------------------------------------
SORU 2 : Her iki ayda da satilan urun_isimleri ayni urunlerin,
urun_isim'ini ve urunleri nisan ayinda alan musterilerin isimlerini 
getiren bir Query yaziniz.
----------------------------------------------------------------*/                   
select urun_isim, musteri_isim
from nisan_satislar
where exists (select urun_isim
			  from mayis_satislar
			where mayis_satislar.urun_isim = nisan_satislar.urun_isim);
                  
/*----------------------------------------------------------------
SORU 3 : Nisan ayinda satilip mayis ayinda satilmayan urun ismini ve
satin alan kisiyi listeleyen bir QUERY yaziniz.
----------------------------------------------------------------*/
select urun_isim, musteri_isim
from mayis_satislar
where  exists (select urun_isim
					from nisan_satislar
				where nisan_satislar.urun_isim=mayis_satislar.urun_isim);

/*----------------------------------------------------------------
SORU 4 : Mayis ayinda satilip nisan ayinda satilmayan urun id ve
satin alan kisiyi listeleyen bir QUERY yaziniz.
----------------------------------------------------------------*/

select urun_isim, musteri_isim
from mayis_satislar
where not exists (select urun_isim
					from nisan_satislar
				where nisan_satislar.urun_isim=mayis_satislar.urun_isim);


/* ======================== IS NULL CONDITION ===========================
    Arama yapilan field'da NULL degeri almis kayitlari getirir.
======================================================================*/

CREATE TABLE insanlar
(
ssn char(9),
isim varchar(50),
adres varchar(50)
);
INSERT INTO insanlar VALUES(123456789, 'Ali Can', 'Istanbul');
INSERT INTO insanlar VALUES(234567890, 'Veli Cem', 'Ankara');
INSERT INTO insanlar VALUES(345678901, 'Mine Bulut', 'Izmir');
INSERT INTO insanlar (ssn, adres) VALUES(456789012, 'Bursa');
INSERT INTO insanlar (ssn, adres) VALUES(567890123, 'Denizli');
SELECT * FROM insanlar;

-- Ismi null olan kayitlari 'Isimsiz' olarak guncelleyin :
UPDATE insanlar
set isim='isimsiz'
where isim is null;

-- Ismi null olan kayitlari silin :
delete from insanlar
where isim  is null;


                  
                  