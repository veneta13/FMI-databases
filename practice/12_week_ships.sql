use ships;
GO

-- 1 --
CREATE TRIGGER max35000
ON CLASSES
INSTEAD OF INSERT
AS
	IF (SELECT TOP 1 DISPLACEMENT
		FROM INSERTED) > 35000
		BEGIN
			INSERT INTO CLASSES
			SELECT CLASS, TYPE, COUNTRY, NUMGUNS, BORE, 35000
			FROM INSERTED;
		END
	ELSE
		BEGIN
			INSERT INTO CLASSES
			SELECT *
			FROM INSERTED;
		END;
GO

DROP TRIGGER max35000;
GO

-- 2 --
CREATE VIEW class_ship
AS
	SELECT CLASSES.CLASS, COUNT(SHIPS.NAME) AS SHIPS
	FROM CLASSES
	LEFT JOIN SHIPS ON CLASSES.CLASS = SHIPS.CLASS
	GROUP BY CLASSES.CLASS;
GO

CREATE TRIGGER deleteships
ON class_ship
INSTEAD OF DELETE
AS
BEGIN
	DELETE FROM SHIPS
	WHERE CLASS IN (SELECT CLASS
					FROM DELETED);
	DELETE FROM CLASSES
	WHERE CLASS IN (SELECT CLASS
					FROM DELETED)
END;
GO

DROP TRIGGER deleteships;
GO

DROP VIEW class_ship;
GO

-- 3 --
CREATE TRIGGER nomorethan2
ON SHIPS
AFTER INSERT, UPDATE
AS
	IF EXISTS (SELECT *
			   FROM SHIPS
			   GROUP BY CLASS
			   HAVING COUNT(*) > 2)
	BEGIN
		ROLLBACK;
	END;
GO

DROP TRIGGER nomorethan2;
GO

-- 4 --
CREATE TRIGGER numguns
ON OUTCOMES
AFTER INSERT, UPDATE
AS
	IF EXISTS (SELECT *
			   FROM OUTCOMES o1
			   JOIN SHIPS s1 ON o1.SHIP = s1.NAME
			   JOIN CLASSES c1 ON c1.CLASS = s1.CLASS
			   JOIN OUTCOMES o2 ON o1.BATTLE = o2.BATTLE
			   JOIN SHIPS s2 ON o2.SHIP = s2.NAME
			   JOIN CLASSES c2 ON c2.CLASS = s2.CLASS
			   WHERE c1.NUMGUNS > 9 AND c2.NUMGUNS < 9)
	BEGIN
		ROLLBACK;
	END;
GO

DROP TRIGGER numguns;
GO

-- 5 --
CREATE TRIGGER alreadysunk_o
ON OUTCOMES
AFTER UPDATE, INSERT
AS
	IF EXISTS (SELECT *
			   FROM OUTCOMES o1
			   JOIN OUTCOMES o2 ON o1.SHIP = o2.SHIP
			   JOIN BATTLES b1 ON o1.BATTLE = b1.NAME
			   JOIN BATTLES b2 ON o2.BATTLE = b2.NAME
			   WHERE o1.RESULT = 'sunk'
			   AND b1.DATE < b2.DATE)
	BEGIN
		ROLLBACK;
	END;
GO

CREATE TRIGGER alreadysunk_b
ON BATTLES
AFTER UPDATE
AS
	IF EXISTS (SELECT *
			   FROM OUTCOMES o1
			   JOIN OUTCOMES o2 ON o1.SHIP = o2.SHIP
			   JOIN BATTLES b1 ON o1.BATTLE = b1.NAME
			   JOIN BATTLES b2 ON o2.BATTLE = b2.NAME
			   WHERE o1.RESULT = 'sunk'
			   AND b1.DATE < b2.DATE)
	BEGIN
		ROLLBACK;
	END;
GO

DROP TRIGGER alreadysunk_o;
DROP TRIGGER alreadysunk_b;
GO
