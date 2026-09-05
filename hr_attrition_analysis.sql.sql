CREATE TABLE employees.employee_attrition_clean AS
SELECT *
FROM employees.employee_attrition;
select * from employees.employee_attrition_clean;
select count(*) from employees.employee_attrition_clean;
ALTER TABLE employees.employee_attrition_clean
ADD COLUMN tenure INT;
SET SQL_SAFE_UPDATES = 0;

UPDATE employees.employee_attrition_clean
SET tenure = TotalWorkingYears;
SET SQL_SAFE_UPDATES = 1;
SELECT
    EmployeeNumber,
    TotalWorkingYears,
    tenure
FROM employees.employee_attrition_clean
LIMIT 10;

SET SQL_SAFE_UPDATES = 0;
ALTER TABLE employees.employee_attrition_clean
DROP COLUMN Age_group;
Alter table  employees.employee_attrition_clean
ADD COLUMN Age_group varchar(20);
UPDATE employees.employee_attrition_clean
set Age_group = 
case when age < 25 then 'Under 25' 
when age between 25 AND 34 then '25-34'
when age between 35 AND 44 then '35-44' 
when age between 45 AND 54 then '45-54' else '55+' end ;
Alter table  employees.employee_attrition_clean
ADD COLUMN Salary_band varchar(20);
update employees.employee_attrition_clean
set Salary_band = 
case when MonthlyIncome < 3000 then 'Low' 
when MonthlyIncome between  3000 AND 5999 then  'Lower-mid'
when MonthlyIncome between 6000 AND 9999  then 'Mid'
when MonthlyIncome between 10000 AND 14999 then 'Upper-mid' else 'High' end ;
Alter table  employees.employee_attrition_clean
ADD COLUMN tenure_group varchar(50);
update employees.employee_attrition_clean
set tenure_group = 
case when tenure < 2 then 'Less than 2' 
when tenure between  2 AND 5 then '2-5 Years' else 'More Than 5 years' end ;

-- ==========================================
-- PHASE 3: HR ANALYSIS
-- ==========================================
-- CASE 1: COMPANY WORKFORCE OVERVIEW

select count(EmployeeNumber) as total_employees , 
count(case when Attrition = 'Yes' then 1 end) as total_attrition , 
round(count(case when Attrition = 'Yes' then 1 end) / count(*) * 100.0,2) as Attrition_rate , 
round(avg(MonthlyIncome),2) as Avg_Monthly_Income , round(avg(tenure),2) as avg_tenure 
from employees.employee_attrition_clean;

-- CASE 2: Attrition by Department
select Department , count(*) as Total_employees, count(case when Attrition = 'Yes' then 1 end ) as dep_Attrition_count , 
round(count(case when Attrition = 'Yes' then 1 end)/count(*) * 100.0,2) as Attrition_rate
from employees.employee_attrition_clean group by Department;

-- Case 3: Attrition by job roles 
select jobRole , count(*) as No_of_empl , count(case when Attrition = 'Yes' then 1 end ) as empl_Attrition 
,round(count(case when Attrition = 'Yes' then 1 end )/count(*) * 100.0 ,2) as Attrition_rate
from employees.employee_attrition_clean group by JobRole; 
-- Case 4 : Overtime & Attrition

select count(*) as Employee_count ,overtime, count(case when Attrition = 'Yes' then 1 end ) as 
Attrition_count,
round(count(case when Attrition = "Yes" then 1 end)/count(*) * 100.0,2) as attrition_rate from 
employees.employee_attrition_clean  group by overtime;

-- Case 5 :  Attrition by age_group

select count(*) as Employee_count ,age_group, count(case when Attrition = 'Yes' then 1 end ) as 
Attrition_count,
round(count(case when Attrition = "Yes" then 1 end)/count(*) * 100.0,2) as attrition_rate from 
employees.employee_attrition_clean  group by age_group;

-- Case 6: Attrition by Salary Band

select count(*) as Employee_count ,salary_band, count(case when Attrition = 'Yes' then 1 end ) as 
Attrition_count,
round(count(case when Attrition = "Yes" then 1 end)/count(*) * 100.0,2) as attrition_rate from 
employees.employee_attrition_clean  group by salary_band;

