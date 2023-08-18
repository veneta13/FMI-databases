use pc;

-- 1 --
SELECT DISTINCT MAKER
FROM PRODUCT
WHERE MODEL IN (SELECT MODEL
				FROM PC
				WHERE SPEED > 500);

-- 2 --
SELECT *
FROM LAPTOP
WHERE PRICE < ANY(SELECT PRICE
				  FROM PC);

-- 3 --
SELECT TOP 1 MODEL
FROM (
	  (
		  SELECT MODEL, PRICE
		  FROM LAPTOP
	  )
	  UNION
	  (
		  SELECT MODEL, PRICE
		  FROM PC
	  )
	  UNION
	  (
		  SELECT MODEL, PRICE
		  FROM PRINTER)
	  ) allProducts
ORDER BY PRICE DESC;

-- 4 --
SELECT DISTINCT MAKER
FROM PRODUCT
JOIN PRINTER ON PRINTER.MODEL = PRODUCT.MODEL
WHERE PRINTER.COLOR = 'y'
AND PRINTER.PRICE <= ALL(SELECT PRICE
						 FROM PRINTER
						 WHERE COLOR = 'y');

-- 5 --
SELECT DISTINCT MAKER
FROM PRODUCT
JOIN PC ON PC.MODEL = PRODUCT.MODEL
WHERE RAM <= ALL(SELECT RAM
				 FROM PC)
AND SPEED >= ALL(SELECT SPEED
				 FROM PC
				 WHERE RAM <= ALL(SELECT RAM
								  FROM PC));

