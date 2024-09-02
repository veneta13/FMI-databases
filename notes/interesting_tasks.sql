-- Some tasks I find more important / challenging than the others.

use pc;

-- 2.PC.2

--Напишете заявка, която извежда номер на модел
--и цена на всички продукти, произведени от
--производител с име ‘B’. Сортирайте резултата
--така, че първо да се изведат най-скъпите
--продукти.

--(
--	SELECT LAPTOP.MODEL, PRICE
--	FROM LAPTOP
--	JOIN PRODUCT ON LAPTOP.MODEL = PRODUCT.MODEL
--	WHERE MAKER = 'B'
--)
--UNION
--(
--	SELECT PC.MODEL, PRICE
--	FROM PC
--	JOIN PRODUCT ON PC.MODEL = PRODUCT.MODEL
--	WHERE MAKER = 'B'
--)
--UNION
--(
--	SELECT PRINTER.MODEL, PRICE
--	FROM PRINTER
--	JOIN PRODUCT ON PRINTER.MODEL = PRODUCT.MODEL
--	WHERE MAKER = 'B'
--)
--ORDER BY PRICE;

-- 2.pc.4
--Напишете заявка, която извежда всички двойки
--модели на компютри, които имат еднаква честота
--на процесора и памет. Двойките трябва да се
--показват само по веднъж, например ако вече е
--изведена двойката (i, j), не трябва да се извежда
--(j, i).

--SELECT DISTINCT p1.MODEL, p2.MODEL
--FROM PC p1
--JOIN PC p2 ON p1.SPEED = p2.SPEED AND p1.RAM = p2.RAM
--WHERE p1.MODEL < p2.model;

-- 2.pc.5

--Напишете заявка, която извежда
--производителите на поне два различни
--компютъра с честота на процесора поне 500 MHz.

--SELECT DISTINCT p1.MAKER
--FROM PC pc1
--JOIN PRODUCT p1 ON pc1.MODEL = p1.MODEL
--JOIN PRODUCT p2 ON p1.MAKER = p2.MAKER
--JOIN PC pc2 ON pc2.MODEL = p2.MODEL
--WHERE 
--	NOT (pc1.CODE = pc2.CODE)
--	AND pc1.SPEED >= 500
--	AND pc2.SPEED >= 500;


-- 3.pc.3

--Напишете заявка, която извежда модела на
--продукта (PC, лаптоп или принтер) с най-висока цена.

--SELECT TOP 1 MODEL
--FROM (
--	  (
--		  SELECT MODEL, PRICE
--		  FROM LAPTOP
--	  )
--	  UNION
--	  (
--		  SELECT MODEL, PRICE
--		  FROM PC
--	  )
--	  UNION
--	  (
--		  SELECT MODEL, PRICE
--		  FROM PRINTER)
--	  ) allProducts
--ORDER BY PRICE DESC;

use ships;

-- 4 - пример от упражнение

--За всяка държава да се изведат имената на корабите, които
--никога не са участвали в битка.

--select country, name
--from classes
--join ships on classes.class = ships.class
--left join outcomes on name = ship
--where outcomes.ship is null;

--select country, name
--from outcomes
--right join ships on ship = name
--join classes on classes.class = ships.class
--where outcomes.ship is null;

use movies;

-- 4 - пример от упражнение

--За всеки актьор и/или продуцент да се изведе името му,
--рождената му дата и networth.

--SELECT COALESCE(ms.name, me.name) AS name, ms.birthdate, me.networth
--FROM moviestar ms
--FULL JOIN movieexec me ON ms.name = me.name;

-- 4 - пример от упражение

-- За всяка държава да се изведат имената на корабите, които
-- никога не са участвали в битка.

-- DONE

-- 4 - пример от упражение

--За всеки клас да се изведат името му, държавата и имената
--на всички негови кораби, пуснати през 1916 г.

--use ships;

--select CLASSES.CLASS, country, ships.NAME
--from classes
--left join ships on CLASSES.CLASS = SHIPS.CLASS and LAUNCHED = 1916;

-- 4.movies.6

-- Напишете заявка, която извежда имената
--на актьорите, които не са участвали в
--нито един филм.

--SELECT NAME
--FROM MOVIESTAR
--LEFT JOIN STARSIN ON STARNAME = NAME
--WHERE MOVIETITLE IS NULL;

use pc;

-- 4.pc.2

--Напишете заявка, която извежда
--производител, модел и тип на
--продукт за тези производители,
--за които съответният продукт не
--се продава (няма го в таблиците
--PC, Laptop или Printer).

