```markdown
# Step 1: Initial Query to Retrieve All Bookings with User, Property, and Payment Details

The initial query retrieves booking details along with the corresponding user, property, and payment information. Below is the SQL query saved to `performance.sql`:

```sql
-- Initial query to retrieve all bookings with user, property, and payment details
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status AS booking_status,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.property_id,
    p.name AS property_name,
    p.location AS property_location,
    pay.payment_id,
    pay.amount AS payment_amount,
    pay.payment_method,
    pay.payment_date
FROM 
    Booking b
JOIN 
    User u ON b.user_id = u.user_id
JOIN 
    Property p ON b.property_id = p.property_id
LEFT JOIN 
    Payment pay ON b.booking_id = pay.booking_id;
```

---

# Step 2: Analyze Query Performance Using EXPLAIN

To analyze the query's performance, use the following command:

```sql
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status AS booking_status,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.property_id,
    p.name AS property_name,
    p.location AS property_location,
    pay.payment_id,
    pay.amount AS payment_amount,
    pay.payment_method,
    pay.payment_date
FROM 
    Booking b
JOIN 
    User u ON b.user_id = u.user_id
JOIN 
    Property p ON b.property_id = p.property_id
LEFT JOIN 
    Payment pay ON b.booking_id = pay.booking_id;
```

**Common Inefficiencies:**
- Multiple `JOIN` operations may result in significant overhead if the tables have a large number of records.
- Inefficient use of indexes if foreign keys (`user_id`, `property_id`, `booking_id`) are not indexed.
- Redundant data fetched due to unoptimized `SELECT` statements (e.g., fetching unused columns).

---

# Step 3: Refactor Query for Improved Performance

The refactored query reduces execution time by:
- Ensuring indexes on foreign key columns are utilized.
- Avoiding fetching unnecessary columns.
- Changing `LEFT JOIN` to `JOIN` if payment details are always required.

```sql
-- Refactored query for better performance
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status AS booking_status,
    u.first_name,
    u.last_name,
    p.name AS property_name,
    pay.amount AS payment_amount,
    pay.payment_method
FROM 
    Booking b
JOIN 
    User u ON b.user_id = u.user_id
JOIN 
    Property p ON b.property_id = p.property_id
LEFT JOIN 
    Payment pay ON b.booking_id = pay.booking_id;
```

**Improvements Made:**
- Selected only the necessary columns to reduce data transfer overhead.
- Utilized indexed columns in `JOIN` conditions (`user_id`, `property_id`, `booking_id`).
- Simplified the query structure by focusing on essential information.

---

# Final Step: Re-run EXPLAIN ANALYZE to Compare Performance

Run the same `EXPLAIN ANALYZE` command on the refactored query to measure the improvements. Document the results, focusing on:
- Reduced query execution time.
- Lower cost and fewer rows scanned.
- Index usage in the query plan.

---

# Saved Queries in `performance.sql`

```sql
-- Initial query
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status AS booking_status,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.property_id,
    p.name AS property_name,
    p.location AS property_location,
    pay.payment_id,
    pay.amount AS payment_amount,
    pay.payment_method,
    pay.payment_date
FROM 
    Booking b
JOIN 
    User u ON b.user_id = u.user_id
JOIN 
    Property p ON b.property_id = p.property_id
LEFT JOIN 
    Payment pay ON b.booking_id = pay.booking_id;

-- Refactored query
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status AS booking_status,
    u.first_name,
    u.last_name,
    p.name AS property_name,
    pay.amount AS payment_amount,
    pay.payment_method
FROM 
    Booking b
JOIN 
    User u ON b.user_id = u.user_id
JOIN 
    Property p ON b.property_id = p.property_id
LEFT JOIN 
    Payment pay ON b.booking_id = pay.booking_id;
```
```