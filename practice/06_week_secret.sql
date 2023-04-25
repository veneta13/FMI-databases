-- PC --

use pc;

-- 1 --
SELECT MODEL
FROM PC
GROUP BY MODEL
HAVING MAX(HD) - MIN(HD) >= 20;

-- SHIPS --

use ships;

-- 1 --
SELECT SHIP
FROM OUTCOMES
JOIN BATTLES ON BATTLE = NAME
GROUP BY SHIP
HAVING MAX(YEAR(DATE)) - MIN(YEAR(DATE)) >= 2;

-- 2 --
SELECT YEAR(DATE) AS YEAR, COUNT(*) AS COUNT
FROM BATTLES
LEFT JOIN SHIPS ON YEAR(DATE) = LAUNCHED
GROUP BY YEAR(DATE);

-- 3 --
SELECT SHIPS.NAME, YEAR(DATE) - LAUNCHED
FROM SHIPS
JOIN OUTCOMES ON SHIP = NAME
JOIN BATTLES ON BATTLES.NAME = BATTLE
WHERE RESULT = 'sunk';

-- 4 --
SELECT
	CLASSES.CLASS,
	SUM(CASE o1.RESULT
			WHEN 'ok' THEN 1
			ELSE 0
		END) -
	SUM(CASE o2.RESULT
			WHEN 'sunk' THEN 1
			ELSE 0
		END) AS DIFF
FROM CLASSES
LEFT JOIN SHIPS ON CLASSES.CLASS = SHIPS.CLASS
LEFT JOIN OUTCOMES o1 ON o1.SHIP = SHIPS.NAME
LEFT JOIN OUTCOMES o2 ON o2.SHIP = SHIPS.NAME
GROUP BY CLASSES.CLASS;