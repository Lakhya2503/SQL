-- 1. CATEGORIES - product categories, the "parent" side of a one-to-many
-- relationship with products.
CREATE TABLE categories (
    category_id   SERIAL PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL UNIQUE,
    description   TEXT
);

-- 2. PRODUCTS - everything TechBazaar sells. Each belongs to exactly one
-- category (many-to-one via category_id).
CREATE TABLE products (
    product_id     SERIAL PRIMARY KEY,
    category_id    INT NOT NULL REFERENCES categories(category_id),
    product_name   VARCHAR(100) NOT NULL,
    price          NUMERIC(10, 2) NOT NULL CHECK (price > 0),
    stock_quantity INT NOT NULL DEFAULT 0 CHECK (stock_quantity >= 0),
    is_active      BOOLEAN NOT NULL DEFAULT TRUE,   -- FALSE = discontinued, kept for order history
    created_at     DATE NOT NULL DEFAULT CURRENT_DATE
);

-- 3. CUSTOMERS - people who buy from TechBazaar. referred_by is a
-- self-referencing FK, same idea as employees.manager_id above.
CREATE TABLE customers (
    customer_id    SERIAL PRIMARY KEY,
    first_name     VARCHAR(50) NOT NULL,
    last_name      VARCHAR(50) NOT NULL,
    email          VARCHAR(100) NOT NULL UNIQUE,
    phone          VARCHAR(20),                     -- nullable: not every customer gives a phone number
    city           VARCHAR(50),                     -- nullable, on purpose (NULL-handling examples later)
    country        VARCHAR(50) NOT NULL DEFAULT 'USA',
    signup_date    DATE NOT NULL DEFAULT CURRENT_DATE,
    loyalty_points INT NOT NULL DEFAULT 0,
    referred_by    INT REFERENCES customers(customer_id)
);

-- 4. ORDERS - one row per customer order. employee_id is nullable:
-- customers can check out on the website with no sales rep involved.
CREATE TABLE orders (
    order_id      SERIAL PRIMARY KEY,
    customer_id   INT NOT NULL REFERENCES customers(customer_id),
    employee_id   INT REFERENCES employees(employee_id),   -- NULL = self-service web order
    order_date    DATE NOT NULL DEFAULT CURRENT_DATE,
    status        VARCHAR(20) NOT NULL DEFAULT 'pending'
                   CHECK (status IN ('pending', 'processing', 'completed', 'cancelled', 'refunded')),
    shipping_city VARCHAR(50),
    notes         TEXT
);

-- 5. ORDER_ITEMS - the line items of an order: which products, how many,
-- and at what price. unit_price is a snapshot of the price AT THE TIME of
-- the order, since a product's catalog price can change afterwards.
-- ON DELETE CASCADE: delete an order, its line items go with it.
CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id      INT NOT NULL REFERENCES orders(order_id) ON DELETE CASCADE,
    product_id    INT NOT NULL REFERENCES products(product_id),
    quantity      INT NOT NULL CHECK (quantity > 0),
    unit_price    NUMERIC(10, 2) NOT NULL CHECK (unit_price > 0)
);

-- 6. PAYMENTS - money actually collected against an order. Not every
-- order has a payment yet (e.g. still 'pending').
CREATE TABLE payments (
    payment_id     SERIAL PRIMARY KEY,
    order_id       INT NOT NULL REFERENCES orders(order_id) ON DELETE CASCADE,
    payment_date   DATE NOT NULL,
    amount         NUMERIC(10, 2) NOT NULL CHECK (amount > 0),
    payment_method VARCHAR(20) NOT NULL
                   CHECK (payment_method IN ('credit_card', 'debit_card', 'paypal', 'bank_transfer', 'gift_card', 'upi')),
    status         VARCHAR(20) NOT NULL DEFAULT 'success'
                   CHECK (status IN ('success', 'failed', 'refunded'))
);

-- Relationships at a glance:
--   employees  (many) >─── (1) employees         [self: manager_id - already seeded above]
--   categories (1) ───< (many) products
--   customers  (1) ───< (many) orders
--   employees  (1) ───< (many) orders            [nullable FK: web orders have no rep]
--   orders     (1) ───< (many) order_items
--   products   (1) ───< (many) order_items
--   orders     (1) ───< (many) payments
--   customers  (many) >─── (1) customers         [self: referred_by]
-- order_items is a JUNCTION TABLE between orders and products - it sits
-- between them and carries its own data (quantity, unit_price), which is
-- exactly how a many-to-many relationship is modeled in SQL.


