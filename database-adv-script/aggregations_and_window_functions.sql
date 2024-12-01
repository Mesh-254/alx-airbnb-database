-- query to find the total number of bookings made by each user, using the COUNT function and GROUP BY clause.
SELECT 
    User.user_id, 
    User.first_name, 
    User.last_name, 
    COUNT(booking_id) 
FROM  User 
LEFT JOIN Booking ON 
    User.user_id = Booking.user_id  
GROUP BY 
    User.user_id;



-- Use a window function (ROW_NUMBER, RANK) to rank properties based on the total number of bookings they have received.
SELECT Property.*, RANK () OVER (ORDER BY COUNT(Booking.booking_id) DESC)  FROM Property
LEFT JOIN (SELECT property_id, COUNT(Booking.booking_id) FROM Booking GROUP BY property_id AS BookingCount
ON Property.property_id = BookingCount.property_id;