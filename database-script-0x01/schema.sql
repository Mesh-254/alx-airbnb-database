CREATE TABLE User (
user_id UUID, PRIMARY KEY ,
first_name VARCHAR(255) NOTNULL,
last_name VARCHAR(255) NOTNULL,
email VARCHAR(255) UNIQUE NOTNULL,
password_hash VARCHAR(255) NOTNULL,
phone_number VARCHAR(255),
role: ENUM (guest, host, admin), NOT NULL,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
);

-- Index for email
CREATE UNIQUE INDEX idx_user_email ON User(email);



CREATE TABLE Property (
    property_id UUID PRIMARY KEY,
    host_id UUID NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(255) NOT NULL,
    pricepernight DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_host FOREIGN KEY (host_id) REFERENCES User(user_id)
);

-- Index for host_id
CREATE INDEX idx_property_host_id ON Property(host_id);



CREATE TABLE Booking (
    booking_id UUID PRIMARY KEY,
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status ENUM('pending', 'confirmed', 'canceled') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_property FOREIGN KEY (property_id) REFERENCES Property(property_id),
    CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES User(user_id)
);

-- Indexes for foreign keys
CREATE INDEX idx_booking_property_id ON Booking(property_id);
CREATE INDEX idx_booking_user_id ON Booking(user_id);
CREATE INDEX idx_booking_status ON Booking(status);




CREATE TABLE Payment (
    payment_id UUID PRIMARY KEY,
    booking_id UUID NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method ENUM('credit_card', 'paypal', 'stripe') NOT NULL,
    CONSTRAINT fk_booking FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)
);

--Index for Booking id
CREATE INDEX idx_payment_booking_id ON Payment(booking_id);



CREATE TABLE Review (
    review_id UUID PRIMARY KEY,
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    rating INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
    comment TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_review_property FOREIGN KEY (property_id) REFERENCES Property(property_id),
    CONSTRAINT fk_review_user FOREIGN KEY (user_id) REFERENCES User(user_id)
);

CREATE TABLE Message (
    message_id UUID PRIMARY KEY,
    sender_id UUID NOT NULL,
    recipient_id UUID NOT NULL,
    message_body TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_sender FOREIGN KEY (sender_id) REFERENCES User(user_id),
    CONSTRAINT fk_recipient FOREIGN KEY (recipient_id) REFERENCES User(user_id)
);




