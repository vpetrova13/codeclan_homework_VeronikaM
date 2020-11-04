-----MVP------
-----Q1-----
SELECT 
	e.*,
	p.local_account_no,
	p.local_sort_code
FROM employees AS e LEFT JOIN pay_details AS p
ON e.pay_detail_id = p.id ;

----Q2----
SELECT 
	t.name,
	e.*,
	p.local_account_no,
	p.local_sort_code
FROM employees AS e LEFT JOIN pay_details AS p 
ON e.pay_detail_id = p.id LEFT JOIN teams AS t 
ON e.team_id = t.id;

-----Q3-----
SELECT 
	e.first_name,
	e.last_name,
	t.name,
	t.charge_cost 
FROM employees AS e LEFT JOIN teams AS t
ON e.team_id = t.id
WHERE CAST (t.charge_cost AS int) > 80
order BY e.last_name ASC NULLS LAST;

---Q4---
SELECT
	t.name AS team_name,
	count(e.id) AS number_of_people 
FROM employees AS e RIGHT JOIN teams AS t 
ON e.team_id = t.id 
GROUP BY t.name
ORDER BY number_of_people ASC;

--Q5---
SELECT 
	id,
	first_name,
	last_name,
	fte_hours,
	salary,
	salary * fte_hours AS effective_salary,
	sum(fte_hours * salary) OVER (ORDER BY fte_hours*salary ASC NULLS last) AS running_total
FROM employees;

---Q6---

SELECT
	t.name AS team_name,
	count(e.id) * CAST(t.charge_cost AS int) AS total_day_charge
FROM employees AS e left JOIN teams AS t 
ON e.team_id = t.id 
GROUP BY t.id;

---7---
SELECT
	t.name AS team_name,
	count(e.id) * CAST(t.charge_cost AS int) AS total_day_charge
FROM employees AS e left JOIN teams AS t 
ON e.team_id = t.id 
GROUP BY t.id
HAVING count(e.id) * CAST(t.charge_cost AS int) > 5000;

-----Extension----
-----Q1----
SELECT count(DISTINCT (employee_id)) AS number_of_employees_in_committee
FROM employees_committees;

---Q2----
SELECT count(DISTINCT e.id) - count(DISTINCT ec.employee_id) 
FROM employees AS e left JOIN employees_committees AS ec 
ON e.id = ec.employee_id
WHERE ec.employee_id IS NULL ;



SELECT count(id) 
FROM employees 
WHERE id NOT IN (SELECT employee_id FROM employees_committees);



WITH 
employees_on_committees(num) AS (
  SELECT 
    COUNT(DISTINCT(employee_id))
  FROM employees_committees
),
total_employees(num) AS (
  SELECT 
    COUNT(id)
  FROM employees
)
SELECT 
  total_employees.num - employees_on_committees.num 
    AS num_not_in_committees
FROM employees_on_committees CROSS JOIN total_employees;

---Q3---
SELECT *
FROM employees RIGHT JOIN employees_committees 
ON employees.id = employees_committees.employee_id LEFT JOIN committees 
ON employees_committees.committee_id = committees.id
WHERE country = 'China';

SELECT 
  e.*, 
  c.name AS committee_name
FROM employees AS e INNER JOIN employees_committees AS ec
ON e.id = ec.employee_id
INNER JOIN committees AS c
ON ec.committee_id = c.id
WHERE e.country = 'China';

---Q4----
SELECT count(DISTINCT e.id) AS no_of_people, teams.name
FROM employees AS e RIGHT JOIN employees_committees 
ON e.id = employees_committees.employee_id FULL JOIN teams 
ON e.team_id = teams.id 
GROUP BY teams.name
ORDER BY no_of_people DESC NULLS LAST;
