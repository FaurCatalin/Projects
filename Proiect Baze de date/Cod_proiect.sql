--Punctul 1 si 2 crearea tabelelor
CREATE TABLE Student(
nume VARCHAR(15) NOT NULL,
prenume VARCHAR(20) NOT NULL,
nrLegitimatie NUMBER(6) PRIMARY KEY CHECK(nrLegitimatie>99999),
mediaGenerala NUMBER(4,2) CHECK(mediaGenerala>=0 AND mediaGenerala<=10),
mediaAnul1 NUMBER(4,2) CHECK(mediaAnul1>=0 AND mediaAnul1<=10),
mediaAnul2 NUMBER(4,2) CHECK(mediaAnul2>=0 AND mediaAnul2<=10),
mediaAnul3 NUMBER(4,2) CHECK(mediaAnul3>=0 AND mediaAnul3<=10));

CREATE TABLE Note(
disciplina VARCHAR(10),
anStudiu INT CHECK(anStudiu BETWEEN 1 AND 4),
nrPrezente NUMBER(2),
dataPrezentari DATE DEFAULT SYSDATE,
notaObtinuta NUMBER(4,2) CHECK(notaObtinuta>=0 AND notaObtinuta<=10),
nrLegitimatie NUMBER(6) CHECK(nrLegitimatie>99999),
	CONSTRAINT const1 FOREIGN KEY (nrLegitimatie) 
	REFERENCES Student(nrLegitimatie)
);
--Punctul 3 popularea bazei de date
SELECT sysdate FROM dual;
ALTER SESSION SET nls_date_format='dd-mm-yyyy';
set autocommit on;

--Tabelul Student
INSERT INTO Student VALUES('Popa','Ion',123456,4,5,0,0);
INSERT INTO Student VALUES('Adam','Gheorghe',123457,7,5,0,0);
INSERT INTO Student VALUES('Pop','George',123458,7,5,0,0);
INSERT INTO Student VALUES('Gorie','Madalin',123459,9,9,0,0);
INSERT INTO Student VALUES('Bogdan','Alex',123451,8,8,0,0);
INSERT INTO Student VALUES('Dragomir','Catalin',123452,8,8,0,0);

--Tabelul cu Note
--pentru studentul cu nrLegitimatie=123456
INSERT INTO Note VALUES('Matemaica',1,1,'22/12/2020',4,123456);
INSERT INTO Note VALUES('Chimie',2,1,'01/03/2020',10,123456);
INSERT INTO Note VALUES('Engleza',3,2,'02/09/2020',9,123456);

--pentru studentul cu nrLegitimatie=123457
INSERT INTO Note VALUES('Fizica',1,1,'12/12/2020',9,123457);

--pentru studentul cu nrLegitimatie=123458
INSERT INTO Note  VALUES('Matemaica',1,1,'12/12/2020',10,123458);

--pentru studentul cu nrLegitimatie=123459
INSERT into Note VALUES('Chimie',2,2,'01/02/2020',9,123459);
INSERT into Note VALUES('Matemaica',1,2,'02/01/2020',8,123459);
INSERT into Note VALUES('Logica',1,1,'12/12/2020',10,123459);

--pentru studentul cu nrLegitimatie=123451
INSERT into Note VALUES('Istorie',1,1,'03/02/2020',7,123451);
INSERT into Note VALUES('Engleza',3,2,'10/01/2020',7,123451);
INSERT into Note VALUES('Franceza',2,1,'20/12/2020',7,123451);

--pentru studentul cu nrLegitimatie=123452
INSERT into Note VALUES('Chimie',1,2,'10/03/2020',4,123452);
INSERT into Note VALUES('Matemaica',3,2,'12/01/2020',3,123452);
INSERT into Note VALUES('Logica',2,1,'18/12/2020',6,123452);

--Pentru punctul 4-> o interogare pentru studenti care nu au promovat o disciplina
SELECT S.nume, S.prenume FROM Student S, Note N
WHERE S.nrLegitimatie= N.nrLegitimatie AND N.notaObtinuta<=4
GROUP BY S.nrLegitimatie,S.nume, S.prenume;

--Pentru punctul 5
SELECT S.nume, S.prenume, MAX(N.anStudiu) AS anulDeStudiu , S.nrLegitimatie FROM Student S, Note N
WHERE S.nrLegitimatie=N.nrLegitimatie
GROUP BY S.nrLegitimatie,S.nume,S.prenume;

