
CREATE TABLE meslek_lisesi4 (
okul_no CHAR(4) UNIQUE,
isim VARCHAR(50) NOT NULL,
derece DOUBLE,
adres VARCHAR(100),
son_degisiklik_tarihi DATE
);
SELECT * FROM meslek_lisesi4;

INSERT INTO meslek_lisesi4 VALUES('1001','Fatih Oz', 89,'Ankara', '2022-11-23');      
INSERT INTO meslek_lisesi4 VALUES('1002','Fatih Yildiz', 94,'Istanbul', '2022-11-23');
INSERT INTO meslek_lisesi4 VALUES('1003','Bora Sverige', 78,'Izmir', '2022-11-23');
INSERT INTO meslek_lisesi4 VALUES('1004','Nevzat Celik', 69,'Ankara', '2022-11-23');

SELECT *  
FROM meslek_lisesi4 
WHERE derece>90; 