
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