--Ebene als Kategorie für Schweregrad
--je höher desto schlimmer das Problem.. ab Lv 17

select * from Bernet --Meldung 208, Ebene 16

select from bernet  --Meldung 156, Ebene 1


--Ebene 15: DAU Fehler.. der User ist Schuld
--Ebene 16: DAU Fehler.. der User ist Schuld
--Ebene 14: Security.. er hat kein Recht drauf
--Ebene 12: DAU ...

--Ebenen bis 10 Inkl. sind keine fehler sondern Infos
--Ebenen von 11 bis 16 inklusive ist in der Regel der Anwender Schuld
--Ebene 17 und aufwärts.. ohje... wird immer schlimmer
--Bei Ebene 25 (Todesurteil)


--die fehlernummern kommen aus dem hier:

select * from sysmessages where msglangid = 1031

--Eine Warnung kann einen Auftrag auslösen oder einen Operator informieren