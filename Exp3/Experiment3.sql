

create table tbl_emp1(emp_id int);
insert into tbl_emp1(emp_id) 
			values(2),(4),(4),(6),(6),(7),(8),(8);

select * from tbl_emp1;

select max(emp_id) from tbl_emp1 where emp_id not in (select emp_id from tbl_emp1 group by emp_id having count(*) >1);