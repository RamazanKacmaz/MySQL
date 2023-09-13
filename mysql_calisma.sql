CREATE TABLE alisveris_list(
Id int ,
urunismi VARCHAR(30) not NULL,
fiat INT ,
CONSTRAINT  id_pk PRIMARY KEY (id)
);

SELECT * FROM alisveris_list;



INSERT INTO alisveris_list VALUES (101, 'Un', 125);
INSERT INTO alisveris_list VALUES (102, 'Seker', 140);
INSERT INTO alisveris_list VALUES (103, 'Yag', 115);

CREATE TABLE market(
urun_id INT,
urun_kalori INT,
urun_marka VARCHAR(20),
CONSTRAINT urun_id_fk FOREIGN KEY(urun_id)
REFERENCES alisveris_list(Id)
);

SELECT * FROM market;

INSERT INTO market VALUES(101, 1600, 'Sodya');
INSERT INTO market VALUES(102, 1250, 'Ülker');
INSERT INTO market VALUES(103, 960, 'Aida');


SAVEPOINT cay;

DELETE FROM market;

ROLLBACK to cay;
 
 TRUNCATE TABLE market;