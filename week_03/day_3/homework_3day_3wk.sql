-----MVP-----
----Q1----
SELECT *
FROM pay_details 
WHERE local_account_no IS NULL AND iban IS NULL;

---Q2----
SELECT first_name, 
	last_name,
	country 
FROM employees 
ORDER BY country ASC NULLS LAST, last_name ASC NULLS LAST;

--Q3----
SELECT *
FROM employees
ORDER BY salary DESC NULLS LAST 
LIMIT 10;

---Q4---
SELECT first_name,
	last_name,
	salary
FROM employees 
WHERE country = 'Hungary'
ORDER BY salary ASC NULLS LAST; 

---Q5---
SELECT *
FROM employees
WHERE email LIKE '%yahoo%';

--Q6---
SELECT count(id) AS number_of_people, 
	pension_enrol
FROM employees 
GROUP BY pension_enrol;

---Q7---
SELECT department, fte_hours, max(salary) AS maximum_salary 
FROM employees
GROUP BY department, fte_hours
having department = 'Engineering' AND fte_hours = 1;

---Q8---
SELECT country, count(id) AS number_of_people, avg(salary)
FROM employees 
GROUP BY country
HAVING count(id) > 30
ORDER BY avg(salary) DESC NULLS LAST ; 

---Q9---
SELECT first_name, last_name, fte_hours, salary,
	fte_hours * salary AS effective_yearly_salary
FROM employees;

---Q10---
SELECT e.first_name, e.last_name
FROM employees AS e LEFT JOIN pay_details AS p
ON e.id = p.id 
WHERE p.local_tax_code IS NULL;

--Q11---
SELECT e.first_name , e.last_name, (48 * 35 * CAST(t.charge_cost AS int) - e.salary)* e.fte_hours AS expected_profit
FROM employees AS e LEFT JOIN teams AS t
ON e.team_id = t.id;

---Q12---
SELECT department, avg(salary) AS avg_salary, avg(fte_hours) AS avg_fte_hours
FROM employees
GROUP BY department;



WITH dsa(department, avg_salary, avg_fte_hours) AS (
SELECT department, avg(salary) AS avg_salary, avg(fte_hours) AS avg_fte_hours
FROM employees
GROUP BY department
) 
SELECT e.id, e.first_name, e.last_name, e.salary, e.fte_hours, e.department,
	e.salary/dsa.avg_salary AS salary_ratio, e.fte_hours / dsa.avg_fte_hours AS fte_ratio
FROM employees AS e left JOIN dsa ON dsa.department = e.department
WHERE e.department = 'Legal';


WITH biggest_dept(name, avg_salary, avg_fte_hours) AS (
  SELECT 
     department,
     AVG(salary),
     AVG(fte_hours)
  FROM employees
  GROUP BY department
  ORDER BY COUNT(id) DESC NULLS LAST
  LIMIT 1
)
SELECT
  e.id,
  e.first_name,
  e.last_name, 
  e.salary / bd.avg_salary AS salary_over_dept_avg,
  e.fte_hours / bd.avg_fte_hours AS fte_hours_over_dept_avg
FROM employees AS e CROSS JOIN biggest_dept AS bd
WHERE department = bd.name;

SELECT 
	id, 
	first_name, 
	last_name, 
	salary,
	fte_hours,
	department,
	salary/AVG(salary) OVER () AS ratio_avg_salary,
	fte_hours/AVG(fte_hours) OVER () AS ratio_fte_hours
FROM employees
WHERE department = (
	SELECT
	department
FROM employees 
GROUP BY department
ORDER BY COUNT(id) DESC
LIMIT 1);
WITH biggest_dept(name, avg_salary, avg_fte_hours) AS (
	SELECT
		department,
		AVG(salary),
		AVG(fte_hours)
	FROM employees 
	GROUP BY department
	ORDER BY COUNT(id) DESC NULLS LAST
	LIMIT 1
)
SELECT 
	*
FROM employees AS e
INNER JOIN biggest_dept AS db
ON e.department = db.name; 

-----Extension-----
----Q1----
SELECT first_name, count(id) AS number_of_people
FROM employees 
WHERE first_name IS NOT NULL 
GROUP BY first_name
HAVING count(id) >1 
ORDER BY number_of_people DESC, first_name ASC;

----Q2----
SELECT id, COALESCE(CAST (pension_enrol AS varchar), 'unknown') AS pension_enrol
FROM employees 

---Q3---
SELECT e.first_name, e.last_name, e.email, e.start_date, 
	employees_committees.committee_id, now() - start_date AS time_at_work 
FROM employees AS e left JOIN employees_committees 
ON e.id = employees_committees.employee_id 
WHERE employees_committees.committee_id = 3
ORDER BY time_at_work DESC NULLS LAST;


SELECT 
  e.first_name, 
  e.last_name, 
  e.email, 
  e.start_date
FROM 
employees AS e INNER JOIN employees_committees AS ec
ON e.id = ec.employee_id
INNER JOIN committees AS c
ON ec.committee_id = c.id
WHERE c.name = 'Equality and Diversity'
ORDER BY e.start_date ASC NULLS LAST;
---Q4---

SELECT count(DISTINCT ec.employee_id), 
CASE WHEN e.salary < 40000 THEN 'low'
	WHEN e.salary >= 40000 THEN 'high'
	ELSE 'none' END AS salary_class 
FROM employees AS e INNER JOIN employees_committees AS ec
ON e.id = ec.employee_id 
GROUP BY salary_class;


SELECT 
  CASE 
    WHEN e.salary < 40000 THEN 'low'
    WHEN e.salary IS NULL THEN 'none'
    ELSE 'high' 
  END AS salary_class,
  COUNT(DISTINCT(e.id)) AS num_committee_members
FROM employees AS e INNER JOIN employees_committees AS ec
ON e.id = ec.employee_id
INNER JOIN committees AS c
ON ec.committee_id = c.id
GROUP BY salary_class;




	