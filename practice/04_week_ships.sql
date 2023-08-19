use ships;

-- 1 --
SELECT DISTINCT NAME, COUNTRY, NUMGUNS, LAUNCHED
FROM SHIPS
JOIN CLASSES ON SHIPS.CLASS = CLASSES.CLASS;

-- 2 --
SELECT DISTINCT OUTCOMES.SHIP
FROM OUTCOMES
JOIN BATTLES ON BATTLES.NAME = OUTCOMES.BATTLE AND YEAR(DATE) = 1942;
