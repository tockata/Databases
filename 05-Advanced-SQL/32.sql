BEGIN TRAN;
 
DELETE Employees FROM Employees e
 JOIN Departments d
 ON e.EmployeeID = d.DepartmentID
WHERE d.Name = 'Sales';
 
ROLLBACK TRAN;