
SET SQL_SAFE_UPDATES= 1;
-- CTE
-- STORE PROCEDURE
-- STRING SUBSTRING
-- TRIGGERS EVENTS


SELECT * FROM layoffs;


SELECT COUNT(DISTINCT location)  
  AS Distinct_location 
FROM
  layoffs;


SELECT * FROM layoffs;

CREATE TABLE staging_database 
LIKE layoffs;

DROP TABLE staging_database;

CREATE TABLE layoffs_staging
LIKE layoffs;

SELECT * FROM layoffs_staging;

INSERT INTO  layoffs_staging 
SELECT * 
FROM  layoffs;
SELECT * FROM layoffs_staging;


SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company,location,industry,total_laid_off,`date`,stage,country,funds_raised_millions) AS row_num
FROM layoffs_staging;

-- CTEs

WITH duplicate_cte AS  (
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company,location,industry,total_laid_off,`date`,stage,country,funds_raised_millions) AS row_num
FROM layoffs_staging
)
SELECT *
FROM duplicate_cte 
WHERE row_num >1;


CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT * FROM 
layoffs_staging2;

INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company,location,industry,total_laid_off,`date`,stage,country,funds_raised_millions) AS row_num
FROM layoffs_staging;

SELECT * FROM 
layoffs_staging2
WHERE row_num >1;

DELETE FROM 
layoffs_staging2
WHERE row_num >1;
 SET SQL_SAFE_UPDATES = 0;
 
 SELECT * FROM 
layoffs_staging2;


SELECT TRIM(company)
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET company = TRIM(company);

SELECT *
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%';
 
UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';


SELECT DISTINCT COUNTRY, TRIM(TRAILING '.' FROM COUNTRY)
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM COUNTRY)
WHERE country  LIKE ' United States%';


SELECT `date`, 
STR_TO_DATE(`date`,'%m/%d/%y');


UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`,'%m/%d/%Y');

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;


SELECT  *
FROM layoffs_staging2
WHERE total_laid_off IS NULL 
AND percentage_laid_off IS NULL;

SELECT industry
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = '';


SELECT t1.industry , t2.industry
FROM layoffs_staging2 t1 
JOIN layoffs_staging2 t2
ON t1.company = t2.company
WHERE ( t1.industry IS NULL )  AND 
t2.industry IS NOT NULL;

UPDATE  layoffs_staging2 t1 
JOIN layoffs_staging2 t2
ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE ( t1.industry IS NULL )  AND 
t2.industry IS NOT NULL;


DELETE 
FROM layoffs_staging2
WHERE total_laid_off IS NULL 
AND percentage_laid_off IS NULL;

ALTER TABLE layoffs_staging2
DROP  COLUMN row_num;
 
 SELECT *
 FROM layoffs_staging2;
 
 
 
 SELECT MAX(total_laid_off) , MAX(percentage_laid_off)
 FROM layoffs_staging2;
 
 SELECT * FROM layoffs_staging2
 WHERE percentage_laid_off = 1
 ORDER BY total_laid_off DESC;
 
 
 SELECT industry ,SUM(total_laid_off)
 FROM layoffs_staging2
 GROUP BY  industry
 ORDER BY  2 DESC;
 
 SELECT  company ,SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC ;
 
 
 SELECT country ,SUM(total_laid_off)
 FROM layoffs_staging2
 GROUP BY  country
 ORDER BY  2 DESC;
 
 SELECT `date` ,SUM(total_laid_off)
 FROM layoffs_staging2
 GROUP BY `date`
 ORDER BY 1 DESC;
 
  SELECT YEAR(`date`) ,SUM(total_laid_off)
 FROM layoffs_staging2
 GROUP BY YEAR(`date`)
 ORDER BY 1 DESC;


SELECT AVG(percentage_laid_off)
FROM layoffs_staging2;

SELECT AVG(total_laid_off)
FROM layoffs_staging2;

SELECT  company , AVG(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

SELECT  industry , AVG(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;