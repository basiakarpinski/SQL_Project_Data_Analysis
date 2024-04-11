## Abstract

This project analyzed a web-scraped database of technology jobs from 2023 for the purpose of isolating the top hard skills to learn for software engineering jobs today. The results showed that the most in-demand languages are not necessarily the highest paid, with python,  aws, and MongoDB being most common in high-paying software engineering, but  falling lower in ranking when measured by frequency of demand and average salary for jobs requiring these skills. 

Based on the methology presented, it is recommended for budding software engineers to focus their education first on versatile scripting languages such as **python, typescript,** and **javascript** to maximize demand and financial compensation.

## Purpose

 I undertook this project not because I have the intention of pivoting into a software engineering role, but because the demand for such skills across various industries has notably grown in the last ten years, and is projected to stay on this trend with the diversification of consumer-facing maker technology. It stands to reason then that a valuable, versatile worker should have not only the skills niche to their subject area, but a preliminary understanding of programming for integration of new tools into software-agnostic industry pipelines. Summarily, an interdisciplinary approach to computer programming is **more useful to collaborating teams, creates skill overlap and cost-efficient redundancy, and allows companies to keep up with ever-evolving sectors of their industry.** Human Swiss-army knife, 2024 edition.

## Methodology

 The dataset used for this project was collected from Luke Barousse's [SQL Course](https://lukebarousse.com/sql). The comprehensive course features datasets needed for querying, practice problems, video lessons to guide first-time data analysts, and further practice problems for developing confidence and proficiency.
 
 ### The programs and languages used for this project were:
 - **PostgreSQL** for connecting the database and managing data
 - **SQL** as the primary query language
 - **Visual Studio Code** for compiling queries and creating datasets
 - **Github** for version control, organizing results, and publicly presenting the repository of findings here
 
 Four SQL queries were created for this analysis, accessible here: [project_sql_folder](/project_sql/). 
 
 ### The queries were purposed as follows:
 1. What were the highest-salaried remote software engineering jobs posted in 2023?
 2. What were the skills most often required for the top ten? What were they for the top 20?
 3. What is the average salary per skill across all remote software engineering jobs?
 4. What are the best skills to have for software engineering jobs, correlating market demand and average salary?

## Analysis

 ### The rationale and approach to each query:
 1. *What were the highest-salaried remote software engineering jobs posted in 2023?*  
   The intention here was to isolate which job postings had the highest financial compensation, as a stand-in for 'most valued'. Jos postings that omitted Potential patterns to identify would have been in the forms of job title, employer, hiring quarter, or pay range. This was limited to remote roles to work outside of the barriers of geography-specific demands and GDP. It was found that software engineering **jobs posted that had the highest salary were more likely to be posted during the latter half of the year, in the first fiscal quarter** (with some in the second quarter). Expectedly, the majority of the highest-paying software engineering postings were for Senior software engineers. There were no other correlations within this dataset, but it should be noted that two of the top ten highest-paying jobs were from the company *MongoDB* which specializes in a data manipulation syntax.  

 ![Query 1 chart](/project_sql/assets/sql1_results.jpg)

 2. *What were the skills most often required for the top ten? What were they for the top 20?*  
  To further determine the most valued skills, those required from the top-ten highest-paying remote software engineer job postings were extracted, connected across two additional databases (along job_id to extract skill_id, then along skill_id to extract skill_name). It must be noted here that some skills had multiple IDs, distinguished by whether they were used for data analysis or programming (skill_type). There did not seem to be justification suitable to isolate for one of these when considering that the type of use-case was not always specified in the job posting and was determined through keyword extraction when the database was built. As such, the distinction is not reliable enough for analysis. Accounting for the top ten jobs, the three most in-demand skills were MongoDB, javascript, and python. However, when adjusting for the top 20 highest paying software engineer job postings, **the most-requested skills were Python, AWS, and MongoDB,** followed by javascript and sql. Due to two postings from the company *MongoDB* being in the top ten, expanding the search to the top 20 highest-salaried software engineer jobs may be a more reliable indicator of demand across the industry. While MongoDB fell slightly in ranking, it remained a highly valued skill.  

 ![Results from top 20 salaried jobs](/project_sql/assets/Skill_Demand_for_Top_20_Highest-Salaried_Job_Postings.png/)

 3. *What is the average salary per skill across all remote software engineering jobs?*  
  For this section, I removed the restriction of top 20 jobs and focused on all software engineer jobs in the database. The goal was to isolate for remote software engineering job postings, extract the skills needed for each, and calculate the mean salary for all jobs requiring a given skill. The results from this query, when compared against the previous, would help determine if the skills required for high-salary jobs are exclusive to well-paid mid-to-senior level job postings.
  ```sql
    SELECT
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
        skills

    ORDER BY
        avg_salary DESC
  ```
  The most-requested skills for the top 20 (and top 10) highest-salaried job postings (Query 2) are highlighted bright green in the chart. The results show that the **average salary for these skills fall around the mean, likely indicating that they are skills in demand not only in senior roles but at various levels of experience.** Those skills which had the highest average salary require further analysis; I suspect they had a smaller salary sample set either because they are used in specialized industries or for niche engineering functions.  

 ![Results for average salary per skill. Due to the number of skills, labels have been concatenated. please see the linked SQL file for full results.](/project_sql/assets/Average_Salary_Per_Skill.png)  

 4. *What are the best skills to have for software engineering jobs, correlating market demand and average salary?*  
  In the final query, I created a common table expression (CTE) that compared the demand of various skills against their average salary; in other words, a concatenation of Query 2, without the top-salaried limit, and Query 3. The goal is to extrapolate the hard skills which provide both employability via high market demand, and are well compensated—the "best" skills to prioritize learning. This query allows some fine turning based on which of the aforementions two conditions is more important to an individual; as written it prioritizes average salary first and, where the pay may be the same, by demand. The results of this query are limited to the skills that appeared in ten or more job postings for brevity.  
  ```sql
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
   -- skills_demand.skill_id,
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
```  

