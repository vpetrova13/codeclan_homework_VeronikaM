-------- MVP ------------------------------------------------------------------------
--1--
SELECT *
FROM employees 
WHERE department = 'Human Resources';
--2--
SELECT first_name,
	last_name, 
	country
FROM employees 
WHERE department = 'Legal';
--3--
SELECT count(ID)
FROM employees 
WHERE country = 'Portugal';
--4--
SELECT count(ID)
FROM employees 
WHERE country = 'Portugal' OR country = 'Spain';
--5--
SELECT count(id) 
FROM pay_details 
WHERE local_account_no IS NULL ;
--6--
SELECT first_name, last_name 
FROM employees 
ORDER BY last_name NULLS LAST;
--7--
SELECT count(id) 
FROM employees 
WHERE first_name ILIKE 'F%';
--8--
SELECT count(id)
FROM employees 
WHERE pension_enrol = TRUE AND (country NOT IN ('France', 'Germany'));

SELECT count(id)
FROM employees 
WHERE pension_enrol = TRUE AND (country != 'France' OR country != 'Germany');
--9--
SELECT department, count(id)
FROM employees 
WHERE start_date BETWEEN '2013-01-01' AND '2013-12-31'
GROUP BY department ;
--10--
SELECT count(id), department, fte_hours 
FROM employees
GROUP BY department , fte_hours 
ORDER BY department ASC NULLS LAST , fte_hours ASC NULLS LAST ; 
--11--
SELECT count(id) AS total, department 
FROM employees 
WHERE first_name IS NULL 
GROUP BY department 
HAVING count(id) >= 2
ORDER BY total DESC, department ASC;
--12--
SELECT sum(CAST (grade = 1 AS int))/CAST (count(id)AS REAL) , department
FROM employees 
GROUP BY department;

SELECT 
  department, 
  SUM(CAST(grade = '1' AS INT)) / CAST(COUNT(id) AS REAL) AS prop_grade_1 
FROM employees 
GROUP BY department;

SELECT
  department, 
  SUM((grade = '1')::INT) / COUNT(id)::REAL AS prop_grade_1 
FROM employees 
GROUP BY department;

----Extension -------------------
--1--
SELECT EXTRACT (YEAR FROM start_date) AS year_start
FROM employees 
ORDER BY year_start;

SELECT 
  EXTRACT(YEAR FROM start_date) AS year, 
  COUNT(id) AS num_employees_started 
FROM employees 
GROUP BY EXTRACT(YEAR FROM start_date) 
ORDER BY year ASC NULLS LAST;
--2--
SELECT first_name, last_name, salary, 
	CASE WHEN salary < 40000 THEN 'low'
	WHEN salary >= 40000 THEN 'high'
	END AS salary_class
FROM employees 
WHERE salary IS NOT NULL;
--3--
SELECT substring(local_sort_code, 1,2) AS first_two, count(id) AS count_records
FROM pay_details 
GROUP BY first_two
ORDER BY first_two ASC NULLS FIRST, count_records DESC; 

SELECT
  SUBSTRING(local_sort_code, 1, 2) AS first_two_digits,
  COUNT(id) AS count_records
FROM pay_details
GROUP BY SUBSTRING(local_sort_code, 1, 2)
ORDER BY 
  CASE 
    WHEN SUBSTRING(local_sort_code, 1, 2) IS NULL THEN 1
    ELSE 0
  END DESC,
  count_records DESC,
  first_two_digits ASC;
--4--

SELECT regexp_replace(local_tax_code, '\D+', '', 'g')
FROM pay_details ;
