/*
einf opt über HDDs

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
