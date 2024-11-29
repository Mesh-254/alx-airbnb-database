To ensure the database adheres to **3rd Normal Form (3NF)**, we will follow these normalization steps:

---

### **Normalization Steps**

#### **1. First Normal Form (1NF)**
- **Principle**: Ensure that all attributes contain atomic values and each column has unique values.
  - ✅ All attributes are atomic. For example:
    - `User` table attributes like `first_name`, `last_name`, and `email` contain single, indivisible values.
    - No multivalued attributes exist.
  - **Result**: Schema already satisfies 1NF.

---

#### **2. Second Normal Form (2NF)**
- **Principle**: Ensure no partial dependency exists (all non-key attributes depend on the entire primary key).
  - ✅ Each table has a single-column primary key (`user_id`, `property_id`, etc.).
  - Non-key attributes depend solely on the primary key in all tables.
    - Example: In `Property`, attributes like `name`, `description`, `location`, and `pricepernight` depend entirely on `property_id`.

  **Result**: Schema satisfies 2NF.

---

#### **3. Third Normal Form (3NF)**
- **Principle**: Ensure no transitive dependencies exist (non-key attributes depend only on the primary key, not on other non-key attributes).
  - **Review for Potential Violations**:
    - **`User` Table**:
      - `role` is not a derived or redundant field. No changes required.
    - **`Property` Table**:
      - All attributes depend solely on `property_id`.
    - **`Booking` Table**:
      - `total_price` depends on `property_id` and `start_date` to calculate dynamically. It may violate 3NF because it is a derived value.
        - **Fix**: Remove `total_price` and calculate dynamically based on `pricepernight` and `start_date`-`end_date`.
    - **`Payment` Table**:
      - `amount` depends only on `booking_id`. No changes needed.
    - **`Review` Table**:
      - No transitive dependencies. No changes required.
    - **`Message` Table**:
      - No transitive dependencies. No changes required.

---

### **Revised Database Schema**

#### **User Table**
| **Column**          | **Type**                     | **Constraints**                                      |
|----------------------|------------------------------|-----------------------------------------------------|
| user_id             | UUID                         | Primary Key, Indexed                                |
| first_name          | VARCHAR                      | NOT NULL                                           |
| last_name           | VARCHAR                      | NOT NULL                                           |
| email               | VARCHAR                      | UNIQUE, NOT NULL                                   |
| password_hash       | VARCHAR                      | NOT NULL                                           |
| phone_number        | VARCHAR                      | NULL                                               |
| role                | ENUM (guest, host, admin)    | NOT NULL                                           |
| created_at          | TIMESTAMP                   | DEFAULT CURRENT_TIMESTAMP                         |

---

#### **Property Table**
| **Column**          | **Type**                     | **Constraints**                                      |
|----------------------|------------------------------|-----------------------------------------------------|
| property_id         | UUID                         | Primary Key, Indexed                                |
| host_id             | UUID                         | Foreign Key → User(user_id), NOT NULL              |
| name                | VARCHAR                      | NOT NULL                                           |
| description         | TEXT                         | NOT NULL                                           |
| location            | VARCHAR                      | NOT NULL                                           |
| pricepernight       | DECIMAL                      | NOT NULL                                           |
| created_at          | TIMESTAMP                   | DEFAULT CURRENT_TIMESTAMP                         |
| updated_at          | TIMESTAMP                   | ON UPDATE CURRENT_TIMESTAMP                       |

---

#### **Booking Table**
| **Column**          | **Type**                     | **Constraints**                                      |
|----------------------|------------------------------|-----------------------------------------------------|
| booking_id          | UUID                         | Primary Key, Indexed                                |
| property_id         | UUID                         | Foreign Key → Property(property_id), NOT NULL      |
| user_id             | UUID                         | Foreign Key → User(user_id), NOT NULL              |
| start_date          | DATE                         | NOT NULL                                           |
| end_date            | DATE                         | NOT NULL                                           |
| status              | ENUM (pending, confirmed, canceled) | NOT NULL                                   |
| created_at          | TIMESTAMP                   | DEFAULT CURRENT_TIMESTAMP                         |

---

#### **Payment Table**
| **Column**          | **Type**                     | **Constraints**                                      |
|----------------------|------------------------------|-----------------------------------------------------|
| payment_id          | UUID                         | Primary Key, Indexed                                |
| booking_id          | UUID                         | Foreign Key → Booking(booking_id), NOT NULL        |
| amount              | DECIMAL                      | NOT NULL                                           |
| payment_date        | TIMESTAMP                   | DEFAULT CURRENT_TIMESTAMP                         |
| payment_method      | ENUM (credit_card, paypal, stripe) | NOT NULL                                   |

---

#### **Review Table**
| **Column**          | **Type**                     | **Constraints**                                      |
|----------------------|------------------------------|-----------------------------------------------------|
| review_id           | UUID                         | Primary Key, Indexed                                |
| property_id         | UUID                         | Foreign Key → Property(property_id), NOT NULL      |
| user_id             | UUID                         | Foreign Key → User(user_id), NOT NULL              |
| rating              | INTEGER                      | CHECK (rating >= 1 AND rating <= 5), NOT NULL      |
| comment             | TEXT                         | NOT NULL                                           |
| created_at          | TIMESTAMP                   | DEFAULT CURRENT_TIMESTAMP                         |

---

#### **Message Table**
| **Column**          | **Type**                     | **Constraints**                                      |
|----------------------|------------------------------|-----------------------------------------------------|
| message_id          | UUID                         | Primary Key, Indexed                                |
| sender_id           | UUID                         | Foreign Key → User(user_id), NOT NULL              |
| recipient_id        | UUID                         | Foreign Key → User(user_id), NOT NULL              |
| message_body        | TEXT                         | NOT NULL                                           |
| sent_at             | TIMESTAMP                   | DEFAULT CURRENT_TIMESTAMP                         |

---

### **Normalization Summary**
1. Removed `total_price` from the `Booking` table to eliminate redundancy and adhere to 3NF.
2. Verified that no other transitive dependencies exist across all tables.
3. Ensured all attributes depend only on their primary keys.

---

### **Markdown Explanation File**

```markdown
# Database Normalization: Achieving 3NF

## Objectives
1. Eliminate data redundancy.
2. Ensure database design adheres to 3NF principles.

## Normalization Steps
1. **1NF**: Ensured all attributes are atomic and unique.
2. **2NF**: Ensured no partial dependencies exist.
3. **3NF**:
   - Removed `total_price` from the `Booking` table (derived value).
   - Verified no transitive dependencies exist across all tables.

## Final Design
- The schema adheres to 3NF principles.
- Tables ensure efficient storage and eliminate redundant data.

## Benefits
1. Improved data consistency.
2. Reduced redundancy.
3. Enhanced query performance.

## Future Considerations
1. Index heavily used columns like `email`, `property_id`, and `booking_id`.
2. Optimize queries for large-scale applications.
```

