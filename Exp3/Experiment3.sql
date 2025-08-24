
                                ------------------QUES 1   EASY ----------------
create table tbl_emp1(emp_id int);
insert into tbl_emp1(emp_id) 
			values(2),(4),(4),(6),(6),(7),(8),(8);

select * from tbl_emp1;

select max(emp_id) from tbl_emp1 where emp_id not in 
    (select emp_id from tbl_emp1 group by emp_id having count(*) >1);


                               ----------------QUES 2   MEDIUM ---------------
CREATE TABLE department (
    id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

CREATE TABLE employee (
    id INT,
    name VARCHAR(50),
    salary INT,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES department(id)
);

INSERT INTO department (id, dept_name) VALUES
(1, 'IT'),
(2, 'SALES');

INSERT INTO employee (id, name, salary, department_id) VALUES
(1, 'JOE', 70000, 1),
(2, 'JIM', 90000, 1),
(3, 'HENRY', 80000, 2),
(4, 'SAM', 60000, 2),
(5, 'MAX', 90000, 1);

select * from department;
select * from employee;

--first approach
select D.dept_name, E.name, E.salary, D.id
from employee as E
join 
department as D
on D.id=E.department_id
where E.salary in
( select max(E2.salary) from employee as E2 where E2.department_id=E.department_id )
order by E.department_id;

--second approach
select D.dept_name, E.name, E.salary, D.id
from employee as E
join 
department as D
on D.id=E.department_id
where E.salary in
( select max(E2.salary) from employee as E2 group by E2.department_id )
order by E.department_id;


                                     ----------------------QUES 3  HARD -----------------

create table tableA(empId int , Ename varchar(50), salary int)
insert into tableA(empId, Ename, salary) values(1,'AA',1000), (2,'BB',300);

create table tableB(empId int , Ename varchar(50), salary int)
insert into tableB(empId, Ename, salary) values(2,'BB',400), (3,'CC',100);

select * from tableA;
select * from tableB;

--first approach
select empId, Ename, salary from tableA 
UNION
select empId, Ename, salary from tableB 
where salary <( select min(salary) from tableA);

--second approach
select empId, min(Ename), min(salary) as 'Salary' from
(
select * from tableA 
UNION All
select * from tableB 
) as temp_result
group by empId;