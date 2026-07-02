-- ==========================================
-- Week 3 SQL Project
-- Database: Chinook
-- Author: Promise Ezeibe
-- ==========================================

-- ==========================================
-- TASK 1: Display all customers
-- ==========================================

SELECT *
FROM customer;

-- ==========================================
-- TASK 2: Display selected columns
-- ==========================================

SELECT first_name, last_name, email
FROM customer;

-- ==========================================
-- TASK 3: Customers from Brazil
-- ==========================================

SELECT *
FROM customer
WHERE country = 'Brazil';

-- ==========================================
-- TASK 4: Customers from Canada
-- ==========================================

SELECT *
FROM customer
WHERE country = 'Canada';

-- ==========================================
-- TASK 5: Customers NOT from Canada
-- ==========================================

SELECT first_name, last_name, city
FROM customer
WHERE country <> 'Canada';

-- ==========================================
-- TASK 6: Sort customers alphabetically
-- ==========================================

SELECT first_name, last_name
FROM customer
ORDER BY first_name;

-- ==========================================
-- TASK 7: Sort customers in descending order
-- ==========================================

SELECT first_name, last_name
FROM customer
ORDER BY first_name DESC;

-- ==========================================
-- TASK 8: Display first 10 customers
-- ==========================================

SELECT *
FROM customer
LIMIT 10;

-- ==========================================
-- TASK 9: Display unique countries
-- ==========================================

SELECT DISTINCT country
FROM customer
ORDER BY country;

-- ==========================================
-- TASK 10: Count total customers
-- ==========================================

SELECT COUNT(*) AS total_customers
FROM customer;

-- ==========================================
-- TASK 11: Customers by country
-- ==========================================

SELECT country,
       COUNT(*) AS total_customers
FROM customer
GROUP BY country
ORDER BY total_customers DESC;

-- ==========================================
-- TASK 12: Countries with more than one customer
-- ==========================================

SELECT country,
       COUNT(*) AS total_customers
FROM customer
GROUP BY country
HAVING COUNT(*) > 1;

-- ==========================================
-- TASK 13: Customer invoices
-- ==========================================

SELECT
    c.first_name,
    c.last_name,
    i.invoice_id,
    i.total
FROM customer c
INNER JOIN invoice i
ON c.customer_id = i.customer_id;

-- ==========================================
-- TASK 14: Total spent by each customer
-- ==========================================

SELECT
    c.first_name,
    c.last_name,
    SUM(i.total) AS total_spent
FROM customer c
INNER JOIN invoice i
ON c.customer_id = i.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC;

-- ==========================================
-- TASK 15: Top 10 customers
-- ==========================================

SELECT
    c.first_name,
    c.last_name,
    SUM(i.total) AS total_spent
FROM customer c
JOIN invoice i
ON c.customer_id = i.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC
LIMIT 10;

-- ==========================================
-- TASK 16: Total revenue
-- ==========================================

SELECT
    SUM(total) AS total_revenue
FROM invoice;

-- ==========================================
-- TASK 17: Average invoice amount
-- ==========================================

SELECT
    ROUND(AVG(total),2) AS average_invoice
FROM invoice;

-- ==========================================
-- TASK 18: Highest invoice
-- ==========================================

SELECT
    MAX(total) AS highest_invoice
FROM invoice;

-- ==========================================
-- TASK 19: Lowest invoice
-- ==========================================

SELECT
    MIN(total) AS lowest_invoice
FROM invoice;

-- ==========================================
-- TASK 20: Total number of invoices
-- ==========================================

SELECT
    COUNT(*) AS total_invoices
FROM invoice;

-- ==========================================
-- TASK 21: Customer spending
-- ==========================================

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    ROUND(SUM(i.total),2) AS total_spent
FROM customer c
JOIN invoice i
ON c.customer_id = i.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC;

-- ==========================================
-- TASK 22: Top 5 customers
-- ==========================================

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    ROUND(SUM(i.total),2) AS total_spent
FROM customer c
JOIN invoice i
ON c.customer_id = i.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC
LIMIT 5;

-- ==========================================
-- TASK 23: Revenue by country
-- ==========================================

SELECT
    billing_country,
    ROUND(SUM(total),2) AS revenue
FROM invoice
GROUP BY billing_country
ORDER BY revenue DESC;

-- ==========================================
-- TASK 24: Number of customers by country
-- ==========================================

SELECT
    country,
    COUNT(*) AS customers
FROM customer
GROUP BY country
ORDER BY customers DESC;

-- ==========================================
-- TASK 25: Monthly revenue
-- ==========================================

SELECT
    EXTRACT(YEAR FROM invoice_date) AS year,
    EXTRACT(MONTH FROM invoice_date) AS month,
    ROUND(SUM(total),2) AS revenue
FROM invoice
GROUP BY year, month
ORDER BY year, month;

-- ==========================================
-- TASK 26: Top 10 best-selling tracks
-- ==========================================

SELECT
    t.name,
    COUNT(il.track_id) AS sales
FROM track t
JOIN invoice_line il
ON t.track_id = il.track_id
GROUP BY t.track_id, t.name
ORDER BY sales DESC
LIMIT 10;

-- ==========================================
-- TASK 27: Revenue by genre
-- ==========================================

SELECT
    g.name,
    ROUND(SUM(il.unit_price * il.quantity),2) AS revenue
FROM genre g
JOIN track t
ON g.genre_id = t.genre_id
JOIN invoice_line il
ON t.track_id = il.track_id
GROUP BY g.genre_id, g.name
ORDER BY revenue DESC;

-- ==========================================
-- TASK 28: Revenue by artist
-- ==========================================

SELECT
    ar.name,
    ROUND(SUM(il.unit_price * il.quantity),2) AS revenue
FROM artist ar
JOIN album al
ON ar.artist_id = al.artist_id
JOIN track t
ON al.album_id = t.album_id
JOIN invoice_line il
ON t.track_id = il.track_id
GROUP BY ar.artist_id, ar.name
ORDER BY revenue DESC
LIMIT 10;

-- ==========================================
-- TASK 29: Row numbering using window function
-- ==========================================

SELECT
    first_name,
    last_name,
    ROW_NUMBER() OVER (ORDER BY first_name) AS row_num
FROM customer;