/*
Vollständige Sicherung  V   Zeitpunkt
Differentielle          D Diff zu V   Zeitpunkt
TransaktprotSich        T sichert alle Anweisung  Verlaufssicherung (I U D)


V  6:00 !!
	T
	T
	T
  D  
    T
	T
	T
  D x
	T
	T  15:30
	T  16:00


V
	D TTT
	
Was ist der schnellste Restore?  V --> so häufig wie möglich V 
Wie lange dauert der Restore einer T Sicherung? 
	-->so lange wie die Anweisungen dauerten .. kann dauern



Liste der Restorefälle

1. Versehentliches Löschen oder manipulieren von DS/Tabellen
2. DB defekt/Tb defekt
3. Hardwaredefekt Serverkomplett weg
   Serverdefekt aber HDD (mit den DB) ist ok
	Server defekt un dnur eine HDD mit mdf ist vorhanden, aber die HDD mit Log ist weg
5. Was wäre, wenn ich wüsste, dass die DB gleich einen Fehler hat..
	SP, Test einer Devs...














*/

--Manuelle Sicherung ..--V TTT D TTT D TTT D TTT
BACKUP DATABASE [Northwind] TO  DISK = N'D:\_BACKUP\Northwind.bak' 
	WITH NOFORMAT, NOINIT,  NAME = N'Northwind-Vollständig', 
	SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

BACKUP DATABASE [Northwind] TO  DISK = N'D:\_BACKUP\Northwind.bak' WITH  DIFFERENTIAL , 
NOFORMAT, NOINIT,  NAME = N'Northwind-Diff', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO


BACKUP LOG [Northwind] TO  DISK = N'D:\_BACKUP\Northwind.bak' WITH NOFORMAT, 
	NOINIT,  NAME = N'Northwind-Tlog', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

--Fall 1. Versehentliches Löschen oder manipulieren von DS/Tabellen
--11:37...  11:50.. Error 11:30
--Idee: genauer Zeitpunkt..udn was fehlt.. zb Tabelle oder best Datensätze
--> DB unter anderen Namen restoren

USE [master]
RESTORE DATABASE [Northwind2] FROM  DISK = N'D:\_BACKUP\Northwind.bak' WITH  FILE = 27,  MOVE N'Northwind' TO N'D:\_SQLDB\MSSQL15.MSSQLSERVER\MSSQL\DATA\northxxwnd.mdf',  MOVE N'Northwind_log' TO N'D:\_SQLDB\MSSQL15.MSSQLSERVER\MSSQL\DATA\northwxxnd.ldf',  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE DATABASE [Northwind2] FROM  DISK = N'D:\_BACKUP\Northwind.bak' WITH  FILE = 39,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [Northwind2] FROM  DISK = N'D:\_BACKUP\Northwind.bak' WITH  FILE = 40,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [Northwind2] FROM  DISK = N'D:\_BACKUP\Northwind.bak' WITH  FILE = 41,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [Northwind2] FROM  DISK = N'D:\_BACKUP\Northwind.bak' WITH  FILE = 42,  NOUNLOAD,  STATS = 5

GO
--altere Sicherung von 11:37:00
USE [master]
RESTORE DATABASE [Northwind5] FROM  DISK = N'D:\_BACKUP\Northwind.bak' WITH  FILE = 27,  MOVE N'Northwind' TO N'D:\_SQLDB\MSSQL15.MSSQLSERVER\MSSQL\DATA\north5wnd.mdf',  MOVE N'Northwind_log' TO N'D:\_SQLDB\MSSQL15.MSSQLSERVER\MSSQL\DATA\north5wnd.ldf',  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [Northwind5] FROM  DISK = N'D:\_BACKUP\Northwind.bak' WITH  FILE = 28,  NOUNLOAD,  STATS = 5,  STOPAT = N'2021-07-22T11:37:00'
GO

--2. Fall 2 DB restoren mit geringst möglichen Datenverlust
---  zuviele Daten wurde verändert so dass  Fall1 unmöglich

--11:37 letztes Backup T
--11:50 Error in DB
--12:02 Meldung Error---> Restore