-- Case 7: Attrition by Tenure_group

select count(*) as Employee_count, tenure_group, count(case when Attrition = 'Yes' then 1 end ) as 
Attrition_count,
round(count(case when Attrition = "Yes" then 1 end)/count(*) * 100.0,2) as attrition_rate from 
employees.employee_attrition_clean  group by tenure_group;

-- Case 8: department Attrition when overtime = yes

select count(*) as Employee_count, Department, count(case when Attrition = 'Yes' then 1 end ) as 
Attrition_count,
round(count(case when Attrition = "Yes" then 1 end)/count(*) * 100.0,2) as attrition_rate from 
employees.employee_attrition_clean where overtime = "yes"  group by Department;

--  Case 9: Overtime × Job Role AND attrition

select count(*) as Employee_count, JobRole, count(case when Attrition = 'Yes' then 1 end ) as 
Attrition_count,
round(count(case when Attrition = "Yes" then 1 end)/count(*) * 100.0,2) as attrition_rate from 
employees.employee_attrition_clean where overtime = "yes"  group by JobRole;

--  Case 10 :  Low Salary , Overtime , Attrition

select count(*) as Employee_count,  count(case when Attrition = 'Yes' then 1 end ) as 
Attrition_count,
round(count(case when Attrition = "Yes" then 1 end)/count(*) * 100.0,2) as attrition_rate from 
employees.employee_attrition_clean where Salary_band = 'Low' AND Overtime = 'Yes' ;
select * from employees.employee_attrition_clean;

--  Case 11: Early Tenure + Overtime + Attrition

select count(*) as Employee_count,  count(case when Attrition = 'Yes' then 1 end ) as 
Attrition_count,
round(count(case when Attrition = "Yes" then 1 end)/count(*) * 100.0,2) as attrition_rate from 
employees.employee_attrition_clean where tenure_group = 'Less than 2' AND Overtime = 'Yes' ;

-- Case 12 : Early Tenure + Low Salary + Overtime

select count(*) as Employee_count,  count(case when Attrition = 'Yes' then 1 end ) as 
Attrition_count,
round(count(case when Attrition = "Yes" then 1 end)/count(*) * 100.0,2) as attrition_rate from 
employees.employee_attrition_clean where  salary_band = 'Low' AND 
tenure_group = 'Less than 2' AND Overtime = 'Yes' ;

-- Case 13: Department + Overtime + Low Salary

select count(*) as Employee_count, Department,  count(case when Attrition = 'Yes' then 1 end ) as 
Attrition_count,
round(count(case when Attrition = "Yes" then 1 end)/count(*) * 100.0,2) as attrition_rate from 
employees.employee_attrition_clean where  salary_band = 'Low' AND Overtime = 'Yes'  group by Department;

-- Case 14: JobRole + Overtime + Low Salary

select count(*) as Employee_count, JobRole,  count(case when Attrition = 'Yes' then 1 end ) as 
Attrition_count,
round(count(case when Attrition = "Yes" then 1 end)/count(*) * 100.0,2) as attrition_rate from 
employees.employee_attrition_clean where  salary_band = 'Low' AND Overtime = 'Yes' 
AND tenure_group = 'Less than 2'  group by JobRole;

-- Case 15: Attrition by job Satisfaction

select count(*) as Employee_count, JobSatisfaction,  count(case when Attrition = 'Yes' then 1 end ) as 
Attrition_count,
round(count(case when Attrition = "Yes" then 1 end)/count(*) * 100.0,2) as attrition_rate from 
employees.employee_attrition_clean   group by JobSatisfaction;

-- Case 16 — Job Satisfaction + Overtime + Attrition

select count(*) as Employee_count, JobSatisfaction, overtime ,  count(case when Attrition = 'Yes' then 1 end ) as 
Attrition_count,
round(count(case when Attrition = "Yes" then 1 end)/count(*) * 100.0,2) as attrition_rate from 
employees.employee_attrition_clean where overtime = 'Yes'   group by JobSatisfaction;

select count(*) as Employee_count, JobSatisfaction, overtime ,  count(case when Attrition = 'Yes' then 1 end ) as 
Attrition_count,
round(count(case when Attrition = "Yes" then 1 end)/count(*) * 100.0,2) as attrition_rate from 
employees.employee_attrition_clean    group by JobSatisfaction , overtime ;

