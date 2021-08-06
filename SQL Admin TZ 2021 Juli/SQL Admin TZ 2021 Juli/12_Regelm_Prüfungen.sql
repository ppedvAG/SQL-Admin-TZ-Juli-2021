--Backup gelaufen x anderer HDD x
--Tabellen änderungen (ALTER) X
--ZUgriffsversuche  X
--guest inaktiv x
--Model Full -- nicht einfach x
--DB Log und Daten getrennt X

--Idee 1: F7 Details zum gewählten Objekt



alter trigger trgTabAlter on database
for ddl_database_level_events --ALTER_TABLE
as
insert into logging 
select EVENTDATA(), GETDATE() 


create table logging
	(id int identity,  nachricht xml, Datum datetime)

	drop view v1

	select * from logging




create view v1
as
select * from orders
