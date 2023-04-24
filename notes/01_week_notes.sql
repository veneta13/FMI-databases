use movies;

-- PROJECTION --
SELECT STUDIONAME, TITLE 
FROM MOVIE;

SELECT TITLE, LENGTH / 60.0 as HOURS
FROM MOVIE;

-- SELECTION --
SELECT * FROM MOVIE
WHERE STUDIONAME = 'Disney'
AND YEAR = 1990;

-- STRING COMPARISON --
SELECT *
FROM MOVIE
WHERE TITLE LIKE 'Star %_';

-- DATE AND TIME --
SELECT *
FROM MOVIESTAR
WHERE BIRTHDATE > '1970-06-01';

SELECT NAME, YEAR(BIRTHDATE)
FROM MOVIESTAR
WHERE MONTH(BIRTHDATE) = 7;

-- NULL VALUES --
SELECT *
FROM MOVIE
WHERE LENGTH IS NULL;

-- SORTING --
SELECT TITLE, YEAR, LENGTH
FROM MOVIE
WHERE LENGTH > 60
ORDER BY LENGTH DESC, TITLE;

SELECT *
FROM MOVIESTAR
ORDER BY MONTH(BIRTHDATE);