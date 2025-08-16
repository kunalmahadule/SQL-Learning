create database Venom;
use Venom;


-- creating Employee Table 
CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    salary INT,
    country VARCHAR(50)
);

INSERT INTO Employees (emp_id, name, department, salary, country) VALUES
(1, 'John Doe', 'HR', 55000, 'USA'),
(2, 'Alice Ray', 'IT', 72000, 'India'),
(3, 'Mark Lee', 'IT', 68000, 'USA'),
(4, 'Sara Kim', 'Finance', 75000, 'UK'),
(5, 'Alex Roy', 'HR', 51000, 'India'),
(6, 'Emma Lin', 'IT', 80000, 'USA');

select * from Employees;





-- creating Users Table 

CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    username VARCHAR(50),
    country VARCHAR(50),
    signup_date DATE
);

INSERT INTO Users (user_id, username, country, signup_date) VALUES
(101, 'sam123', 'India', '2024-11-10'),
(102, 'jenny88', 'USA', '2025-01-02'),
(103, 'arjun21', 'India', '2025-02-14'),
(104, 'mike007', 'UK', '2024-12-20'),
(105, 'sophie_l', 'USA', '2025-02-01');

select * from users;



DELIMITER $$
create procedure showdata()
begin
select * from Employees;
select * from users;
end $$
DELIMITER ;

call showdata();


# Day 1 -> 
/* 
SELECT, FROM, WHERE
Filtering with AND, OR, NOT
Sorting with ORDER BY (ASC/DESC)
Practice:
Select top 5 highest-paid employees
Filter users from a specific country
 */

-- IT employees in USA only
select name, department, salary, country from employees where department = "it" and country = "usa";


-- Employees either in HR department or earning above 70000
select name, department, salary, country from employees where department="hr" or salary>70000;


-- Employees NOT from India
select * from employees where not country ="india";


-- Employees ordered by salary (highest first)
select * from employees order by salary desc;


-- Top 5 highest-paid employees
select * from employees order by salary desc limit 5;


-- Users from India only
select * from users where country="India";

-- Find IT department employees from USA earning above 70,000,
-- sorted by salary in descending order

select * from employees where department ="it" and country="usa" and salary > 70000 order by salary desc;


-- Get employees earning between 60,000 and 75,000
-- but not from India, sorted by name alphabetically

select * from employees where salary between 60000 and 75000 and not country="india" order by name asc;

-- select * from employees where salary between 60000 and 75000 and country <> "india" order by name asc; 



-- Employees from HR or IT department,
-- but only if they earn above 55,000

select * from employees where (department = "hr" or "it") and salary>55000;


-- Get all employees except Finance department,
-- sort them by department (A-Z) and then by salary (high to low)

select * from employees where not department = 'finance' order by department asc, salary desc;

-- SELECT name, department, salary FROM Employees WHERE department <> 'Finance' ORDER BY department ASC, salary DESC;




-- Get employees whose name starts with 'A' or ends with 'y',
-- and they earn above 50,000

select * from employees where (name like "a%" or name like "%y") and salary>50000;



-- Get users who signed up between 2025-01-01 and 2025-02-15

select * from users where signup_date between '2025-01-01' and '2025-02-15';




-- Get all employees NOT in IT and NOT from USA
select * from employees where not department = "it" and not country ="usa";

-- SELECT name, department, country FROM Employees WHERE department <> 'IT' AND country <> 'USA';




-- Get top 3 highest-paid employees from India only
select name, department, salary, country from employees where country="india" order by salary desc limit 3; 




-- Sort employees first by country A-Z,
-- then by salary in descending order

select * from employees order by country asc, salary desc;


-- Get employees from IT earning above 70,000
-- OR employees from HR earning less than 55,000


select * from employees where (department="it" and salary>70000) OR (department="HR" and salary<55000);






/*
Day 2 – GROUP BY & HAVING
GROUP BY for summarizing
Aggregate functions: COUNT(), SUM(), AVG(), MIN(), MAX()
HAVING to filter groups
Practice:
Find total sales per region
Show only regions with sales > 100K
*/


-- Create the Sales table
CREATE TABLE Sales (
    sale_id INT PRIMARY KEY,
    region VARCHAR(50),
    salesperson VARCHAR(50),
    amount DECIMAL(10,2),
    sale_date DATE
);

