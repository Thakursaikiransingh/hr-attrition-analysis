CREATE DATABASE hr_attrition;
USE hr_attrition;
show tables;

select * from hr_attrition_clean;

#Query 1: Overall Attrition Rate
select
	count(*) as Total_employees,
    sum(case when Attrition='Yes' Then 1 else 0 end) as attrited,
    sum(case when Attrition='NO' then 1 else 0 end) as Retained,
    round(sum(case when Attrition='Yes' Then 1 else 0 end)*100.0/count(*),2) 
from hr_attrition_clean;

#Query 2: Attrition by Department
select 
	department,
	count(*) as total,
    sum(case when Attrition='Yes' Then 1 else 0 end) as attrited,
    round(sum(case when Attrition='Yes' Then 1 else 0 end)*100.0/count(*),2) as Attrition_Rate
from hr_attrition_clean
group by department
order by Attrition_Rate desc;

 #Query 3: Attrition by OverTime
 select
	overtime,
    count(*) as Total,
    sum(case when Attrition='Yes' Then 1 else 0 end) as attrited,
    round(sum(case when Attrition='Yes' Then 1 else 0 end)*100.0/count(*),2) as Attrition_Rate
from hr_attrition_clean
group by overtime
order by Attrition_Rate desc;

#Query 4: Attrition by MaritalStatus
select
	MaritalStatus,
    count(*) as Total,
    sum(case when Attrition='Yes' Then 1 else 0 end) as attrited,
    round(sum(case when Attrition='Yes' Then 1 else 0 end)*100.0/count(*),2) as Attrition_Rate
from hr_attrition_clean
group by MaritalStatus
order by Attrition_Rate desc;

# Query 5: Attrition by BusinessTravel
SELECT 
    BusinessTravel,
    COUNT(*) AS Total,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attrited,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Attrition_Rate
FROM hr_attrition_clean
GROUP BY BusinessTravel
ORDER BY Attrition_Rate DESC;

#Query 6: Attrition by JobRole
SELECT 
    JobRole,
    COUNT(*) AS Total,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attrited,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Attrition_Rate
FROM hr_attrition_clean
GROUP BY JobRole
ORDER BY Attrition_Rate DESC;

#Query 7: Average Income - Attrited vs Retained
select 
	Attrition,
    round(avg(MonthlyIncome),2) as avg_monthly_income,
    round(avg(age),2) as avg_age,
    ROUND(AVG(TotalWorkingYears), 2) AS Avg_Working_Years,
    ROUND(AVG(YearsAtCompany), 2) AS Avg_Years_At_Company
FROM hr_attrition_clean
GROUP BY Attrition;

#Attrition by Income Group
select 
	case
		when MonthlyIncome < 3000 Then 'Low (<3K)'
        when MonthlyIncome < 6000 Then 'Mid (3-6K)'
        when MonthlyIncome < 10000 then 'High (6-10K)'
        else 'Very High (>10K)'
	end as Income_Group,
    count(*) as Total,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attrited,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Attrition_Rate
FROM hr_attrition_clean
group by Income_Group
ORDER BY Attrition_Rate DESC;

#Attrition by Age Group
select 
	case
		when Age < 25 THEN 'Young (18-24)'
		WHEN Age < 35 THEN 'Early Career (25-34)'
        WHEN Age < 45 THEN 'Mid Career (35-44)'
        ELSE 'Senior (45+)'
    END AS Age_Group,
	COUNT(*) AS Total,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attrited,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Attrition_Rate
FROM hr_attrition_clean
GROUP BY Age_Group
ORDER BY Attrition_Rate DESC;

#High Risk Employees
select 
	EmployeeNumber,
    Age,
    Department,
    JobRole,
    MonthlyIncome,
    OverTime,
    MaritalStatus,
    YearsAtCompany,
    JobSatisfaction
FROM hr_attrition_clean
where Attrition = 'Yes' and OverTime = 'Yes' and JobSatisfaction = 1 and  MonthlyIncome < 3000
order by MonthlyIncome ASC
limit 10;

