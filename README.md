# HR Employee Attrition Analysis

## Project Overview

This project analyzes employee attrition patterns using SQL, Power BI, and DAX.

The objective is to identify workforce patterns, understand factors associated with higher attrition, identify higher-risk employee segments, and provide HR-focused recommendations.

## Tools Used

- MySQL
- Power BI
- DAX
- Excel
- CSV Dataset

## Business Questions

1. What is the overall employee attrition rate?
2. Which departments and job roles have higher attrition?
3. Which employee factors are associated with higher attrition?
4. Which employee groups have higher attrition risk?
5. Which employees should HR review first?

## Dashboard

The Power BI dashboard contains five pages:

### 1. HR Attrition Overview

Provides an overall view of:
- Total Employees
- Attrition Count
- Attrition Rate
- Average Monthly Income
- Attrition by Department
- Attrition by Job Role
- Attrition by Overtime

### 2. Attrition Drivers

Analyzes attrition in relation to:
- Salary Band
- Tenure Group
- Job Satisfaction
- Work-Life Balance
- Environment Satisfaction
- Business Travel

### 3. Workforce Profile

Provides workforce composition by:
- Job Role
- Department
- Age Group
- Gender
- Education Level

### 4. Attrition Risk Analysis

Analyzes higher-risk employee segments using:
- Job Level
- Overtime
- Salary Band
- Tenure Group

A rule-based high-risk segment was identified using:

- Job Level = 1
- Overtime = Yes
- Salary Band = Low
- Tenure Group = Less than 2 years

### 5. Employee Action View

Provides employee-level details for the identified high-risk segment to support HR review and targeted retention actions.

## Key Findings

- Overall employee attrition rate is approximately 16.12%.
- Attrition is higher in some departments and job roles than others.
- Employees working overtime show higher attrition rates.
- Frequent business travel is associated with higher attrition.
- Lower job satisfaction is associated with higher attrition.
- Early-tenure employees represent an important retention area.
- Job Level 1 employees show relatively higher attrition.
- The identified high-risk segment contains 29 employees.

## HR Recommendations

Based on the observed patterns, HR could consider:

- Reviewing workload and overtime levels.
- Strengthening early-tenure employee support.
- Improving employee engagement and satisfaction.
- Reviewing career development opportunities.
- Reviewing compensation competitiveness.
- Conducting targeted retention discussions with higher-risk employee groups.

## Analytical Limitation

This analysis identifies associations and patterns in the dataset; it does not establish causal relationships.

The identified high-risk segment is a rule-based analytical segment and should not be interpreted as a predictive attrition model.

## Project Structure

```text
HR-Employee-Attrition-Analysis/
│
├── README.md
│
├── data/
│   └── employee_attrition_clean.csv
│
├── sql/
│   └── hr_attrition_analysis.sql
│
├── powerbi/
│   └── HR_Employee_Attrition_Analysis.pbix
│
└── screenshots/
    ├── page1_overview.png
    ├── page2_attrition_drivers.png
    ├── page3_workforce_profile.png
    ├── page4_risk_analysis.png
    └── page5_employee_action.png
