CREATE DATABASE projects_hr;
USE projects_hr;
CREATE TABLE hr_data (
    id VARCHAR(20),
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    birthdate VARCHAR(50),
    gender VARCHAR(20),
    race VARCHAR(50),
    department VARCHAR(50),
    jobtitle VARCHAR(100),
    location VARCHAR(50),
    hire_date VARCHAR(50),
    termdate VARCHAR(100),
    location_city VARCHAR(50),
    location_state VARCHAR(50)
);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 26.7/Uploads/Human Resources.csv'
INTO TABLE hr_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;
SELECT * FROM hr_data LIMIT 10;
SELECT * FROM hr_data;

    -- data cleaning and preprocessing --

ALTER TABLE hr_data 
CHANGE COLUMN id emp_id VARCHAR(20) NULL; 

DESCRIBE hr_data;

SET sql_safe_updates = 0;

UPDATE hr_data
SET birthdate = CASE
    WHEN birthdate LIKE '%/%/%' THEN date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN birthdate LIKE '%-%-%' THEN date_format(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

ALTER TABLE hr_data
MODIFY COLUMN birthdate DATE;

  -- change the data format and datatype of hire_date column --

UPDATE hr_data
SET hire_date = CASE
    WHEN hire_date LIKE '%/%/%' THEN date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN hire_date LIKE '%-%-%' THEN date_format(str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;  

ALTER TABLE hr_data
MODIFY COLUMN hire_date DATE;

   -- change the date format and datatype of termdate column--

UPDATE hr_data
SET termdate = date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC'))
WHERE termdate IS NOT NULL AND termdate != '';

UPDATE hr_data
SET termdate = NULL
WHERE termdate = '';

    -- create age column --

ALTER TABLE hr_data
ADD column age INT;

UPDATE hr_data
SET age = timestampdiff(YEAR,birthdate,curdate());

SELECT min(age), max(age) FROM hr_data;


     -- 1. what is gender breakdown of employees in the company --

SELECT gender, COUNT(*) AS count
FROM hr_data
WHERE termdate IS NULL
GROUP BY gender;     


    -- 2. what is race breakdown of employees in the company --

SELECT race, COUNT(*) AS count
FROM hr_data
WHERE termdate IS NULL
GROUP BY race;     


     -- 3. What is the age distribution of the employees in the company --

SELECT
    CASE
        WHEN age>=18 AND age<=24 THEN '18-24'
        WHEN age>=25 AND age<=34 THEN '25-34'
        WHEN age>=35 AND age<=44 THEN '35-44'
        WHEN age>=45 AND age<=54 THEN '45-54'
        WHEN age>=55 AND age<=64 THEN '55-64'
        ELSE '65+'
    END AS age_group,
    COUNT(*) AS count
    FROM hr_data
    WHERE termdate IS NULL
    GROUP BY age_group
    ORDER BY age_group;        


    -- 4. How manyemployees work at HQ vs remote --

SELECT location, COUNT(*) AS count
FROM hr_data
WHERE termdate IS NULL
GROUP BY location;


    -- 5. What is the average length of the employement who have been terminated --

SELECT ROUND(AVG(year(termdate) - year(hire_date)),0) AS length_of_emp
FROM hr_data
WHERE termdate IS NOT NULL AND termdate <= curdate();


    -- 6. How does gender distribution vary across department aand job titles --

SELECT * FROM hr_data;

SELECT department,jobtitle,gender,COUNT(*) AS count
FROM hr_data
WHERE termdate IS NOT NULL
GROUP BY department,jobtitle,gender
ORDER BY department,jobtitle,gender;

SELECT department,gender,COUNT(*) AS count
FROM hr_data
WHERE termdate IS NOT NULL
GROUP BY department,gender
ORDER BY department,gender;



     -- 7. What is the distribution of jobtitles across the company --

SELECT jobtitle, COUNT(*) AS count
FROM hr_data
WHERE termdate IS NULL
GROUP BY jobtitle;    


     -- 8. Which department has the higher turnover or termination rate --

SELECT * FROM hr_data;

SELECT department,
        COUNT(*) AS total_count,
        COUNT(CASE
                WHEN termdate IS NOT NULL AND termdate <= curdate() THEN 1
                END) AS terminated_count,
        ROUND((COUNT(CASE
                WHEN termdate IS NOT NULL AND termdate <= curdate() THEN 1
                END)/COUNT(*))*100,2) AS termination_rate
        FROM hr_data
        GROUP BY department
        ORDER BY termination_rate DESC;


     -- 9. What is the distribution of employees across location_state --

SELECT location_state, COUNT(*) AS count
FROM hr_data
WHERE termdate IS NULL
GROUP BY location_state;

SELECT location_city, COUNT(*) AS count
FROM hr_data
WHERE termdate IS NULL
GROUP BY location_city;


     -- 10. How has the companies employee count changes over time based on the hire and termination date --


SELECT * FROM hr_data;
 
SELECT year,
        hires,
        terminations,
        hires-terminations AS net_change,
        (terminations/hires)*100 AS change_percent
    FROM(
           SELECT YEAR(hire_date) AS year,
           COUNT(*) AS hires,
           SUM(CASE
                   WHEN termdate IS NOT NULL AND termdate <= curdate() THEN 1
                END) AS terminations
           FROM hr_data
           GROUP BY YEAR(hire_date)) AS subquery
GROUP BY YEAR
ORDER BY YEAR;  


      -- 11. What is the tenure distribution for each department --


SELECT department, round(avg(datediff(termdate,hire_date)/365),0) AS avg_tenure
FROM hr_data
WHERE termdate IS NOT NULL AND termdate<= CURDATE()
GROUP BY department;     


-- 12. termination and hire breakdown gender wise --

SELECT
    gender,
    total_hires,
    total_terminations,
    ROUND((total_terminations/total_hires)*100,2) AS termination_rate
FROM(
    SELECT gender,
        COUNT(*) AS total_hires,
        COUNT(CASE
            WHEN termdate IS NOT NULL AND termdate <= curdate() THEN 1
            END) AS total_terminations
    FROM hr_data
    GROUP BY gender) AS subquery
GROUP BY gender;


-- 13. termination and hire breakdown age wise --

SELECT
    age,
    total_hires,
    total_terminations,
    ROUND((total_terminations/total_hires)*100,2) AS termination_rate
FROM(
    SELECT age,
        COUNT(*) AS total_hires,
        COUNT(CASE
            WHEN termdate IS NOT NULL AND termdate <= curdate() THEN 1
            END) AS total_terminations
    FROM hr_data
    GROUP BY age) AS subquery
GROUP BY age;


-- 13. termination and hire breakdown department wise --

SELECT
    department,
    total_hires,
    total_terminations,
    ROUND((total_terminations/total_hires)*100,2) AS termination_rate
FROM(
    SELECT department,
        COUNT(*) AS total_hires,
        COUNT(CASE
            WHEN termdate IS NOT NULL AND termdate <= curdate() THEN 1
            END) AS total_terminations
    FROM hr_data
    GROUP BY department) AS subquery
GROUP BY department;


-- 14. termination and hire breakdown race wise --

SELECT
    race,
    total_hires,
    total_terminations,
    ROUND((total_terminations/total_hires)*100,2) AS termination_rate
FROM(
    SELECT race,
        COUNT(*) AS total_hires,
        COUNT(CASE
            WHEN termdate IS NOT NULL AND termdate <= curdate() THEN 1
            END) AS total_terminations
    FROM hr_data
    GROUP BY race) AS subquery
GROUP BY race;


-- 15. termination and hire breakdown year wise --

SELECT
    year,
    hires,
    terminations,
    (terminations/hires)*100 AS termination_rate
FROM(
    SELECT YEAR(hire_date) AS year,
        COUNT(*) AS hires,
        SUM(CASE
            WHEN termdate IS NOT NULL AND termdate <= curdate() THEN 1
            END) AS terminations
    FROM hr_data
    GROUP BY year) AS subquery
GROUP BY year;
