BEGIN TRAN
DROP TABLE EmployeesProjects
COMMIT
ROLLBACK TRAN

--The best way to recover dropped table is to have backpup of database
--there are other wayes like this:
--http://www.mssqltips.com/sqlservertip/3160/recover-deleted-sql-server-data-and-tables-with-the-help-of-transaction-log-and-lsns/ 

--next script recovers SoftUni database from backup. You should specify your own path
--to backup file and SoftUni database should not be in use to recover it:
USE master
RESTORE DATABASE SoftUni FROM DISK = 'D:\SQL Database\MSSQL12.SQLEXPRESS\MSSQL\Backup\SoftUni.bak'
GO