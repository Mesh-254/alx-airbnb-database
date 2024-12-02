--all unique keys (including the PRIMARY KEY) must include the partitioning column.
ALTER TABLE Booking DROP PRIMARY KEY;
ALTER TABLE Booking ADD PRIMARY KEY (booking_id, start_date);

-- partitioned the table using the RANGE method based on the YEAR(start_date)
ALTER TABLE Booking
PARTITION BY RANGE (YEAR(start_date)) (
    PARTITION p2022 VALUES LESS THAN (2023),
    PARTITION p2023 VALUES LESS THAN (2024),
    PARTITION p2024 VALUES LESS THAN (2025),
    PARTITION pFuture VALUES LESS THAN MAXVALUE
);

-- Fetch bookings for a specific date range
SELECT * FROM Booking
WHERE start_date BETWEEN '2023-01-01' AND '2023-12-31';