-- Case 17 — Performance Rating × Attrition

select count(*) as Employee_count, PerformanceRating ,  count(case when Attrition = 'Yes' then 1 end ) as 
Attrition_count,
round(count(case when Attrition = "Yes" then 1 end)/count(*) * 100.0,2) as attrition_rate from 
employees.employee_attrition_clean    group by PerformanceRating ;

--  Case 18 — Distance From Home × Attrition

ALTER TABLE employees.employee_attrition_clean
ADD COLUMN DistanceGroup varchar (50);

SET SQL_SAFE_UPDATES = 0;
UPDATE employees.employee_attrition_clean
SET DistanceGroup = 
case when DistanceFromHome <= 10 then 'Near by home'
when DistanceFromHome Between 11 AND 20 then 'away from home'
when DistanceFromHome Between 21 AND 30 then 'far away from home' else 'Not covered from home' end; 

select count(*) as Employee_count, DistanceGroup ,  count(case when Attrition = 'Yes' then 1 end ) as 
Attrition_count,
round(count(case when Attrition = "Yes" then 1 end)/count(*) * 100.0,2) as attrition_rate from 
employees.employee_attrition_clean    group by DistanceGroup ;

-- case 19 - Business Travel × Attrition

select count(*) as Employee_count, BusinessTravel ,  count(case when Attrition = 'Yes' then 1 end ) as 
Attrition_count,
round(count(case when Attrition = "Yes" then 1 end)/count(*) * 100.0,2) as attrition_rate from 
employees.employee_attrition_clean    group by BusinessTravel;

-- Case 20 — Work-Life Balance × Attrition

select count(*) as Employee_count, WorkLifeBalance ,  count(case when Attrition = 'Yes' then 1 end ) as 
Attrition_count,
round(count(case when Attrition = "Yes" then 1 end)/count(*) * 100.0,2) as attrition_rate from 
employees.employee_attrition_clean    group by WorkLifeBalance;

-- Case 21 — Job Involvement × Attrition

select count(*) as Employee_count, JobInvolvement,  count(case when Attrition = 'Yes' then 1 end ) as 
Attrition_count,
round(count(case when Attrition = "Yes" then 1 end)/count(*) * 100.0,2) as attrition_rate from 
employees.employee_attrition_clean    group by JobInvolvement;

-- Case 22 — Job Involvement × Overtime

select count(*) as Employee_count, JobInvolvement, overtime,  count(case when Attrition = 'Yes' then 1 end ) as 
Attrition_count,
round(count(case when Attrition = "Yes" then 1 end)/count(*) * 100.0,2) as attrition_rate from 
employees.employee_attrition_clean    group by JobInvolvement, overtime;

alter table employees.employee_attrition_clean
ADD column company_experience_group varchar(50);

update employees.employee_attrition_clean
set company_experience_group = 
case when NumCompaniesWorked <= 2 then 'Low' 
when NumCompaniesWorked between 3 AND 5 then 'Medium' else 'High' end ;

-- Case 23 — NumCompaniesWorked × Attrition

select count(*) as Employee_count, company_experience_group ,  count(case when Attrition = 'Yes' then 1 end ) as 
Attrition_count,
round(count(case when Attrition = "Yes" then 1 end)/count(*) * 100.0,2) as attrition_rate from 
employees.employee_attrition_clean    group by company_experience_group ;


alter table employees.employee_attrition_clean
ADD column company_tenure_group varchar(50);

update employees.employee_attrition_clean
set company_tenure_group = 
case when YearsAtCompany <= 2 then 'Early' 
when YearsAtCompany between 3 AND 5 then 'Developing' 
when YearsAtCompany between 6 AND 10 then 'Established' else 'Long Tenure' end ;

-- Case 24 — Years at Company × Attritions

select count(*) as Employee_count, company_tenure_group ,  count(case when Attrition = 'Yes' then 1 end ) as 
Attrition_count,
round(count(case when Attrition = "Yes" then 1 end)/count(*) * 100.0,2) as attrition_rate from 
employees.employee_attrition_clean    group by company_tenure_group ;