--SELECT PRODUCT.MODEL, MAKER, TYPE
--FROM PRODUCT
--LEFT JOIN (
--			(SELECT MODEL, CODE FROM PC)
--			 UNION
--			(SELECT MODEL, CODE FROM LAPTOP)
--			 UNION
--			(SELECT MODEL, CODE FROM PRINTER)
--		   ) models ON models.MODEL = PRODUCT.MODEL
--WHERE models.CODE IS NULL;


use ships;

-- 4.c.ships.4

-- Всички държави, които нямат нито един потънал кораб.

--SELECT distinct COUNTRY
--FROM CLASSES
--WHERE COUNTRY NOT IN (SELECT DISTINCT COUNTRY
--					  FROM CLASSES
--					  JOIN SHIPS ON CLASSES.CLASS = SHIPS.CLASS
--					  JOIN OUTCOMES ON SHIPS.NAME = OUTCOMES.SHIP
--					  WHERE RESULT = 'sunk');

-- 4.c.ships.5

--(От държавен изпит) Имената на класовете, за които няма кораб, пуснат на вода
--(launched) след 1921 г. Ако за класа няма пуснат никакъв кораб, той също трябва
--да излезе в резултата.

--SELECT *
--FROM CLASSES
--LEFT JOIN SHIPS ON SHIPS.CLASS = CLASSES.CLASS AND LAUNCHED > 1921
--WHERE NAME IS NULL;

-- 4.c.ships.6

--Името, държавата и калибъра (bore) на всички класове кораби с 6, 8 или 10
--оръдия. Калибърът да се изведе в сантиметри (1 инч е приблизително 2.54 см).


--SELECT CLASS, COUNTRY, BORE * 2.54 AS BORE
--FROM CLASSES
--WHERE NUMGUNS IN (6, 8, 10);

-- 4.c.ships.7

--Държавите, които имат класове с различен калибър (напр. САЩ имат клас с 14
--калибър и класове с 16 калибър, докато Великобритания има само класове с 15).

--SELECT DISTINCT c1.COUNTRY
--FROM CLASSES c1
--JOIN CLASSES c2 ON c1.COUNTRY = c2.COUNTRY AND c1.BORE < c2.BORE;

use movies;

-- 5 - пример от упражнение

--За всяка филмова звезда да се изведе броят на
--филмите, в които се е снимала.
--Ако за дадена звезда не знаем какви филми има, за нея
--да се изведе 0.

--SELECT name, COUNT(starname) as moviesCount
--FROM MovieStar
--LEFT JOIN StarsIn ON name = starname
--GROUP BY name;


-- 5 - пример от упражнение

--Да се изведе средният брой филми, в които са се снимали
--актьорите.

--SELECT AVG(moviescount)
--FROM (SELECT COUNT(movietitle) AS moviescount
--	  FROM MovieStar
--	  LEFT JOIN StarsIn ON name = starname
--	  GROUP BY name) stat;


-- 5.movies.2

--За всеки актьор/актриса изведете броя на
--различните студиа, с които са записвали филми,
--включително и за тези, за които нямаме
--информация в кои филми са играли

--SELECT NAME, COUNT(DISTINCT STUDIONAME) AS COUNT_STUDIOS
--FROM MOVIESTAR
--LEFT JOIN STARSIN ON STARNAME = NAME
--LEFT JOIN MOVIE ON TITLE = MOVIETITLE AND YEAR = MOVIEYEAR
--GROUP BY NAME;

use pc;

-- 5.pc.5

--Напишете заявка, която извежда средната цена на компютрите и
--лаптопите на производител ‘B’ (едно число).

--SELECT AVG(PRICE) AS AVG_PRICE
--FROM (
--	(
--		SELECT PRICE
--		FROM PC
--		JOIN PRODUCT ON PC.MODEL = PRODUCT.MODEL
--		WHERE MAKER = 'B'
--	)
--	 UNION ALL
--	(
--		SELECT PRICE
--		FROM LAPTOP
--		JOIN PRODUCT ON LAPTOP.MODEL = PRODUCT.MODEL
--		WHERE MAKER = 'B'
--	)
--) unionB;

--5.pc.8

--Напишете заявка, която извежда производителите на компютрите с
--най-висока цена.


--SELECT DISTINCT MAKER
--FROM PRODUCT
--JOIN PC ON PC.MODEL = PRODUCT.MODEL
--WHERE PRICE = (SELECT MAX(PRICE)
--			   FROM PC);

--5.pc.11

--Напишете заявка, която за всеки размер на лаптоп намира
--разликата в цената на най-скъпия и най-евтиния лаптоп със същия
--размер.

--SELECT SCREEN, (MAX(PRICE) - MIN(PRICE)) AS PRICE_DIFFERENCE
--FROM LAPTOP
--GROUP BY SCREEN;

