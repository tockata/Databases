SELECT COUNT(*) as [Employees with manager]
FROM Employees
WHERE ManagerID IS NOT NULL