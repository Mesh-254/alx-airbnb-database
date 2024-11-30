# Database Schema Definition for AirBnB System

## Overview

This project defines the database schema for a simplified AirBnB-like system. The schema includes tables for managing users, properties, bookings, payments, reviews, and messages, ensuring proper constraints and indexing for optimal performance. 

## Entities and Attributes

The schema consists of the following entities:

### 1. **User**
- **Attributes**: 
  - `user_id`: Primary Key, UUID, Indexed
  - `first_name`: `VARCHAR`, Not Null
  - `last_name`: `VARCHAR`, Not Null
  - `email`: `VARCHAR`, Unique, Not Null
  - `password_hash`: `VARCHAR`, Not Null
  - `phone_number`: `VARCHAR`, Nullable
  - `role`: `ENUM` (`guest`, `host`, `admin`), Not Null
  - `created_at`: `TIMESTAMP`, Default to Current Timestamp
- **Constraints**:
  - Unique constraint on `email`
  - Non-null constraints on required fields
- **Indexing**:
  - Index on `email`

### 2. **Property**
- **Attributes**:
  - `property_id`: Primary Key, UUID, Indexed
  - `host_id`: Foreign Key referencing `User(user_id)`
  - `name`: `VARCHAR`, Not Null
  - `description`: `TEXT`, Not Null
  - `location`: `VARCHAR`, Not Null
  - `pricepernight`: `DECIMAL`, Not Null
  - `created_at`: `TIMESTAMP`, Default to Current Timestamp
  - `updated_at`: `TIMESTAMP`, Updated Automatically
- **Constraints**:
  - Foreign key constraint on `host_id`
- **Indexing**:
  - Index on `host_id`

### 3. **Booking**
- **Attributes**:
  - `booking_id`: Primary Key, UUID, Indexed
  - `property_id`: Foreign Key referencing `Property(property_id)`
  - `user_id`: Foreign Key referencing `User(user_id)`
  - `start_date`: `DATE`, Not Null
  - `end_date`: `DATE`, Not Null
  - `total_price`: `DECIMAL`, Not Null
  - `status`: `ENUM` (`pending`, `confirmed`, `canceled`), Not Null
  - `created_at`: `TIMESTAMP`, Default to Current Timestamp
- **Constraints**:
  - Foreign key constraints on `property_id` and `user_id`
  - Valid values for `status`
- **Indexing**:
  - Indexes on `property_id`, `user_id`, and `status`

### 4. **Payment**
- **Attributes**:
  - `payment_id`: Primary Key, UUID, Indexed
  - `booking_id`: Foreign Key referencing `Booking(booking_id)`
  - `amount`: `DECIMAL`, Not Null
  - `payment_date`: `TIMESTAMP`, Default to Current Timestamp
  - `payment_method`: `ENUM` (`credit_card`, `paypal`, `stripe`), Not Null
- **Constraints**:
  - Foreign key constraint on `booking_id`
- **Indexing**:
  - Index on `booking_id`

### 5. **Review**
- **Attributes**:
  - `review_id`: Primary Key, UUID, Indexed
  - `property_id`: Foreign Key referencing `Property(property_id)`
  - `user_id`: Foreign Key referencing `User(user_id)`
  - `rating`: `INTEGER`, Not Null, Valid Range: 1–5
  - `comment`: `TEXT`, Not Null
  - `created_at`: `TIMESTAMP`, Default to Current Timestamp
- **Constraints**:
  - Valid range constraint on `rating`
  - Foreign key constraints on `property_id` and `user_id`

### 6. **Message**
- **Attributes**:
  - `message_id`: Primary Key, UUID, Indexed
  - `sender_id`: Foreign Key referencing `User(user_id)`
  - `recipient_id`: Foreign Key referencing `User(user_id)`
  - `message_body`: `TEXT`, Not Null
  - `sent_at`: `TIMESTAMP`, Default to Current Timestamp
- **Constraints**:
  - Foreign key constraints on `sender_id` and `recipient_id`

## Indexing

To enhance query performance:
- Primary keys are indexed automatically.
- Additional indexes are created on:
  - `email` in the `User` table
  - `property_id` in the `Property` and `Booking` tables
  - `booking_id` in the `Booking` and `Payment` tables
  - `status` in the `Booking` table

## SQL Script

The SQL script includes `CREATE TABLE` statements for all entities, with appropriate constraints and indexes defined. Each table is designed for data integrity, performance, and ease of management.

## Usage

1. Run the SQL script to initialize the database.
2. Ensure proper configuration of the database system to handle UUIDs, ENUMs, and timestamp defaults.
3. Verify the schema using test data and queries to ensure all constraints and indexes function correctly.