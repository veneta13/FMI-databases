use movies;

GO

-- 1 --
CREATE VIEW movies_1
AS
SELECT NAME, BIRTHDATE
FROM MOVIESTAR
WHERE GENDER = 'F';

GO

-- 2 --
CREATE VIEW movies_2(NAME, MOVIE_COUNT)
AS
SELECT NAME, COUNT(MOVIETITLE)
FROM MOVIESTAR
LEFT JOIN STARSIN ON STARNAME = NAME
GROUP BY NAME;
