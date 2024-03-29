use pc;

-- 1 --
SELECT DISTINCT PRODUCT.MODEL, PRICE
FROM PRODUCT
LEFT JOIN PC ON PRODUCT.MODEL = PC.MODEL
WHERE product.TYPE = 'PC';

-- 2 --
SELECT PRODUCT.MODEL, MAKER, TYPE
FROM PRODUCT
LEFT JOIN (
			(SELECT MODEL, CODE FROM PC)
			 UNION
			(SELECT MODEL, CODE FROM LAPTOP)
			 UNION
			(SELECT MODEL, CODE FROM PRINTER)
		   ) models ON models.MODEL = PRODUCT.MODEL
WHERE models.CODE IS NULL;
