use ships;

GO 

-- 1 --
CREATE VIEW BritishShips
AS
SELECT NAME, SHIPS.CLASS, TYPE, NUMGUNS, BORE, DISPLACEMENT, LAUNCHED
FROM CLASSES
JOIN SHIPS ON CLASSES.CLASS = SHIPS.CLASS
WHERE COUNTRY = 'Gt.Britain';

-- 2 --
SELECT DISTINCT NUMGUNS, DISPLACEMENT
FROM BritishShips
WHERE TYPE = 'bb'
AND LAUNCHED < 1919;

-- 3 --
SELECT DISTINCT NUMGUNS, DISPLACEMENT
FROM CLASSES
JOIN SHIPS ON CLASSES.CLASS = SHIPS.CLASS
WHERE COUNTRY = 'Gt.Britain'
AND TYPE = 'bb'
AND LAUNCHED < 1919;

-- 4 --
SELECT AVG(max_displacement)
FROM (SELECT MAX(DISPLACEMENT) AS MAX_DISPLACEMENT
      FROM CLASSES
      GROUP BY COUNTRY
	  ) AS max_displacement_table;

GO 

-- 5 --
CREATE VIEW sunk_ships
AS
SELECT DISTINCT SHIP, BATTLE
FROM OUTCOMES
WHERE RESULT = 'sunk';

-- 6 --
INSERT INTO sunk_ships
VALUES ('California', 'Guadalcanal');

-- 7 --
CREATE VIEW guns_9
AS
SELECT CLASS
FROM CLASSES
WHERE NUMGUNS > 8
WITH CHECK OPTION;

-- 8 --
CREATE VIEW guns_9
AS
SELECT CLASS
FROM CLASSES
WHERE NUMGUNS > 8;

-- 9 --
SELECT BATTLE
FROM OUTCOMES
JOIN SHIPS ON SHIP = NAME
JOIN CLASSES ON SHIPS.CLASS = CLASSES.CLASS
WHERE NUMGUNS < 9
GROUP BY BATTLE
HAVING COUNT(SHIP) > 2
AND SUM(CASE RESULT WHEN 'damaged' THEN 1 ELSE 0 END) >= 1;
