--  query to find all properties where the average rating is greater than 4.0 using a subquery.
SELECT
     Property.* FROM Property 
WHERE 
    (SELECT AVG(Review.rating) FROM Review WHERE Review.property_id = Property.property_id) > 4.0;


--  correlated subquery to find users who have made more than 3 bookings.
SELECT User.* FROM User WHERE (SELECT COUNT(booking_id) FROM Booking WHERE Booking.user_id = User.user_id) > 3;
