- ====================== UNION ======================
/*
    Iki farkli sorgulamanin sonucunu birlestiren islemdir.
    Iki veya daha fazla Sorgu ifadesinin sonuc kumelerini 
    birlestirerek tek bir sonuc kumesi olusturur.
    2.sorgunun sonuna ORDER BY komutunu kullanirsaniz 
    tum tabloyu istediginiz siralamaya gore siralar.
   
    NOT: Secilen Field SAYISI ve DATA TYPE'i ayni olmalidir.
    
    Syntax:
    ----------
    SELECT sutun_adi,sutun_adi2, .. FROM tablo_adi1
    UNION
    SELECT sutun_adi1, sutun_adi2, .. FROM tablo_adi2;
    
    NOT: UNION operatoru SADECE benzersiz degerleri alir. 
    Benzer verileri almak icin UNION ALL kullanilir.
======================================================*/
CREATE TABLE kadro(
id int,
isim varchar(50),
sehir varchar(50),
maas int,
sirket varchar(20)
);
INSERT INTO kadro VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');
INSERT INTO kadro VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');
INSERT INTO kadro VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500,'Honda');
INSERT INTO kadro VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');
INSERT INTO kadro VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');
INSERT INTO kadro VALUES(456715012, 'Veli Sahin', 'Ankara', 4500, 'Ford');
INSERT INTO kadro VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');
INSERT INTO kadro VALUES(345678902, 'Mehmet Ozturk', 'Izmir', 3500,'Honda');
SELECT * FROM kadro;
-- 1) Honda ve Tofas'ta calisan benzersiz isimdeki personelleri listeleyin
SELECT isim
FROM kadro
WHERE sirket IN ('Honda','Tofas');

SELECT DISTINCT isim
FROM kadro
WHERE sirket IN ('Honda','Tofas');

SELECT isim
FROM kadro
WHERE sirket='Honda'
UNION
SELECT isim
FROM kadro
WHERE sirket='Tofas';

-- 2) Honda, Ford ve Tofas'ta calisan benzersiz isimdeki 
-- personelleri listeleyin
SELECT isim
FROM kadro
WHERE sirket='Honda'
UNION
SELECT isim
FROM kadro
WHERE sirket='Tofas'
UNION
SELECT isim
FROM kadro
WHERE sirket='Ford';
-- 3) Honda, Ford ve Tofas'ta calisan butun personelleri listeleyin
SELECT isim
FROM kadro
WHERE sirket='Honda'
UNION ALL
SELECT isim
FROM kadro
WHERE sirket='Tofas'
UNION ALL
SELECT isim
FROM kadro
WHERE sirket='Ford';
-- 4) Honda, Ford ve Tofas'ta calisan butun personellerin
-- isim, maas, sehir bilgilerini listeleyin
SELECT isim, maas, sehir
FROM kadro
WHERE sirket='Honda'
UNION ALL
SELECT isim, maas, sehir
FROM kadro
WHERE sirket='Tofas'
UNION ALL
SELECT isim, maas, sehir
FROM kadro
WHERE sirket='Ford';
-- 5) Maasi 4000'den fazla olan isci isimlerini ve 5000'den fazla
-- maas alinan sehirleri gosteren sorguyu yaziniz
SELECT isim AS isim_sehir
FROM kadro
WHERE maas > 4000
UNION
SELECT sehir
FROM kadro
WHERE maas >5000;
-- 6) Mehmet Ozturk ismindeki personellerin aldigi maaslari ve 
-- Istanbul'daki personelin maaslarini bir tabloda gosteren sorgu yaziniz
SELECT maas, isim AS isim_sehir
FROM kadro
WHERE isim = 'Mehmet Ozturk'
UNION
SELECT maas, sehir
FROM kadro
WHERE sehir = 'Istanbul';
-- 7) Mehmet Ozturk ismindeki personellerin aldigi maaslari ve Istanbul'daki 
-- personelin maaslarini en yuksekten dusuge dogru siralayarak bir 
-- tabloda gosteren sorguyu yaziniz.
SELECT maas, isim AS isim_sehir
FROM kadro
WHERE isim = 'Mehmet Ozturk'
UNION
SELECT maas, sehir
FROM kadro
WHERE sehir = 'Istanbul'
ORDER BY maas DESC;
/*
SELECT (AGGREGATE FUNCTION, DISTINCT) AS name
FROM table_name
WHERE condition (LIKE, IN, REGEXP_LIKE, IS NULL, EXISTS, BETWEEN, AND, OR)
GROUP BY
HAVING
ORDER BY (DESC)
LIMIT
*/
-- 8) 3000'den fazla maas alinan sehirleri ve personelden 
-- ucreti 5000'den az olanlarin isimlerini bir tabloda gosteren sorguyu yaziniz
SELECT sehir AS isim_sehir
FROM kadro
WHERE maas > 3000
UNION
SELECT isim
FROM kadro
WHERE maas < 5000;    
-- 9) 5000'den az maas alanlarin ve buna ek olarak Honda calisani olmayanlarin
-- bilgilerini bir tabloda listeleyen bir sorgu yaziniz. 
SELECT *
FROM kadro
WHERE maas < 5000
UNION
SELECT *
FROM kadro
WHERE  sirket <> 'Honda';
-- <> ile != ayni anlami tasimaktadir!!!
-- 10) Ismi Veli Sahin olanlari ve ek olarak Istanbul'da calismayanlarin 
-- isimlerini ve sehirlerini listeleyen sorguyu yaziniz.
SELECT isim, sehir
FROM kadro
WHERE isim = 'Veli Sahin'
UNION
SELECT isim, sehir
FROM kadro
WHERE sehir <> 'Istanbul';

