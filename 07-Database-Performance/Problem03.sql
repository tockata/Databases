-- create table with partitions:
CREATE TABLE IF NOT EXISTS test (
    id INT NOT NULL AUTO_INCREMENT,
    date DATETIME,
    text TEXT,
    UNIQUE KEY (id, date)
)
PARTITION BY RANGE ( YEAR(date) ) (
    PARTITION p0 VALUES LESS THAN (1990),
    PARTITION p1 VALUES LESS THAN (2000),
    PARTITION p2 VALUES LESS THAN (2010),
    PARTITION p3 VALUES LESS THAN MAXVALUE
);


-- create stored procedure to fill the table with sample data:
DELIMITER $$
CREATE PROCEDURE InsertRand(IN NumRows INT, IN MinDate INT, IN MaxDate INT)
    BEGIN
        DECLARE i INT;
        SET i = 1;
        START TRANSACTION;
        WHILE i <= NumRows DO
            INSERT INTO test(Date, Text) VALUE(
				(FROM_UNIXTIME((MaxDate - MinDate) * RAND() + MinDate)),
				CONCAT('text', CAST(i as char))
			 );
            SET i = i + 1;
        END WHILE;
        COMMIT;
    END$$
DELIMITER ;

-- fill table with sample data:
CALL InsertRand(1000000, UNIX_TIMESTAMP('1970-01-01'), UNIX_TIMESTAMP('2015-12-31'));

-- search random dates in all partitions:
SELECT date FROM test partition (p0, p1, p2, p3)
WHERE month(date) = 2;

-- search in one partition:
SELECT date FROM test partition (p0)
WHERE month(date) = 2