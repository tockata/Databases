CREATE TABLE Users (
	Id int IDENTITY,
	Username nvarchar(50) NOT NULL,
	Password nvarchar(50) NOT NULL CHECK (LEN(Password) >= 5),
	FullName nvarchar(100) NOT NULL,
	LastLoginTime datetime,
	CONSTRAINT PK_Users PRIMARY KEY(Id),
	CONSTRAINT UK_Users_Username UNIQUE (Username))