/*============================== JOIN ISLEMLERI ===============================
    
    Union,Union All Operatorleri farkli tablolardaki sutunlari 
    birlestirmek icin de kullanilir.
    
    Join islemleri ise farkli Tablolari birlestirmek icin kullanilir. Diger 
    bir ifade ile farkli tablolardaki secilen sutunlar ile yeni bir tablo 
    olusturmak icin kullanilabilir.
    
    JOIN islemleri Iliskisel Veritabanlari icin cok onemli bir ozelliktir. Cunku
    Foreign Key'ler ile iliskili olan tablolardan istenilen sutunlari cekmek 
    icin JOIN islemleri kullanilabilir.
    
    mySQL'de 3 Cesit Join islemi kullanilabilmektedir.
    
    1) INNER JOIN:  Tablolardaki ortak olan sonuc kumesini gosterir
    2) LEFT JOIN:  Ilk tabloda (Sol) olan sonuclari gosterir
    3) RIGHT JOIN:  Ikinci tabloda (Sag) olan tum sonuclari gosterir
      
    full JOIN=(left join + union + right join) Tablodaki tum sonuclari gosterir
==============================================================================*/  
CREATE TABLE sirket 
    (
        sirket_id int, 
        sirket_isim VARCHAR(20)
    );
    
    INSERT INTO sirket VALUES(100, 'Toyota');
    INSERT INTO sirket VALUES(101, 'Honda');
    INSERT INTO sirket VALUES(102, 'Ford');
    INSERT INTO sirket VALUES(103, 'Hyundai');
    
    CREATE TABLE siparisler
    (
        siparis_id int,
        sirket_id int, 
        siparis_tarihi DATE
    );
    
    INSERT INTO siparisler VALUES(11, 101, '2020-04-17');
    INSERT INTO siparisler VALUES(22, 102, '2020-04-18');
    INSERT INTO siparisler VALUES(33, 103, '2020-04-19');
    INSERT INTO siparisler VALUES(44, 104, '2020-04-20');
    INSERT INTO siparisler VALUES(55, 105, '2020-04-21');
