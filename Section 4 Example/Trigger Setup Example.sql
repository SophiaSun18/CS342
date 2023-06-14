create table alog (au_id varchar(11),
				changeby varchar(50),
				chdate datetime)
go

create  trigger foo
 on authors
 for update
as
  insert into alog 
     select au_id,
			user_name(),
			getdate()
		from inserted
go