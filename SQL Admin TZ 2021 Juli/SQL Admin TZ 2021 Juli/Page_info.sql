select * from sys.dm_db_database_page_allocations
	(db_id(), object_id('votes'),null,null,'Limited')


--								DB      FileID, PageNr
select * from sys.dm_db_page_info(db_id(),1,  100, 'detailed')