-- Case 25 - Promotion & Attrition

ALTER table employees.employee_attrition_clean
ADD Column promotion_delay_group varchar (50) ;
update employees.employee_attrition_clean
set promotion_delay_group = 
case when YearsSinceLastPromotion <= 1 then  'Recent Promotion' 
when YearsSinceLastPromotion  Between 2 AND  4 then 'Moderate Delay'
else ' Long Delay' end ;

select count(*) as Employee_count, promotion_delay_group ,  count(case when Attrition = 'Yes' then 1 end ) as 
Attrition_count,
round(count(case when Attrition = "Yes" then 1 end)/count(*) * 100.0,2) as attrition_rate from 
employees.employee_attrition_clean    group by promotion_delay_group ;

-- Case 26 — Job Level × Attrition

select count(*) as Employee_count, JobLevel ,  count(case when Attrition = 'Yes' then 1 end ) as 
Attrition_count,
round(count(case when Attrition = "Yes" then 1 end)/count(*) * 100.0,2) as attrition_rate from 
employees.employee_attrition_clean    group by JobLevel ;

-- Case 27 — Job Level × Overtime

select count(*) as Employee_count, JobLevel ,overtime,  count(case when Attrition = 'Yes' then 1 end ) as 
Attrition_count,
round(count(case when Attrition = "Yes" then 1 end)/count(*) * 100.0,2) as attrition_rate from 
employees.employee_attrition_clean    group by JobLevel , overtime ;

-- Case 28 High Rate Segment

select count(*) as Employee_count, Department , JobRole from 
employees.employee_attrition_clean where tenure_group = 'Less than 2'
AND Salary_band = 'Low' AND OverTime = 'Yes'  group by Department , JobRole;

-- Case 29 — High-Risk Segment Ranking
with high_risk_segment as ( select JobRole , count(*) as Employee_count , 
count(case when Attrition = 'Yes' then 1 end) as Attrition_count , 
round(count(case when Attrition = 'Yes' then 1 end)/count(*) *100.0,2) as Attrition_rate 
from employees.employee_attrition_clean
where tenure_group = 'Less than 2' AND Salary_band = 'Low' AND OverTime = 'Yes' group by JobRole),
rnk_segment as (select JobRole , Employee_count , Attrition_count , Attrition_rate , 
dense_rank() over(order by Attrition_rate desc) as dns_rnk from high_risk_segment)
select JobRole , Employee_count , Attrition_count , Attrition_rate ,dns_rnk from rnk_segment;

-- Case 30 — Attrition Risk Profile by Multiple Factors

select JobRole,OverTime, count(*) as Employee_count , count(case when Attrition = 'Yes' then 1 end) as Attrition_count
, round(count(case when Attrition = 'Yes' then 1 end ) / count(*) * 100.0 , 2) as Attrition_rate from 
employees.employee_attrition_clean group by JobRole , OverTime ;

-- Case 31 — Rank JobRole × Overtime over attrition rate

with job_rate as (select JobRole , OverTime , 
count(*) as Employee_count , count(case when Attrition = 'Yes' then 1 end) as Attrition_count,
round(count(case when Attrition = 'Yes' then 1 end ) / count(*) * 100.0 , 2) as Attrition_rate 
from employees.employee_attrition_clean group by JobRole , OverTime )
select  JobRole , OverTime ,Employee_count , Attrition_count,Attrition_rate ,  
dense_rank () over(order by  Attrition_rate desc) as dns_rnk  from job_rate;

-- Case 32 — Rank Departments by Attrition Rate

with dep_att as (select Department, 
count(*) as Employee_count , count(case when Attrition = 'Yes' then 1 end) as Attrition_count,
round(count(case when Attrition = 'Yes' then 1 end ) / count(*) * 100.0 , 2) as Attrition_rate 
from employees.employee_attrition_clean group by Department)
select Department ,Employee_count , Attrition_count,Attrition_rate ,  
dense_rank () over(order by  Attrition_rate desc) as dns_rnk  from dep_att;

-- Case 33 — Department × Overtime Ranking

