12 16 20 24 28 32


----List all data from the departments table.
--select * from departments;

----List all data from the employees table
--select * from employees;

----Write a query to display the last name, job id, hire date and employee ID for each employee with the employee ID column listed 
----first. Provide an alias of start date for the hire date column.
--select employee_id, last_name, job_id, hire_date as "Start date" from employees;

----List all the unique job IDS from the employees table.
--select distinct(job_id) from employees;

----Write a query to list all employees and job IDs in a single column output with a comma and a space between the last name and 
----the job id. The output should look like this:
--select last_name ||', '|| job_id as "Employees and Jobs" from employees;

----Write a query to list employees last name, department ID and salary for employees with a salary between 3000 and 4000.
--select last_name, department_id, salary from employees where salary between 3000 and 4000;

----Write a query to display the first name, the last name, the hiredate and the salary for employees with a name of 
----Tobias end Jones. Sort the output by salary.
----select first_name, last_name, hire_date, salary from employees where last_name in ('Jones', 'Tobias') order by salary;

----Display the last name and department ID of employees in departments 30 or 80 in ascending alphabetical order by name.
--select last_name, department_id from employees where department_id in (30, 80) order by last_name asc;

----List all employees with a hire date in 2005.
select employee_id , hire_date from employees where extract(year from hire_date) = 2005;
----Write a query to list employees who have no manager.
select employee_id from empolyees where manager_id is null;
----Write a query to show show the last name, salary and commission of all employees who earn a commission. Sort the data in ascending order of salary.
select last_name, salary, commission_pct from employees where commission_pct is not null order by last_name asc;
----12--Write a query to list all employees where the third character is a g.
select last_name from employees where last_name like '__g%'
----Write a query to list all employees that have both a ‘g’ and a ‘k’ in their last name.
select last_name from employees where last_name like '%K%g%' ;
----List all employees that have a commission of 20%.
select last_name from employees where commission_pct=0.2;
----Write a query to list all employees their last name their salary and include a new salary column which is their original salary plus a 30% increase.
select last_name, salary, ((salary)+(salary*0.3)) as "New Salary" from employees order by salary
----16--Write a query that lists the employees last name and the length of the last name.
select last_name, length(last_name) as "Length of Last Name" from employees;
----Write a query that lists employee last name and calculate how many weeks they have worked for the company. Hint: (current_date-hire_date).
select last_name, round(months_between((current_date - hire_date))/4,0) from employees;
----Write a query that Returns employee last name in uppercase and employ first name in lowercase.
select upper(last_name) last_name, lower(first_name) first_name from employees;
----Write a query that lists the highest salary, The sum of all salaries, the average salary and the minimum salary of all employees.
select max (salary) as "higest salary", sum (salary) as "total salary", round(avg (salary),2) as "average salary", min (salary) as "lowest salary" from employees
----20--Write a query to display the number of people working in each department.
select department_id, count(employee_id) as "Number of People" from employees group by department_id;
----Write a query to determine the number of Managers in the employees table. Hint: the result is 18.
select count(distinct manager_id) from employees;
----Write a query to find the difference between the highest and the lowest salary give the column alias of difference.
select max(salary) - min(salary) as difference from employees;
----Write a query to display the manager number and the salary of the highest paid employee for that manager.
select manager_id, max(salary) from employees group by manager_id;
----24--Write a query that lists the employee first name, last name, job id and department name for all employees and their 
----departments. Hint: you need to join the employees and department tables for this.
select e.first_name, e.last_name, e.job_id, d.department_name from employees e full outer join departments d on e.department_id = d.department_id;

----Write a query that joins the employees table to the employees table so you can display an employee last name and their managers last name. Hint: remember to give the employees tables two different aliases.
select e.employee_id manager_id, e.last_name manager_name, e.salary, m.employee_id , m.last_name employee_name, m.salary  
 from employees e, employees m where  m.manager_id = e.employee_id;
----Write a query that shows the names and addresses of all departments. You need to join locations, countries and departments.
select  d.department_id, d.department_name, (l.street_address||', '|| l.city || ', '|| l.state_province||', '|| c.country_name) as address  
from departments d 
join locations l on d.location_id=l.location_id 
join countries c on l.country_id = c.country_id;
----Write a query to list employee last names who were hired after ‘Bull’.
select last_name, hire_date from employees where hire_date>(select hire_date from employees where last_name='Bull') ;
----28--Write a query to return how many departments have an ‘a’ in their name.
select count(department_name) from departments where department_name like '%a%';

----Write a query that shows the name, the location and the number of employees for department. Make sure all departments are included even the ones without employees.
select d.department_id, d.department_name, l.street_address, count(e.employee_id) "number of employees" 
from employees e full outer join departments d on e.department_id=d.department_id full outer join locations l on  d.location_id=l.location_id  
group by d.department_id, d.department_name, l.street_address;

----Write a query that shows employees last name, their managers last name, but only if the manager has a salary higher than 15000. The query should return employer name manager 
----name manager salary and the job title of the manager. Hint: you need to join employees to employees and to jobs.
select e.employee_id, e.last_name e.manager_name, e.salary, m.employee_id , m.last_name employee_name, m.salary, j.job_title  
from employees e, employees m, jobs j 
where  m.manager_id = e.employee_id and e.job_id= j.job_id and e.salary>15000;

----Write a query that returns the department number, department name, number and where the department has less than 3 employees.
select count(e.employee_id) "number of employees", d.department_id 
from employees e join departments d on e.department_id=d.department_id 
group by d.department_id 
having count(e.employee_id)<3;

select department_id , department_name
from departments 
where department_id in 
(select department_id , count(employee_id)
from employees 
group by department_id
having count(employee_id)<3) ;

----32--Write a query to find all employees who earn more than the average salary for their departments. 
----Display last name, salary, department ud and the avg salary for that department. Sort the output by 
----avg salary and round to two decimals. Hint: You will need a correlated subquery to solve this problem.
select 
    e.last_name, 
    e.salary, 
    e.department_id,
    round(avg(em.salary),2) as "Avg Salary for Dept." 
from employees e inner join employees em on e.department_id = em.department_id
where e.salary > (select 
                    round(avg(salary),2) 
                from employees 
                where e.department_id = department_id) group by e.last_name, e.salary, e.department_id
order by avg(em.salary);