SELECT * FROM sirket;
SELECT * FROM siparisler;
/*=============================== INNER JOIN  ==================================
    
    Iki tablonun kesisim kumesi ile yeni bir tablo olusturmak icin kullanilir.
    
    1) Select'ten sonra tabloda gormek istediginiz sutunlari yazarken
       table_name.field_name seklinde yazin.
    2) From'dan sonra table_name yazarken 
       1. table_name + INNER JOIN + 2. table_name yazmaliyiz.
    3) Join'i hangi kurala gore yapacaginizi belirtmelisiniz. 
       Bunun icin ON kuralimiz yazilmali.
    
    Syntax
    -----------
    SELECT sutun1,sutun2....sutunN
    FROM tablo1 INNER JOIN tablo2
    ON tablo1.sutun = tablo2.sutun;
    
================================================================================  */
/* -----------------------------------------------------------------------------
  ORNEK1: Iki Tabloda sirket_id'si ayni olanlarin sirket_ismi, siparis_id ve 
  siparis_tarihleri listeleyen bir sorgu yaziniz.
------------------------------------------------------------------------------*/
SELECT sirket.sirket_isim, siparisler.siparis_id, siparisler.siparis_tarihi
FROM siparisler INNER JOIN sirket 
ON sirket.sirket_id = siparisler.sirket_id;
-- INNER JOIN ile sadece iki tablodaki ortak olan satirlar secilir.
-- Diger bir ifadeyle iki tablodaki ortak olan sirket_id degerleri icin 
-- ilgili sutunlar listenir.
/*=============================== LEFT JOIN  ==================================
    
    LEFT JOIN, 1. tablodan (sol tablo) SELECT ile ifade edilen sutunlara ait tum
    satirlari getirir. 
    Ancak, diger tablodan sadece ON ile belirtilen kosula uyan satirlari getirir. 
    
    1) Left Join'de ilk tablodaki tum record'lar gosterilir.
    2) Ilk tablodaki datalara 2.tablodan gelen ek datalar 
       varsa bu ek datalar ortak datalar icin gosterilir, 
       ancak ortak olmayan datalar icin o kisimlar bos kalir.
    3) Ilk yazdiginiz Tablonun tamamini aldigi icin hangi tabloyu
       istedigimize karar verip once onu yazmaliyiz. 
        
    Syntax
    -----------
    SELECT sutun1,sutun2....sutunN
    FROM tablo1 LEFT JOIN tablo2
    ON tablo1.sutun = tablo2.sutun;
    
==============================================================================*/  
/* -----------------------------------------------------------------------------
  ORNEK2: sirketler tablosundaki tum sirketleri ve bu sirketlere ait olan 
  siparis_id ve siparis_tarihleri listeleyen bir sorgu yaziniz.
------------------------------------------------------------------------------*/
-- ******************** LEFT COZUMU *************************
SELECT sirket.sirket_isim, siparisler.siparis_id, siparisler.siparis_tarihi
FROM  sirket LEFT JOIN siparisler
ON sirket.sirket_id = siparisler.sirket_id;
-- ******************** RIGHT COZUMU *************************
SELECT sirket.sirket_isim, siparisler.siparis_id, siparisler.siparis_tarihi
FROM  siparisler RIGHT JOIN sirket
ON sirket.sirket_id = siparisler.sirket_id;
-- from dan sonra  Left Join'de ilk tablodaki tum satirlar gosterilir.
-- Ilk tablodaki satirlara 2.tablodan kosula uyan ortak satirlar 
-- gosterilir, ancak ortak olmayan kisimlar bos kalir
/*=============================== RIGHT JOIN  ==================================
    
    RIGHT JOIN, 2. tablodan (sag tablo) SELECT ile ifade edilen sutunlara ait tum
    satirlari getirir. 
    Ancak, diger tablodan sadece ON ile belirtilen kosula uyan satirlari getirir. 
        
    1) Right Join'de ikinci tablodaki tum record'lar gosterilir.
    2) Ikinci tablodaki datalara 1.tablodan gelen ek datalar 
       varsa bu ek datalar ortak datalar icin gosterilir ancak 
       ortak olmayan datalar icin o kisimlar bos kalir
       
    Syntax
    -----------
    SELECT sutun1,sutun2....sutunN
    FROM tablo1 RIGHT JOIN tablo2
    ON tablo1.sutun = tablo2.sutun;
    
==============================================================================*/
/* -----------------------------------------------------------------------------
  ORNEK3: siparisler tablosundaki tum siparis_id ve siparis_tarihleri ile 
  bunlara karsilik gelen sirket_isimlerini listeleyen bir sorgu yaziniz.
------------------------------------------------------------------------------*/   
SELECT  siparisler.siparis_id, siparisler.siparis_tarihi, sirket.sirket_isim
FROM sirket RIGHT JOIN siparisler
ON sirket.sirket_id = siparisler.sirket_id;
    /*=============================== full JOIN  ==================================
    full JOIN: (left join + union + right join)
    full  JOIN, Her iki tablo icin secilen sutunlara ait olan tum satirlari 
    getirmek icin kullanilir. 
    
    Syntax
    -----------
    SELECT sutun1,sutun2....sutunN
    FROM tablo1 
    left JOIN tablo2
    ON tablo1.sutun = tablo2.sutun
    union
    SELECT sutun1,sutun2....sutunN
    FROM tablo1 
    right JOIN tablo2
    ON tablo1.sutun = tablo2.sutun
    
    1) full JOIN'de iki tabloda var olan tum record'lar gosterilir.
    2) Bir tabloda olup otekinde olmayan data'lar bos kalir.
==============================================================================*/
/* -----------------------------------------------------------------------------
  ORNEK4: sirketler ve siparisler adindaki tablolarda yer alan sirket_id, 
  sirket_isim, siparis_id ve siparis_tarihleri listeleyen bir sorgu yaziniz.
------------------------------------------------------------------------------*/
SELECT sirket.sirket_isim,sirket.sirket_id, siparisler.siparis_id, siparisler.siparis_tarihi
FROM sirket LEFT JOIN siparisler
ON sirket.sirket_id = siparisler.sirket_id
UNION
SELECT sirket.sirket_isim,siparisler.sirket_id, siparisler.siparis_id, siparisler.siparis_tarihi
FROM sirket RIGHT JOIN siparisler
ON sirket.sirket_id = siparisler.sirket_id;
-- *************************************************************************************    
    
    CREATE TABLE bolumler (
      bolum_id   int PRIMARY KEY,
      bolum_isim VARCHAR(14),
      konum      VARCHAR(13)
    );
    
    INSERT INTO bolumler VALUES (10,'MUHASEBE','IST');
    INSERT INTO bolumler VALUES (20,'MUDURLUK','ANKARA');
    INSERT INTO bolumler VALUES (30,'SATIS','IZMIR');
    INSERT INTO bolumler VALUES (40,'ISLETME','BURSA');
    INSERT INTO bolumler VALUES (50,'DEPO', 'YOZGAT');
    CREATE TABLE caliskanlar (
      personel_id   int PRIMARY KEY,
      personel_isim VARCHAR(10),
      meslek        VARCHAR(9),
      mudur_id      int,
      maas          int,
      bolum_id      int
    );
  
    INSERT INTO caliskanlar VALUES (7369,'AHMET','KATIP',1111,800,20);
    INSERT INTO caliskanlar VALUES (7499,'BAHATTIN','SATISE',1222,1600,30);
    INSERT INTO caliskanlar VALUES (7521,'NESE','SATISE',1222,1250,30);
    INSERT INTO caliskanlar VALUES (1111,'MUZAFFER','MUDUR',7839,2975,20);
    INSERT INTO caliskanlar VALUES (7654,'MUHAMMET','SATISE',1222,1250,30);
    INSERT INTO caliskanlar VALUES (1222,'EMINE','MUDUR',7839,2850,30);
    INSERT INTO caliskanlar VALUES (1333,'HARUN','MUDUR',7839, 2450,10);
    INSERT INTO caliskanlar VALUES (7788,'MESUT','ANALIST',1111,3000,20);
    INSERT INTO caliskanlar VALUES (7839,'SEHER','BASKAN',NULL,5000,10);
    INSERT INTO caliskanlar VALUES (7844,'DUYGU','SATISE',1222,1500,30);
    INSERT INTO caliskanlar VALUES (7876,'ALI','KATIP',1111,1100,20);
    INSERT INTO caliskanlar VALUES (7900,'MERVE','KATIP',1222,950,30);
    INSERT INTO caliskanlar VALUES (7902,'NAZLI','ANALIST',1111,3000,20);
    INSERT INTO caliskanlar VALUES (7934,'EBRU','KATIP',1333,1300,10);
    INSERT INTO caliskanlar VALUES (7956,'SIBEL','MIMAR',1333,3300,60);
    INSERT INTO caliskanlar VALUES (7933,'ZEKI','MUHENDIS',1333,4300,60);
   SELECT * FROM bolumler;
   SELECT * FROM caliskanlar;
  
