INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at) VALUES
    ('uuid-1', 'John', 'Doe', 'john.doe@example.com', 'hashpassword1', '1234567890', 'guest', CURRENT_TIMESTAMP),
    ('uuid-2', 'Jane', 'Smith', 'jane.smith@example.com', 'hashpassword2', '0987654321', 'host', CURRENT_TIMESTAMP),
    ('uuid-3', 'Bob', 'Johnson', 'bob.johnson@example.com', 'hashpassword3', '0811118874'. 'guest', CURRENT_TIMESTAMP),
    ('uuid-4', 'Admin', 'User', 'admin@example.com', 'adminpassword', NULL, 'admin', CURRENT_TIMESTAMP);


INSERT INTO Property (property_id, host_id, name, description, location, pricepernight, created_at, updated_at) VALUES
    ('uuid-1', 'uuid-2', 'Cozy Apartment', 'A modern apartment in the city center.', 'New York, USA', 150.00, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('uuid-2', 'uuid-2', 'Beach House', 'A beautiful house near the beach.', 'Miami, USA', 250.00, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);


INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at) VALUES
    ('uuid-1', 'uuid-2', 'uuid-1', '2024-12-01', '2024-12-05', 600.00, 'confirmed', CURRENT_TIMESTAMP),
    ('uuid-2', 'uuid-1', 'uuid-3', '2024-12-10', '2024-12-15', 1250.00, 'pending', CURRENT_TIMESTAMP);


INSERT INTO Payment (payment_id, booking_id, amount, payment_date, payment_method) VALUES
    ('uuid-1', 'uuid-1', 600.00, CURRENT_TIMESTAMP, 'credit_card'),
    ('uuid-2', 'uuid-2', 1250.00, CURRENT_TIMESTAMP, 'paypal');


INSERT INTO Review (review_id, property_id, user_id, rating, comment, created_at) VALUES
    ('uuid-1', 'uuid-4', 'uuid-1', 5, 'Fantastic stay! Highly recommend.', CURRENT_TIMESTAMP),
    ('uuid-2', 'uuid-5', 'uuid-3', 4, 'Great location, but could use some upgrades.', CURRENT_TIMESTAMP);


INSERT INTO Message (message_id, sender_id, recipient_id, message_body, sent_at) VALUES
    ('uuid-1', 'uuid-1', 'uuid-2', 'Hi, is the Beach House available for next weekend?', CURRENT_TIMESTAMP),
    ('uuid-2', 'uuid-2', 'uuid-1', 'Yes, the Beach House is available. Let me know if you would like to book.', CURRENT_TIMESTAMP);



