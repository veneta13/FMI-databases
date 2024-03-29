use pc;
GO

-- 1 --
CREATE TRIGGER addpc
ON LAPTOP
AFTER DELETE
AS
	INSERT INTO PC
	SELECT CODE + 100, '1121', SPEED, RAM, HD, '52x', PRICE 
	FROM DELETED
	WHERE MODEL IN (SELECT MODEL
					FROM PRODUCT
				    WHERE MAKER = 'D');
GO

DROP TRIGGER addpc;
GO 

-- 2 --

CREATE TRIGGER nocheaper
ON PC
AFTER UPDATE
AS
	IF EXISTS (SELECT *
				FROM PC p
				WHERE EXISTS(SELECT *
							 FROM PC
							 WHERE PRICE < p.PRICE
							 AND SPEED = p.SPEED)
				AND CODE IN (SELECT i.CODE
							 FROM DELETED d
							 JOIN INSERTED i ON d.CODE = i.code
							 WHERE d.PRICE != i.PRICE))
	BEGIN
		ROLLBACK;
	END;
GO

DROP TRIGGER nocheaper;
GO

-- 3 --
CREATE TRIGGER noprinter
ON PRODUCT
AFTER INSERT, UPDATE
AS
	IF EXISTS(SELECT *
			  FROM PRODUCT p1
			  JOIN PRODUCT p2 ON p1.MAKER = p2.MAKER
			  WHERE p1.TYPE = 'Printer'
			  AND p2.TYPE = 'PC'
			  )
	BEGIN
		ROLLBACK;
	END;
GO

DROP TRIGGER noprinter;
GO

-- 4 --
CREATE TRIGGER andlaptop
ON PRODUCT
AFTER INSERT, UPDATE, DELETE
AS
	IF NOT EXISTS(SELECT *
				   FROM PRODUCT p1
				   JOIN LAPTOP ON LAPTOP.MODEL = p1.MODEL
				   JOIN PRODUCT p2 ON p1.MAKER = p2.MAKER
				   JOIN PC ON PC.MODEL = p2.MODEL 
				   WHERE p1.TYPE = 'Laptop'
				   AND p2.TYPE = 'PC'
				   AND PC.SPEED <= LAPTOP.SPEED
				   )
	BEGIN
		ROLLBACK;
	END;
GO

DROP TRIGGER andlaptop;
GO

-- 5 --
CREATE TRIGGER price2000
ON LAPTOP
AFTER UPDATE
AS
	IF EXISTS(SELECT MAKER
			   FROM PRODUCT
			   JOIN LAPTOP ON LAPTOP.MODEL = PRODUCT.MODEL
			   GROUP BY MAKER
			   HAVING AVG(PRICE) < 2000
			   )
	BEGIN
		ROLLBACK;
	END;
GO

DROP TRIGGER price2000;
GO

-- 6 --
CREATE TRIGGER morememory
ON LAPTOP
AFTER UPDATE, INSERT
AS
	IF EXISTS(SELECT *
			  FROM PC
			  WHERE PC.RAM < (SELECT DISTINCT RAM
							  FROM INSERTED)
			  AND PC.PRICE < (SELECT DISTINCT PRICE
							  FROM INSERTED))
	BEGIN
		ROLLBACK;
	END;
GO

DROP TRIGGER morememory;
GO

-- 7 --
CREATE TRIGGER nomatrix
ON PRINTER
INSTEAD OF INSERT
AS
	INSERT INTO PRINTER
	SELECT *
	FROM INSERTED
	WHERE COLOR != 'y'
	OR TYPE != 'Matrix';
GO

DROP TRIGGER nomatrix;
GO
