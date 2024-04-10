/* 
Question: What are the most optimal skills to learn (high demand and high paying)?
- Identify skills in high deman and associated with high average salaries for remote Software Eng roles
- Concentrated on Remote positions with speicified salaries
- Why? Targets skills that offer job security and financial gain, for efficient Software Eng edification
*/

WITH skills_demand AS ( --most frequent skill req
    SELECT
        skills_dim.skill_id,
        skills,
        COUNT(skills_job_dim.job_id) AS demand_count

    FROM job_postings_fact
        INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
        INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id

    WHERE
        job_title_short = 'Software Engineer'
        AND salary_year_avg IS NOT NULL
        AND job_location = 'Anywhere'

    GROUP BY
        skills_dim.skill_id

), average_salary AS ( --highest paid skills by average salary offered
    SELECT
    skills_dim.skill_id,
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary

    FROM job_postings_fact
        INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
        INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id

    WHERE
        job_title_short = 'Software Engineer' 
        AND salary_year_avg IS NOT NULL
        AND job_location = 'Anywhere'

    GROUP BY
        skills_dim.skill_id

)

SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary

FROM
    skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id

WHERE
    demand_count >= 10

ORDER BY
        avg_salary DESC,
        demand_count DESC


LIMIT 20