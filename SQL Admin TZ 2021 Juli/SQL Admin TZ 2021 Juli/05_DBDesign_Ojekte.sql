/*
Normalisierung Gegenteil der Redundanz (ist schnell)

NF 1. 2. 3. BC  4. 5.

NF1 in jeder Zelle nur ein Wert
NF2 Primary Key (eindeutiger DS)
NF3 jeder Wert uasserhalb des PK hat keine Abhängigkeit von anderen Werten


104  Otto  Maier  8000 München

104  Otto  Maier  80369 München (Schwabing)

--is ok aber auch nicht mehr..

Aufgabe des PK:
--Wert muss eindeutig sein (macht bei SQL Server ein IX)
--PK geht eine Beziehung mit FK ein!!!

--was macht ref Integrität (Beziehung)..Super.. 


--Datentypen

INT +-2,1Mrd

'Otto'
text().. nie verwenden! seit 2005 auf Abschussliste

varchar(50) 'otto' 4 
char(50)    'otto                       ' 50
nvarchar(50) 'otto'   4 * 2   8
nchar(50)   'otto   ' 50 * 2    100

varchar(8000) ist Max

Datum
date 2.10.2021
datetime  (ms) ist ungenau.. 3 bis 4 ms Ungenauigkeit
smalldatetime (sek)
datetime2 (ns)
datetimeoffset (ns inkl Zeitzone)



decimal (18,0)  decimal (4,2)  4 Stellen kang, davon 2 Nachkommastellen
money 8 Nachkommstellen
float 27 Nachkomma


XML
geography
geometry

--wichtig.. vergib den passenden und übertrieb nicht


--Ziel: jede Seite sollte möglichst voll werden

dbcc showcontig('t1')--das ist krank---
--- Gescannte Seiten.............................: 20000
--- Mittlere Seitendichte (voll).....................: 50.79%





*/
create table t3 (id int , spx char(4100), spy char(4100))

--Northwind..

--an einigen Stellen n obwohl unnötig

--Tabellen

--Sichten.. Was sind Sichten? Abfragen

--gemerkte Abfragen, die unter einem Namen wie eine tabelle verwendet werden kann
--kann auch INS UP DEL, kann auch Rechte haben

--wofür brauche ich Sichten? Zugriff nur auf unsensbile Daten einschränken
--komplexe abfragen vereinfachen


create view demoview
as
select * from customers


select * from demoview

select * from (select * from Customers) t


--Der Sichten editor kann nicht alles!

select * from KundeUmsatzUK

--was ist schneller?
--die Abfrage oder der Aufruf der Sicht (die die Abfrage enthält)

--Sicht:
CREATE VIEW [dbo].[KundeUmsatzUK]
AS
SELECT        dbo.Customers.CompanyName, dbo.Orders.OrderDate, dbo.Employees.LastName, dbo.[Order Details].UnitPrice, dbo.[Order Details].Quantity, dbo.Products.ProductName
FROM            dbo.Customers INNER JOIN
                         dbo.Orders ON dbo.Customers.CustomerID = dbo.Orders.CustomerID INNER JOIN
                         dbo.Employees ON dbo.Orders.EmployeeID = dbo.Employees.EmployeeID INNER JOIN
                         dbo.[Order Details] ON dbo.Orders.OrderID = dbo.[Order Details].OrderID INNER JOIN
                         dbo.Products ON dbo.[Order Details].ProductID = dbo.Products.ProductID
WHERE        (dbo.Customers.Country = N'UK')
GO


--Laut Ausführungsplan 50:50 .. Sicht ist gleich schnell
SELECT        dbo.Customers.CompanyName, dbo.Orders.OrderDate, dbo.Employees.LastName, dbo.[Order Details].UnitPrice, dbo.[Order Details].Quantity, dbo.Products.ProductName
FROM            dbo.Customers INNER JOIN
                         dbo.Orders ON dbo.Customers.CustomerID = dbo.Orders.CustomerID INNER JOIN
                         dbo.Employees ON dbo.Orders.EmployeeID = dbo.Employees.EmployeeID INNER JOIN
                         dbo.[Order Details] ON dbo.Orders.OrderID = dbo.[Order Details].OrderID INNER JOIN
                         dbo.Products ON dbo.[Order Details].ProductID = dbo.Products.ProductID
WHERE        (dbo.Customers.Country = N'UK')

select * from KundeUmsatzUK

--Prozeduren
--stored procedures können zahlreiche versch Anweisungen enthalten..
--auch INS UP DEL und SEL


create proc gpdemo @par int, @par2 int
AS
select @par*@par1
--I U D


--geht nicht
select * from proc!!

exec proc gpdemo 12, 14

--der Vorteil der Proc liegt darin, dass er Plan nur einmal überlegt und ersteltl werden muss
--auch nach dem Neustart vorhanden
--man spart sich die Analyse und Kompilierzeit (Plans).. kann aber auch der Nachteil..

--Vorteil
--Kapseln der BILogik

--Proz schneller als Sicht / adhoc

--ja.. idR schon





--F()

--F() sind super praktisch und super felxibel, aber meist total langsam..

select * from Customers where CustomerID like 'A%' --schnell


select * from Customers where left(CustomerID,1) = 'A'-- immer eine Suche von A bis Z

select funk(wert), funk2(spalte) from fkt(Wert) where fkt3(spalte) > fkt4(wert)