By this table, the skills which are both in-demand in software engineer roles and well-paid are **typescript, javascript, and python.** Interestingly, these results more closely match the output from Query 2 than Query 3, corroborating the suspicion that skills with higher salaries likely have low demand and their average salary was based on a small subsample.

![Results for skills listed in software engineer postings at least ten times, ordered by average salary across those postings.](/project_sql/assets/optimized-for-demand-and-pay.png)  


## Conclusion
 From this series of queries, the top skill for software engineers to know in 2023 was indisputably python, with other common scripting languages, typescript and javascript also in demand. Likewise, due to the growing prevalence of AWS and Microsoft Azure hosting and cloud rendering services, experience with these technologies is also an asset. Finally, there is some trend in software engeineering vacancies to also request familiarity with querying languages such as MongoDB and SQL. It may then befit programming-adjacent workers—technical artists, producers, render farm managers, to name a few—to also develop some preliminary understanding in querying databases, scripting tools, and perhaps most importantly, troubleshooting script errors and reading log files.  

 There are some caveats to the analysis presented, and the generalizability of these results. 
 - Queries were restricted to only software engineering positions, roles typically requiring specialized and deep knowledge of programming. These may not be the most optimal skills for those who only work in bureaucratic roles far outside of asset pipelines.
 - The profileration of AI-based assistants means simple scripts can be built using natural language descriptor prompts, albeit this method requires both benig able to read and adjust the script as necessary, and a strong understanding of digital security protection when requesting and running AI-generated scripts. 
 - Within the database, there was no division of degree of proficiency and niche skills for each programming language. Python, for example, can be used for everything from simple math calculations to solving optical motion capture data, both requiring drastically different degrees and directions of proficiency. 
 - Restricting searches to jobs workable from 'anywhere' provides some insight into globally-applicable trends, but may not be refelctive of local market demands. Software engeineers working in digital security or the military, for example, are less likely to be 'work-from-anywhere' type roles and produce significantly different results than those above. Furthermore, the GDP of an area will reflect the compensation for that job posting, a variable that may affect average salaries for the type of work commonly outsourced.
 - Companies that hire internally or through networking are less likely to post higher-paying vacanies on public job boards, skewing the accuracy of a full-market analysis.
 - Lastly, it is not uncommon to find "ghost vacancies" or "evergreen job postings"—jobs posted publicly by a company for the purpose of collecting applicant information, without intent to fill the role quickly (if at all), or to demonstrate continual growth to shareholders. Such practices skew the reliability of publicly-scraped data.

Specifically in regards to the final analysis of "best" or "optimal" skill to learn, alternative frameworks of analysis should be considered. Rather than ordering first by one variable, and by the other when there is a matching value for the first variable, it would be more accurate to do a matrix calculation that produces two modifiers applied to a base value. In this sense, skills that may have a high average salary but low demand will produce an "optimized" rank lowered by a modifier concurrent with their low demand, and raised by a modifier that reflects the above-average pay grade. The "best" skill to learn will also change as the dataset used here becomes older and no longer reflective of the current or future job market. It may be useful to apply the above queries on a month-by-month parameter to gain an understanding of hiring trends, and which skills are projected to be most in-demand in the near future. Finally, the best skills to focus on will differ based on the target audience's unique situation; if they are only looking for entry-level roles, or only part-time, contract, or freelance work, or exclusively in a specific geographical area.

To continue this work would behoove procuring a newer, regularly updated dataset of job postings, taking into account the aforementioned caveats and limitations. From a data analyst perspective, perhaps I should heed my own findings and learn python for the purposes of scraping and extracting such data myself. This project developed my understanding and confidence with SQL and the programs used.  


#### I would like to express my gratitutde to [Luke Barousse](https://www.lukebarousse.com) and [Kelly Adams](https://www.kellyjadams.com) for putting together the SQL course from which this project was produced, for providing the dataset publicly, and diligently putting into practice the cornerstones of good instructional design for the benefit of others. I look forward to more courses under your shared guidance.

