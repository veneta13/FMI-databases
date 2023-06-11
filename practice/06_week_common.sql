-- SHIPS --

use ships;

-- 1 --
SELECT BATTLE, COUNT(*) AS COUNT_SUNK
FROM OUTCOMES
JOIN SHIPS ON NAME = SHIP
JOIN CLASSES ON CLASSES.CLASS = SHIPS.CLASS
WHERE COUNTRY = 'USA' AND RESULT = 'sunk'
GROUP BY BATTLE;

-- 2 --
SELECT DISTINCT BATTLE
FROM OUTCOMES
JOIN SHIPS ON NAME = SHIP
JOIN CLASSES ON CLASSES.CLASS = SHIPS.CLASS
GROUP BY COUNTRY, BATTLE
HAVING COUNT(*) >= 3;

-- 3 --
SELECT DISTINCT CLASS
FROM SHIPS
WHERE CLASS NOT IN (SELECT DISTINCT CLASS
					FROM SHIPS
					WHERE LAUNCHED > 1921);

-- 4 --
SELECT DISTINCT NAME, COUNT(BATTLE) AS COUNT
FROM SHIPS
LEFT JOIN OUTCOMES ON NAME = SHIP AND RESULT = 'damaged'
GROUP BY NAME;

-- 5 --
SELECT COUNTRY, COUNT(SHIPS.NAME) AS COUNT_ALL, COUNT(OUTCOMES.SHIP) AS COUNT_SUNK
FROM CLASSES
LEFT JOIN SHIPS ON CLASSES.CLASS = SHIPS.CLASS
LEFT JOIN OUTCOMES ON NAME = SHIP AND RESULT = 'sunk'
GROUP BY COUNTRY;

-- 6 --
SELECT COUNTRY, COUNT(DISTINCT d.SHIP) AS COUNT_DAMAGED, COUNT(DISTINCT s.SHIP) AS COUNT_SUNK
FROM CLASSES
LEFT JOIN SHIPS ON CLASSES.CLASS = SHIPS.CLASS
LEFT JOIN OUTCOMES d ON d.SHIP = NAME AND d.RESULT = 'damaged'
LEFT JOIN OUTCOMES S ON s.SHIP = NAME AND s.RESULT = 'sunk'
GROUP BY COUNTRY;

-- 7 --
SELECT CLASS, SUM(CASE result WHEN 'ok' THEN 1 ELSE 0 END) AS COUNT_OK
FROM SHIPS
LEFT JOIN OUTCOMES ON SHIP = NAME
GROUP BY CLASS
HAVING COUNT(DISTINCT NAME) >= 3;

-- 8 --
SELECT NAME, LAUNCHED
FROM SHIPS
WHERE CLASS NOT LIKE '%i%' AND CLASS NOT LIKE '%k%'
ORDER BY LAUNCHED DESC;

-- 9 --
SELECT DISTINCT BATTLE
FROM OUTCOMES
JOIN SHIPS ON NAME = SHIP
JOIN CLASSES ON CLASSES.CLASS = SHIPS.CLASS
WHERE COUNTRY = 'Japan' AND RESULT = 'damaged';

-- 10 --
SELECT DISTINCT BATTLE, s1.CLASS
FROM OUTCOMES
JOIN SHIPS ON NAME = SHIP
JOIN CLASSES s1 ON SHIPS.CLASS = s1.CLASS
WHERE LAUNCHED = (SELECT LAUNCHED + 1
				  FROM SHIPS
				  WHERE NAME = 'Rodney')
AND s1.NUMGUNS > (SELECT AVG(NUMGUNS)
				  FROM CLASSES
				  WHERE COUNTRY = s1.COUNTRY
				  GROUP BY COUNTRY);

-- 11 --
SELECT CLASSES.CLASS 
FROM SHIPS
JOIN CLASSES ON CLASSES.CLASS = SHIPS.CLASS
WHERE COUNTRY = 'USA'
GROUP BY CLASSES.CLASS
HAVING MAX(LAUNCHED) - MIN(LAUNCHED) > 10;

-- 12 --
SELECT DISTINCT BATTLE, COUNT(*) / COUNT(DISTINCT COUNTRY) AS AVG_SHIPS
FROM OUTCOMES
JOIN SHIPS ON SHIP = NAME
JOIN CLASSES ON CLASSES.CLASS = SHIPS.CLASS
GROUP BY BATTLE;

-- 13 --
SELECT 
	DISTINCT COUNTRY,
	COUNT(DISTINCT s1.NAME) AS COUNT_ALL,
	COUNT(DISTINCT o1.BATTLE) AS COUNT_BATTLES,
	COUNT(DISTINCT o2.BATTLE) AS COUNT_SUNK
FROM CLASSES
LEFT JOIN SHIPS s1 ON s1.CLASS = CLASSES.CLASS
LEFT JOIN OUTCOMES o1 ON s1.NAME = o1.SHIP
LEFT JOIN OUTCOMES o2 ON s1.NAME = o2.SHIP AND o2.RESULT = 'sunk'
GROUP BY COUNTRY;

