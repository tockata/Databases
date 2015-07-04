INSERT INTO Users VALUES
('pesho', 'pesho123', 'Petar Petrov', NULL, 2),
('gosho', 'gosho123', 'Georgi Georgiev', CONVERT(DATETIME, '2015-06-22'), 1),
('mimi', 'mimi123', 'Maria Kostadinova', CONVERT(DATETIME, '2015-06-20'), 3)

GO

INSERT INTO Groups VALUES
('Javascript'),
('Databases'),
('Angular')