with dep_att as (select Department, OverTime,
count(*) as Employee_count , count(case when Attrition = 'Yes' then 1 end) as Attrition_count,
round(count(case when Attrition = 'Yes' then 1 end ) / count(*) * 100.0 , 2) as Attrition_rate 
from employees.employee_attrition_clean group by Department , OverTime)
select Department , OverTime , Employee_count , Attrition_count,Attrition_rate ,  
dense_rank () over(order by  Attrition_rate desc) as dns_rnk  from dep_att;

-- Case 34 — Salary Band × Overtime
with dep_att as (select Salary_band, OverTime,
count(*) as Employee_count , count(case when Attrition = 'Yes' then 1 end) as Attrition_count,
round(count(case when Attrition = 'Yes' then 1 end ) / count(*) * 100.0 , 2) as Attrition_rate 
from employees.employee_attrition_clean group by Salary_band , OverTime)
select Salary_band , OverTime , Employee_count , Attrition_count,Attrition_rate ,  
dense_rank () over(order by  Attrition_rate desc) as dns_rnk  from dep_att;

-- Case 35 — Final Interaction Analysis

select Salary_band, OverTime, JobLevel ,
count(*) as Employee_count , count(case when Attrition = 'Yes' then 1 end) as Attrition_count,
round(count(case when Attrition = 'Yes' then 1 end ) / count(*) * 100.0 , 2) as Attrition_rate 
from employees.employee_attrition_clean group by Salary_band , OverTime, JobLevel;

-- Case 36 — Identify the Highest-Risk Segments

with rnk_high_att as (select Salary_band, OverTime, JobLevel ,
count(*) as Employee_count , count(case when Attrition = 'Yes' then 1 end) as Attrition_count,
round(count(case when Attrition = 'Yes' then 1 end ) / count(*) * 100.0 , 2) as Attrition_rate 
from employees.employee_attrition_clean group by Salary_band , OverTime, JobLevel having count(*) >= 20
AND Attrition_rate > 16.12) 
select Salary_band, OverTime, JobLevel ,Employee_count ,Attrition_count,Attrition_rate  , dense_rank()
over(order by Attrition_rate desc) as dns_rnk from rnk_high_att;

-- Case 38 — Add Tenure to the Risk Profile

select Salary_band, OverTime, JobLevel , Tenure_group,
count(*) as Employee_count , count(case when Attrition = 'Yes' then 1 end) as Attrition_count,
round(count(case when Attrition = 'Yes' then 1 end ) / count(*) * 100.0 , 2) as Attrition_rate 
from employees.employee_attrition_clean where Salary_band = 'Low' AND OverTime = 'Yes' AND JobLevel = 1 
group by  Salary_band, OverTime, JobLevel, Tenure_group ; 

-- Case 39 — Identify the Highest-Risk Employees

SELECT EmployeeNumber,Age,Department,JobRole,MonthlyIncome,OverTime,JobLevel,YearsAtCompany,
tenure_group,Attrition from employees.employee_attrition_clean where Salary_band = 'Low' and 
OverTime = 'Yes' and JobLevel = 1 and tenure_group = 'Less than 2' ;

SELECT EmployeeNumber,Age,Department,JobRole,MonthlyIncome,OverTime,JobLevel,YearsAtCompany,
tenure_group,Attrition from employees.employee_attrition_clean where Attrition = 'No' and Salary_band = 'Low' and 
OverTime = 'Yes' and JobLevel = 1 and tenure_group = 'Less than 2' ;

-- Case 41 — Current High-Risk Employees by Department

select Department , count(*) as High_risk_segment_empl  from employees.employee_attrition_clean
where Attrition = 'No' and Salary_band = 'Low' and 
OverTime = 'Yes' and JobLevel = 1 and tenure_group = 'Less than 2'  group by Department;

-- Case 42 — Current High-Risk Employees by Job Role

select JobRole , count(*) as High_risk_segment_empl  from employees.employee_attrition_clean
where Attrition = 'No' and Salary_band = 'Low' and 
OverTime = 'Yes' and JobLevel = 1 and tenure_group = 'Less than 2'  group by JobRole;

-- Case 43 — Current High-Risk Employees: Salary Details