-- MOVIES --

use movies;

-- 1 --
SELECT DISTINCT NAME, BIRTHDATE, STUDIONAME
FROM MOVIESTAR m1
LEFT JOIN STARSIN ON STARNAME = NAME
LEFT JOIN MOVIE ON 
	TITLE = MOVIETITLE
	AND YEAR = MOVIEYEAR
	AND STUDIONAME = (SELECT TOP 1 STUDIONAME
					  FROM MOVIE
					  JOIN STARSIN ON TITLE = MOVIETITLE AND YEAR = MOVIEYEAR
					  WHERE STARNAME = m1.NAME
					  GROUP BY STUDIONAME
					  ORDER BY COUNT(*) DESC);

-- 2 --
SELECT DISTINCT MOVIETITLE, MOVIEYEAR
FROM STARSIN
WHERE STARNAME NOT LIKE '%k%' AND STARNAME NOT LIKE '%b%' AND MOVIEYEAR < 1982
ORDER BY MOVIEYEAR ASC;

-- 3 --
SELECT TITLE, LENGTH / 60 AS LENGTH
FROM MOVIE
WHERE 
YEAR = (SELECT YEAR
		FROM MOVIE
		WHERE TITLE = 'Terms of Endearment')
AND (LENGTH < (SELECT LENGTH
			   FROM MOVIE
			   WHERE TITLE = 'Terms of Endearment')
OR LENGTH IS NULL);

-- 4 --
SELECT MOVIESTAR.NAME
FROM MOVIESTAR
JOIN STARSIN s1 ON s1.STARNAME = NAME AND s1.MOVIEYEAR < 1980
JOIN STARSIN s2 ON s2.STARNAME = NAME AND s2.MOVIEYEAR > 1985
JOIN MOVIEEXEC ON MOVIEEXEC.NAME = MOVIESTAR.NAME;

-- 5 --
SELECT TITLE
FROM MOVIE m1
WHERE INCOLOR = 'n' AND YEAR < (SELECT MIN(YEAR)
								FROM MOVIE
								WHERE INCOLOR = 'y' AND STUDIONAME = m1.STUDIONAME
								GROUP BY STUDIONAME);

-- 6 --
SELECT NAME, ADDRESS
FROM STUDIO
LEFT JOIN MOVIE ON NAME = STUDIONAME
LEFT JOIN STARSIN ON MOVIETITLE = TITLE AND MOVIEYEAR = YEAR
GROUP BY NAME, ADDRESS
HAVING COUNT(DISTINCT STARNAME) < 5
ORDER BY COUNT(DISTINCT STARNAME);

-- 7 --
SELECT NAME, COUNT(DISTINCT STUDIONAME) AS COUNT
FROM MOVIESTAR
JOIN STARSIN ON STARNAME = NAME
JOIN MOVIE ON TITLE = MOVIETITLE AND YEAR = MOVIEYEAR
GROUP BY NAME;

-- 8 --
SELECT NAME, COUNT(DISTINCT STUDIONAME) AS COUNT
FROM MOVIESTAR
LEFT JOIN STARSIN ON STARNAME = NAME
LEFT JOIN MOVIE ON TITLE = MOVIETITLE AND YEAR = MOVIEYEAR
GROUP BY NAME;

-- 9 --
SELECT STARNAME
FROM STARSIN
WHERE MOVIEYEAR > 1990
GROUP BY STARNAME
HAVING COUNT(*) >= 3;

-- PC --

use pc;

-- 1 --
SELECT MAKER, COUNT(DISTINCT PC.MODEL) AS COUNT
FROM PRODUCT
JOIN PRINTER ON PRODUCT.MODEL = PRINTER.MODEL
LEFT JOIN PC ON PC.MODEL = PRODUCT.MODEL
WHERE PRINTER.TYPE = 'Laser'
GROUP BY MAKER
HAVING COUNT(*) >= 2;

-- 2 --
SELECT MAKER, AVG(PRICE)
FROM PRODUCT p1
JOIN PC ON p1.MODEL = PC.MODEL
GROUP BY MAKER
HAVING AVG(PRICE) < (SELECT AVG(PRICE)
					 FROM PRODUCT
					 JOIN LAPTOP ON PRODUCT.MODEL = LAPTOP.MODEL
					 WHERE MAKER = p1.MAKER);

-- 3 --
SELECT PC.MODEL
FROM PC
JOIN PRODUCT p1 ON p1.MODEL = PC.MODEL
GROUP BY PC.MODEL, MAKER
HAVING AVG(PRICE) < (SELECT TOP 1 PRICE
					 FROM LAPTOP
					 JOIN PRODUCT ON PRODUCT.MODEL = LAPTOP.MODEL
					 WHERE p1.MAKER = MAKER
					 ORDER BY PRICE ASC);

-- 4 --
SELECT MODEL
FROM PC
GROUP BY MODEL
ORDER BY MAX(PRICE);
