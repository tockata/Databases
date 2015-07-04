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
WHERE Task like 'Completed%'

GO

DELETE FROM WorkHours
WHERE Id = 2

GO