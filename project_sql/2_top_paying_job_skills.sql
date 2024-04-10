/* 
Question: What are the skills required for the top-paying remote Software Engineer jobs?
- Use query 1
- Add the specific skills required for these roles
- Why? To recognize which skills are valued the highest in software eng jobs (not just most commonly requested, but best-paid)
*/

WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        company_dim.name AS company_name,
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

    LIMIT 20
) 

SELECT 
  /*  top_paying_jobs.*,*/
    skills,
   COUNT(top_paying_jobs.job_id) AS num_of_job_requiring_this_skill --<- for the below aggregation
FROM top_paying_jobs
    INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id

/* Let's organize it by skill to see which skills are most common in these top 10 */

GROUP BY
    skills
ORDER BY
    num_of_job_requiring_this_skill DESC

/*JSON RESULTS:
[
  {
    "skills": "mongodb",
    "num_of_job_requiring_this_skill": "6"
  },
  {
    "skills": "javascript",
    "num_of_job_requiring_this_skill": "5"
  },
  {
    "skills": "python",
    "num_of_job_requiring_this_skill": "5"
  },
  {
    "skills": "typescript",
    "num_of_job_requiring_this_skill": "4"
  },
  {
    "skills": "aws",
    "num_of_job_requiring_this_skill": "4"
  },
  {
    "skills": "react",
    "num_of_job_requiring_this_skill": "4"
  },
  {
    "skills": "css",
    "num_of_job_requiring_this_skill": "2"
  },
  {
    "skills": "dynamodb",
    "num_of_job_requiring_this_skill": "2"
  },
  {
    "skills": "elasticsearch",
    "num_of_job_requiring_this_skill": "2"
  },
  {
    "skills": "graphql",
    "num_of_job_requiring_this_skill": "2"
  },
  {
    "skills": "azure",
    "num_of_job_requiring_this_skill": "2"
  },
  {
    "skills": "node.js",
    "num_of_job_requiring_this_skill": "2"
  },
  {
    "skills": "ruby",
    "num_of_job_requiring_this_skill": "2"
  },
  {
    "skills": "snowflake",
    "num_of_job_requiring_this_skill": "2"
  },
  {
    "skills": "spark",
    "num_of_job_requiring_this_skill": "1"
  },
  {
    "skills": "mysql",
    "num_of_job_requiring_this_skill": "1"
  },
  {
    "skills": "couchbase",
    "num_of_job_requiring_this_skill": "1"
  },
  {
    "skills": "pandas",
    "num_of_job_requiring_this_skill": "1"
  },
  {
    "skills": "asp.net",
    "num_of_job_requiring_this_skill": "1"
  },
  {
    "skills": "airflow",
    "num_of_job_requiring_this_skill": "1"
  },
  {
    "skills": "react.js",
    "num_of_job_requiring_this_skill": "1"
  },
  {
    "skills": "gcp",
    "num_of_job_requiring_this_skill": "1"
  },
  {
    "skills": "golang",
    "num_of_job_requiring_this_skill": "1"
  },
  {
    "skills": "redis",
    "num_of_job_requiring_this_skill": "1"
  },
  {
    "skills": "html",
    "num_of_job_requiring_this_skill": "1"
  },
  {
    "skills": "c#",
    "num_of_job_requiring_this_skill": "1"
  }
] 

RESULTS SUMMARY:
- accounting for the top 10 jobs, the three most in-demand skills were MONGODB, Javascript, and Python. However, when changing to the top 20 highest paying Software Eng job postings, the most-requested skills were python, aws, and mongodb, followed by javascript, snowflake, and typescript. While MongoDB fell off the top spot, it remains a highly valued skill*/