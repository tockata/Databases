UPDATE Users
SET Password = NULL
WHERE LastLoginTime <= '2010-03-10'