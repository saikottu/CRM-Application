-- View all Users
SELECT * FROM users;

-- Delete a User by ID
DELETE FROM users WHERE id = 39;

-- Update User email
UPDATE users
SET email = 'sainaidukottu12@gmail.com'
WHERE username = 'sai';

-- View all Requests
SELECT * FROM requests;

-- Search Customers by name
SELECT * FROM customers WHERE name LIKE '%lak%';

-- View all Customers
SELECT * FROM customers;

-- View all Logs
SELECT * FROM logs;

-- View Report Downloads
SELECT * FROM report_downloads;