-- ----------------------------------------------------------------------------
-- SEED DATA
-- ----------------------------------------------------------------------------

INSERT INTO categories (category_name, description) VALUES
    ('Electronics',            'Gadgets, computer accessories and audio equipment'),
    ('Home & Kitchen',         'Appliances and tools for cooking and the home'),
    ('Books',                  'Programming, productivity and self-improvement books'),
    ('Clothing',               'Everyday apparel for men and women'),
    ('Sports & Outdoors',      'Fitness, camping and outdoor gear'),
    ('Beauty & Personal Care', 'Skincare, haircare and personal grooming products');

-- 30 products, 5 per category. Notes for later sections:
--   - product 3 (USB-C Hub) has 0 stock
--   - product 20 (Rain Jacket) is_active = FALSE (discontinued, still referenced by history)
--   - product 28 (Hair Dryer) is active but never ordered
INSERT INTO products (category_id, product_name, price, stock_quantity, is_active, created_at) VALUES
    (1, 'Wireless Mouse',                19.99, 120, TRUE,  '2023-01-10'),
    (1, 'Mechanical Keyboard',           79.99,  45, TRUE,  '2023-01-10'),
    (1, 'USB-C Hub',                     34.50,   0, TRUE,  '2023-02-01'),
    (1, '27-inch Monitor',              249.99,  15, TRUE,  '2023-02-15'),
    (1, 'Noise Cancelling Headphones',  129.00,  30, TRUE,  '2023-03-01'),
    (2, 'Stainless Steel Kettle',        39.99,  60, TRUE,  '2023-01-20'),
    (2, 'Non-stick Frying Pan',          24.99,  80, TRUE,  '2023-01-20'),
    (2, 'Air Fryer',                     89.99,  25, TRUE,  '2023-02-10'),
    (2, 'Coffee Maker',                  54.99,  40, TRUE,  '2023-02-10'),
    (2, 'Blender',                       44.50,  35, TRUE,  '2023-03-05'),
    (3, 'Learning SQL',                  42.00, 100, TRUE,  '2023-01-05'),
    (3, 'Clean Code',                    38.50,  70, TRUE,  '2023-01-05'),
    (3, 'The Pragmatic Programmer',      45.00,  55, TRUE,  '2023-01-05'),
    (3, 'Atomic Habits',                 16.99, 150, TRUE,  '2023-01-05'),
    (3, 'Deep Work',                     18.99,  90, TRUE,  '2023-01-05'),
    (4, 'Men''s Cotton T-Shirt',         14.99, 200, TRUE,  '2023-02-01'),
    (4, 'Women''s Denim Jacket',         59.99,  40, TRUE,  '2023-02-01'),
    (4, 'Running Shoes',                 89.00,  60, TRUE,  '2023-02-20'),
    (4, 'Wool Sweater',                  49.99,  35, TRUE,  '2023-03-10'),
    (4, 'Rain Jacket',                   69.99,  20, FALSE, '2023-02-20'),
    (5, 'Yoga Mat',                      22.00, 110, TRUE,  '2023-01-25'),
    (5, 'Dumbbell Set 20kg',             75.00,  25, TRUE,  '2023-01-25'),
    (5, 'Camping Tent 2-Person',        110.00,  18, TRUE,  '2023-03-15'),
    (5, 'Cycling Helmet',                39.99,  50, TRUE,  '2023-03-15'),
    (5, 'Water Bottle 1L',               12.99, 180, TRUE,  '2023-01-25'),
    (6, 'Moisturizing Cream',            18.50,  95, TRUE,  '2023-02-05'),
    (6, 'Electric Toothbrush',           49.99,  40, TRUE,  '2023-02-05'),
    (6, 'Hair Dryer',                    34.99,  30, TRUE,  '2023-02-05'),
    (6, 'Sunscreen SPF50',               15.99, 100, TRUE,  '2023-03-01'),
    (6, 'Perfume 50ml',                  65.00,  25, TRUE,  '2023-03-01');

