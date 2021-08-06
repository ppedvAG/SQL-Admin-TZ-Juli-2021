--CPU

set statistics io, time on

select SUM(freight), lastname from ku1
group by lastname

--, CPU-Zeit = 969 ms, verstrichene Zeit = 168 ms.
--mehr CPU Zeit als es dauert.. mehr CPUs..

--hat es sich gelohnt: ja

--man kann den MAXDOP auch pro DB einstellen..
--lohnen sich mehr CPUS als weniger

--im SETUP (ab 2016).. Kerne: 8--> max CPU 8 
--                            16--> max 8 CPUs
--                             4--> max 4 CPUs

--ab einem best Kostenwert verwendet alle CPUs , ausser es wurde limitiert
--(SETUP)

--SQL Server nimmt immer einen oder alle..daher Limit auf 8


--Kostenschwellwert liegt per dafault bei 5
--nur Pläne mit mehr als 5 SQL Dollar werden parallisiert

--mit 1 CPU 50% der CPU Leistung 

--mit 6 statt 8 CPUs: 2 CPU frei, geringer Dauer und geringe CPU Last

--Ansatz: KOstenschwellwert 25 und Kerne reduzieren

--OLTP und OLAP (mehr CPU)


set statistics time on

select SUM(freight), lastname from ku1
group by lastname option (maxdop 4)

--taucht im Plan eine Gather und Repartition Stream auf: guter Hinweis für MAXDOP geringer setzen


--CXPACKET  os_wait_stats

select * from sys.dm_os_wait_stats where wait_type like 'CX%'