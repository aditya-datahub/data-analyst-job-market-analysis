CREATE TABLE data_analyst_jobs (
    id INT,
    job_title TEXT,
    salary_estimate TEXT,
    job_description TEXT,
    rating NUMERIC,
    company_name TEXT,
    location TEXT,
    headquarters TEXT,
    company_size TEXT,
    founded INT,
    type_of_ownership TEXT,
    industry TEXT,
    sector TEXT,
    revenue TEXT,
    competitors TEXT,
    easy_apply TEXT
);

SELECT * FROM data_analyst_jobs LIMIT 10;

SELECT COUNT(*) FROM data_analyst_jobs;

SELECT job_title, company_name, location, COUNT(*)
FROM data_analyst_jobs
GROUP BY job_title, company_name, location
HAVING COUNT(*) > 1;

SELECT COUNT(*) FROM data_analyst_jobs WHERE rating = -1;

SELECT DISTINCT salary_estimate FROM data_analyst_jobs ;

SELECT job_title, company_name, location, COUNT(*), MIN(id) as keep_this_id
FROM data_analyst_jobs
GROUP BY job_title, company_name, location
HAVING COUNT(*) > 1;


DELETE FROM data_analyst_jobs
WHERE id NOT IN (
    SELECT MIN(id)
    FROM data_analyst_jobs
    GROUP BY job_title, company_name, location
);

SELECT COUNT(*) FROM data_analyst_jobs;

UPDATE data_analyst_jobs
SET rating = NULL
WHERE rating = -1;

SELECT COUNT(*) FROM data_analyst_jobs WHERE rating IS NULL;

ALTER TABLE data_analyst_jobs ADD COLUMN salary_min INT;
ALTER TABLE data_analyst_jobs ADD COLUMN salary_max INT;

UPDATE data_analyst_jobs
SET 
    salary_min = SUBSTRING(salary_estimate FROM '\$(\d+)K')::INT,
    salary_max = SUBSTRING(salary_estimate FROM '-\$(\d+)K')::INT;

SELECT salary_estimate, salary_min, salary_max 
FROM data_analyst_jobs 

SELECT COUNT(*) FROM data_analyst_jobs WHERE salary_estimate = '-1';

SELECT * FROM data_analyst_jobs WHERE salary_estimate = '-1';

SELECT id, salary_estimate, salary_min, salary_max 
FROM data_analyst_jobs 
WHERE salary_estimate = '-1';

SELECT company_name, COUNT(*) as total_jobs
FROM data_analyst_jobs
GROUP BY company_name
ORDER BY total_jobs DESC
LIMIT 10;

SELECT location, COUNT(*) as total_jobs
FROM data_analyst_jobs
GROUP BY location
ORDER BY total_jobs DESC
LIMIT 10;

SELECT 
    location,
    company_name,
    job_count
FROM (
    SELECT 
        location,
        company_name,
        COUNT(*) as job_count,
        RANK() OVER (
            PARTITION BY location 
            ORDER BY COUNT(*) DESC
        ) as rank_in_city
    FROM data_analyst_jobs
    GROUP BY location, company_name
) ranked
WHERE rank_in_city = 1 AND job_count > 3
ORDER BY job_count DESC;

SELECT 
    CASE 
        WHEN rating >= 4 THEN 'High rated (4+)'
        WHEN rating >= 3 THEN 'Medium rated (3-4)'
        WHEN rating IS NOT NULL THEN 'Low rated (<3)'
        ELSE 'No rating'
    END as rating_bucket,
    COUNT(*) as num_jobs,
    ROUND(AVG(salary_min)) as avg_min_salary,
    ROUND(AVG(salary_max)) as avg_max_salary
FROM data_analyst_jobs
GROUP BY rating_bucket
ORDER BY avg_max_salary DESC;