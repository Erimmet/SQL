-- high demand & high paying skills for Data Analyst jobs that are work from home


with skills_demand as (
    select 
        skills_dim.skill_id,
        skills_dim.skills,
        count(skills_job_dim.job_id) AS demand_count
    from job_postings_fact
    inner join skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    inner join skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    where
        job_title_short = 'Data Analyst' AND
        job_work_from_home = True AND
        salary_year_avg IS NOT NULL
    group by skills_dim.skill_id
), avg_salary as (
    select 
        skills_job_dim.skill_id,
        ROUND(AVG(salary_year_avg), 2) AS average_salary
    from job_postings_fact
    inner join skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    inner join skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    where
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL
    group by skills_job_dim.skill_id
    
)

select 
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
from
    skills_demand
inner join avg_salary ON skills_demand.skill_id = avg_salary.skill_id
order by demand_count desc, avg_salary desc
limit 10;

