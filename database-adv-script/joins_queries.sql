-- query using an INNER JOIN to retrieve all bookings and the respective users who made those bookings
SELECT 
    Booking.*, 
    User.first_name, 
    User.last_name,
    User.email, 
    User.phone_number  
FROM Booking INNER JOIN User  ON Booking.user_id = User.user_id;



--query using aLEFT JOIN to retrieve all properties and their reviews, including properties that have no reviews.
SELECT 
    Property.*, 
    Review.review_id, 
    Review.rating, 
    Review.comment, 
    Review.created_at AS review_created_at 
FROM Property LEFT JOIN Review  ON Property.property_id = Review.property_id ORDER BY Review.rating DESC;


-- query using a FULL OUTER JOIN to retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user.
SELECT User.*, Booking.* FROM User FULL OUTER JOIN Booking ON User.user_id = Booking.user_id;



