high-usage columns in the User, Booking, and Property tables are those that are frequently used in WHERE, JOIN, and ORDER BY clauses.Following are the columns 
Based on the queries we've written so far, the **high-usage columns** in the **User**, **Booking**, and **Property** tables are those that are frequently used in `WHERE`, `JOIN`, and `ORDER BY` clauses. Here's the breakdown of the high-usage columns for each table, based on the queries discussed:

### **User Table:**
1. **`user_id`**:
   - Used in `JOIN` operations with **Booking** and **Review** tables to link bookings and reviews to specific users.
   - Commonly used in `WHERE` clauses for filtering, especially when querying for specific users or their related data (e.g., `WHERE user_id = <user_id>`).

2. **`email`**:
   - Used in `WHERE` clauses for user lookup (e.g., user login or registration). It's also indexed for faster lookup, as seen in the schema (`CREATE UNIQUE INDEX idx_user_email ON User(email)`).

3. **`role`**:
   - Frequently used in `WHERE` clauses for filtering based on user roles (e.g., `WHERE role = 'host'` or `WHERE role = 'admin'`).


### **Booking Table:**
1. **`user_id`**:
   - Used in `JOIN` operations with the **User** table to link bookings to the user who made them.
   - Commonly used in `WHERE` clauses to filter bookings by user (e.g., `WHERE user_id = <user_id>`).

2. **`property_id`**:
   - Used in `JOIN` operations with the **Property** table to link bookings to specific properties.
   - Frequently used in `WHERE` clauses to filter bookings by property (e.g., `WHERE property_id = <property_id>`).

3. **`booking_id`**:
   - Frequently used in `WHERE` clauses to identify specific bookings.
   - Used in `JOIN` operations with the **Payment** table to link payments to bookings.

### **Property Table:**
1. **`property_id`**:
   - Used in `JOIN` operations with the **Booking**, **Review**, and **Payment** tables to link properties to bookings, reviews, and payments.
   - Commonly used in `WHERE` clauses to filter properties (e.g., `WHERE property_id = <property_id>`).

2. **`host_id`**:
   - Used in `JOIN` operations with the **User** table to link properties to their hosts.
   - Frequently used in `WHERE` clauses to filter properties by host (e.g., `WHERE host_id = <user_id>`).

### **Summary of High-Usage Columns:**
- **User Table**: `user_id`, `email`, `role`
- **Booking Table**:`booking_id`, `user_id`, `property_id`
- **Property Table**: `property_id`, `host_id`


EXPLAIN SELECT Property.*, ROW_NUMBER() OVER (ORDER BY COUNT(Booking.booking_id) DESC), RANK() OVER (ORDER BY COUNT(Booking.booking_id) DESC) AS booking_rank 
FROM Property
LEFT JOIN Booking ON Property.property_id = Booking.property_id
GROUP BY Property.property_id
ORDER BY booking_rank;

# SQL CREATE INDEX commands for the high-usage columns in the User, Booking, and Property tables.

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


# Saving this SQL to a file called 'database_index.sql'
file_path = '/database_index.sql'
with open(file_path, 'w') as file:
    file.write(index_commands)

file_path  # Returning the file path for download
