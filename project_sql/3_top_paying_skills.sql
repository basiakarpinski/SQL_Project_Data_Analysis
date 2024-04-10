/*
Question: What is the average salary per skill? does it correlate with the top 10 or top 20 highest paying job postings?
- Look at avg salary associated with ear skill for Software Eng positions
- Focuses on roles with specified yearly salaries, with 'work from anywhere'
- Why? To determine most valuable skill to learn and validate it across previous results of top-paying jobs.
*/

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

/*
JSON OUTPUT

[
  {
    "skills": "dynamodb",
    "avg_salary": "184000"
  },
  {
    "skills": "couchbase",
    "avg_salary": "182500"
  },
  {
    "skills": "c",
    "avg_salary": "174500"
  },
  {
    "skills": "snowflake",
    "avg_salary": "169000"
  },
  {
    "skills": "pandas",
    "avg_salary": "168833"
  },
  {
    "skills": "asp.net",
    "avg_salary": "168750"
  },
  {
    "skills": "airflow",
    "avg_salary": "165375"
  },
  {
    "skills": "react",
    "avg_salary": "156222"
  },
  {
    "skills": "ansible",
    "avg_salary": "155000"
  },
  {
    "skills": "angular",
    "avg_salary": "155000"
  },
  {
    "skills": "jquery",
    "avg_salary": "155000"
  },
  {
    "skills": "asp.net core",
    "avg_salary": "155000"
  },
  {
    "skills": "mongo",
    "avg_salary": "155000"
  },
  {
    "skills": "neo4j",
    "avg_salary": "155000"
  },
  {
    "skills": "elasticsearch",
    "avg_salary": "154500"
  },
  {
    "skills": "looker",
    "avg_salary": "150000"
  },
  {
    "skills": "flow",
    "avg_salary": "150000"
  },
  {
    "skills": "azure",
    "avg_salary": "149778"
  },
  {
    "skills": "ruby",
    "avg_salary": "143800"
  },
  {
    "skills": "html",
    "avg_salary": "143750"
  },
  {
    "skills": "c++",
    "avg_salary": "143500"
  },
  {
    "skills": "oracle",
    "avg_salary": "143333"
  },
  {
    "skills": "typescript",
    "avg_salary": "142143"
  },
  {
    "skills": "jenkins",
    "avg_salary": "140833"
  },
  {
    "skills": "numpy",
    "avg_salary": "140500"
  },
  {
    "skills": "shell",
    "avg_salary": "140000"
  },
  {
    "skills": "rust",
    "avg_salary": "139900"
  },
  {
    "skills": "mongodb",
    "avg_salary": "139500"
  },
  {
    "skills": "bigquery",
    "avg_salary": "138333"
  },
  {
    "skills": "node",
    "avg_salary": "137667"
  },
  {
    "skills": "node.js",
    "avg_salary": "137300"
  },
  {
    "skills": "javascript",
    "avg_salary": "137000"
  },
  {
    "skills": "css",
    "avg_salary": "136833"
  },
  {
    "skills": "aurora",
    "avg_salary": "135667"
  },
  {
    "skills": "pulumi",
    "avg_salary": "135000"
  },
  {
    "skills": "fastify",
    "avg_salary": "133000"
  },
  {
    "skills": "express",
    "avg_salary": "133000"
  },
  {
    "skills": "next.js",
    "avg_salary": "133000"
  },
  {
    "skills": "python",
    "avg_salary": "132266"
  },
  {
    "skills": "gcp",
    "avg_salary": "128351"
  },
  {
    "skills": "react.js",
    "avg_salary": "127000"
  },
  {
    "skills": "kubernetes",
    "avg_salary": "125625"
  },
  {
    "skills": "c#",
    "avg_salary": "125600"
  },
  {
    "skills": "django",
    "avg_salary": "125167"
  },
  {
    "skills": "aws",
    "avg_salary": "125143"
  },
  {
    "skills": "linux",
    "avg_salary": "125000"
  },
  {
    "skills": "solidity",
    "avg_salary": "125000"
  },
  {
    "skills": "erlang",
    "avg_salary": "125000"
  },
  {
    "skills": "terraform",
    "avg_salary": "122500"
  },
  {
    "skills": "sql server",
    "avg_salary": "121417"
  },
  {
    "skills": "power bi",
    "avg_salary": "121250"
  },
  {
    "skills": "golang",
    "avg_salary": "120500"
  },
  {
    "skills": "sap",
    "avg_salary": "120000"
  },
  {
    "skills": "redis",
    "avg_salary": "119800"
  },
  {
    "skills": "spark",
    "avg_salary": "118000"
  },
  {
    "skills": "word",
    "avg_salary": "117500"
  },
  {
    "skills": "java",
    "avg_salary": "115833"
  },
  {
    "skills": "cassandra",
    "avg_salary": "115000"
  },
  {
    "skills": "sql",
    "avg_salary": "112729"
  },
  {
    "skills": "spring",
    "avg_salary": "112500"
  },
  {
    "skills": "github",
    "avg_salary": "110889"
  },
  {
    "skills": "kafka",
    "avg_salary": "110000"
  },
  {
    "skills": "slack",
    "avg_salary": "109375"
  },
  {
    "skills": "graphql",
    "avg_salary": "108125"
  },
  {
    "skills": "fastapi",
    "avg_salary": "107750"
  },
  {
    "skills": "kotlin",
    "avg_salary": "107500"
  },
  {
    "skills": "sas",
    "avg_salary": "105000"
  },
  {
    "skills": "excel",
    "avg_salary": "104545"
  },
  {
    "skills": "tableau",
    "avg_salary": "99976"
  },
  {
    "skills": "postgresql",
    "avg_salary": "98800"
  },
  {
    "skills": "r",
    "avg_salary": "97500"
  },
  {
    "skills": "docker",
    "avg_salary": "94308"
  },
  {
    "skills": "mysql",
    "avg_salary": "93375"
  },
  {
    "skills": "notion",
    "avg_salary": "91250"
  },
  {
    "skills": "sheets",
    "avg_salary": "90000"
  },
  {
    "skills": "go",
    "avg_salary": "89000"
  },
  {
    "skills": "vmware",
    "avg_salary": "87500"
  },
  {
    "skills": "flask",
    "avg_salary": "85000"
  },
  {
    "skills": "outlook",
    "avg_salary": "85000"
  },
  {
    "skills": "ruby on rails",
    "avg_salary": "81500"
  },
  {
    "skills": "gitlab",
    "avg_salary": "79250"
  },
  {
    "skills": "zoom",
    "avg_salary": "75000"
  },
  {
    "skills": "firebase",
    "avg_salary": "75000"
  },
  {
    "skills": "redshift",
    "avg_salary": "75000"
  },
  {
    "skills": "git",
    "avg_salary": "68500"
  },
  {
    "skills": "nosql",
    "avg_salary": "61625"
  },
  {
    "skills": "laravel",
    "avg_salary": "55000"
  },
  {
    "skills": "digitalocean",
    "avg_salary": "55000"
  },
  {
    "skills": "ubuntu",
    "avg_salary": "55000"
  },
  {
    "skills": "elixir",
    "avg_salary": "54000"
  },
  {
    "skills": "pyspark",
    "avg_salary": "54000"
  },
  {
    "skills": "powerpoint",
    "avg_salary": "45000"
  },
  {
    "skills": "php",
    "avg_salary": "45000"
  },
  {
    "skills": "bitbucket",
    "avg_salary": "36000"
  },
  {
    "skills": "scala",
    "avg_salary": "28000"
  }
]

RESULTS SUMMARY: none of the skills needed for top paying make this list, HOWEVER, this is the average salary for all remote jobs requiring each skill. As such, the sample salary dataset across skills varies (skills that are only requested by a few mid-level jobs will have less averaging to do than something that is required from both beginners and experts). Likewise, this dataset does not take into account the level of proficiency with each skill. It is still more useful to look at the top 10-20 jobs and the rquisite skills. The next step will be to look at the fluectuation of top-paying jobs last year on a monthly basis, and their most in-demand skills.
*/