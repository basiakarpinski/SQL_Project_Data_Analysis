## Abstract

This project analyzed a web-scraped database of technology jobs from 2023 for the purpose of isolating the top hard skills to learn for software engineering jobs today. The results showed that the most in-demand languages are not necessarily the highest paid, with python,  aws, and MongoDB being most common in high-paying software engineering, but  falling lower in ranking when measured by frequency of demand and average salary for jobs requiring these skills. 

Based on the methology presented, it is recommended for budding software engineers to focus their education first on versatile scripting languages such as **python, typescript,** and **javascript** to maximize demand and financial compensation.

## Introduction

 I undertook this project not because I have the intention of pivoting into a software engineering role, but because the demand for such skills across various industries has notably grown in the last ten years, and is projected to stay on this trend with the diversification of consumer-facing maker technology. It stands to reason then that a valuable, versatile worker should have not only the skills niche to their subject area, but a preliminary understanding of programming for integration of new tools into software-agnostic industry pipelines. Summarily, an interdisciplinary approach to computer programming is **more useful to collaborating teams, creates skill overlap and cost-efficient redundancy, and allows companies to keep up with ever-evolving sectors of their industry.** Human Swiss-army knife, 2024 edition.

## Methodology
 -- using 2023 webscrape of technology jobs (datanerd.tech)
 The dataset used for this project was collected from 
 
 ### The programs and languages used for this project were:
 - **PostgreSQL** for connecting the database and managing data
 - **SQL** as the primary query language
 - **Visual Studio Code** for compiling queries and creating datasets
 - **Github** for version control, organizing results, and publicly presenting the repository of findings here

 -- focus on remote Software Eng jobs 
 
 Four SQL queries were created for this analysis, accessible here: [project_sql_folder](/project_sql/). 
 
 ### The queries were purposed as follows:
 1. What were the highest-salaried remote software engineering jobs posted in 2023?
 2. What were the skills most often required for the top ten? What were they for the top 20?
 3. What is the average salary per skill across all remote software engineering jobs?
 4. What are the best skills to have for software engineering jobs, correlating market demand and average salary?

## Analysis
 -- results
 ### The rationale and approach to each query:
 1. *What were the highest-salaried remote software engineering jobs posted in 2023?*  
   The intention here was to isolate which job postings had the highest financial compensation, as a stand-in for 'most valued'. Jos postings that omitted Potential patterns to identify would have been in the forms of job title, employer, hiring quarter, or pay range. This was limited to remote roles to work outside of the barriers of geography-specific demands and GDP. It was found that software engineering **jobs posted that had the highest salary were more likely to be posted during the latter half of the year, in the first fiscal quarter** (with some in the second quarter). There were no other correlations within this dataset, but it should be noted that two of the top ten highest-paying jobs were from the company *MongoDB* which specializes in a data manipulation syntax.  

 ![query 1 chart](/project_sql/assets/sql1_results.jpg)

 2. *What were the skills most often required for the top ten? What were they for the top 20?*  
  To further determine the most valued skills, those required from the top-ten highest-paying remote software engineer job postings were extracted, connected across two additional databases (along job_id to extract skill_id, then along skill_id to extract skill_name). It must be noted here that some skills had multiple IDs, distinguished by whether they were used for data analysis or programming (skill_type). There did not seem to be justification suitable to isolate for one of these when considering that the type of use-case was not always specified in the job posting and was determined through keyword extraction whent he database was built. As such, the distinction is not reliable enough for analysis. Accounting for the top ten jobs, the three most in-demand skills were MongoDB, javascript, and python. However, when adjusting for the top 20 highest paying software engineer job postings, **the most-requested skills were Python, AWS, and MongoDB,** followed by javascript, snowflake, and typescript. Due to two postings from the company *MongoDB* being int he top ten, expanding the search to the top 20 highest-salaried software engineer jobs may be a more reliable indicator of demand across the industry. While MongoDB fell slightly in demand, it remained a highly valued skill.  

 ![QResults from top 20 salaried jobs](/project_sql/assets/Skill_Demand_for_Top_20_Highest-Salaried_Job_Postings.png/)

 3. *What is the average salary per skill across all remote software engineering jobs?*

 4. *What are the best skills to have for software engineering jobs, correlating market demand and average salary?*
 -- defining "best" and "optimal"

## Conclusion
 -- barriers to generalizing these results (niche and proficiency, geographical differences in demand and salary, interal hires, posting reliability)
 -- alternative frameworks of analysis (matrix analysis, monthly trends, experience brackets, part-time vs full time, regular vs contract vs freelance employment)
 -- newer database (how to webscrape)


[def]: image.png