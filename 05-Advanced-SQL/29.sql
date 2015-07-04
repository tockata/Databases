CREATE TABLE WorkHours (
	Id int IDENTITY,
	EmployeeId int NOT NULL,
	Date datetime NOT NULL,
	Task nvarchar(MAX) NOT NULL,
	Hours float NOT NULL,
	Comments nvarchar(MAX) NOT NULL,
	CONSTRAINT PK_WorkHours PRIMARY KEY(Id),
	CONSTRAINT FK_WorkHours_Employees FOREIGN KEY (EmployeeId) REFERENCES Employees(EmployeeID))