select round(avg(MonthlyIncome),2) as avg_salary , Min(MonthlyIncome) as min_salary, Max(MonthlyIncome) as max_salary,
count(*) as High_risk_segment_empl  from employees.employee_attrition_clean
where Attrition = 'No' and Salary_band = 'Low' and 
OverTime = 'Yes' and JobLevel = 1 and tenure_group = 'Less than 2';

-- Case 44 — Current High-Risk Employees by Age Group

select Age_group , count(*) as High_risk_segment_empl  from employees.employee_attrition_clean
where Attrition = 'No' and Salary_band = 'Low' and 
OverTime = 'Yes' and JobLevel = 1 and tenure_group = 'Less than 2'group by Age_group;

-- Case 45 — High-Risk Employees: Job Satisfaction

select JobSatisfaction , count(*) as High_risk_segment_empl  from employees.employee_attrition_clean
where Attrition = 'No' and Salary_band = 'Low' and 
OverTime = 'Yes' and JobLevel = 1 and tenure_group = 'Less than 2'group by JobSatisfaction;

-- Case 46 — High-Risk Employees: Work-Life Balance

select WorkLifeBalance , count(*) as High_risk_segment_empl  from employees.employee_attrition_clean
where Attrition = 'No' and Salary_band = 'Low' and 
OverTime = 'Yes' and JobLevel = 1 and tenure_group = 'Less than 2'group by WorkLifeBalance;

-- Case 47 — Current High-Risk Employees: Business Travel

select BusinessTravel, count(*) as High_risk_segment_empl  from employees.employee_attrition_clean
where Attrition = 'No' and Salary_band = 'Low' and 
OverTime = 'Yes' and JobLevel = 1 and tenure_group = 'Less than 2'group by BusinessTravel;

-- Case 48 — Create a Final Employee Risk Score

with category_score as  (select Department, CASE WHEN Salary_band = 'Low' THEN 1 ELSE 0 END
+
CASE WHEN OverTime = 'Yes' THEN 1 ELSE 0 END
+
CASE WHEN JobLevel = 1 THEN 1 ELSE 0 END
+
CASE WHEN tenure_group = 'Less than 2' THEN 1 ELSE 0 END
AS risk_score from employees.employee_attrition_clean
where Attrition = 'No'),
category_group as ( select Department ,case when risk_score = 4 then 'High Risk'
 when risk_score = 3 then 'Medium_High_Risk'  
 when risk_score = 2 then 'Medium_Risk' else 'Low_Risk' end  as risk_category, count(*) as 
High_risk_segment_empl from category_score group by case when risk_score = 4 then 'High Risk'
 when risk_score = 3 then 'Medium_High_Risk'  
 when risk_score = 2 then 'Medium_Risk' else 'Low_Risk' end , Department )
select Department , risk_category , High_risk_segment_empl from category_group;

-- Case 50 — Risk Category Percentage by Department

with category_score as  (select Department, CASE WHEN Salary_band = 'Low' THEN 1 ELSE 0 END
+
CASE WHEN OverTime = 'Yes' THEN 1 ELSE 0 END
+
CASE WHEN JobLevel = 1 THEN 1 ELSE 0 END
+
CASE WHEN tenure_group = 'Less than 2' THEN 1 ELSE 0 END
AS risk_score from employees.employee_attrition_clean
where Attrition = 'No'),
category_group as ( select Department ,case when risk_score = 4 then 'High Risk'
 when risk_score = 3 then 'Medium_High_Risk'  
 when risk_score = 2 then 'Medium_Risk' else 'Low_Risk' end  as risk_category, count(*) as 
High_risk_segment_empl from category_score group by case when risk_score = 4 then 'High Risk'
 when risk_score = 3 then 'Medium_High_Risk'  
 when risk_score = 2 then 'Medium_Risk' else 'Low_Risk' end , Department ),
dep_wise as (select Department , risk_category , High_risk_segment_empl, 
SUM(High_risk_segment_empl) OVER (PARTITION BY Department)as dep_total_empl from category_group)
select Department , risk_category , High_risk_segment_empl,dep_total_empl, 
ROUND(
    High_risk_segment_empl / dep_total_empl * 100.0,
    2
) AS risk_percentage from dep_wise;


-- Case 51 — Rank Risk Categories Within Each Department