--5.pc.12

--Да се изведат различните модели компютри,
--подредени по цена на най-скъпия конкретен
--компютър от даден модел.

--SELECT MODEL
--FROM PC
--GROUP BY MODEL
--ORDER BY MAX(PRICE);

use ships;

--5.ships.3

--Напишете заявка, която извежда за всеки
--клас първата и последната година, в която
--кораб от съответния клас е пуснат на вода.

--SELECT CLASSES.CLASS, MIN(LAUNCHED) AS FIRST_YEAR, MAX(LAUNCHED) AS LAST_YEAR
--FROM CLASSES
--LEFT JOIN SHIPS ON CLASSES.CLASS = SHIPS.CLASS
--GROUP BY CLASSES.CLASS;

--5.ships.4

--Напишете заявка, която за всеки клас
--извежда броя на корабите, потънали в
--битка.

--SELECT CLASSES.CLASS, COUNT(BATTLE) AS SUNK_COUNT
--FROM CLASSES
--LEFT JOIN SHIPS ON CLASSES.CLASS = SHIPS.CLASS
--LEFT JOIN OUTCOMES ON SHIP = NAME AND RESULT = 'sunk'
--GROUP BY CLASSES.CLASS;

--5.ships.5

--Напишете заявка, която за всеки клас с над
--4 пуснати на вода кораба извежда броя на
--корабите, потънали в битка.

--SELECT CLASS, COUNT(RESULT) AS SUNK_COUNT
--FROM SHIPS
--LEFT JOIN OUTCOMES ON SHIP = NAME AND RESULT = 'sunk'
--WHERE CLASS IN (SELECT CLASS
--				FROM SHIPS
--				GROUP BY CLASS
--				HAVING COUNT(*) >= 4)
--GROUP BY CLASS;

use pc;

-- 6 - пример от упражнение

--Да преброим колко лаптопа има във всяка ценова категория.
--Защо не може да се ползва GROUP BY price_rank?

--SELECT CASE
--	   WHEN price < 900 THEN 'LOW'
--	   WHEN price > 1100 THEN 'HIGH'
--	   ELSE 'AVERAGE'
--	   END 
--AS price_rank, COUNT(*) AS num_laptops
--FROM laptop
--GROUP BY CASE
--		 WHEN price < 900 THEN 'LOW'
--		 WHEN price > 1100 THEN 'HIGH'
--		 ELSE 'AVERAGE'
--		 END;

use ships;

-- Да се изведат имената на корабите, които са участвали в битки в
-- продължение поне на две години.

--SELECT SHIP
--FROM OUTCOMES
--JOIN BATTLES ON BATTLE = NAME
--GROUP BY SHIP
--HAVING MAX(YEAR(DATE)) - MIN(YEAR(DATE)) >= 2;

-- За всяка година, в която е проведена битка, да се изведе броят на
-- корабите, пуснати на вода през тази година.

--SELECT YEAR(DATE) AS YEAR, COUNT(SHIPS.NAME) AS COUNT
--FROM BATTLES
--LEFT JOIN SHIPS ON YEAR(DATE) = LAUNCHED
--GROUP BY YEAR(DATE);

-- За всеки потънал кораб колко години са минали от пускането му на вода до потъването (year(date)-launched)

--SELECT SHIPS.NAME, YEAR(DATE) - LAUNCHED
--FROM SHIPS
--JOIN OUTCOMES ON SHIP = NAME
--JOIN BATTLES ON BATTLES.NAME = BATTLE
--WHERE RESULT = 'sunk';

-- за всеки клас - баланс между здрави и потънали кораби (например 5 ok, 10 damaged, 2 sunk - 5-2=3)
-- Забележка: ако кораб в 2 битки е бил ok, а в трета е потънал, по-лесно е да го броим като +1, а не -1

--SELECT
--	CLASSES.CLASS,
--	SUM(CASE o1.RESULT
--			WHEN 'ok' THEN 1
--			ELSE 0
--		END) -
--	SUM(CASE o2.RESULT
--			WHEN 'sunk' THEN 1
--			ELSE 0
--		END) AS DIFF
--FROM CLASSES
--LEFT JOIN SHIPS ON CLASSES.CLASS = SHIPS.CLASS
--LEFT JOIN OUTCOMES o1 ON o1.SHIP = SHIPS.NAME
--LEFT JOIN OUTCOMES o2 ON o2.SHIP = SHIPS.NAME
--GROUP BY CLASSES.CLASS;

use ships;

--6.c.ships.5

--За всяка държава да се изведе броят на корабите и броят на потъналите кораби.

