/*
einf opt �ber HDDs

Tabellen auf andere HDDs legen

Teile von Tabellen auf andere HDD zu legen


--> Dateigruppen

*/

create database testdb --> mdf .ldf

create table testtab  --> mdf

--testdb: mdf ldf   ndf  ndf  
create table testtab () ON DATEIGRUPPE

--Datei: C\Program Files\.......\dbdatei.ndf  --> HOT (DGR)

create table testtab () on HOT

--jede DB hat eine PRIMARY (= mdf)
create table tessdt (id int) on HOT

USE [master]
GO

GO
ALTER DATABASE [Northwind] ADD FILEGROUP [HOT]
GO
ALTER DATABASE [Northwind] 
ADD FILE ( NAME = N'NWINDHOT', FILENAME = N'D:\_SQLDB\NWINDHOT.ndf' , SIZE = 8192KB , FILEGROWTH = 65536KB ) 
TO FILEGROUP [HOT]
GO


--was aber wenn man schon Tabellen hat...
--es gibt keinen TSQL Befehl zum Verschieben von DGR zu DGR


--enormer Aufwand f�r SSMS per Entwurfsansicht Tabellen zu verschieben
--viele Sperren auf Tabellen und L�schen 

--auch einfach machbar, wenn man den Gr IX auf andere DGruppe legt

create table test(id int) ON HOT


--Tipp: Verschieben ist nicht m�glich..kein TSQL daf�r..
--aber per SSMS... aber mit L�schen verbunden
--Entwurfsansicht der Tabelle--> Eigenschaften
--evtl vorher im SSMS Optionen ---Designer_ Haken bei L�schen verhindern entfernen

--Alternative: CL IX auf anderen Dgruppe