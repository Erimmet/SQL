select 
    skills,
    ROUND(AVG(salary_year_avg), 2) AS average_salary
from job_postings_fact
inner join skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
inner join skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
where
    job_title_short = 'Data Analyst' AND
    -- job_work_from_home = True AND
    salary_year_avg IS NOT NULL
group by 
    skills
order by 
   average_salary DESC
limit 10;