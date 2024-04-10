/* 
Question: What are the top-paying Software Engineer jobs?
- Identify the top 10 highest-paying Soft Eng roles that were available last year remotely.
- Focuses on the job postings with specified salaries (no null).
- Why: Highlight the top-paying opportunities for Soft Eng, offering insights into best skills for soft eng.
*/

SELECT
    job_id,
    job_title,
    job_location,
    company_dim.name AS company_name,
    job_schedule_type,
    salary_year_avg,
    job_posted_date

FROM
    job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id

WHERE
    job_title_short = 'Software Engineer' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL

ORDER BY
    salary_year_avg DESC

LIMIT 10