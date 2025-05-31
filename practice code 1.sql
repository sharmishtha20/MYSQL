#select statements
SELECT *
FROM parks_and_recreation.employee_demographics;

SELECT age, gender,
age + 10
FROM parks_and_recreation.employee_demographics;

SELECT DISTINCT gender, age
FROM parks_and_recreation.employee_demographics;

#filtering data
#WHERE CLAUSE - to fulfill specific condition

SELECT *
FROM employee_salary
WHERE salary <= 50000;

SELECT *
FROM employee_demographics
WHERE gender != 'Female';

SELECT *
FROM employee_demographics
where birth_date > '1985-03-04';

# LOGICAL OPERATORS - AND OR NOT -
#and - both them are true
SELECT *
FROM employee_demographics
WHERE birth_date > '1985-03-04'
AND gender = 'Female';

#or is for if one of them is true
SELECT *
FROM employee_demographics
where birth_date > '1985-03-04'
OR gender = 'Female';

#LIKE STATEMENT 
# % - FIRST IT IS LIKE JERR AND THEN ANYTHING
SELECT *
FROM employee_demographics
WHERE first_name LIKE 'Jer%';

SELECT *
FROM employee_demographics
WHERE first_name LIKE '%er%';

#_ - specify no of char after that
SELECT *
FROM employee_demographics
WHERE first_name LIKE 'Jer__';

#combine both 
SELECT *
FROM employee_demographics
WHERE first_name LIKE 'Je_%';

#GROUP BY - groups rows by conditions
#for non aggreagted fun (gender)

SELECT gender
FROM employee_demographics 
GROUP BY gender;

#for aggreagted func - mention at selct only (avg age)

SELECT gender, AVG(age)
FROM employee_demographics 
GROUP BY gender;

SELECT gender, AVG(age), MIN(age), MAX(age), COUNT(age)
FROM employee_demographics 
GROUP BY gender;


#ORDER BY - (A-Z,1-0)
#ASC - accending, DESC - decendding

SELECT *
FROM employee_demographics
ORDER BY 4, 5 DESC;

#HAVING - specifically created for groupby filter (alternate to where)

SELECT gender, AVG(age)
FROM employee_demographics
GROUP BY gender
HAVING AVG(age) > 30
;

#using both where and having , in following eg we have filterd out occupation by managers only then we filter out there salary by having 

SELECT occupation, AVG(salary)
FROM employee_salary
WHERE occupation like '%manager%'
GROUP BY occupation
HAVING AVG(salary) > 75000;

## LIMIT - specifies how many rows u want in output

#top 3 rows
SELECT *
FROM employee_demographics
LIMIT 3;

#OLDEST EMPLOYEE
SELECT *
FROM employee_demographics
ORDER BY age DESC
LIMIT 2, 1; # 1 means taking 1 row after 2 which is 3 it will be displayed 

##ALIASING - giving name to fun such as avg, min. - denoted as 'AS'

SELECT gender, AVG(age) AS avg_age
FROM employee_demographics
GROUP BY gender
HAVING avg_age > 40;



	