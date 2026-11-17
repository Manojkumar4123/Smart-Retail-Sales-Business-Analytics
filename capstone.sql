CREATE DATABASE capstone;

USE capstone;

CREATE TABLE brands (
    Brand_id INT PRIMARY KEY,
    Brand_name VARCHAR(100) NOT NULL
);

CREATE TABLE customers (
    Customer_id INT PRIMARY KEY,
    First_name VARCHAR(50) NOT NULL,
    Last_name VARCHAR(50) NOT NULL,
    Phone VARCHAR(25),
    Email VARCHAR(100) NOT NULL,
    Street VARCHAR(100) NOT NULL,
    City VARCHAR(50) NOT NULL,
    State VARCHAR(50) NOT NULL,
    Zip_code INT NOT NULL
);

CREATE TABLE stores (
    Store_id INT PRIMARY KEY,
    Store_name VARCHAR(100) NOT NULL,
    Phone VARCHAR(25) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Street VARCHAR(100) NOT NULL,
    City VARCHAR(50) NOT NULL,
    State VARCHAR(50) NOT NULL,
    Zip_code INT NOT NULL
); 

CREATE TABLE staffs (
    Staff_id INT PRIMARY KEY,
    First_name VARCHAR(50) NOT NULL,
    Last_name VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Phone VARCHAR(100) NOT NULL,
    Active TINYINT NOT NULL,
    Store_id INT NOT NULL,
    Manager_id INT,

    FOREIGN KEY (Store_id)
        REFERENCES stores(Store_id),

    FOREIGN KEY (Manager_id)
        REFERENCES staffs(Staff_id)
);

CREATE TABLE products (
    Product_id INT PRIMARY KEY,
    Product_name VARCHAR(255) NOT NULL,
    Brand_id INT NOT NULL,
    Category_id INT NOT NULL,
    Model_year YEAR NOT NULL,
    List_price DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (Brand_id)
        REFERENCES brands(Brand_id)
);


CREATE TABLE stocks (
    Store_id INT NOT NULL,
    Product_id INT NOT NULL,
    Quantity INT NOT NULL,

    PRIMARY KEY (Store_id, Product_id),

    FOREIGN KEY (Store_id)
        REFERENCES stores(Store_id),

    FOREIGN KEY (Product_id)
        REFERENCES products(Product_id)
);

CREATE TABLE orders (
    Order_id INT PRIMARY KEY,
    Customer_id INT NOT NULL,
    Order_status VARCHAR(30) NOT NULL,
    Order_date DATE NOT NULL,
    Required_date DATE NOT NULL,
    Shipped_date DATE,
    Store_id INT NOT NULL,
    Staff_id INT NOT NULL,

    FOREIGN KEY (Customer_id)
        REFERENCES customers(Customer_id),

    FOREIGN KEY (Store_id)
        REFERENCES stores(Store_id),

    FOREIGN KEY (Staff_id)
        REFERENCES staffs(Staff_id)
);


CREATE TABLE order_items (
    Order_id INT NOT NULL,
    Item_id INT NOT NULL,
    Product_id INT NOT NULL,
    Quantity INT NOT NULL,
    List_price DECIMAL(10,2) NOT NULL,
    Discount DECIMAL(5,2) NOT NULL,
    Total_Price DECIMAL(12,2) NOT NULL,

    PRIMARY KEY (Order_id, Item_id),

    FOREIGN KEY (Order_id)
        REFERENCES orders(Order_id),

    FOREIGN KEY (Product_id)
        REFERENCES products(Product_id)
);

CREATE TABLE categories (
    Category_id INT PRIMARY KEY,
    Category_name VARCHAR(100) NOT NULL
);

-- 3. Inner Join for Order Details :
-- Join orders, order_items, and products to display detailed line items:

USE capstone;

SELECT
    o.Order_id,
    o.Order_date,
    o.Customer_id,
    oi.Item_id,
    p.Product_id,
    p.Product_name,
    oi.Quantity,
    oi.List_price,
    oi.Discount,
    oi.Total_Price
FROM orders o
INNER JOIN order_items oi
    ON o.Order_id = oi.Order_id
INNER JOIN products p
    ON oi.Product_id = p.Product_id
LIMIT 1000;
    
    -- 4. Total Sales by Store :
-- Write a query to group sales (total_price) by each store_id:

-- 4. Total Sales by Store

SELECT
    s.Store_id,
    s.Store_name,
    SUM(oi.Total_Price) AS Total_Sales
FROM stores s
INNER JOIN orders o
    ON s.Store_id = o.Store_id
INNER JOIN order_items oi
    ON o.Order_id = oi.Order_id
GROUP BY
    s.Store_id,
    s.Store_name