-- 20 customers. Notes for later sections:
--   - phone/city are NULL for several rows on purpose
--   - referred_by chains a few customers back to an earlier customer
--   - customers 19 and 20 have NO orders at all
--   - customer 18 has exactly ONE order, and it's cancelled
INSERT INTO customers (first_name, last_name, email, phone, city, country, signup_date, loyalty_points, referred_by) VALUES
    ('Alice',    'Johnson',  'alice.johnson@email.com',  '212-555-0101', 'New York',      'USA',    '2023-01-15', 320, NULL),
    ('Brian',    'Kim',      'brian.kim@email.com',      NULL,           'Los Angeles',   'USA',    '2023-02-20', 150, 1),
    ('Carla',    'Mendes',   'carla.mendes@email.com',   '305-555-0103', 'Miami',         'USA',    '2023-03-05',  80, NULL),
    ('David',    'Okoro',    'david.okoro@email.com',    '312-555-0104', 'Chicago',       'USA',    '2023-03-22',   0, NULL),
    ('Elena',    'Petrova',  'elena.petrova@email.com',  NULL,           'Seattle',       'USA',    '2023-04-10', 210, 1),
    ('Farid',    'Haidari',  'farid.haidari@email.com',  '206-555-0106', 'Seattle',       'USA',    '2023-04-18',  45, NULL),
    ('Grace',    'Lin',      'grace.lin@email.com',      '415-555-0107', 'San Francisco', 'USA',    '2023-05-02', 500, NULL),
    ('Hassan',   'Ali',      'hassan.ali@email.com',     NULL,           'Houston',       'USA',    '2023-05-29',  60, 3),
    ('Isabella', 'Rossi',    'isabella.rossi@email.com', '617-555-0109', 'Boston',        'USA',    '2023-06-14',   0, NULL),
    ('Jamal',    'Carter',   'jamal.carter@email.com',   '404-555-0110', 'Atlanta',       'USA',    '2023-07-01',  90, NULL),
    ('Kavya',    'Reddy',    'kavya.reddy@email.com',    '512-555-0111', 'Austin',        'USA',    '2023-07-19', 130, 7),
    ('Liam',     'O''Brien', 'liam.obrien@email.com',    NULL,           'Denver',        'USA',    '2023-08-08',  20, NULL),
    ('Mei',      'Tanaka',   'mei.tanaka@email.com',     '602-555-0113', 'Phoenix',       'USA',    '2023-08-27',  75, NULL),
    ('Noah',     'Schmidt',  'noah.schmidt@email.com',   NULL,           NULL,            'USA',    '2023-09-10',   0, NULL),
    ('Olivia',   'Martin',   'olivia.martin@email.com',  '503-555-0115', 'Portland',      'USA',    '2023-09-30', 260, 7),
    ('Paulo',    'Souza',    'paulo.souza@email.com',    NULL,           'Sao Paulo',     'Brazil', '2023-10-12',  15, NULL),
    ('Queenie',  'Wu',       'queenie.wu@email.com',     NULL,           'Toronto',       'Canada', '2023-11-02',  40, NULL),
    ('Ravi',     'Kapoor',   'ravi.kapoor@email.com',    NULL,           'Mumbai',        'India',  '2023-11-25',   0, NULL),
    ('Sofia',    'Nowak',    'sofia.nowak@email.com',    NULL,           NULL,            'Poland', '2023-12-05',   0, NULL),
    ('Tomas',    'Vidal',    'tomas.vidal@email.com',    NULL,           'Madrid',        'Spain',  '2024-01-08',   0, NULL);

-- 45 orders, spread across Jan-Jun 2024. Statuses mixed on purpose:
-- 'pending' orders have no payment yet, 'cancelled' orders never got
-- paid, and customers 19/20 place none at all. employee_id values below
-- (1-4) point at Robert/Priya/Marcus/Elena, seeded back in PART 1.