with category_score as  (select Department, CASE WHEN Salary_band = 'Low' THEN 1 ELSE 0 END
+
CASE WHEN OverTime = 'Yes' THEN 1 ELSE 0 END
+
CASE WHEN JobLevel = 1 THEN 1 ELSE 0 END
+
CASE WHEN tenure_group = 'Less than 2' THEN 1 ELSE 0 END
AS risk_score from employees.employee_attrition_clean
where Attrition = 'No'),
category_group as ( select Department ,case when risk_score = 4 then 'High Risk'
 when risk_score = 3 then 'Medium_High_Risk'  
 when risk_score = 2 then 'Medium_Risk' else 'Low_Risk' end  as risk_category, count(*) as 
High_risk_segment_empl from category_score group by case when risk_score = 4 then 'High Risk'
 when risk_score = 3 then 'Medium_High_Risk'  
 when risk_score = 2 then 'Medium_Risk' else 'Low_Risk' end , Department ),
dep_wise as (select Department , risk_category , High_risk_segment_empl, 
SUM(High_risk_segment_empl) OVER (PARTITION BY Department)as dep_total_empl from category_group)
select Department , risk_category , High_risk_segment_empl,dep_total_empl, 
ROUND(
    High_risk_segment_empl / dep_total_empl * 100.0,
    2
) AS risk_percentage, DENSE_RANK() OVER (PARTITION BY Department ORDER BY High_risk_segment_empl DESC)
as dns_rnk from dep_wise;

-- Find the Highest-Risk Category in Each Department

with category_score as  (select Department, CASE WHEN Salary_band = 'Low' THEN 1 ELSE 0 END
+ CASE WHEN OverTime = 'Yes' THEN 1 ELSE 0 END + CASE WHEN JobLevel = 1 THEN 1 ELSE 0 END +
CASE WHEN tenure_group = 'Less than 2' THEN 1 ELSE 0 END
AS risk_score from employees.employee_attrition_clean
where Attrition = 'No'),
category_group as ( select Department ,risk_score , case when risk_score = 4 then 'High Risk'
 when risk_score = 3 then 'Medium_High_Risk'  
 when risk_score = 2 then 'Medium_Risk' else 'Low_Risk' end  as risk_category, count(*) as 
High_risk_segment_empl from category_score group by case when risk_score = 4 then 'High Risk'
 when risk_score = 3 then 'Medium_High_Risk'  
 when risk_score = 2 then 'Medium_Risk' else 'Low_Risk' end , Department, risk_score ),
 rnk_score  as (select Department , High_risk_segment_empl , risk_score , risk_category , 
 dense_rank() over(partition by Department order by risk_score desc) as dns_rnk from category_group)
 select  Department , High_risk_segment_empl , risk_score , risk_category , dns_rnk from rnk_score 
 where dns_rnk = 1;
 
 DESCRIBE employees.employee_attrition_clean;

-- Case 53 — Attrition by Environment Satisfaction 

select COUNT(*) as  Employee_count ,EnvironmentSatisfaction, COUNT(CASE WHEN Attrition = 'Yes' then 1 end) as  Attrition_count,
round(COUNT(CASE WHEN Attrition = 'Yes' then 1 end) /COUNT(*) * 100.0 ,2) as  Attrition_rate  
from employees.employee_attrition_clean
GROUP BY EnvironmentSatisfaction;

-- Case 54 — Attrition by Relationship Satisfaction

select RelationshipSatisfaction, COUNT(*) as  Employee_count , COUNT(CASE WHEN Attrition = 'Yes' then 1 end) as  Attrition_count,
round(COUNT(CASE WHEN Attrition = 'Yes' then 1 end) /COUNT(*) * 100.0 ,2) as  Attrition_rate  
from employees.employee_attrition_clean
GROUP BY  RelationshipSatisfaction;
 
-- Case 55 — Attrition by Number of Companies Worked

select NumCompaniesWorked, COUNT(*) as  Employee_count , COUNT(CASE WHEN Attrition = 'Yes' then 1 end) as  Attrition_count,
round(COUNT(CASE WHEN Attrition = 'Yes' then 1 end) /COUNT(*) * 100.0 ,2) as  Attrition_rate  
from employees.employee_attrition_clean
GROUP BY  NumCompaniesWorked;