--Pentru punctul 6 
SELECT S.nrLegitimatie, S.nume, S.prenume,N.disciplina,MAX(N.notaObtinuta) FROM Student S, Note N
WHERE S.nrLegitimatie=N.nrLegitimatie 
GROUP BY S.nrLegitimatie,S.nume,S.prenume,N.disciplina,N.anStudiu
HAVING MAX(N.notaObtinuta)>5
ORDER BY S.nume,S.prenume,N.anStudiu,N.disciplina;

--Pentru punctul 7
CREATE OR REPLACE TRIGGER Media
BEFORE INSERT OR UPDATE ON Note
FOR EACH ROW
DECLARE
k INT;
BEGIN
IF :NEW.anStudiu=1 THEN
	SELECT COUNT(*) INTO k FROM Note N Where N.anStudiu=1 AND N.nrLegitimatie=:NEW.nrLegitimatie;
	UPDATE Student S SET mediaAnul1=(mediaAnul1*k+:NEW.notaObtinuta)/(k+1) WHERE S.nrLegitimatie=:NEW.nrLegitimatie;
ELSIF :NEW.anStudiu=2 THEN
	SELECT COUNT(*) INTO k FROM Note N Where N.anStudiu=2 AND N.nrLegitimatie=:NEW.nrLegitimatie;
	UPDATE Student S SET mediaAnul2=(mediaAnul2*k+:NEW.notaObtinuta)/(k+1) WHERE S.nrLegitimatie=:NEW.nrLegitimatie;
ELSE
	SELECT COUNT(*) INTO k FROM Note N Where N.anStudiu=3 AND N.nrLegitimatie=:NEW.nrLegitimatie;
	UPDATE Student S SET mediaAnul3=(mediaAnul3*k+:NEW.notaObtinuta)/(k+1) WHERE S.nrLegitimatie=:NEW.nrLegitimatie;
END IF;
UPDATE Student S SET mediaGenerala=(mediaAnul1+mediaAnul2+mediaAnul3)/3 WHERE S.nrLegitimatie=:NEW.nrLegitimatie AND mediaAnul1>0 AND mediaAnul2>0 AND mediaAnul3>0;
UPDATE Student S SET mediaGenerala=(mediaAnul1+mediaAnul2)/2 WHERE S.nrLegitimatie=:NEW.nrLegitimatie AND mediaAnul3<0;
UPDATE Student S SET mediaGenerala=(mediaAnul2+mediaAnul3)/2 WHERE S.nrLegitimatie=:NEW.nrLegitimatie AND mediaAnul1<0;
UPDATE Student S SET mediaGenerala=mediaAnul1 WHERE S.nrLegitimatie=:NEW.nrLegitimatie AND mediaAnul2<= 0 AND mediaAnul3<=0;
UPDATE Student S SET mediaGenerala=mediaAnul2 WHERE S.nrLegitimatie=:NEW.nrLegitimatie AND mediaAnul1<= 0 AND mediaAnul3<=0;
UPDATE Student S SET mediaGenerala=mediaAnul3 WHERE S.nrLegitimatie=:NEW.nrLegitimatie AND mediaAnul1<= 0 AND mediaAnul2<=0;

END;
/
INSERT into Note VALUES('Economie',1,1,'12/12/2020',10,123459);
SELECT * FROM Student;

--Pentru PUNCTUL 8
CREATE OR REPLACE FUNCTION Promovabilitate(discipli VARCHAR)
RETURN NUMBER
AS
x NUMBER(2);
y NUMBER(2);
promo NUMBER(5,2);
BEGIN
SELECT COUNT(disciplina) INTO x FROM Student S, Note N
WHERE S.nrLegitimatie=N.nrLegitimatie AND disciplina=discipli 
GROUP BY disciplina;
SELECT COUNT(DISTINCT N.nrLegitimatie) INTO y FROM Student S, Note N
WHERE S.nrLegitimatie=N.nrLegitimatie AND disciplina=discipli AND notaObtinuta>=5 
GROUP BY disciplina;
promo:=(y/x)*100;
RETURN promo;
END;
/

SELECT Promovabilitate('Matemaica') FROM dual;


--Pentru punctul 9