-- Insert sample data
INSERT INTO Sales (sale_id, region, salesperson, amount, sale_date) VALUES
(1, 'East',  'John',  50000, '2025-01-10'),
(2, 'West',  'Alice', 30000, '2025-01-12'),
(3, 'East',  'Mark',  70000, '2025-01-15'),
(4, 'South', 'Sara',  45000, '2025-01-18'),
(5, 'West',  'Alex',  60000, '2025-01-20'),
(6, 'East',  'Emma',  90000, '2025-01-22'),
(7, 'South', 'Mark',  30000, '2025-01-25'),
(8, 'West',  'Sara',  85000, '2025-01-28'),
(9, 'East',  'Alice', 40000, '2025-01-30');


-- Show total sales per region.
select region as R, sum(amount) as Total_sales from sales group by region;


-- Number of sales per salesperson
select salesperson, sum(amount) from sales where salesperson = "mark" group by salesperson;
-- select salesperson, sum(amount) from sales group by salesperson having salesperson = "mark";

 -- Average sales per region
select salesperson, avg(amount) as Avg_sales from sales group by region;

-- Maximum sale per region
select region, max(amount) from sales group by region;


-- Regions with sales > 100,000
select region, sum(amount) as reg_sales from sales group by region having reg_sales>100000;


-- Salesperson with more than 1 sale
select salesperson, count(amount) as more_than_1_sale from sales group by salesperson having more_than_1_sale>1; 


-- Regions with average sale > 50,000
select region, avg(amount) as avg_sale from sales group by region having avg_sale>50000;


-- Show the total sales per region for January 2025 only.
select region, sum(amount) as total_sale from sales where sale_date between "2025-01-01" and "2025-01-20" group by region;


CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    department_id INT,
    salary INT
);

-- Create Departments Table
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

-- Create Projects Table
CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(50),
    emp_id INT
);

-- Insert Employees
INSERT INTO employees VALUES
(1, 'Amit', 101, 50000),
(2, 'Priya', 101, 60000),
(3, 'Raj', 102, 55000),
(4, 'Sneha', 103, 70000),
(5, 'Vikram', 102, 45000),
(6, 'Meena', 101, 65000),
(7, 'Rohit', 103, 80000);

-- Insert Departments
INSERT INTO departments VALUES
(101, 'IT'),
(102, 'HR'),
(103, 'Finance');

-- Insert Projects
INSERT INTO projects VALUES
(201, 'AI Automation', 1),
(202, 'Recruitment Drive', 3),
(203, 'Budget Planning', 4),
(204, 'AI Automation', 2),
(205, 'Recruitment Drive', 5),
(206, 'AI Automation', 6);


-- Q1. Find the total salary per department (only if total salary > 1,50,000)


-- Q2. Find the number of employees working in each project


-- Q3. Show departments with average salary above 60,000


-- Q4. List projects with more than 1 employee assigned


-- Q5. For each department, show highest salary employee

select * from employees;









/*
Day 3 Topics – SQL Clauses & Filtering
WHERE Clause – Filtering data based on conditions.
Comparison Operators – =, !=, >, <, >=, <=.
Logical Operators – AND, OR, NOT.
BETWEEN Operator – Range filtering.
IN Operator – Match from multiple values.
LIKE Operator & Wildcards – Pattern matching (% and _).
IS NULL / IS NOT NULL – Handling missing values.
Order of Evaluation in WHERE conditions.
*/




/*
-- Day 3 Joins
Types of Joins 
INNER JOIN
LEFT JOIN / LEFT OUTER JOIN
RIGHT JOIN / RIGHT OUTER JOIN
FULL JOIN / FULL OUTER JOIN --> not supported in MySql (use Union)
CROSS JOIN
SELF JOIN 
*/


use Venom;
show tables;

CREATE TABLE students (
  student_id INT PRIMARY KEY,
  student_name VARCHAR(50),
  course_id INT
);

CREATE TABLE courses (
  course_id INT PRIMARY KEY,
  course_name VARCHAR(50)
);


INSERT INTO students (student_id, student_name, course_id)
VALUES
  (1, 'John Doe', 1),
  (2, 'Jane Smith', 2),
  (3, 'Michael Johnson', 3),
  (4, 'Emily Davis', 4);

INSERT INTO courses (course_id, course_name)
VALUES
  (1, 'Introduction to Computer Science'),
  (2, 'Calculus I'),
  (3, 'English Literature'),
  (4, 'Biology 101');


-- Example: Show students with their enrolled course names
SELECT s.student_id, s.student_name, c.course_name
FROM students s
INNER JOIN courses c
ON s.course_id = c.course_id; -- Match where course_id exists in both


select s.student_id, s.student_name, c.course_name
from students s
inner join courses c
on s.course_id = c.course_id;


select * from students s 
left join courses c
on s.course_id = c.course_id;



