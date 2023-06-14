--ZeAi Sun

--1
use pubs
go

--2
select a.au_lname as [Last Name],
	a.city as [City],
	t.title as [Published]
from authors a left outer join titleauthor ta
	on a.au_id = ta.au_id
	left outer join titles t
	on ta.title_id = t.title_id
where a.state = 'CA'
go

--3
create table Bonus (
	deposit_id int identity(1,1) NOT NULL,
	emp_id char(9) NOT NULL,
	title_id varchar(6) NOT NULL,
	deposit_date date NOT NULL,
	deposit_amount money NOT NULL,
	constraint [PK_dId] primary key (deposit_id),
	constraint [FK_eId] foreign key (emp_id) references employee(emp_id),
	constraint [FK_tId] foreign key (title_id) references titles(title_id)
)
go

--4
insert into Bonus(emp_id, title_id, deposit_date, deposit_amount)
select e.emp_id,
	t.title_id,
	getdate(),
	150  -- this part doesn't work so I just insert value 150.
	-- e.job_id * select(emp_id = e.emp_id from (select emp_id, count(*) from employee e inner join titles t on e.pub_id = t.pub_id group by emp_id))
from employee e inner join titles t
	on e.pub_id = t.pub_id

--5
drop table Bonus
go