--SELECT COUNTRY, COUNT(SHIPS.NAME) AS COUNT_ALL, COUNT(OUTCOMES.SHIP) AS COUNT_SUNK
--FROM CLASSES
--LEFT JOIN SHIPS ON CLASSES.CLASS = SHIPS.CLASS
--LEFT JOIN OUTCOMES ON NAME = SHIP AND RESULT = 'sunk'
--GROUP BY COUNTRY;

--6.c.ships.6

--За всяка държава да се изведе броят на повредените кораби и броят на потъналите кораби. Всяка от
--бройките може да бъде и нула.

--SELECT COUNTRY, COUNT(DISTINCT d.SHIP) AS COUNT_DAMAGED, COUNT(DISTINCT s.SHIP) AS COUNT_SUNK
--FROM CLASSES
--LEFT JOIN SHIPS ON CLASSES.CLASS = SHIPS.CLASS
--LEFT JOIN OUTCOMES d ON d.SHIP = NAME AND d.RESULT = 'damaged'
--LEFT JOIN OUTCOMES S ON s.SHIP = NAME AND s.RESULT = 'sunk'
--GROUP BY COUNTRY;

--6.c.ships.7

--Намерете за всеки клас с поне 3 кораба броя на корабите от този клас, които са победили в битка
--(result = 'ok').

--SELECT CLASS, SUM(CASE result WHEN 'ok' THEN 1 ELSE 0 END) AS COUNT_OK
--FROM SHIPS
--LEFT JOIN OUTCOMES ON SHIP = NAME
--GROUP BY CLASS
--HAVING COUNT(DISTINCT NAME) >= 3;

--6.c.ships.13

--За всяка държава да се изведе: броят на корабите от тази държава; броя на битките, в които е участвала; броя на
--битките, в които неин кораб е потънал ('sunk') (ако някоя от бройките е 0 – да се извежда 0).

--SELECT 
--	DISTINCT COUNTRY,
--	COUNT(DISTINCT s1.NAME) AS COUNT_ALL,
--	COUNT(DISTINCT o1.BATTLE) AS COUNT_BATTLES,
--	COUNT(DISTINCT o2.BATTLE) AS COUNT_SUNK
--FROM CLASSES
--LEFT JOIN SHIPS s1 ON s1.CLASS = CLASSES.CLASS
--LEFT JOIN OUTCOMES o1 ON s1.NAME = o1.SHIP
--LEFT JOIN OUTCOMES o2 ON s1.NAME = o2.SHIP AND o2.RESULT = 'sunk'
--GROUP BY COUNTRY;

use movies;

--6.c.movies.1

--За всяка филмова звезда да се изведе името, рождената дата и с кое студио е записвала най-много
--филми. (Ако има две студиа с еднакъв брой филми, да се изведе кое да е от тях).

--SELECT DISTINCT NAME, BIRTHDATE, STUDIONAME
--FROM MOVIESTAR m1
--LEFT JOIN STARSIN ON STARNAME = NAME
--LEFT JOIN MOVIE ON 
--	TITLE = MOVIETITLE
--	AND YEAR = MOVIEYEAR
--	AND STUDIONAME = (SELECT TOP 1 STUDIONAME
--					  FROM MOVIE
--					  JOIN STARSIN ON TITLE = MOVIETITLE AND YEAR = MOVIEYEAR
--					  WHERE STARNAME = m1.NAME
--					  GROUP BY STUDIONAME
--					  ORDER BY COUNT(*) DESC);

use pc;

--6.c.pc.1

--Намерете за всички производители на поне 2 лазерни принтера, броя на произвежданите от тях PC-та
--(конкретни конфигурации), евентуално 0.

--SELECT MAKER, COUNT(DISTINCT PC.MODEL) AS COUNT
--FROM PRODUCT
--JOIN PRINTER ON PRODUCT.MODEL = PRINTER.MODEL
--LEFT JOIN PC ON PC.MODEL = PRODUCT.MODEL
--WHERE PRINTER.TYPE = 'Laser'
--GROUP BY MAKER
--HAVING COUNT(*) >= 2;

--6.c.pc.2

--Да се изведат всички производители, за които средната цена на произведените компютри е по-ниска
--от средната цена на техните лаптопи.

--SELECT MAKER, AVG(PRICE)
--FROM PRODUCT p1
--JOIN PC ON p1.MODEL = PC.MODEL
--GROUP BY MAKER
--HAVING AVG(PRICE) < (SELECT AVG(PRICE)
--					 FROM PRODUCT
--					 JOIN LAPTOP ON PRODUCT.MODEL = LAPTOP.MODEL
--					 WHERE MAKER = p1.MAKER);
