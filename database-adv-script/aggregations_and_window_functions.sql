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
SELECT 
    Property.*, 
    ROW_NUMBER() OVER (ORDER BY total_bookings DESC) AS row_num,
    RANK() OVER (ORDER BY total_bookings DESC) AS booking_rank
FROM (
    SELECT 
        Property.*, 
        COUNT(Booking.booking_id) AS total_bookings
    FROM Property
    LEFT JOIN Booking ON Property.property_id = Booking.property_id
    GROUP BY Property.property_id
) AS PropertyWithBookings
ORDER BY booking_rank;