select * from students s
right outer join courses c
on c.course_id = s.course_id;


select * from students s
cross join courses c
on c.course_id = s.course_id;



select student_id, student_name from students
union all
select course_name from courses; 



use kunal;

-- Customers Table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50)
);

INSERT INTO customers (customer_id, customer_name, city) VALUES
(1, 'Amit', 'Delhi'),
(2, 'Ravi', 'Mumbai'),
(3, 'Priya', 'Pune'),
(4, 'Neha', 'Delhi'),
(5, 'Kunal', 'Bangalore');

-- Orders Table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product VARCHAR(50),
    amount DECIMAL(10,2),
    order_date DATE
);

INSERT INTO orders (order_id, customer_id, product, amount, order_date) VALUES
(101, 1, 'Laptop', 55000, '2025-08-01'),
(102, 2, 'Mobile', 20000, '2025-08-02'),
(103, 3, 'Tablet', 30000, '2025-08-05'),
(104, 1, 'Headphones', 2000, '2025-08-08'),
(105, 4, 'Keyboard', 1500, '2025-08-09');

-- Extra Table for UNION practice
CREATE TABLE suppliers (
    supplier_id INT PRIMARY KEY,
    supplier_name VARCHAR(50),
    city VARCHAR(50)
);

INSERT INTO suppliers (supplier_id, supplier_name, city) VALUES
(201, 'Tech Supplies', 'Delhi'),
(202, 'Gadget World', 'Pune'),
(203, 'Mobile Hub', 'Chennai');


select * from customers;
select * from orders;
select * from suppliers;



-- Get customer names with their product names from orders.
select c.customer_name, o.product 
from customers c
inner join orders o
on c.customer_id = o.customer_id;


-- List all customers and their orders. If no order, still show customer. 
select  c.customer_name, o.product from customers c 
left join orders o
on c.customer_id = o.customer_id;




-- List all orders with their customer names, even if customer is missing. 
select o.product, c.customer_name from orders o 
right join customers c 
on o.customer_id = c.customer_id;




 -- Show all customers and orders (including those without matches in either table).
select c.customer_name, o.product from customers c
left join orders o 
on c.customer_id = o.customer_id
union
select c.customer_name, o.product from customers c
right join orders o 
on c.customer_id = o.customer_id;





-- Pair each customer with every supplier.
select c.customer_name, s.supplier_name  from customers c
cross join suppliers s
on c.city = s.city;



-- Find customers from the same city.
select c1.customer_name, c1.city from customers c1
join customers c2 
on c1.city = c2.city and c1.customer_name != c2.customer_name;



--  Get all distinct cities from both customers and suppliers.
select c.city from customers c
left join suppliers s
on c.city = s.city
union
select c.city from customers c
right join suppliers s
on c.city = s.city;




 -- Get all cities from both customers and suppliers including duplicates.
select c.city from customers c
left join suppliers s
on c.city = s.city
union all
select c.city from customers c
right join suppliers s
on c.city = s.city;



/*
📌 Day 4 – Conditional Logic in SQL
CASE WHEN → Conditional logic inside queries.
Example: Assign performance ratings based on sales.

NULL handling
IS NULL → Check if a column has NULL values.
COALESCE() → Replace NULL values with a default value.
Pattern Matching
LIKE → Match patterns using % and _.
BETWEEN → Find values within a range.
IN → Match against multiple possible values.
*/

use venom;
select * from employees;

--  CASE WHEN — Conditional Logic
select name, salary,
	case 
		when salary >= 62000 then "Excellent"
        when salary >= 50000 then "Good"
		else "need improvement"
	end as performance
from employees;


-- NULL Handling
SELECT * FROM employees
WHERE salary IS NULL;
drop table employees;


--  Pattern Matching 
SELECT * FROM employees
WHERE name LIKE 'A%';   -- Starts with A


-- Between
SELECT * FROM employees
WHERE salary BETWEEN 50000 AND 80000;

-- IN
SELECT * FROM employees
WHERE name IN ('Amit', 'Priya', 'Vikram');



--  Day 4 Practice Set with a fresh dataset


CREATE TABLE employees (
    emp_id INT,
    name VARCHAR(50),
    department VARCHAR(50),
    salary INT,
    manager_id INT
);

INSERT INTO employees VALUES
    (1, 'Alice', 'HR', 60000, 3),
    (2, 'Bob', 'IT', 80000, NULL),
    (3, 'Charlie', 'Finance', 120000, NULL),
    (4, 'David', 'IT', 45000, 2),
    (5, 'Eva', 'HR', 30000, 1),
    (6, 'Frank', 'Marketing', 50000, 3);
    