/* -----------------------------------------------------------------------------
  ORNEK1: SATIS ve MUHASEBE bolumlerinde calisanlarin isimlerini ve 
  bolumlerini, once bolum sonra isim sirali olarak listeleyiniz
------------------------------------------------------------------------------*/
SELECT caliskanlar.personel_isim, bolumler.bolum_isim
FROM caliskanlar JOIN bolumler
ON caliskanlar.bolum_id = bolumler.bolum_id
WHERE bolum_isim IN ('Satis','Muhasebe')
ORDER BY bolum_isim, personel_isim;
/* -----------------------------------------------------------------------------
  ORNEK2: SATIS,ISLETME ve DEPO bolumlerinde calisan personelin isimlerini,  
  bolumlerini  isim sirali olarak listeleyiniz. 
  NOT: calisani olmasa bile bolum ismi gosterilmelidir.
------------------------------------------------------------------------------*/
SELECT bolumler.bolum_isim, caliskanlar.personel_isim
FROM bolumler LEFT JOIN caliskanlar
ON caliskanlar.bolum_id = bolumler.bolum_id
WHERE bolum_isim IN ('Satis','Isletme','Depo')
ORDER BY personel_isim;
/* -----------------------------------------------------------------------------
  ORNEK3:  Calisan tum personelin isimlerini, bolum isimlerini ve 
  maaslarini bolum ters ve maas sirali listeleyiniz. 
  NOT: bolum ismi olmasa bile personel gosterilmelidir.
------------------------------------------------------------------------------*/
SELECT caliskanlar.personel_isim, bolumler.bolum_isim, caliskanlar.maas
FROM bolumler RIGHT JOIN caliskanlar
ON caliskanlar.bolum_id = bolumler.bolum_id
ORDER BY bolum_isim DESC, maas;
 
/* -----------------------------------------------------------------------------
  ORNEK4: SATIS ve MUDURLUK bolumlerinde calisan personelin maaslari 2000'den
  buyuk olanlarin isimlerini, bolum isimlerini ve 
  maaslarini, bolume ve isme gore siralayarak listeleyiniz. 
------------------------------------------------------------------------------*/ 
 
SELECT caliskanlar.personel_isim, bolumler.bolum_isim, caliskanlar.maas 
FROM caliskanlar JOIN bolumler
ON caliskanlar.bolum_id = bolumler.bolum_id 
WHERE maas > 2000 AND bolum_isim IN ('Satis','Mudurluk')
ORDER BY bolum_isim,personel_isim;














