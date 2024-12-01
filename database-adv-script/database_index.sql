
EXPLAIN SELECT Property.*, ROW_NUMBER() OVER (ORDER BY COUNT(Booking.booking_id) DESC), RANK() OVER (ORDER BY COUNT(Booking.booking_id) DESC) AS booking_rank 
FROM Property
LEFT JOIN Booking ON Property.property_id = Booking.property_id
GROUP BY Property.property_id
ORDER BY booking_rank;


EXPLAIN  SELECT Property.*, ROW_NUMBER() OVER (ORDER BY COUNT(Booking.booking_id) DESC), RANK() OVER (ORDER BY COUNT(Booking.booking_id) DESC) AS booking_rank 
FROM Property
LEFT JOIN Booking ON Property.property_id = Booking.property_id
GROUP BY Property.property_id
ORDER BY booking_rank;

-- query using an INNER JOIN to retrieve all bookings and the respective users who made those bookings
EXPLAIN  SELECT 
    Booking.*, 
    User.first_name, 
    User.last_name,
    User.email, 
    User.phone_number  
FROM Booking INNER JOIN User  ON Booking.user_id = User.user_id;



--query using aLEFT JOIN to retrieve all properties and their reviews, including properties that have no reviews.
EXPLAIN SELECT 
    Property.*, 
    Review.review_id, 
    Review.rating, 
    Review.comment, 
    Review.created_at AS review_created_at 
FROM Property LEFT JOIN Review  ON Property.property_id = Review.property_id ORDER BY Review.rating DESC;


-- query using a FULL OUTER JOIN to retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user.
EXPLAIN SELECT User.*, Booking.* FROM User FULL OUTER JOIN Booking ON User.user_id = Booking.user_id;


index_commands = """
-- User Table: Creating indexes for high-usage columns
CREATE INDEX idx_user_user_id ON User(user_id);
CREATE INDEX idx_user_email ON User(email);
CREATE INDEX idx_user_role ON User(role);

-- Booking Table: Creating indexes for high-usage columns
CREATE INDEX idx_booking_booking_id ON Booking(booking_id);
CREATE INDEX idx_booking_user_id ON Booking(user_id);
CREATE INDEX idx_booking_property_id ON Booking(property_id);

-- Property Table: Creating indexes for high-usage columns
CREATE INDEX idx_property_property_id ON Property(property_id);
CREATE INDEX idx_property_host_id ON Property(host_id);
"""

EXPLAIN ANALYZE SELECT Property.*, ROW_NUMBER() OVER (ORDER BY COUNT(Booking.booking_id) DESC), RANK() OVER (ORDER BY COUNT(Booking.booking_id) DESC) AS booking_rank 
FROM Property
LEFT JOIN Booking ON Property.property_id = Booking.property_id
GROUP BY Property.property_id
ORDER BY booking_rank;

-- query using an INNER JOIN to retrieve all bookings and the respective users who made those bookings
EXPLAIN ANALYZE SELECT 
    Booking.*, 
    User.first_name, 
    User.last_name,
    User.email, 
    User.phone_number  
FROM Booking INNER JOIN User  ON Booking.user_id = User.user_id;



--query using aLEFT JOIN to retrieve all properties and their reviews, including properties that have no reviews.
EXPLAIN ANALYZE SELECT 
    Property.*, 
    Review.review_id, 
    Review.rating, 
    Review.comment, 
    Review.created_at AS review_created_at 
FROM Property LEFT JOIN Review  ON Property.property_id = Review.property_id ORDER BY Review.rating DESC;


-- query using a FULL OUTER JOIN to retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user.
EXPLAIN ANALYZE SELECT User.*, Booking.* FROM User FULL OUTER JOIN Booking ON User.user_id = Booking.user_id;
