use movies;

-- 1 --
BEGIN TRANSACTION;

INSERT INTO MOVIESTAR(NAME, BIRTHDATE)
VALUES ('Nicole Kidman', '1967-06-20');

ROLLBACK TRANSACTION;

-- 2 --
BEGIN TRANSACTION;

DELETE
FROM MOVIEEXEC
WHERE NETWORTH < 10000000;

ROLLBACK TRANSACTION;

-- 3 --
BEGIN TRANSACTION;

DELETE
FROM MOVIESTAR
WHERE ADDRESS IS NULL;

ROLLBACK TRANSACTION;


-- 4 --
BEGIN TRANSACTION;

UPDATE MOVIEEXEC
SET NAME = 'Pres. ' + NAME
WHERE CERT# IN (SELECT PRESC#
				FROM STUDIO);

ROLLBACK TRANSACTION;
