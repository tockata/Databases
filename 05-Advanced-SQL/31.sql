CREATE TABLE WorkHoursLogs (
	Id int IDENTITY,
	LogDateTime datetime NOT NULL,
	OldEmployeeId int NULL,
	OldDate datetime NULL,
	OldTask nvarchar(MAX) NULL,
	OldHours float NULL,
	OldComments nvarchar(MAX) NULL,
	NewEmployeeId int NULL,
	NewDate datetime NULL,
	NewTask nvarchar(MAX) NULL,
	NewHours float NULL,
	NewComments nvarchar(MAX) NULL,
	Command nchar(6) NOT NULL
	CONSTRAINT PK_WorkHoursLogs PRIMARY KEY(Id))

	GO

	-- Scripts below creates triggers that will insert data in table WorkHoursLogs
	-- after Insert, Update or Delete in table WorkHours
	CREATE TRIGGER tr_WorkHoursInsert ON WorkHours AFTER INSERT AS
		INSERT INTO WorkHoursLogs(LogDateTime, NewEmployeeId, NewDate, NewTask, NewHours, NewComments, Command)
		SELECT GETDATE(), i.EmployeeId, i.Date, i.Task, i.Hours, i.Comments, 'INSERT'
		FROM inserted i

	GO

	CREATE TRIGGER tr_WorkHoursUpdate ON WorkHours AFTER UPDATE AS
		INSERT INTO WorkHoursLogs(LogDateTime, OldEmployeeId, OldDate, OldTask, OldHours, OldComments, 
			NewEmployeeId, NewDate, NewTask, NewHours, NewComments, Command)
		SELECT GETDATE(), d.EmployeeId, d.Date, d.Task, d.Hours, d.Comments, 
			i.EmployeeId, i.Date, i.Task, i.Hours, i.Comments, 'UPDATE'
		FROM inserted i, deleted d

	GO

	CREATE TRIGGER tr_WorkHoursDelete ON WorkHours AFTER DELETE AS
		INSERT INTO WorkHoursLogs(LogDateTime, OldEmployeeId, OldDate, OldTask, OldHours, OldComments, Command)
		SELECT GETDATE(), d.EmployeeId, d.Date, d.Task, d.Hours, d.Comments, 'DELETE'
		FROM deleted d

	GO

	--Test triggers:
INSERT INTO WorkHours VALUES
(23, CONVERT(DATETIME, '2015-06-22'), 'Task 1', 4.5, 'Comment 1'),
(8, CONVERT(DATETIME, '2015-06-23'), 'Task 2', 2.0, 'Comment 2'),
(16, CONVERT(DATETIME, '2015-06-25'), 'Task 3', 8, 'Comment 3')

GO

UPDATE WorkHours
SET Task = 'Completed task'
WHERE Id = 1

GO

UPDATE WorkHours
SET Comments = 'This task has been completed'
WHERE Task LIKE 'Completed%'

GO

DELETE FROM WorkHours
WHERE Comments LIKE '%completed%'

GO