ORDER BY Total_Sales DESC;

-- 5. Top 5 Selling Products 
-- Use ORDER BY and LIMIT to get the top 5 most sold products by quantity.


SELECT
    p.Product_id,
    p.Product_name,
    SUM(oi.Quantity) AS Total_Quantity_Sold
FROM products p
INNER JOIN order_items oi
    ON p.Product_id = oi.Product_id
GROUP BY
    p.Product_id,
    p.Product_name
ORDER BY Total_Quantity_Sold DESC
LIMIT 5;

-- 6. Customer Purchase Summary 
-- For each customer, return total orders placed, total items purchased, and total revenue.
-- 6. Customer Purchase Summary

SELECT
    c.Customer_id,
    CONCAT(c.First_name, ' ', c.Last_name) AS Customer_Name,
    COUNT(DISTINCT o.Order_id) AS Total_Orders,
    COALESCE(SUM(oi.Quantity), 0) AS Total_Items_Purchased,
    COALESCE(SUM(oi.Total_Price), 0) AS Total_Revenue

FROM customers c

LEFT JOIN orders o
    ON c.Customer_id = o.Customer_id

LEFT JOIN order_items oi
    ON o.Order_id = oi.Order_id

GROUP BY
    c.Customer_id,
    c.First_name,
    c.Last_name

ORDER BY Total_Revenue DESC;

-- 7. Segment Customers by Total Spend 
-- o Write a query to classify customers into spending brackets (e.g., low, 
-- medium, high).

-- 7. Segment Customers by Total Spend

SELECT
    c.Customer_id,
    CONCAT(c.First_name, ' ', c.Last_name) AS Customer_Name,
    COALESCE(SUM(oi.Total_Price), 0) AS Total_Spend,

    CASE
        WHEN COALESCE(SUM(oi.Total_Price), 0) < 1000
            THEN 'Low'

        WHEN COALESCE(SUM(oi.Total_Price), 0) BETWEEN 1000 AND 5000
            THEN 'Medium'

        ELSE 'High'
    END AS Spending_Bracket

FROM customers c

LEFT JOIN orders o
    ON c.Customer_id = o.Customer_id

LEFT JOIN order_items oi
    ON o.Order_id = oi.Order_id

GROUP BY
    c.Customer_id,
    c.First_name,
    c.Last_name

ORDER BY Total_Spend DESC;

-- 8. Staff Performance Analysis 
-- o Analyze total revenue generated by each staff member based on their 
-- handled orders.

SELECT
    s.Staff_id,
    CONCAT(s.First_name, ' ', s.Last_name) AS Staff_Name,
    st.Store_name,
    COUNT(DISTINCT o.Order_id) AS Total_Orders_Handled,
    COALESCE(SUM(oi.Total_Price), 0) AS Total_Revenue

FROM staffs s

LEFT JOIN stores st
    ON s.Store_id = st.Store_id

LEFT JOIN orders o
    ON s.Staff_id = o.Staff_id

LEFT JOIN order_items oi
    ON o.Order_id = oi.Order_id

GROUP BY
    s.Staff_id,
    s.First_name,
    s.Last_name,
    st.Store_name

ORDER BY Total_Revenue DESC;

-- 9. Stock Alert Query 
-- o Write a query to list products where stock quantity < 10 in any store.

-- 9. Stock Alert Query

SELECT
    st.Store_id,
    s.Store_name,
    st.Product_id,
    p.Product_name,
    st.Quantity AS Stock_Quantity

FROM stocks st

INNER JOIN stores s
    ON st.Store_id = s.Store_id

INNER JOIN products p
    ON st.Product_id = p.Product_id

WHERE st.Quantity < 10

ORDER BY st.Quantity ASC;

-- 10. Create Final Segmentation Table 
-- o Create a table customer_segments that will be populated from Python 
-- ML results later:

create table customer_segments (
   customer_id varchar(50) ,
   Recency varchar(50),
   Frequency varchar(50),
   Monetary varchar(50),
   segment varchar(50)

);


select * from customer_segments;



SHOW CREATE TABLE capstone.products;

ALTER TABLE capstone.products
ADD CONSTRAINT fk_products_brand
FOREIGN KEY (Brand_id)
REFERENCES capstone.brands (Brand_id);

SHOW CREATE TABLE capstone.order_items;

ALTER TABLE capstone.order_items
ADD CONSTRAINT fk_order_items_product
FOREIGN KEY (Product_id)
REFERENCES capstone.products (Product_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

select Segment,count(*)
from customer_segments
group by Segment; 

select count(Segment) from customer_segments;

DESCRIBE customer_segments;

SELECT Customer_Segment, COUNT(*)
FROM customer_segments
GROUP BY Customer_Segment;