INSERT INTO orders (customer_id, employee_id, order_date, status, shipping_city) VALUES
    (1,  42,    '2024-01-05', 'completed', 'New York'),
    (3,  NULL, '2024-01-07', 'completed', 'Miami'),
    (5,  44,    '2024-01-10', 'completed', 'Seattle'),
    (7,  NULL, '2024-01-12', 'cancelled', 'San Francisco'),
    (9,  43,    '2024-01-15', 'completed', 'Boston'),
    (2,  42,    '2024-01-18', 'completed', 'Los Angeles'),
    (11, NULL, '2024-01-22', 'completed', 'Austin'),
    (4,  44,    '2024-01-25', 'pending',   'Chicago'),
    (6,  3,    '2024-02-02', 'completed', 'Seattle'),
    (8,  NULL, '2024-02-05', 'completed', 'Houston'),
    (1,  42,    '2024-02-08', 'completed', 'New York'),
    (13, 44,    '2024-02-11', 'completed', 'Phoenix'),
    (10, NULL, '2024-02-14', 'refunded',  'Atlanta'),
    (15, 43,    '2024-02-18', 'completed', 'Portland'),
    (3,  NULL, '2024-02-21', 'completed', 'Miami'),
    (7,  42,    '2024-02-25', 'completed', 'San Francisco'),
    (12, 44,    '2024-03-01', 'completed', 'Denver'),
    (5,  NULL, '2024-03-04', 'completed', 'Seattle'),
    (9,  43,    '2024-03-08', 'cancelled', 'Boston'),
    (2,  42,    '2024-03-12', 'completed', 'Los Angeles'),
    (1,  44,    '2024-03-19', 'completed', 'New York'),
    (11, 43,    '2024-03-27', 'completed', 'Austin'),
    (6,  42,    '2024-04-02', 'completed', 'Seattle'),
    (18, NULL, '2024-04-05', 'cancelled', 'Mumbai'),
    (8,  44,    '2024-04-09', 'completed', 'Houston'),
    (3,  NULL, '2024-04-12', 'completed', 'Miami'),
    (13, 43,    '2024-04-16', 'completed', 'Phoenix'),
    (7,  42,    '2024-04-20', 'completed', 'San Francisco'),
    (15, NULL, '2024-04-24', 'completed', 'Portland'),
    (10, 41,    '2024-04-28', 'completed', 'Atlanta'),
    (1,  40,    '2024-05-02', 'completed', 'New York'),
    (5,  44,    '2024-05-06', 'completed', 'Seattle'),
    (17, 40,    '2024-05-14', 'completed', 'Toronto'),
    (2,  39,    '2024-05-18', 'pending',   'Los Angeles'),
    (11, 40,    '2024-05-26', 'completed', 'Austin'),
    (4,  40,    '2024-05-30', 'completed', 'Chicago'),
    (6,  43,    '2024-06-03', 'completed', 'Seattle'),
    (1,  44,    '2024-06-11', 'completed', 'New York'),
    (15, 39,    '2024-06-15', 'completed', 'Portland'),
    (9,  3,    '2024-06-20', 'completed', 'Boston');