select * from employees;

/*
CASE WHEN – Assign performance category based on salary:
Salary ≥ 100000 → 'Excellent'
Salary ≥ 60000 → 'Good'
Else → 'Needs Improvement'
*/

select *,
	case
		when salary >= 100000 then 'Excellent'
        when salary >= 60000 then 'Good'
        else 'Needs Improvement'
	end as 'Performance'
from employees;


-- IS NULL – Get all employees who don’t have a manager assigned.
select * from employees where manager_id is NULL;


-- COALESCE – Display employee name with their manager_id, but if manager_id is NULL, show "No Manager".
select name, coalesce(manager_id, 'No Manager') from employees;


-- LIKE – Get all employees whose names start with "A" or "D".
select * from employees where name like "A%" or name like "D%";


-- LIKE – Get all employees whose name’s second letter is "o".
select * from employees where name like "_o%"; 

 
 -- BETWEEN – Get employees whose salary is between 45000 and 80000.
 select name, salary, coalesce(manager_id, 'No Manager') from employees where salary between 45000 and 80000;
 
 
 -- IN – Get all employees from HR and IT departments only.
select * from employees where department in ('HR','IT');


 /*
 Combine CASE + BETWEEN – Show employee name, salary, and salary_range:
If salary between 30000–50000 → 'Low'
If salary between 50001–90000 → 'Medium'
Else → 'High'
 */
select name, salary, 
	case 
		when salary between 30000 and 50000 then 'Low'
        when salary between 50001 and 90000 then 'Medium'
		else 'High'
	end as 'salary_range'
from employees;



-- Day 5 – Subqueries & Correlated Subqueries
/*
Subqueries (Single Row & Multi Row)
Using a query inside another query
SELECT ... WHERE column > (SELECT ...)
Correlated Subqueries
Subquery that runs once per row of the outer query
Use Cases in Data Science Context
Filtering with aggregate conditions (e.g., above average salary)
Finding customers with more than a threshold orders
*/
use venom;

-- Creating employees table
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    salary INT
);

-- Inserting data into employees
INSERT INTO employees (emp_id, name, department, salary) VALUES
(1, 'Alice', 'HR', 60000),
(2, 'Bob', 'IT', 80000),
(3, 'Charlie', 'Finance', 120000),
(4, 'David', 'IT', 45000),
(5, 'Eva', 'HR', 30000),
(6, 'Frank', 'Marketing', 50000);


-- Creating orders table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    amount INT
);

-- Inserting data into orders
INSERT INTO orders (order_id, customer_name, amount) VALUES
(101, 'Alice', 200),
(102, 'Alice', 300),
(103, 'Alice', 250),
(104, 'Bob', 500),
(105, 'Bob', 450),
(106, 'Bob', 400),
(107, 'Bob', 350),
(108, 'Charlie', 600),
(109, 'Eva', 150);


-- Single Row Subquery – Get all employees earning above the average company salary.
select * from employees where salary > (select avg(salary) from employees);


--  Multi Row Subquery – Get all employees whose salary matches any salary in the IT department.
select * from employees where salary in (select salary from employees where department = 'IT');


--  Correlated Subquery – For each employee, show their name and whether their salary is above their department average.
select name,department,salary from employees where salary >any (select avg(salary) from employees group by department);
select * from employees;
SELECT e.name, e.department, e.salary
FROM employees e
WHERE e.salary > (
    SELECT AVG(salary)
    FROM employees
    WHERE department = e.department
);



-- Subquery in FROM – Show the highest paid employee per department.
-- select * from employees where salary >any (select max(salary) from employees group by department); -- wrong query
SELECT dept_highest.department, dept_highest.max_salary, e.name
FROM (
    SELECT department, MAX(salary) AS max_salary
    FROM employees
    GROUP BY department
) AS dept_highest
JOIN employees e 
    ON e.department = dept_highest.department 
   AND e.salary = dept_highest.max_salary;


-- EXISTS – Get departments that have at least one employee earning more than 70000.
SELECT DISTINCT department
FROM employees e
WHERE EXISTS (
    SELECT 1
    FROM employees
    WHERE department = e.department 
      AND salary > 70000
);
select * from employees;	


--  Subquery with orders – Get customers who have made more than 3 orders.
select customer_name, count(amount) as count_order from orders group by customer_name having count_order > 3;

SELECT customer_name
FROM (
    SELECT customer_name, COUNT(*) AS order_count
    FROM orders
    GROUP BY customer_name
) AS sub
WHERE order_count > 3;








 
 
 
 
 
