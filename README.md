# HR Employee Attrition Analysis

## Project Overview
This project analyzes IBM HR Employee Attrition data to identify 
key factors driving employee turnover. The analysis combines 
Python, SQL, and Power BI to deliver actionable insights for 
HR teams and business leaders.

## Business Problem
Employee attrition costs companies 6-9 months of an employee's 
salary to replace them. This project identifies which factors 
most significantly drive attrition and provides actionable 
recommendations to improve employee retention.

## Tools & Technologies
- Python (Pandas, NumPy, Matplotlib, Seaborn, Scipy)
- MySQL (12 Business Queries)
- Power BI (4 Page Interactive Dashboard)
- Jupyter Notebook

## Dataset
- Source: IBM HR Analytics Dataset — Kaggle
- Rows: 1470 employees
- Columns: 32 features (after cleaning)
- Target Variable: Attrition (Yes/No)

## Project Structure
hr-attrition-analysis/
├── HR_Attrition_Analysis.ipynb   
├── hr_attrition_analysis.sql     
├── hr_attrition_clean.csv        
├── HR_Attrition_Analysis.pbix    
└── README.md                     

## Analysis Workflow
1. Data Cleaning & Preprocessing (Python)
2. Exploratory Data Analysis — 16 Variables (Python)
3. Statistical Hypothesis Testing — Chi-Square (Python)
4. Business Query Analysis (SQL)
5. Interactive Dashboard (Power BI)

## Key Findings
- Overall attrition rate = 16.12% (237 out of 1470)
- OverTime is strongest attrition driver
- Overtime employees = 30.53% attrition rate
- Non-overtime employees = only 10.44% attrition rate
- Sales Representatives have highest role attrition (39.76%)
- Young employees (18-24) leave most frequently (39.18%)
- Low income employees (<3K) have 28.61% attrition rate
- Attrited employees earn 30% less than retained ones
- New employees (0-2 years) have 29.82% attrition rate
- All departments have medium satisfaction scores below 3.0
- 10 high risk employees identified for immediate intervention
- Frequent business travelers leave 3x more than non-travelers

## Statistical Analysis
Chi-Square Tests performed on all categorical variables:

| Factor         | P-Value| Result          |
|----------------|--------|-----------------|
| OverTime       | 0.0000 | Significant     |
| MaritalStatus  | 0.0000 | Significant     |
| JobRole        | 0.0000 | Significant     |
| BusinessTravel | 0.0000 | Significant     |
| Department     | 0.0000 | Significant     |
| Gender         | 0.3000 | Not Significant |

## Power BI Dashboard
5 page interactive dashboard containing:
- Page 1: Overview (KPI Cards + Donut Chart)
- Page 2: Department & Role Analysis
- Page 3: Demographics & Income Analysis
- Page 4: Satisfaction & Filters
- Page 5: Key Insights & Recommendations

## Business Recommendations
1. Reduce overtime — 416 employees at 30.53% attrition risk
2. Salary hike for 395 low income employees earning below 3K
3. Immediate HR intervention for 10 high risk employees
4. Career development programs for employees under 34 years
5. Cap frequent business travel to maximum 2 trips per month
6. Improve onboarding program for first 2 years of employment

## Author
Thakur Sai Kiran Singh
- LinkedIn: linkedin.com/in/sai-kiran-singh-thakur-757093285
- GitHub: github.com/Thakursaikiransingh
