/*
Security: 
AuthMethoden: NT  + (NT + SQL)

Dienstkonten
immer Dienstkonten bei Zugriff auf ext Ressourcen!!!
Agent (per Zeitplan)
DB Engine (adhoc)
nur im SSKM Dienstkonten anpassen


Browserdienst.. Client mit richtigen Ports versorgt wird bei Instanzen

unbeaufsichtigte Dientkonten
Kennw�rter werden von Windows verwaltet
Lokale Konten --> Computer
NT SERVICE\SQLSERVER  
NT SERVICE\MSSQL$FE

normale Userkonten: keine besonderern Rechte vorab


Pfade
Trenne Daten von Logfiles per default.. eigtl pro DB
Backup

TEMPDB
eig HDDs


--SystemDBs
Logins  master
Grundeinstellung f�r DBs model
wieso w�chst die msdb (Agent: Jobs und Zeitpl�ne; Verlauf))... 

Idee: Wartungsplan


/*