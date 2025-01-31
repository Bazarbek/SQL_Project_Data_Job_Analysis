SELECT
skills,
ROUND(AVG(salary_year_avg), 0) AS avg_salary

FROM
job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
job_title_short = 'Data Analyst' AND
salary_year_avg IS NOT NULL
--job_work_from_home = TRUE
GROUP BY
skills
ORDER BY
avg_salary DESC
LIMIT 25 

/* Insights from Top Paying Data Analyst Skills (2023)

Key Observations:
1. **Extreme Outlier:**
   - **SVN (Subversion) tops the list with a massive $400,000 salary**—this is **significantly higher** than all other skills.
   - This could be due to niche demand, senior-level roles, or incorrect reporting.

2. **Blockchain & Cloud-Based Skills are Highly Valued:**
   - **Solidity ($179,000)** (Ethereum smart contracts) is in second place, showing the growing demand for **blockchain-related data analysts**.
   - **Terraform ($146,734)** and **VMware ($147,500)** indicate strong cloud and infrastructure knowledge demand.

3. **AI, Machine Learning & Deep Learning Pay Well:**
   - **TensorFlow ($120,647)**, **PyTorch ($125,226)**, **Keras ($127,013)**, and **Hugging Face ($123,950)** showcase the demand for AI-related expertise.
   - **MXNet ($149,000)** is a less common but high-paying deep-learning skill.

4. **Big Data & Streaming Technologies:**
   - **Kafka ($129,999)** and **Cassandra ($118,407)** are critical for handling massive-scale data pipelines.

5. **Low-Code & Automation Tools Appear:**
   - **DataRobot ($155,486)** suggests demand for autoML platforms.
   - **Airflow ($116,387)** is a workflow automation tool widely used in **data engineering**.

---

**What This Means for Data Analysts:**
✅ **Learn AI & ML** – TensorFlow, PyTorch, and Keras are in demand.  
✅ **Cloud Skills Are Crucial** – Terraform, VMware, and Kubernetes-related skills pay well.  
✅ **Blockchain Expertise is Emerging** – Solidity commands high salaries.  
✅ **Data Engineering Skills Pay Off** – Kafka, Cassandra, and Airflow are valuable.

*/