WITH skills_demand AS (
    SELECT
        skills_dim.skill_id, 
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count  -- Fixed incorrect column reference
    FROM job_postings_fact
    INNER JOIN skills_job_dim  -- Removed extra space in alias
        ON job_postings_fact.job_id = skills_job_dim.job_id  -- Fixed missing condition
    INNER JOIN skills_dim
        ON skills_job_dim.skill_id = skills_dim.skill_id  -- Fixed missing ON condition
    WHERE
        job_title_short = 'Data Analyst' AND  -- Fixed missing space before AND
        salary_year_avg IS NOT NULL AND
        job_work_from_home = TRUE
    GROUP BY
        skills_dim.skill_id, skills_dim.skills  -- Added skills_dim.skills to GROUP BY
),  
average_salary AS (
    SELECT
        skills_job_dim.skill_id,
        ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary  -- Added missing comma and closing parenthesis
    FROM job_postings_fact
    INNER JOIN skills_job_dim 
        ON job_postings_fact.job_id = skills_job_dim.job_id  -- Fixed missing condition
    INNER JOIN skills_dim
        ON skills_job_dim.skill_id = skills_dim.skill_id  -- Fixed missing ON condition
    WHERE
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL 
        AND job_work_from_home = TRUE
    GROUP BY
        skills_job_dim.skill_id
)
SELECT
    skills_demand.skill_id,  -- Added missing dot in alias reference
    skills_demand.skills, 
    demand_count, 
    avg_salary
FROM skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id  -- Fixed missing equals condition
WHERE
    demand_count > 10
ORDER BY
    demand_count DESC,
    avg_salary DESC
Limit 25