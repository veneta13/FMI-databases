use movies;

-- COALESCE returns the first non-null value from a list
SELECT COALESCE(ms.NAME, me.NAME) AS NAME, ms.BIRTHDATE, me.NETWORTH
FROM MOVIESTAR ms
FULL JOIN MOVIEEXEC me ON ms.NAME = me.NAME;

SELECT ms.NAME, me.NAME, ms.BIRTHDATE, me.NETWORTH
FROM MOVIESTAR ms
FULL JOIN MOVIEEXEC me ON ms.NAME = me.NAME;