/*
===================================================
SQL ANALYSIS - EXACT FINDINGS & BUSINESS ACTIONS
HR ATTRITION PROJECT
=================================================

Query 1: Overall Attrition Rate
- Exact count: 237 employees left out of 1470
- Exact attrition rate: 16.12%
- 1233 employees successfully retained

Query 2: Attrition by Department
- Sales loses exactly 92 out of 446 employees (20.63%)
- HR loses exactly 12 out of 63 employees (19.05%)
- R&D loses exactly 133 out of 961 employees (13.84%)
- ACTION: Sales needs urgent retention strategy

Query 3: Attrition by OverTime
- Overtime workers: 127 left out of 416 (30.53%)
- Non-overtime workers: 110 left out of 1054 (10.44%)
- Exact gap: 20.09% difference
- ACTION: Reduce overtime by hiring 2-3 additional staff

Query 4: Attrition by Marital Status
- Single: 120 left out of 470 (25.53%)
- Married: 84 left out of 673 (12.48%)
- Divorced: 33 left out of 327 (10.09%)
- ACTION: Create engagement programs for single employees

Query 5: Attrition by Business Travel
- Frequent travelers: 69 left out of 277 (24.91%)
- Rare travelers: 156 left out of 1043 (14.96%)
- Non-travelers: 12 left out of 150 (8.00%)
- ACTION: Cap frequent travel to max 2 trips per month

Query 6: Attrition by Job Role
- Sales Rep: 33 left out of 83 (39.76%) - CRITICAL
- Lab Technician: 62 left out of 259 (23.94%)
- HR: 12 left out of 52 (23.08%)
- Manager: only 5 left out of 102 (4.90%)
- Research Director: only 2 left out of 80 (2.50%)
- ACTION: Immediate salary review for Sales Representatives

Query 7: Average Income Comparison
- Attrited avg salary = 4787 vs Retained = 6832
- Exact salary gap = 2045 per month (30% less)
- Attrited avg age = 33.61 vs Retained = 37.56
- Attrited avg tenure = 5.13 vs Retained = 7.37 years
- ACTION: Salary increment of 2000+ can reduce attrition

Query 8: Attrition by Income Group
- Low (<3K): 113 left out of 395 (28.61%) - HIGHEST RISK
- Mid (3-6K): 66 left out of 519 (12.72%)
- High (6-10K): 33 left out of 275 (12.00%)
- Very High (>10K): 25 left out of 281 (8.90%)
- ACTION: Priority salary hike for 395 low income employees

Query 9: Attrition by Age Group
- Young (18-24): 38 left out of 97 (39.18%) - CRITICAL
- Early Career (25-34): 112 left out of 554 (20.22%)
- Senior (45+): 36 left out of 314 (11.46%)
- Mid Career (35-44): 51 left out of 505 (10.10%)
- ACTION: Career growth programs needed for under 34 age group

Query 10: High Risk Employees Identified
- 10 specific employees flagged by EmployeeNumber
- All working overtime + lowest satisfaction (1) + income <3K
- Mostly Lab Technicians and Research Scientists in R&D
- ACTION: HR must contact these 10 employees immediately
- Risk: Losing critical technical talent if ignored

Query 11: Department Satisfaction Scores
- HR dept: Job Satisfaction = 2.60 (LOWEST)
- R&D dept: Job Satisfaction = 2.73
- Sales dept: Job Satisfaction = 2.75 (highest)
- All scores below 3.0 out of 4.0
- ACTION: Company wide satisfaction improvement needed

Query 12: Attrition by Experience
- New (0-2 yrs): 102 left out of 342 (29.82%) - HIGHEST
- Junior (3-5 yrs): 60 left out of 434 (13.82%)
- Mid (6-10 yrs): 55 left out of 448 (12.28%)
- Senior (10+ yrs): 20 left out of 246 (8.13%)
- ACTION: Improve onboarding program for first 2 years

=================================================
TOP 5 BUSINESS RECOMMENDATIONS
=================================================
1. Reduce overtime — 416 employees at 30.53% risk
2. Salary hike for 395 low income (<3K) employees
3. Immediate intervention for 10 high risk employees
4. Career programs for young employees (18-34 age group)
5. Cap frequent business travel to reduce 24.91% attrition
*/

# Department wise Average Satisfaction
SELECT 
    Department,
    ROUND(AVG(JobSatisfaction), 2) AS Avg_Job_Satisfaction,
    ROUND(AVG(WorkLifeBalance), 2) AS Avg_WorkLife_Balance,
    ROUND(AVG(EnvironmentSatisfaction), 2) AS Avg_Environment_Satisfaction,
    COUNT(*) AS Total_Employees
FROM hr_attrition_clean
GROUP BY Department
ORDER BY Avg_Job_Satisfaction ASC;

#Years At Company vs Attrition
SELECT 
    CASE 
        WHEN YearsAtCompany <= 2 THEN 'New (0-2 years)'
        WHEN YearsAtCompany <= 5 THEN 'Junior (3-5 years)'
        WHEN YearsAtCompany <= 10 THEN 'Mid (6-10 years)'
        ELSE 'Senior (10+ years)'
    END AS Experience_Group,
    COUNT(*) AS Total,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attrited,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Attrition_Rate
FROM hr_attrition_clean
GROUP BY Experience_Group
ORDER BY Attrition_Rate DESC;