-- Line items for every order above. Order 1's keyboard (74.99, below
-- today's catalog price of 79.99) and order 33's book (39.99, below
-- today's 42.00) are deliberate - proof unit_price is a per-line snapshot,
-- not always trusting products.price.
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
    (1404,  1,  1, 19.99),
(1404,  2,  1, 74.99),
(1405, 11,  2, 42.00),
(1405, 14,  1, 16.99),
(1406,  5,  1, 129.00),
(1406, 21,  2, 22.00),
(1407,  9,  1, 54.99),
(1407, 10,  1, 44.50),
(1408, 16,  3, 14.99),
(1408, 18,  1, 89.00),
(1409, 22,  1, 75.00),
(1409, 24,  1, 39.99),
(1410,  4,  1, 249.99),
(1411,  6,  1, 39.99),
(1411,  7,  2, 24.99),
(1412, 26,  2, 18.50),
(1412, 29,  1, 15.99),
(1413,  2,  1, 79.99),
(1413,  1,  2, 19.99),
(1414, 13,  1, 45.00),
(1414, 12,  1, 38.50),
(1415, 27,  1, 49.99),
(1416, 30,  1, 65.00),
(1416,  6,  1, 39.99),
(1417, 17,  1, 59.99),
(1418,  3,  1, 34.50),
(1418,  5,  1, 129.00),
(1419, 19,  1, 49.99),
(1419, 16,  2, 14.99),
(1420, 23,  1, 110.00),
(1421, 25,  4, 12.99),
(1422,  8,  1, 89.99),
(1423, 20,  1, 69.99),
(1404, 11,  1, 42.00),
(1404, 15,  1, 18.99),
(1405,  9,  1, 54.99),
(1405, 24,  2, 39.99),
(1406, 21,  1, 22.00),
(1406,  6,  1, 39.99),
(1407, 22,  1, 75.00),
(1408, 10,  1, 44.50),
(1408,  7,  1, 24.99),
(1409, 29,  3, 15.99),
(1410, 13,  1, 45.00),
(1410,  5,  1, 129.00),
(1411,  3,  1, 34.50),
(1412, 18,  1, 89.00),
(1412, 16,  1, 14.99),
(1413, 14,  2, 16.99),
(1413, 12,  1, 38.50),
(1414, 11,  1, 39.99),
(1415,  2,  1, 79.99),
(1416,  9,  1, 54.99),
(1416, 10,  1, 44.50),
(1417, 30,  1, 65.00),
(1418,  4,  1, 249.99),
(1419, 23,  1, 110.00),
(1420, 21,  2, 22.00),
(1420, 25,  2, 12.99),
(1421, 19,  1, 49.99),
(1422,  6,  1, 39.99),
(1422,  8,  1, 89.99),
(1423,  1,  1, 19.99),
(1423,  2,  1, 79.99),
(1404, 27,  1, 49.99),
(1405, 17,  1, 59.99),
(1405, 16,  1, 14.99),
(1406, 30,  1, 65.00),
(1406, 26,  1, 18.50);

-- Every 'completed'/'refunded' order has one payment; 'pending' (8, 37)
-- and 'cancelled' (4, 19, 26) orders have none - this asymmetry is what
-- makes LEFT JOIN / NOT EXISTS examples meaningful later.
INSERT INTO payments (order_id, payment_date, amount, payment_method, status) VALUES
   (1384, '2024-01-05',  94.98, 'credit_card',   'success'),
(1385, '2024-01-08', 100.99, 'paypal',        'success'),
(1386, '2024-01-10', 129.00, 'debit_card',    'success'),
(1387, '2024-01-16',  99.49, 'gift_card',     'success'),
(1388, '2024-01-19', 133.97, 'credit_card',   'success'),
(1389, '2024-01-22', 114.99, 'paypal',        'success'),
(1390, '2024-02-02',  89.97, 'debit_card',    'success'),
(1391, '2024-02-06',  52.99, 'bank_transfer', 'success'),
(1392, '2024-02-08', 119.97, 'credit_card',   'success'),
(1393, '2024-02-12',  83.50, 'paypal',        'success'),
(1394, '2024-02-16',  49.99, 'credit_card',   'refunded'),
(1395, '2024-02-18', 104.99, 'debit_card',    'success'),
(1396, '2024-02-22', 163.50, 'gift_card',     'success'),
(1397, '2024-02-26',  79.97, 'credit_card',   'success'),
(1398, '2024-03-02', 110.00, 'paypal',        'success'),
(1399, '2024-03-04',  60.99, 'debit_card',    'success'),
(1400, '2024-03-13', 101.98, 'credit_card',   'success'),
(1401, '2024-03-16',  69.99, 'bank_transfer', 'success'),
(1402, '2024-03-19',  60.99, 'paypal',        'success'),
(1403, '2024-03-24',  54.99, 'credit_card',   'success'),
(1404, '2024-03-28', 101.98, 'debit_card',    'success'),
(1405, '2024-04-02',  39.99, 'gift_card',     'success'),
(1406, '2024-04-10',  69.49, 'paypal',        'success'),
(1407, '2024-04-13',  47.97, 'credit_card',   'success'),
(1408, '2024-04-17',  45.00, 'debit_card',    'success'),
(1409, '2024-04-21', 163.50, 'bank_transfer', 'success'),
(1410, '2024-04-25', 103.99, 'credit_card',   'success'),
(1411, '2024-04-29',  72.48, 'paypal',        'success'),
(1412, '2024-05-02',  39.99, 'credit_card',   'success'),
(1413, '2024-05-07',  79.99, 'debit_card',    'success'),
(1414, '2024-05-11',  99.49, 'gift_card',     'success'),
(1415, '2024-05-15',  65.00, 'credit_card',   'success'),
(1416, '2024-05-23', 110.00, 'paypal',        'success'),
(1417, '2024-05-27',  69.98, 'debit_card',    'success'),
(1418, '2024-05-31',  49.99, 'bank_transfer', 'success'),
(1419, '2024-06-04', 129.98, 'credit_card',   'success'),
(1420, '2024-06-08',  99.98, 'paypal',        'success'),
(1421, '2024-06-12',  49.99, 'debit_card',    'success'),
(1422, '2024-06-16',  74.98, 'gift_card',     'success'),
(1423, '2024-06-21',  83.50, 'credit_card',   'success');

-- Sanity check - run this and confirm row counts. Expected: employees 8,
-- categories 6, products 30, customers 20, orders 45, order_items 69,
-- payments 40.
SELECT 'employees'   AS table_name, COUNT(*) AS row_count FROM employees
UNION ALL SELECT 'categories',   COUNT(*) FROM categories
UNION ALL SELECT 'products',     COUNT(*) FROM products
UNION ALL SELECT 'customers',    COUNT(*) FROM customers
UNION ALL SELECT 'orders',       COUNT(*) FROM orders
UNION ALL SELECT 'order_items',  COUNT(*) FROM order_items
UNION ALL SELECT 'payments',     COUNT(*) FROM payments;