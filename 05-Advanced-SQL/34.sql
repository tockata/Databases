SELECT *
INTO #EmployeesProjects 
FROM EmployeesProjects

DROP TABLE EmployeesProjects

SELECT *
INTO EmployeesProjects
FROM #EmployeesProjects