/*  Backup ist Online
12:02 T Sicherung ..dauert 5 min
Restore DB von 11:49
--> Datenverlust: 5min

12:02 T Sicherung ..dauert 5 min
12:02 keine Änderung an DB zulassen!
Restore DB von 11:49
--> Datenverlust: 5min
*/
USE [master]
ALTER DATABASE [Northwind] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
BACKUP LOG [Northwind] TO  DISK = N'D:\_BACKUP\Northwind_LogBackup_2021-07-22_12-12-46.bak' WITH NOFORMAT, NOINIT,  NAME = N'Northwind_LogBackup_2021-07-22_12-12-46', NOSKIP, NOREWIND, NOUNLOAD,  NORECOVERY ,  STATS = 5
RESTORE DATABASE [Northwind] FROM  DISK = N'D:\_BACKUP\Northwind.bak' WITH  FILE = 27,  NORECOVERY,  NOUNLOAD,  REPLACE,  STATS = 5
RESTORE DATABASE [Northwind] FROM  DISK = N'D:\_BACKUP\Northwind.bak' WITH  FILE = 39,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [Northwind] FROM  DISK = N'D:\_BACKUP\Northwind.bak' WITH  FILE = 40,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [Northwind] FROM  DISK = N'D:\_BACKUP\Northwind.bak' WITH  FILE = 41,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [Northwind] FROM  DISK = N'D:\_BACKUP\Northwind.bak' WITH  FILE = 42,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [Northwind] FROM  DISK = N'D:\_BACKUP\Northwind_LogBackup_2021-07-22_12-12-46.bak' WITH  NOUNLOAD,  STATS = 5,  STOPAT = N'2021-07-22T12:11:00'
ALTER DATABASE [Northwind] SET MULTI_USER

GO


select * from sys.sysdatabases

--
EXEC sys.sp_configure N'contained database authentication', N'1'
GO
RECONFIGURE WITH OVERRIDE
GO

select @@MICROSOFTVERSION

--SNAPSHOT







USE master
GO


-- Create the database snapshot
CREATE DATABASE SN_Nwind1015 ON
( NAME = Northwind, FILENAME = 'D:\_SQLDB\SN_Nwind1015.mdf' )
AS SNAPSHOT OF Northwind;
GO


---Kann man eine SN DB sichern? ..nö
--Kann man eine SN DB restoren?.. äh nö..

--Kann man die OrgDB normal sichern? ..Jaa!
--Kann man die Org DB restoren?.. Nö, erst wenn SN weg ist
--kann man mehrere SN haben? .. ja geht..


--Restore vom Snapshot--
--1. Alle Leute runter von beiden DBs---

select spid from sysprocesses
	where dbid in (DB_ID('northwind'), DB_ID('sn_nwind1015'))

kill 52

restore database northwind 
from database_snapshot='SN_Nwind1015'





--DB Dateien
--für jede DAtei eine "Klammer"

--mdf
--ndf
--ndf
--ndf
--ldf ..spielt keine Rolle


---SQL Server
-- DB: 500MB
-- Arbeitszeiten: 24/7  
--  Mo bis Fr 6 bis 1900  
-- Max Datenverlust in Zeit: 15min
-- Max Ausfallzeit: 1 Stunden (abzgl Reaktionszeit)
--optional.. so exakt es geht...

--Dauer eines V: 5 sec online
--wie oft..? jede Stunde.. 
--wie lange muss man das Backup aufbewahren..

--300MB V Sekunden für Restore

--1 mal pro Tag: Mo bis Fr 20 Uhr V jeden Tag
--Datenverlust regelt das T: alle 15 min von Mo bis Fr  6 bis 1900
--wir wollen nicht viele T, daher alle 3 bis 4 T eine D Mo bis FR
--Am Wochenende: nur D (20 Uhr)
---_Wartungsplan

--So 16 Uhr
--SA SO 12 D  
--FR 20 Uhr SA 12 Uhr  V D

--ab FR 19:15........SA 24 T......D...MO 6:15







