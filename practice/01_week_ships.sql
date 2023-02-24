use ships;

-- 1 --
SELECT CLASS, COUNTRY
FROM CLASSES
WHERE NUMGUNS < 10;

-- 2 --
SELECT NAME AS shipName
FROM SHIPS
WHERE LAUNCHED < 1918;

-- 3 --
SELECT SHIP, BATTLE
FROM OUTCOMES
WHERE RESULT = 'sunk';

-- 4 --
SELECT NAME
FROM SHIPS
WHERE CLASS = NAME;

-- 5 --
SELECT NAME
FROM SHIPS
WHERE NAME LIKE 'R%';

-- 6 --
SELECT NAME
FROM SHIPS
WHERE NAME LIKE '% %'
AND NAME NOT LIKE '% % %';
