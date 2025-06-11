#mysql learning intermideate 
#topics covered - JOINS, UNIONS, SRING FUNCTIONS, SUBstring, CASE STATEMENTS, window function

##JOINS - connects two sql tables 
#inner joins - join is by default inner join. joins two tables by same col 
 
SELECT *
FROM employee_demographics;

SELECT *
FROM employee_salary;

SELECT *
FROM employee_demographics AS dem
INNER JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id;
    
#OUTER JOIN - JOINS TABLES REGARDLESS OF EMPTY col

SELECT *
FROM employee_demographics AS dem
RIGHT JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id;
    
#SELF JOIN - where a table is joined with itself

SELECT *
FROM employee_salary emp1
JOIN employee_salary emp2
	ON emp1.employee_id = emp2.employee_id;

SELECT *
FROM employee_salary emp1
JOIN employee_salary emp2
	ON emp1.employee_id + 1 = emp2.employee_id;
    
##UNIONS - combine select statements 
SELECT first_name, last_name
FROM employee_demographics
UNION ALL
SELECT first_name, last_name
FROM employee_salary;


#EXAMPLE - finding old and high paying employee to reduce cost

SELECT first_name, last_name, 'Old man' AS Label
FROM employee_demographics
WHERE age > 40 AND gender = 'male'
UNION
SELECT first_name, last_name, 'Old lady' AS Label
FROM employee_demographics
WHERE age > 40 AND gender = 'female'
UNION	
SELECT first_name, last_name, 'high paying' AS Label
FROM employee_salary
WHERE salary > 70000;

##STRING FUNCTION
#1.LENGTH - gives length

SELECT LENGTH ('skyfall');

SELECT first_name, LENGTH(first_name)
FROM employee_demographics
ORDER BY 2 ;

#2.UPPER - uppper case char , LOWER - lower case char
SELECT UPPER ('skyfall');
SELECT LOWER ('skyfall');

#3. TRIM - removes the space , variants- LTRIM (LEFT), RTRIM(RIGHT)

SELECT LTRIM ('       skyfall     ');

#select term from right or left
##SUBSTRING - choosing char next to

SELECT first_name,
LEFT(first_name, 4),
RIGHT(first_name, 4),
SUBSTRING(first_name,0,2)
FROM employee_demographics;

## REPLACE

SELECT first_name, REPLACE(first_name, 'a', 'z')
FROM employee_demographics;

##LOCATE 

SELECT first_name, LOCATE('An', first_name)
FROM employee_demographics;

#--- CASE STATEMENTS

SELECT first_name, 
Last_name,
CASE
	WHEN age <= 30 THEN 'Young'	
    WHEN age BETWEEN 31 AND 50 THEN 'Old'
    WHEN age >= 50 THEN ' On Death Door'
END AS Age_bracket 
FROM employee_demographics;

#EXAMPLE
-- bounus and pay inc detrmine salary and their bonous
-- pay Increse and Bonus
-- < 50000 = 5%
-- > 50000 = 7%
-- finance = 10%

SELECT first_name, last_name, salary,
CASE
	WHEN salary < 50000 THEN salary + (salary * 0.05)
    WHEN salary = 50000 THEN salary + (salary * 0.06)
    WHEN salary > 50000 THEN salary + (salary * 0.07)
    WHEN dept_id = 6 THEN salary + (salary * 0.1)
END as New_Salary
FROM employee_salary;

-- SUB QUERIES

SELECT *
FROM employee_demographics
WHERE employee_id IN 
				(SELECT employee_id
					FROM employee_salary
					WHERE dept_id = 1)

;

SELECT *   
FROM employee_salary; 

-- WINDOW FUNCTION
##group by way
SELECT dept_id, AVG(salary)
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
GROUP BY dept_id;

#window way
SELECT dem.first_name, dem.last_name, salary, 
SUM(salary) OVER(PARTITION BY gender ORDER BY dem.employee_id) AS rolling
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id;

