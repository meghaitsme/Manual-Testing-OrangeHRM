/* products table :-  stores comprehensive information about all items available for sale in our business. 
This table serves as the central repository for product information and is crucial for 
inventory management, pricing strategies, and sales analysis.*/

-- 1. show the database.
show databases;   -- 14 rows returned 
/* bookstore
company
countries
employeetable
hrm
information_schema
learntube
mysql
orangehrm
performance_schema
school_db
store_db
sys
udemydatabase */

-- 2. create database 
create database customeranalytics;    -- 1 row(s) affected 

-- 3. use customeranalytics
use customeranalytics;                -- 0 row(s) affected 

-- 4. create the Product table
create table products( product_id int auto_increment primary key,     -- auto_increment, unique identifier 
					   name varchar(100) not null,    				  -- product name
                       description Text,                              -- detailed product info
                       category varchar(50),                          -- Product Category 
                       price decimal(10,2) not null,                  -- Customer facing price 
                       cost decimal(10,2) not null,					  -- Internal Cost 
                       stock_quantity int not null,					  -- Inventory level
                       created_at timestamp default current_timestamp, -- creation time
                       updated_at timestamp default current_timestamp on update current_timestamp    -- last update time
					);                  -- 0 row(s) affected 
                    
-- when inserted :- current_timestamp
-- when updated :- automatically refelct the last modification time.            

-- primary key :- product_id

-- 5. Apply index on category column in the Products table.
	CREATE INDEX idx_products_category ON products(category);		 -- 0 rows affected Records : 0 Duplicates : 0 Warnings : 0 
    -- product :- is name of the table where index is created.
    -- category :- category column in the products table on which index is being applied. 
    
    -- drop :- drop index idx_products_category;
    
-- 6. Insert statement for products:
insert into products (name,description,category ,price,cost ,stock_quantity) 
values ('Premium wireless headphones','These wireless headphones feature noise-cancellation technology, 24-hour battery life, and premium sound quality with deep bass response.','Electronics',199.99,120.00,50 ),
 ('Ergonomic Office chair','Comfortable and adjustable chair with lumbar support and breathable mesh back.','Furniture',149.99,90.00,30),
 ( 'Smart LED Desk Lamp', 'Energy -efficient LED lamp with adjustable brigthness and USB charging port', 'Office supplies', 39.99,22.00,100),
 ('Bluetooth mechanical keyboard','Tactile mechanical keyboard with bluethooth connectivity and customizable RGB lighting','Electronics',89.99,50.00,40),
 ('Adjustable standing desk','Height adjustable desk frame with memory settings and electric lift system','Furniture',399.99,250.00,15);
 
 -- 5 rows affected records : 5 Duplicates : 0 Warnings : 0 
 
 Select * from products;   -- 5 rows returned 
 /* name						Description																Category 		Price		Cost		Stock_quantity	Created_at		updated_at														
 1	Premium wireless headphones	These wireless headphones feature noise-cancellation technology, 24-hour battery life, and premium sound quality with deep bass response.	Electronics	199.99	120.00	50	2025-08-05 16:25:54	2025-08-05 16:25:54
2	Ergonomic Office chair	Comfortable and adjustable chair with lumbar support and breathable mesh back.	Furniture	149.99	90.00	30	2025-08-05 16:25:54	2025-08-05 16:25:54
3	Smart LED Desk Lamp	Energy -efficient LED lamp with adjustable brigthness and USB charging port	Office supplies	39.99	22.00	100	2025-08-05 16:25:54	2025-08-05 16:25:54
4	Bluetooth mechanical keyboard	Tactile mechanical keyboard with bluethooth connectivity and customizable RGB lighting	Electronics	89.99	50.00	40	2025-08-05 16:25:54	2025-08-05 16:25:54
5	Adjustable standing desk	Height adjustable desk frame with memory settings and electric lift system	Furniture	399.99	250.00	15	2025-08-05 16:25:54	2025-08-05 16:25:54
								
 */
 
 -- Profit Margin Analysis:- 
 -- Profit Margin  (%) = ((Price - cost)  /  Price) * 100 ;
 
 -- 1. Profit Margin for All products 
 /* Price-cost : this calculates absolute profit per unit - how much money u make after paying the cost.
    (price-cost) /price : divides the profit ,by selling price to get the profit margin as a decimal fraction.
    Example :  if price = 100  and cost = 60 .
    profit margin fraction = (100-60)/100 = 0.4 
    
    * 100 :- Converts the decimal fraction into percentage
    eg :- 0.4 * 100 = 40%
    Round(   ,2 ) :- round the percentage into 2 decimal places for neatness.
    as profit_margin_percent :- gives the name alias to the calculated column in the result set. 
 */
 select product_id,name,category,price,cost,Round(((price-cost) /price)  * 100 , 2 ) as profit_margin_percent 
 from products;
 
 -- 5 rows returned 
 /* 1	Premium wireless headphones	Electronics	199.99	120.00	40.00
2	Ergonomic Office chair	Furniture	149.99	90.00	40.00
3	Smart LED Desk Lamp	Office supplies	39.99	22.00	44.99
4	Bluetooth mechanical keyboard	Electronics	89.99	50.00	44.44
5	Adjustable standing desk	Furniture	399.99	250.00	37.50       */

-- 2. Average profit margin by category 
select category, Round(avg((price- cost)/ price ) * 100 / 2 ) as avg_profit_margin_percent
from products 
group by category 
order by avg_profit_margin_percent desc;

/* Office supplies	22
Electronics	21
Furniture	19                           3 rows returned */

-- 3. Most and least protitable products 

-- Top 5 most profitable 
select name,category,price,cost,round((price-cost)/price * 100 , 2 ) as profit_margin_percent
from products 
order by profit_margin_percent desc
limit 5;

/* Smart LED Desk Lamp	Office supplies	39.99	22.00	44.99
Bluetooth mechanical keyboard	Electronics	89.99	50.00	44.44
Premium wireless headphones	Electronics	199.99	120.00	40.00
Ergonomic Office chair	Furniture	149.99	90.00	40.00
Adjustable standing desk	Furniture	399.99	250.00	37.50           5 rows returned        */

 -- bottom 5 least profitable 
 select name,category,price,cost,Round(((price-cost)/ price ) * 100, 2) as profit_margin_percent
 from products 
 order by profit_margin_percent asc
 limit 5;
 
/* Adjustable standing desk	Furniture	399.99	250.00	37.50
Premium wireless headphones	Electronics	199.99	120.00	40.00
Ergonomic Office chair	Furniture	149.99	90.00	40.00
Bluetooth mechanical keyboard	Electronics	89.99	50.00	44.44
Smart LED Desk Lamp	Office supplies	39.99	22.00	44.99                      5 rows returned  */

-- 4. Profit margin for each product 
select product_id,name, category,price,cost, Round(((price-cost)/price) * 100, 2 ) as profit_margin_percent
from products;
-- 5 rows returned 
/* 1	Premium wireless headphones	Electronics	199.99	120.00	40.00
2	Ergonomic Office chair	Furniture	149.99	90.00	40.00
3	Smart LED Desk Lamp	Office supplies	39.99	22.00	44.99
4	Bluetooth mechanical keyboard	Electronics	89.99	50.00	44.44
5	Adjustable standing desk	Furniture	399.99	250.00	37.50 */

-- 5. Products with Very Low Margins (Below 10%)
select name,category,price,cost,Round(((price - cost)/price) * 100 , 2)  as profit_margin_percent
from products
where ((price- cost)/price) * 100  < 10;   -- 0 rows returned 

-- 6.  Identify Products Priced Below Cost (Negative Margin)
select product_id, name, price, cost , Round(((price-cost) / price) * 100 , 2) as profit_margin_percent
from products
where price < cost ;                 -- 0 rows returned 

-- 7. Compare Profit Margin vs. Stock Level
select name,category,price,cost,stock_quantity , Round(((price-cost)/price) * 100 , 2) as profit_margin_percent
from products 
order by stock_quantity asc, profit_margin_percent desc;   -- 1st stock_quantity 
/*Adjustable standing desk	Furniture	399.99	250.00	15	37.50
Ergonomic Office chair	Furniture	149.99	90.00	30	40.00
Bluetooth mechanical keyboard	Electronics	89.99	50.00	40	44.44
Premium wireless headphones	Electronics	199.99	120.00	50	40.00
Smart LED Desk Lamp	Office supplies	39.99	22.00	100	44.99 */

-- 8. Flag Products Near Break-Even Point
select name,category,price,cost,Round(((price -cost) /price) * 100 , 2) as profit_margin_percent
from products 
where ((price-cost) /price ) * 100 between 1 and 40; -- 1 to 5 : 0 rows 

/*Premium wireless headphones	Electronics	199.99	120.00	40.00
Ergonomic Office chair	Furniture	149.99	90.00	40.00
Adjustable standing desk	Furniture	399.99	250.00	37.50 */

-- 9. High Stock, High Margin Products (Best Sales Candidates)
select name, category ,stock_quantity , Round(((price- cost )/price )  * 100, 2) as profit_margin_percent 
from products
where stock_quantity > 20 and ((price- cost) /price) * 100 > 30 
order by stock_quantity desc,profit_margin_percent desc; 
/* Smart LED Desk Lamp	Office supplies	100	44.99
Premium wireless headphones	Electronics	50	40.00
Bluetooth mechanical keyboard	Electronics	40	44.44
Ergonomic Office chair	Furniture	30	40.00 */


-- 10. Find Low-Margin Products with High Price
SELECT 
    name,
    category,
    price,
    cost,
    ROUND(((price - cost) / price) * 100, 2) AS profit_margin_percent
FROM 
    products
WHERE 
    price > 100 AND ((price - cost) / price) * 100 < 15   -- 0 rows returned , > 3 rows returned 
ORDER BY 
    price DESC;
    
/* Adjustable standing desk	Furniture	399.99	250.00	37.50
Premium wireless headphones	Electronics	199.99	120.00	40.00
Ergonomic Office chair	Furniture	149.99	90.00	40.00*/ 


-- Inventory Table 
create table inventory (
item_id int primary key,
item_name varchar(100) not null,
category varchar(50),
cost_per_unit Decimal(10,2) not null,
stock_quantity int not null,
supplier_id int,
last_updated Timestamp default current_timestamp );  -- 0 rows affected 

insert into inventory (item_id,item_name,category,cost_per_unit,stock_quantity) values 
(1,'Widget A','Tools',10.00,100),
(2,'Widget B','Tools',5.00,200),
(3,'Gadget C','Electornics',7.50,150);  -- 3 rows affected Records : 3 Duplicates : 0 

--  11.Inventory Valuation Per Item
-- Inventory Valuation: The combination of cost and stock_quantity allows for accurate inventory valuation.

select item_id,item_name,cost_per_unit,stock_quantity ,(cost_per_unit * stock_quantity ) as inventory_value 
from inventory ;
/*
 1	Widget A	10.00	100	1000.00
2	Widget B	5.00	200	1000.00
3	Gadget C	7.50	150	1125.00   */    -- 3 rows returned 
    
-- 12.Total value of inventory  
select sum(cost_per_unit * stock_quantity) as total_inventory_value  
from inventory;                                                       -- 3125.00

-- 13.Inventory valuation groupedby category 
select category, sum(cost_per_unit * stock_quantity) as category_inventory_value
from inventory
group by category;

/* Tools	2000.00
Electornics	1125.00 */    

-- 14. Low Stock Items (Below Reorder Level)
select item_id ,item_name,stock_quantity,reorder_level,(cost_per_unit * stock_quantity) as current_value
from inventory
where stock_quantity  < reorder_level ;  -- reorder level column not exists 

-- reorder level doesnot exist 
-- 1.Add a column if u want to track reorder levels 
alter table inventory
add reorder_level int default 10;  -- re run query , 0 rows affected ; Records : 0 , Duplicates : 0 

--  after adding reorder_level column 
select item_id ,item_name,stock_quantity,reorder_level,(cost_per_unit * stock_quantity) as current_value
from inventory
where stock_quantity  > reorder_level ;  -- < 0 rows returned 
-- > 3 rows returned 
/* 1	Widget A	100	10	1000.00
2	Widget B	200	10	1000.00
3	Gadget C	150	10	1125.00*/

-- 15. Most valuable items in inventory
SELECT
  item_id,
  item_name,
  stock_quantity,
  cost_per_unit,
  (cost_per_unit * stock_quantity) AS inventory_value
FROM inventory
ORDER BY inventory_value DESC
LIMIT 5;

/*3	Gadget C	150	7.50	1125.00
1	Widget A	100	10.00	1000.00
2	Widget B	200	5.00	1000.00 */

-- 16. Inventory Valuation Over Time (if history table exists)
-- track changes to stock over time for valuation trends, reporting, or auditing) :- create Stock history table 
create table stock_history( history_id int auto_increment primary key,
							item_id int,
                            stock_quantity int,
                            cost_per_unit decimal(10,2),
                            transaction_type varchar(50) ,
                            transaction_date Datetime default current_timestamp
						);   -- 0 rows affected
                            
insert into stock_history(item_id,stock_quanity,cost_per_unit, transaction_type) values (1,50, 10.00,'purchase');

INSERT INTO stock_history (item_id, stock_quantity, cost_per_unit, transaction_type, transaction_date)
VALUES 
  (1, 10, 5.00, 'purchase', '2025-08-01 10:00:00'),
  (1, 5, 5.00, 'sale', '2025-08-01 14:00:00'),
  (2, 20, 8.00, 'purchase', '2025-08-02 09:30:00'); -- 3 rows created 
  
-- 17. Daily inventory valuation 
select item_id, 
	   Date(transaction_date) as date,
       sum(cost_per_unit * stock_quantity) as daily_inventory_value
from stock_history
GROUP BY item_id, DATE(transaction_date)
ORDER BY daily_inventory_value desc; 

/* 2	2025-08-02	160.00
   1	2025-08-01	75.00  */

-- 18. Top 5 highest value item
SELECT 
  item_id,
  item_name,
  stock_quantity,
  cost_per_unit,
  (stock_quantity * cost_per_unit) AS inventory_value
FROM inventory
ORDER BY inventory_value DESC
LIMIT 5;

/* 3	Gadget C	150	7.50	1125.00
1	Widget A	100	10.00	1000.00
2	Widget B	200	5.00	1000.00 */

-- 19. Zero or Out-of-Stock Items
SELECT 
  item_id,
  item_name,
  stock_quantity
FROM inventory
WHERE stock_quantity = 0;  -- null null null , 0 rows returned 

-- 20. Inventory Valuation by Supplier
-- Create a suppliers Table :-

CREATE TABLE suppliers (
    supplier_id INT PRIMARY KEY,
    supplier_name VARCHAR(100) NOT NULL,
    contact_email VARCHAR(100),
    phone_number VARCHAR(20),
    address TEXT
);                                   -- 0 rows affected 

-- 21. Insert Sample Supplier Data
INSERT INTO suppliers (supplier_id, supplier_name, contact_email)
VALUES 
  (1, 'Alpha Distributors', 'contact@alpha.com'),
  (2, 'Beta Supplies Co.', 'info@beta.com'),
  (3, 'Gamma Traders', 'sales@gamma.com');  -- 3 rows affected
  
-- 22.  Update Inventory to Include Supplier Info:- 
UPDATE inventory
SET supplier_id = 1
WHERE item_id IN (1, 2);  -- Example: assign supplier 1 to items 1 and 2, -- 2 row affected , rows matched : 1 , Changed : 1 , warnings : 0

UPDATE inventory
SET supplier_id = 2
WHERE item_id = 3;   -- 1 row affected , rows matched : 1 , Changed : 1 , warnings : 0

-- 23.Now Run the Inventory Valuation by Supplier Query:

SELECT 
  s.supplier_name,
  SUM(i.stock_quantity * i.cost_per_unit) AS supplier_inventory_value
FROM inventory i
JOIN suppliers s ON i.supplier_id = s.supplier_id
GROUP BY s.supplier_name;

/* Alpha Distributors	2000.00
Beta Supplies Co.	1125.00 */   -- 2 rows returned 

-- Inventory Turnover Ratio (with sales table)
-- Assuming you have a sales table with item_id, quantity_sold, and sale_date:

-- Create sales Table

CREATE TABLE sales (
    sale_id INT AUTO_INCREMENT PRIMARY KEY,
    item_id INT,
    quantity_sold INT,
    sale_date DATE,
    FOREIGN KEY (item_id) REFERENCES inventory(item_id)
);                                                             -- 0 rows affected 

SELECT 
  i.item_id,
  i.item_name,
  SUM(s.quantity_sold) AS total_units_sold,
  i.stock_quantity,
  ROUND(SUM(s.quantity_sold) / NULLIF(i.stock_quantity, 0), 2) AS turnover_ratio
FROM inventory i
JOIN sales s ON i.item_id = s.item_id
GROUP BY i.item_id, i.item_name, i.stock_quantity;
-- Turnover Ratio = How fast inventory is sold and replaced. High = fast-moving, Low = slow-moving

INSERT INTO sales (item_id, quantity_sold, sale_date) VALUES
  (1, 10, '2025-07-01'),
  (1, 5, '2025-07-15'),
  (2, 20, '2025-07-10'),
  (3, 8, '2025-07-20');   -- 4 rows affected records :4 , Duplicates : 0 Warnings : 0
  
-- Re-run the Inventory Turnover Query

SELECT 
  i.item_id,
  i.item_name,
  SUM(s.quantity_sold) AS total_units_sold,
  i.stock_quantity,
  ROUND(SUM(s.quantity_sold) / NULLIF(i.stock_quantity, 0), 2) AS turnover_ratio
FROM inventory i
JOIN sales s ON i.item_id = s.item_id
GROUP BY i.item_id, i.item_name, i.stock_quantity;
  
/* 1	Widget A	15	100	0.15
2	Widget B	20	200	0.10
3	Gadget C	8	150	0.05 */


-- 24.Monthly Sales vs. Current Stock

SELECT 
  i.item_name,
  MONTH(s.sale_date) AS sale_month,
  SUM(s.quantity_sold) AS total_sold,
  i.stock_quantity
FROM inventory i
JOIN sales s ON i.item_id = s.item_id
GROUP BY i.item_name, MONTH(s.sale_date); -- select list is not in the group by class.

-- Option 1: Add stock_quantity to GROUP BY

SELECT 
  i.item_name,
  MONTH(s.sale_date) AS sale_month,
  SUM(s.quantity_sold) AS total_sold,
  i.stock_quantity
FROM inventory i
JOIN sales s ON i.item_id = s.item_id
GROUP BY i.item_name, MONTH(s.sale_date), i.stock_quantity;

/* Widget A	7	15	100
Widget B	7	20	200
Gadget C	7	8	150 */

-- 25.Items Reaching Reorder Level Within Buffer Range

SELECT 
  item_id,
  item_name,
  stock_quantity,
  reorder_level
FROM inventory
WHERE stock_quantity BETWEEN reorder_level AND reorder_level - 5; -- null 0 rows returned 

-- Stock Coverage: How Many Days/Units Left
-- (Requires a sales or consumption rate table — simplified here as assumption.)

SELECT 
  item_id,
  item_name,
  stock_quantity,
  ROUND(stock_quantity / 5, 1) AS estimated_days_remaining -- assuming 5 units/day used
FROM inventory;

/* 1	Widget A	100	20.0
2	Widget B	200	40.0
3	Gadget C	150	30.0*/

-- Inventory Turnover Ratio
-- (Assumes a sales table exists.)

SELECT 
  i.item_id,
  i.item_name,
  SUM(s.quantity_sold) AS total_sold,
  i.stock_quantity,
  ROUND(SUM(s.quantity_sold) / NULLIF(i.stock_quantity, 0), 2) AS turnover_ratio
FROM inventory i
JOIN sales s ON i.item_id = s.item_id
GROUP BY i.item_id, i.item_name, i.stock_quantity;
-- High turnover ratio = fast-moving item.

/* 1	Widget A	15	100	0.15
2	Widget B	20	200	0.10
3	Gadget C	8	150	0.05*/

/* inventory

item_id         INT (PK)  
item_name       VARCHAR  
category        VARCHAR  
cost_per_unit   DECIMAL  

 orders or sales
order_id        INT (PK)  
item_id         INT (FK to inventory.item_id)  
quantity_sold   INT  
unit_price      DECIMAL  
order_date      DATE  */

-- Product Performance Analysis 
-- 26. Top 5 Best-Selling Products by Quantity

SELECT 
  i.item_id,
  i.item_name,
  SUM(o.quantity_sold) AS total_units_sold
FROM orders o
JOIN inventory i ON o.item_id = i.item_id
GROUP BY i.item_id, i.item_name
ORDER BY total_units_sold DESC
LIMIT 5;   -- 10

--  Step 1: Create the orders Table

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    item_id INT,
    quantity_sold INT,
    unit_price DECIMAL(10, 2),
    order_date DATE,
    FOREIGN KEY (item_id) REFERENCES inventory(item_id)     -- 0 rows affected 
);

-- Step 2: Insert Sample Data

INSERT INTO orders (item_id, quantity_sold, unit_price, order_date)
VALUES 
  (1, 10, 15.00, '2025-08-01'),
  (2, 5, 25.00, '2025-08-02'),
  (1, 7, 15.00, '2025-08-03'),
  (3, 3, 30.00, '2025-08-03'),
  (2, 10, 25.00, '2025-08-04');   -- 5 rows affected 
  
  -- Step 3 :Re-run Your Product Performance Query

SELECT 
  i.item_id,
  i.item_name,
  SUM(o.quantity_sold) AS total_units_sold
FROM orders o
JOIN inventory i ON o.item_id = i.item_id
GROUP BY i.item_id, i.item_name
ORDER BY total_units_sold DESC
LIMIT 5;

/* 1	Widget A	17
2	Widget B	15
3	Gadget C	3*/

-- 27.Top 5 Products by Revenue

SELECT 
  i.item_id,
  i.item_name,
  SUM(o.quantity_sold * o.unit_price) AS total_revenue
FROM orders o
JOIN inventory i ON o.item_id = i.item_id
GROUP BY i.item_id, i.item_name
ORDER BY total_revenue DESC
LIMIT 5;

/* 2	Widget B	375.00
1	Widget A	255.00
3	Gadget C	90.00*/

show tables; 
/* inventory
orders
products
sales
stock_history
suppliers*/

-- 28.Monthly Product Sales Trend
select * from orders;   -- order_id, item_id , quantity_sold, unit_price, order_date 
select * from products; -- product_id, name , description,category,price,cost,stock_quantity,created_at,updated_at

SELECT 
    DATE_FORMAT(o.order_date, '%Y-%m') AS sales_month,    -- orders table .order_date column
    p.name AS product_name,                               -- products table. name column
    SUM(o.quantity_sold) AS total_quantity_sold,          -- orders table . quantity_sold column
    SUM(o.quantity_sold * o.unit_price) AS total_revenue  -- orders table . unit_price column
FROM 
    orders o
JOIN 
    products p ON o.item_id = p.product_id
GROUP BY 
    sales_month, p.name
ORDER BY 
    sales_month, total_quantity_sold DESC;
    
/* 2025-08	Premium wireless headphones	17	255.00
2025-08	Ergonomic Office chair	15	375.00
2025-08	Smart LED Desk Lamp	3	90.00 */    

-- 29. Product Sales Contribution Percentage
select * from orders;   -- order_id, item_id , quantity_sold, unit_price, order_date 
select * from products; -- product_id, name , description,category,price,cost,stock_quantity,created_at,updated_at

WITH product_sales AS (           -- it calculates the total revenue per product (quantity_sold * unit_price)
    SELECT
        item_id AS product_id,
        SUM(quantity_sold * unit_price) AS revenue
    FROM orders
    GROUP BY item_id
),
total_revenue AS (                 -- sums all product revenue to get the total sales 
    SELECT SUM(revenue) AS total_sales FROM product_sales
)
SELECT      -- Final select : joins the product to  get the product names and calculates what % of total sales each product contributes.
    p.name AS product_name,
    ps.revenue,
    ROUND((ps.revenue / tr.total_sales) * 100, 2) AS contribution_percentage
FROM product_sales ps
CROSS JOIN total_revenue tr
JOIN products p ON ps.product_id = p.product_id
ORDER BY contribution_percentage DESC;              -- 3 rows returned

/* product_name			revenue	       contribution_percentage 
 Ergonomic Office chair	375.00	52.08
Premium wireless headphones	255.00	35.42
Smart LED Desk Lamp	90.00	12.50*/

-- 30. Top 5 Products by Revenue (Sales × Price)
select * from orders;   -- order_id, item_id , quantity_sold, unit_price, order_date 
select * from products; -- product_id, name , description,category,price,cost,stock_quantity,created_at,updated_at

SELECT 
    p.name AS product_name,                              --  products table. name column 
    SUM(o.quantity_sold * o.unit_price) AS total_revenue --  orders table . quantity_sold column 
FROM orders o											 --  orders table . unit_price column
JOIN products p ON o.item_id = p.product_id				 --  products table ,  Orders table. item Id = product table. product_id col
GROUP BY p.name
ORDER BY total_revenue DESC
LIMIT 5;

-- Category Analysis: The category field allows for aggregated analysis of performance by product type.
-- 31.Total Units Sold per Category
select * from orders;   -- order_id, item_id , quantity_sold, unit_price, order_date 
select * from products; -- product_id, name , description,category,price,cost,stock_quantity,created_at,updated_at

select  p.category, sum(o.quantity_sold) as total_units_sold
from orders o
join products p on o.item_id = p.product_id 
group by p.category
order by total_units_sold desc;

/* category total_units_sold 
Electronics	17
Furniture	15
Office supplies	3 */

-- 32.Total revenue per category 
select * from orders;   -- order_id, item_id , quantity_sold, unit_price, order_date 
select * from products; -- product_id, name , description,category,price,cost,stock_quantity,created_at,updated_at

select p.category, sum(o.quantity_sold * o.unit_price) as total_revenue 
from orders o
join products p on o.item_id = p.product_id
group by p.category
order by total_revenue desc;

/* category total_revenue
Furniture	375.00
Electronics	255.00
Office supplies	90.00*/

-- 33.Average Profit Margin per Category
select * from products; -- product_id, name , description,category,price,cost,stock_quantity,created_at,updated_at
SELECT 
    category,
    ROUND(AVG((price - cost) / price) * 100, 2) AS avg_profit_margin_percent
FROM products
GROUP BY category
ORDER BY avg_profit_margin_percent DESC;

/* Office supplies	44.99
Electronics	42.22
Furniture	38.75 */

-- 34. Average Profit Margin per Category
SELECT 
    category,
    ROUND(AVG((price - cost) / price) * 100, 2) AS avg_profit_margin_percent
FROM products
GROUP BY category
ORDER BY avg_profit_margin_percent DESC;
/* Office supplies	44.99
Electronics	42.22
Furniture	38.75*/

-- 35. Best-Selling Product per Category
SELECT 
    p.category,
    p.name AS top_product,
    SUM(o.quantity_sold) AS total_sold
FROM orders o
JOIN products p ON o.item_id = p.product_id
GROUP BY p.category, p.name
ORDER BY p.category, total_sold DESC;

/* Category   top_product        total_sold
 Electronics	Premium wireless headphones	17
Furniture	Ergonomic Office chair	15
Office supplies	Smart LED Desk Lamp	3*/

-- 36.Category-wise Stock Levels

SELECT 
    category,
    SUM(stock_quantity) AS total_stock
FROM products
GROUP BY category
ORDER BY total_stock DESC;
/* Category   total_stock
Office supplies	100
Electronics	90
Furniture	45*/

-- 37. Pricing Strategy Optimization: Historical pricing data (via updated_at) can be used to analyze the effect of price changes on sales.
-- create product_price_history table to log historical pricing 

create table product_price_history( history_id int auto_increment primary key,
									product_id int,
                                    old_price decimal(10,2),
                                    new_price decimal(10,2),
                                    change_date timestamp default current_timestamp,
                                    foreign key (product_id) references products(product_id)
);         -- 0 rows affected 

-- Track price changes manually (or via triggers if using MySQL 5.7+)

-- Example: Manually logging a price update
INSERT INTO product_price_history (product_id, old_price, new_price) VALUES (1, 149.99, 129.99);  -- 1 row affected 

-- 38. Find All Products with Price Changes
select * from product_price_history;  -- history_id , product_id . old_price, new_price , change_date 
select * from products; -- product_id, name , description,category,price,cost,stock_quantity,created_at,updated_at

SELECT 
    pph.product_id,
    pr.name,
    pph.old_price,
    pph.new_price,
    ROUND(((pph.new_price - pph.old_price) / pph.old_price) * 100, 2) AS price_change_percent,
    pph.change_date
FROM product_price_history pph
JOIN products pr ON pph.product_id = pr.product_id
ORDER BY pph.change_date DESC;

/* 1	Premium wireless headphones	149.99	129.99	-13.33	2025-08-06 13:29:52 */

-- 39.  Analyze Sales Before and After Price Change
select * from product_price_history;  -- history_id , product_id . old_price, new_price , change_date 
select * from products; -- product_id, name , description,category,price,cost,stock_quantity,created_at,updated_at
select * from orders;   -- order_id, item_id , quantity_sold, unit_price, order_date 

SELECT 
    pph.product_id,
    pr.name,
    pph.old_price,
    pph.new_price,
    pph.change_date,
    
    -- Sales BEFORE change
    (SELECT SUM(o.quantity_sold)
     FROM orders o
     WHERE o.item_id = pph.product_id AND o.order_date < pph.change_date) AS sales_before,
     
    -- Sales AFTER change
    (SELECT SUM(o.quantity_sold)
     FROM orders o
     WHERE o.item_id = pph.product_id AND o.order_date >= pph.change_date) AS sales_after
     
FROM product_price_history pph
JOIN products pr ON pph.product_id = pr.product_id
ORDER BY pph.change_date DESC;

/*  product_id   name   					 ol_price  new_price  	 change_date   	 sales_before  sales_after
	1			Premium wireless headphones	149.99		129.99			2025-08-06 		13:29:52	17	
*/

-- 40. Revenue impact of Price change 
select * from product_price_history;  -- history_id , product_id . old_price, new_price , change_date 
select * from products; -- product_id, name , description,category,price,cost,stock_quantity,created_at,updated_at
select * from orders;   -- order_id, item_id , quantity_sold, unit_price, order_date 
SELECT 
    pph.product_id,
    pr.name,
    pph.old_price,
    pph.new_price,
    pph.change_date,
    
    -- Revenue before
    (SELECT SUM(o.quantity_sold * o.unit_price)
     FROM orders o
     WHERE o.item_id = pph.product_id AND o.order_date < pph.change_date) AS revenue_before,
     
    -- Revenue after
    (SELECT SUM(o.quantity_sold * o.unit_price)
     FROM orders o
     WHERE o.item_id = pph.product_id AND o.order_date >= pph.change_date) AS revenue_after
     
FROM product_price_history pph
JOIN products pr ON pph.product_id = pr.product_id;

-- product_id    name               old_price         new_price         change_date         revenue_before      revenue_after
-- 1			Premium wireless headphones	149.99		129.99			2025-08-06 				13:29:52			255.00	


-- 41. Find Products with Frequent Price Changes
select * from product_price_history;  -- history_id , product_id . old_price, new_price , change_date 

SELECT 
    product_id,
    COUNT(*) AS price_change_count
FROM product_price_history
GROUP BY product_id
ORDER BY price_change_count DESC;

-- 42.Flag Products With Price Drops But Lower Sales

SELECT 
    pph.product_id,
    pr.name,
    pph.old_price,
    pph.new_price,
    (pph.old_price - pph.new_price) AS price_drop,
    (SELECT SUM(o.quantity_sold)
     FROM orders o
     WHERE o.item_id = pph.product_id AND o.order_date >= pph.change_date) AS sales_after_drop
FROM product_price_history pph
JOIN products pr ON pph.product_id = pr.product_id
WHERE pph.new_price < pph.old_price
ORDER BY sales_after_drop ASC;

-- Product_id 	name						old_price  new_price  price_drop   sales_after_drop
-- 1			Premium wireless headphones	149.99		129.99		20.00	    null

-- --------------------------------------------------------------------------------------------------------------------------
-- Orders Table :-
-- The orders table is the central transaction record in our business intelligence database. It captures detailed information about every purchase, including products bought, pricing, discounts, shipping, and customer information. This comprehensive table enables deep analysis of sales patterns, customer behavior, and business performance across multiple dimensions.

-- use customeranalytics;

create table ordersv2 ( order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(10, 2) NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    
    discount_percentage DECIMAL(5, 2) DEFAULT 0.00,
    discount_amount DECIMAL(10, 2) DEFAULT 0.00,
    
    tax_amount DECIMAL(10, 2) DEFAULT 0.00,
    shipping_cost DECIMAL(8, 2) DEFAULT 0.00,
    
    order_date DATETIME NOT NULL,
    status VARCHAR(20) NOT NULL,
    payment_method VARCHAR(50),
    shipping_method VARCHAR(50),
    
    is_gift BOOLEAN DEFAULT FALSE,
    is_returned BOOLEAN DEFAULT FALSE,
    
    return_date DATETIME,
    return_reason VARCHAR(200),
    delivery_date DATETIME,
    
    sales_channel VARCHAR(50),
    
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    -- Foreign Keys (Assuming customers and products tables exist)
    CONSTRAINT fk_orders_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT fk_orders_product FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Failed to open the referenced table 'customers'

-- step 1 create customers table 
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    address VARCHAR(255),
    city VARCHAR(50),
    state VARCHAR(50),
    postal_code VARCHAR(20),
    country VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

create table ordersv2 ( 
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(10, 2) NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    
    discount_percentage DECIMAL(5, 2) DEFAULT 0.00,
    discount_amount DECIMAL(10, 2) DEFAULT 0.00,
    
    tax_amount DECIMAL(10, 2) DEFAULT 0.00,
    shipping_cost DECIMAL(8, 2) DEFAULT 0.00,
    
    order_date DATETIME NOT NULL,
    status VARCHAR(20) NOT NULL,
    payment_method VARCHAR(50),
    shipping_method VARCHAR(50),
    
    is_gift BOOLEAN DEFAULT FALSE,
    is_returned BOOLEAN DEFAULT FALSE,
    
    return_date DATETIME,
    return_reason VARCHAR(200),
    delivery_date DATETIME,
    
    sales_channel VARCHAR(50),
    
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    -- Foreign Keys (Assuming customers and products tables exist)
    CONSTRAINT fk_orders_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT fk_orders_product FOREIGN KEY (product_id) REFERENCES products(product_id)
);
-- 0 rows affected 

-- Indexes
CREATE INDEX idx_orders_customer_id ON ordersv2(customer_id); -- 0 row(s) affected Records: 0  Duplicates: 0  Warnings: 0	0.063 sec
CREATE INDEX idx_orders_product_id ON ordersv2(product_id); -- 0 row(s) affected Records: 0  Duplicates: 0  Warnings: 0	0.063 sec
CREATE INDEX idx_orders_order_date ON ordersv2(order_date); -- 0 row(s) affected Records: 0  Duplicates: 0  Warnings: 0	0.063 sec

ALTER TABLE orders
ADD COLUMN total_amount DECIMAL(10,2);  -- 0 rows affected Records : 0 

-- 43. Total Revenue Over Time (Monthly/Yearly)
-- Monthly Revenue:

-- Recalculate total_amount on the fly
-- If total_amount = (unit_price × quantity) - discount_amount + tax_amount + shipping_cost

select * from ordersv2; 
-- ordersv2 :- order_id, customer_id,product_id,quantity,unit_price,total_amount,discount_percentage,discount_amount,tax_amount,
-- shipping_cost,order_date,status,payment_method, shipping_method,is_gift,is_returned,return_reason,delivery_date,sales_channel,
-- created_at,updated_at

SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    SUM((unit_price * quantity) - discount_amount + tax_amount + shipping_cost) AS total_revenue
FROM ordersv2
WHERE status = 'Completed'
GROUP BY month
ORDER BY month;  

-- ordersv2 :- order_id, customer_id,product_id,quantity,unit_price,total_amount,discount_percentage,discount_amount,tax_amount,
-- shipping_cost,order_date,status,payment_method, shipping_method,is_gift,is_returned,return_reason,delivery_date,sales_channel,
-- created_at,updated_at

INSERT INTO ordersv2 (
    customer_id, product_id, quantity, unit_price, total_amount,discount_percentage, discount_amount, tax_amount, shipping_cost,
    order_date, status, payment_method, shipping_method, is_gift, is_returned, return_reason, delivery_date, sales_channel, 
    created_at, updated_at
)
VALUES 
(1, 101, 2, 49.99, 99.98, 10.00, 9.998, 5.00, 0.00, '2025-08-01 10:30:00', 'Completed', 'Credit Card', 
'Standard',FALSE, FALSE, NULL, '2025-08-03 14:00:00','Website', NOW(), NOW() ),

-- Order 2
(2, 102, 1, 199.99, 199.99, 0.00, 0.00, 10.00, 5.00, '2025-08-02 11:45:00', 'Completed', 'PayPal', 'Express', 
 FALSE, FALSE, NULL, '2025-08-04 09:00:00','Mobile App', NOW(), NOW()),

-- Order 3 (Returned)
(3, 103, 3, 15.00, 45.00, 5.00, 2.25, 2.70, 0.00, '2025-08-03 09:15:00', 'Returned', 'Bank Transfer', 'Standard', 
 TRUE, TRUE, 'Wrong Size', '2025-08-05 12:00:00','In-store', NOW(), NOW()),

-- Order 4
(4, 104, 1, 349.50, 349.50, 0.00, 0.00, 17.00, 10.00,'2025-08-03 13:20:00', 'Completed', 'Credit Card', 'Next Day', 
 FALSE, FALSE, NULL, '2025-08-04 16:00:00','Website', NOW(), NOW()),

-- Order 5 (Gift)
(5, 105, 2, 79.99, 159.98, 15.00, 23.997, 8.00, 0.00,'2025-08-04 16:00:00', 'Completed', 'Gift Card', 'Standard', 
 TRUE, FALSE, NULL, '2025-08-06 10:30:00','Marketplace', NOW(), NOW());
 
 -- cannot add or update the child row : foreign key constraints fails .. , so customer table values not inserted . 
 
 INSERT INTO customers (
    customer_id, first_name, last_name, email, phone, address, city, state, postal_code, country
) VALUES
(1, 'Alice', 'Smith', 'alice.smith@example.com', '123-456-7890', '123 Maple Street', 'New York', 'NY', '10001', 'USA'),
(2, 'Bob', 'Johnson', 'bob.johnson@example.com', '987-654-3210', '456 Oak Avenue', 'Los Angeles', 'CA', '90001', 'USA'),
(3, 'Carol', 'Williams', 'carol.williams@example.com', '555-666-7777', '789 Pine Road', 'Chicago', 'IL', '60601', 'USA'),
(4, 'David', 'Brown', 'david.brown@example.com', '222-333-4444', '321 Cedar Blvd', 'Houston', 'TX', '77001', 'USA'),
(5, 'Eva', 'Davis', 'eva.davis@example.com', '888-999-0000', '654 Birch Lane', 'Miami', 'FL', '33101', 'USA');

-- 5 rows affected 

SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    SUM((unit_price * quantity) - discount_amount + tax_amount + shipping_cost) AS total_revenue
FROM ordersv2
WHERE status = 'Completed'
GROUP BY month
ORDER BY month; 

-- month    total_revenue 
-- 2025-08	830.45

-- 44.Top Products by Revenue
-- Which products are generating the most revenue?

SELECT 
    p.name AS product_name,
    SUM(o.total_amount) AS revenue
FROM ordersv2 o
JOIN products p ON o.product_id = p.product_id
WHERE o.status = 'Completed'
GROUP BY o.product_id, p.name
ORDER BY revenue DESC
LIMIT 10;

-- 4 rows returned 
-- product_name   revenue 
/* Smartwatch	349.50
Bluetooth Headphones	199.99
Coffee Maker	159.98
Wireless Mouse	99.98 */

-- 45.Top-Selling Products by Quantity
-- Which products sell the most units?

-- ordersv2 :- order_id, customer_id,product_id,quantity,unit_price,total_amount,discount_percentage,discount_amount,tax_amount,
-- shipping_cost,order_date,status,payment_method, shipping_method,is_gift,is_returned,return_reason,delivery_date,sales_channel,
-- created_at,updated_at

SELECT 
    p.name AS product_name,
    SUM(o.quantity) AS total_units_sold
FROM ordersv2 o
JOIN products p ON o.product_id = p.product_id
WHERE o.status = 'Completed'
GROUP BY o.product_id, p.name
ORDER BY total_units_sold DESC
LIMIT 10;

-- product_name    total_units_sold
/* Wireless Mouse 	    2
Coffee Maker			2
Bluetooth Headphones	1
Smartwatch				1       */   -- 4 rows returned 

-- 46. Category-wise Sales Performance
-- Aggregate revenue by product category:

SELECT 
    p.category,
    SUM(o.total_amount) AS total_revenue
FROM ordersv2 o
JOIN products p ON o.product_id = p.product_id
WHERE o.status = 'Completed'
GROUP BY p.category
ORDER BY total_revenue DESC;

-- category    total_revenue 
/*Wearables	    349.50
Electronics	299.97
Home Appliances	159.98 */

-- 47.Effect of Discount on Revenue
-- Analyze how much revenue is affected by discounts:

SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    SUM(discount_amount) AS total_discounts,
    SUM(total_amount) AS revenue_after_discount
FROM ordersv2
WHERE status = 'Completed'
GROUP BY month
ORDER BY month;

-- month        total_discounts  revenue_after_discount 
/* 2025-08	34.00	809.45  */

-- 48. Pricing Strategy Optimization
-- Analyze how unit price changes impact sales (monthly):

SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    AVG(unit_price) AS avg_price,
    SUM(quantity) AS units_sold
FROM ordersv2
WHERE status = 'Completed'
GROUP BY month
ORDER BY month;

-- month     avg_price    units_sold
-- 2025-08	169.867500	6

-- 48. 1. Shipping Method Usage & Total Shipping Cost
SELECT 
    shipping_method,
    COUNT(*) AS total_orders,
    SUM(shipping_cost) AS total_shipping_cost,
    ROUND(AVG(shipping_cost), 2) AS avg_shipping_cost
FROM ordersv2
WHERE status = 'Completed'
GROUP BY shipping_method
ORDER BY total_orders DESC;

-- shipping_method   total_orders    total_shipping_cost    avg_shipping_cost
/* Standard				2				0.00					0.00
	Express				1				5.00					5.00
	Next Day			1				10.00					10.00 */
    
--  49.Average Delivery Time by Shipping Method
SELECT 
    shipping_method,
    ROUND(AVG(TIMESTAMPDIFF(HOUR, order_date, delivery_date)), 2) AS avg_delivery_hours
FROM ordersv2
WHERE delivery_date IS NOT NULL AND status IN ('Completed', 'Returned')
GROUP BY shipping_method
ORDER BY avg_delivery_hours;

/* shipping_method           avg_delivery_hours*/
/* Next Day	26.00
Express	45.00
Standard	47.67 */

-- 50. Late Deliveries Detection (Delivery after 3 days)

-- ordersv2 :- order_id, customer_id,product_id,quantity,unit_price,total_amount,discount_percentage,discount_amount,tax_amount,
-- shipping_cost,order_date,status,payment_method, shipping_method,is_gift,is_returned,return_reason,delivery_date,sales_channel,
-- created_at,updated_at

SELECT 
    order_id,
    shipping_method,
    order_date,
    delivery_date,
    TIMESTAMPDIFF(DAY, order_date, delivery_date) AS delivery_days
FROM ordersv2
WHERE delivery_date IS NOT NULL
  AND TIMESTAMPDIFF(DAY, order_date, delivery_date) < 3;
  
-- order_id   shipping_method    order_date  
 /* 14	Standard	2025-08-01 10:30:00	2025-08-03 14:00:00	2
15	Express	2025-08-02 11:45:00	2025-08-04 09:00:00	1
16	Standard	2025-08-03 09:15:00	2025-08-05 12:00:00	2
17	Next Day	2025-08-03 13:20:00	2025-08-04 16:00:00	1
18	Standard	2025-08-04 16:00:00	2025-08-06 10:30:00	1*/

-- 51. Shipping Cost Trends Over Time
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    SUM(shipping_cost) AS total_shipping_cost,
    ROUND(AVG(shipping_cost), 2) AS avg_shipping_cost
FROM ordersv2
WHERE status = 'Completed'
GROUP BY month
ORDER BY month;

-- month    total_shipping_cost     avg_shipping_cost
-- 2025-08	15.00					3.75

-- 52. Shipping Cost Comparison: Gift vs. Non-Gift Orders
SELECT 
    is_gift,
    COUNT(*) AS total_orders,
    ROUND(AVG(shipping_cost), 2) AS avg_shipping_cost
FROM ordersv2
GROUP BY is_gift;

/*  is_gift    total_orders     avg_shipping_cost */
--  0	        3				5.00
--  1			2				0.00

-- Return Rate Analysis: Identifying products with high return rates and common return reasons. 
-- 53. Return Rate by Product

SELECT 
    p.product_id,
    p.name AS product_name,
    COUNT(o.order_id) AS total_orders,
    SUM(CASE WHEN o.is_returned = TRUE THEN 1 ELSE 0 END) AS returned_orders,
    ROUND(
        (SUM(CASE WHEN o.is_returned = TRUE THEN 1 ELSE 0 END) / COUNT(o.order_id)) * 100, 
        2
    ) AS return_rate_percentage
FROM ordersv2 o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.product_id, p.name
HAVING total_orders > 0
ORDER BY return_rate_percentage DESC;

-- product_id    product_name      total_orders        returned_orders       return_rate_percentage
/* 103			Notebook				1					1					100.00
101				Wireless Mouse			1					0					0.00
102				Bluetooth Headphones	1					0					0.00
104				Smartwatch				1					0					0.00
105				Coffee Maker			1					0					0.00 */

--  54. Most Common Return Reasons
SELECT 
    return_reason,
    COUNT(*) AS number_of_returns
FROM ordersv2
WHERE is_returned = TRUE AND return_reason IS NOT NULL
GROUP BY return_reason
ORDER BY number_of_returns DESC;

-- return_reason      number_of_returns 
-- Wrong Size				1

-- 55.Category-Level Return Rate
SELECT 
    p.category,
    COUNT(o.order_id) AS total_orders,
    SUM(CASE WHEN o.is_returned = TRUE THEN 1 ELSE 0 END) AS returned_orders,
    ROUND(
        (SUM(CASE WHEN o.is_returned = TRUE THEN 1 ELSE 0 END) / COUNT(o.order_id)) * 100,
        2
    ) AS return_rate_percentage
FROM ordersv2 o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.category
HAVING total_orders > 0
ORDER BY return_rate_percentage DESC;

-- category        total_orders     returned_orders  return_rate_percentage
/* Stationery		1				1				 100.00
Electronics			2				0				 0.00
Wearables			1				0				 0.00
Home Appliances		1				0				 0.00  */

-- 56.Average Time to Return (in days)
SELECT 
    ROUND(AVG(DATEDIFF(return_date, order_date)), 2) AS avg_days_to_return
FROM ordersv2
WHERE is_returned = TRUE AND return_date IS NOT NULL;

/* avg_days_to_return
   null    */ 
   
 -- Sales Channel Performance: Comparing effectiveness and profitability of different sales platforms.
 
-- 57. Total Revenue by Sales Channel
SELECT 
    sales_channel,
    COUNT(*) AS total_orders,
    SUM((unit_price * quantity) - discount_amount + tax_amount + shipping_cost) AS total_revenue
FROM ordersv2
WHERE status = 'Completed'
GROUP BY sales_channel
ORDER BY total_revenue DESC;

-- sales_channel   total_orders    total_revenue
/*	Website			2				471.48
Mobile App			1				214.99
Marketplace			1				143.98 		*/

-- 58. Average Order Value (AOV) by Sales Channel
SELECT 
    sales_channel,
    ROUND(AVG((unit_price * quantity) - discount_amount + tax_amount + shipping_cost), 2) AS avg_order_value
FROM ordersv2
WHERE status = 'Completed'
GROUP BY sales_channel
ORDER BY avg_order_value DESC;

-- sales_channel  avg_order_value 
/* Website		  235.74
Mobile App		  214.99
Marketplace		  143.98  */

-- 59. Return Rate by Sales Channel
SELECT 
    sales_channel,
    COUNT(*) AS total_orders,
    SUM(CASE WHEN is_returned = TRUE THEN 1 ELSE 0 END) AS returned_orders,
    ROUND((SUM(CASE WHEN is_returned = TRUE THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) AS return_rate_percentage
FROM ordersv2
GROUP BY sales_channel
ORDER BY return_rate_percentage DESC;

-- sales_channel    total_orders      returned_orders   return_rate_percentage
/* In-store				1				1				100.00
Website					2				0				0.00
Mobile App				1				0				0.00
Marketplace				1				0				0.00   */

-- 60. Sales Volume by Channel (Units Sold) -- Measures total units sold on each platform.

SELECT 
    sales_channel,
    SUM(quantity) AS total_units_sold
FROM ordersv2
WHERE status = 'Completed'
GROUP BY sales_channel
ORDER BY total_units_sold DESC;

-- 61. Sales Volume by Channel (Units Sold)
SELECT 
    sales_channel,
    SUM(quantity) AS total_units_sold
FROM ordersv2
WHERE status = 'Completed'
GROUP BY sales_channel
ORDER BY total_units_sold DESC;

-- sales_channel    total_units_sold
/* Website				3
Marketplace				2
Mobile App				1   */

-- 62.Monthly Revenue Trend by Sales Channel
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    sales_channel,
    SUM((unit_price * quantity) - discount_amount + tax_amount + shipping_cost) AS monthly_revenue
FROM ordersv2
WHERE status = 'Completed'
GROUP BY month, sales_channel
ORDER BY month, sales_channel;

-- month     sales_channel    monthly_revenue 
-- Helps monitor which channels are growing or declining month-over-month.
/* 2025-08	Marketplace	143.98
2025-08	Mobile App	214.99
2025-08	Website	471.48  */

-- The HAVING clause is used to filter aggregated results.
-- 63. Example: Sales channels with average order value > 100
SELECT 
    sales_channel,
    ROUND(AVG(total_amount), 2) AS avg_order_value
FROM ordersv2
GROUP BY sales_channel
HAVING avg_order_value > 100
ORDER BY avg_order_value DESC;   -- 3 rows returned 

-- sales_channel  avg_order_value
/*Website		  224.74
Mobile App		  199.99
Marketplace		  159.98 */

-- 64. Products with return rate > 20%
SELECT 
    product_id,
    COUNT(*) AS total_orders,
    SUM(CASE WHEN is_returned = TRUE THEN 1 ELSE 0 END) AS returned_orders,
    ROUND(SUM(CASE WHEN is_returned = TRUE THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS return_rate
FROM ordersv2
GROUP BY product_id
HAVING return_rate > 20
ORDER BY return_rate DESC;

-- product_id 		total_orders 	  returned_orders  	 return_rate
--	103					1				1				100.00

-- 65.  Using Temporary Tables
-- Temporary tables are great for intermediate data during complex queries.
-- Top-selling products (temp table)

CREATE TEMPORARY TABLE temp_product_sales AS
SELECT 
    product_id,
    SUM(quantity) AS total_sold
FROM ordersv2
WHERE status = 'Completed'
GROUP BY product_id;

-- Now query it
SELECT * FROM temp_product_sales
ORDER BY total_sold DESC
LIMIT 5;

-- product_id	total_sold
/* 101			2
105				2
102				1
104				1  */

-- Table Partitioning (MySQL):- Partitioning splits large tables into smaller, manageable pieces physically, improving performance.
-- 66.Partition Example (by RANGE on order_date)

CREATE TABLE orders_partitioned (
    order_id INT,
    customer_id INT,
    product_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    KEY(order_date)
)
PARTITION BY RANGE (YEAR(order_date)) (
    PARTITION p2023 VALUES LESS THAN (2024),
    PARTITION p2024 VALUES LESS THAN (2025),
    PARTITION p2025 VALUES LESS THAN (2026),
    PARTITION pmax  VALUES LESS THAN MAXVALUE
);   -- 0 rows affected 

-- 67.find products with higher than average price: Subqueries can be used in SELECT, FROM, or WHERE clauses.
SELECT product_id, name, price
FROM products
WHERE price > (
    SELECT AVG(price) FROM products
);
-- product_id      name                        price
/*  1			Premium wireless headphones		199.99
	5			Adjustable standing desk		399.99
	102			Bluetooth Headphones			199.99
	104			Smartwatch						349.50  */

-- Union and intersect 

-- UNION: Combine rows from two queries (duplicates removed by default)
-- 68.All customers who either placed a gift order or a returned order
SELECT DISTINCT customer_id
FROM ordersv2
WHERE is_gift = TRUE

UNION

SELECT DISTINCT customer_id
FROM ordersv2
WHERE is_returned = TRUE;

-- customer_id
-- 3
-- 5

-- INTERSECT (Not supported in MySQL natively — simulate using IN)
-- Simulated INTERSECT: Customers who placed both gift and returned orders

SELECT customer_id
FROM ordersv2
WHERE is_gift = TRUE
AND customer_id IN (
    SELECT customer_id FROM ordersv2 WHERE is_returned = TRUE
);

-- customer_id
-- 3

-- CTE + Multi-table analysis: Total revenue and profit by channel

WITH revenue_profit AS (
  SELECT
    sc.channel_name,
    SUM(s.quantity * s.price) AS total_revenue,
    SUM(s.quantity * (s.price - p.cost_price)) AS total_profit
  FROM sales s
  JOIN sales_channel sc ON s.channel_id = sc.channel_id
  JOIN products p ON s.product_id = p.product_id
  GROUP BY sc.channel_name
)
SELECT * FROM revenue_profit
ORDER BY total_profit DESC;

CREATE TABLE sales_channel (
  channel_id INT PRIMARY KEY,
  channel_name VARCHAR(100)
);                                       -- 0 rows affected 

INSERT INTO sales_channel (channel_id, channel_name) VALUES
(1, 'Online'),
(2, 'Retail'),
(3, 'Distributor')
;              -- 3 rows affected Records : 3 Duplicates : 0 , Warnings : 0 


-- 69. Temporary Guess-Based Fix (if sales has channel_id and products has cost_price):

WITH revenue_profit AS (
  SELECT
    s.channel_id, -- fallback if no channel_name
    SUM(s.quantity * s.price) AS total_revenue,
    SUM(s.quantity * (s.price - p.cost_price)) AS total_profit
  FROM sales s
  JOIN products p ON s.product_id = p.product_id
  GROUP BY s.channel_id
)
SELECT * FROM revenue_profit
ORDER BY total_profit DESC;

-- This will show results by channel_id instead of channel_name.

-- 70. Step 1: Create Supporting Tables First

select * from sales_channel;  -- channel_id   channel_name
select * from products;  -- product_id name description  category  price cost stock_quantity  created_at updated_at
select * from sales;  -- sale_id item_id quantity_sold  sale_date

WITH revenue_profit AS (
  SELECT
    s.channel_id, -- fallback if no channel_name
    SUM(s.quantity * s.price) AS total_revenue,
    SUM(s.quantity * (s.price - p.cost_price)) AS total_profit
  FROM sales_channel s
  JOIN products p ON s.product_id = p.product_id
  GROUP BY s.channel_id
)
SELECT * FROM revenue_profit
ORDER BY total_profit DESC;

--  You Need to ADD channel_id to the sales Table
-- Add channel_id to the sales table

ALTER TABLE sales ADD COLUMN channel_id INT;

-- Example: Assign channel_id manually for testing
UPDATE sales SET channel_id = 1 WHERE sale_id IN (1, 2); -- Online
UPDATE sales SET channel_id = 2 WHERE sale_id IN (3, 4); -- Retail
UPDATE sales SET channel_id = 3 WHERE sale_id IN (5, 6); -- Distributor

-- 0 rows affected Rows matched : 0 changed : 0 

WITH revenue_profit AS (
  SELECT
    sc.channel_name,
    SUM(s.quantity_sold * p.price) AS total_revenue,
    SUM(s.quantity_sold * (p.price - p.cost)) AS total_profit
  FROM sales s
  JOIN products p ON s.item_id = p.product_id
  JOIN sales_channel sc ON s.channel_id = sc.channel_id
  GROUP BY sc.channel_name
)
SELECT * FROM revenue_profit
ORDER BY total_profit DESC;

-- channel_name   total_revenue total_profit 
-- Retail	3319.72	1343.72
-- Online	2999.85	1199.85

-- 71. Payment Method Trends: Analyzing customer payment preferences and their impact on purchase behavior.
select * from sales;      -- sale_id         item_id          quantity_sold          sale_date      channel_id
select * from payment_methods;

-- Create payment_methods Table

CREATE TABLE payment_methods (
  payment_method_id INT PRIMARY KEY AUTO_INCREMENT,
  method_name VARCHAR(50) NOT NULL
);   -- 0 rows affected 

-- Insert Common Payment Methods

INSERT INTO payment_methods (method_name) VALUES
('Credit Card'),
('Debit Card'),
('Cash'),
('PayPal'),
('Bank Transfer'),
('UPI'),
('Cryptocurrency');     -- rows affected Recoreds : 7 Duplicates : 0 Warnings : 0

ALTER TABLE sales ADD COLUMN payment_method_id INT;

UPDATE sales SET payment_method_id = 1 WHERE sale_id IN (1,2); -- Credit Card
UPDATE sales SET payment_method_id = 3 WHERE sale_id IN (3,4); -- Cash
UPDATE sales SET payment_method_id = 4 WHERE sale_id IN (5,6); -- PayPal   -- 0 affected rows matched : 0 Changed : 0 Warnings : 0 

CREATE TABLE orders (
  order_id INT PRIMARY KEY AUTO_INCREMENT,
  sale_id INT,
  payment_method_id INT,
  total_amount DECIMAL(10,2),
  order_date DATE,
  customer_id INT,  -- optional, if you want to track customers
  FOREIGN KEY (sale_id) REFERENCES sales(sale_id),
  FOREIGN KEY (payment_method_id) REFERENCES payment_methods(payment_method_id)
);

select * from orders;  -- order_id   item_id    quantity_sold    unit_price    order_date      total_amount
/* 1									1			10				15.00	  2025-08-01	 null
2										2			5				25.00	  2025-08-02	 null
3										1			7				15.00	  2025-08-03	 null
4										3			3				30.00	  2025-08-03	 null
5										2			10				25.00	  2025-08-04	 null */

WITH payment_stats AS (
  SELECT
    pm.method_name,
    SUM(p.total_amount) AS total_revenue,
    COUNT(*) AS total_transactions,
    AVG(p.total_amount) AS avg_transaction_value
  FROM orders p
  JOIN payment_methods pm ON p.payment_method_id = pm.payment_method_id
  GROUP BY pm.method_name
)
SELECT * FROM payment_stats
ORDER BY total_revenue DESC;

-- payment_method_id  not exist 

ALTER TABLE orders ADD COLUMN payment_method_id INT;

ALTER TABLE orders
ADD CONSTRAINT fk_payment_method
FOREIGN KEY (payment_method_id)
REFERENCES payment_methods(payment_method_id);

UPDATE orders SET payment_method_id = 1 WHERE order_id IN (1, 2); -- Credit Card -- 2 rows affected, matched 2: changed : 2 
UPDATE orders SET payment_method_id = 3 WHERE order_id IN (3, 4); -- Cash        -- 2 rows matched : 2 changed : 2 
UPDATE orders SET payment_method_id = 4 WHERE order_id IN (5, 6); -- PayPal      -- 1 row affected matched : 1 changed : 1 

WITH payment_stats AS (           -- re executed 
  SELECT
    pm.method_name,
    SUM(p.total_amount) AS total_revenue,
    COUNT(*) AS total_transactions,
    AVG(p.total_amount) AS avg_transaction_value
  FROM orders p
  JOIN payment_methods pm ON p.payment_method_id = pm.payment_method_id
  GROUP BY pm.method_name
)
SELECT * FROM payment_stats
ORDER BY total_revenue DESC;

/*
method_name    total_revenue   total_transactions  avg_transaction_value
Credit Card		null				2					null
Cash			null				2					null	
PayPal		null					1					null	
*/

-- 72. Subquery: Most Frequently Used Payment Method
SELECT method_name
FROM (
  SELECT pm.method_name, COUNT(*) AS usage_count
  FROM orders o
  JOIN payment_methods pm ON o.payment_method_id = pm.payment_method_id
  GROUP BY pm.method_name
) AS method_usage
ORDER BY usage_count DESC
LIMIT 1;

-- Method_name 
/* Credit Card  */

/*1. Order lifecycle (e.g., Pending → Processing → Shipped → Delivered → Cancelled)
  2. Time taken between each status
  3.   Bottlenecks (e.g., delayed shipments)
  4.  Status breakdown (e.g., % delivered, % cancelled)
  
  select * from orders; -- order_id  item_id  quantity_sold  unit_price  order_date  total_amount  payment_method_id
  /*  1	1	10	15.00	2025-08-01		1
2	2	5	25.00	2025-08-02		1
3	1	7	15.00	2025-08-03		3
4	3	3	30.00	2025-08-03		3
5	2	10	25.00	2025-08-04		4      */  -- 5 rows returned
  
  ALTER TABLE orders
ADD COLUMN customer_id INT,
ADD COLUMN order_status VARCHAR(50); -- rows affected 

UPDATE orders SET customer_id = 1, order_status = 'Pending' WHERE order_id = 1;
UPDATE orders SET customer_id = 2, order_status = 'Shipped' WHERE order_id = 2;
UPDATE orders SET customer_id = 1, order_status = 'Delivered' WHERE order_id = 3;
UPDATE orders SET customer_id = 3, order_status = 'Cancelled' WHERE order_id = 4;
UPDATE orders SET customer_id = 2, order_status = 'Delivered' WHERE order_id = 5;
UPDATE orders SET customer_id = 3, order_status = 'Processing' WHERE order_id = 6;

select * from orders ; 
-- order_id  item_id  quantity_sold  unit_price  order_date  total_amount  payment_method_id customer_id order_status

-- 73. Count Orders per Status (Current Snapshot)

SELECT order_status, COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;

-- order_status  total_orders
/*Delivered	2
Pending	1
Shipped	1
Cancelled	1  */

-- 74.fulfillment rate (% Delivered)
SELECT
  ROUND(SUM(CASE WHEN order_status = 'Delivered' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS fulfillment_rate
FROM orders;

-- Average Time to Fulfill Orders (If order_status_history exists)
-- If you track status timestamps:
-- This table is essential for tracking order status changes over time, such as:
-- Pending → Processing → Shipped → Delivered, With timestamps for each stage

CREATE TABLE order_status_history (
  id INT PRIMARY KEY AUTO_INCREMENT,
  order_id INT,
  status VARCHAR(50),
  status_time DATETIME,
  FOREIGN KEY (order_id) REFERENCES orders(order_id)
);                            -- 0 row affected

-- Step 2: Insert Sample Status History

INSERT INTO order_status_history (order_id, status, status_time) VALUES
(1, 'Processing', '2025-08-01 09:00:00'),
(1, 'Shipped', '2025-08-01 12:00:00'),
(1, 'Delivered', '2025-08-01 18:00:00'),

(2, 'Processing', '2025-08-02 10:00:00'),
(2, 'Shipped', '2025-08-02 14:00:00'),
(2, 'Delivered', '2025-08-03 08:00:00'),

(3, 'Processing', '2025-08-03 11:00:00'),
(3, 'Cancelled', '2025-08-03 15:00:00');           -- 8 row affected 

SELECT 
  o.order_id,
  TIMESTAMPDIFF(HOUR,
    MIN(CASE WHEN h.status = 'Processing' THEN h.status_time END),
    MAX(CASE WHEN h.status = 'Delivered' THEN h.status_time END)
  ) AS hours_to_fulfill
FROM orders o
JOIN order_status_history h ON o.order_id = h.order_id
GROUP BY o.order_id
HAVING hours_to_fulfill IS NOT NULL
ORDER BY hours_to_fulfill DESC;


-- order_id  hours_to_fulfill
/*  2 			22
    1			9      */
    
    -- 75.Orders Delayed Over 3 Days (Not Yet Delivered)
SELECT *
FROM orders
WHERE order_status != 'Delivered'
  AND DATEDIFF(CURDATE(), order_date) > 3;
  
/* 1	1	10	15.00	2025-08-01		1	1	Pending
2	2	5	25.00	2025-08-02		1	2	Shipped
								*/
                                
-- 76. Weekly Order Fulfillment Summary (CTE + Time Grouping)

WITH weekly_orders AS (
  SELECT
    WEEK(order_date) AS order_week,
    COUNT(*) AS total_orders,
    SUM(CASE WHEN order_status = 'Delivered' THEN 1 ELSE 0 END) AS delivered_orders
  FROM orders
  GROUP BY WEEK(order_date)
)
SELECT 
  order_week,
  total_orders,
  delivered_orders,
  ROUND(delivered_orders * 100.0 / total_orders, 2) AS delivery_rate
FROM weekly_orders;

/* order_week	total_orders 	delivered_orders	delivery_rate
	30				2				0				0.00
	31				3				2				66.67  */
    
-- 77.Subquery: Longest Time Taken for Fulfillment (Completed Orders Only)

SELECT order_id, MAX(status_time) - MIN(status_time) AS total_hours
FROM order_status_history
WHERE status IN ('Processing', 'Shipped', 'Delivered')
GROUP BY order_id
ORDER BY total_hours DESC
LIMIT 5;

-- order_id  total_hours
/* 2			980000
1			90000
3			0   */

ALTER TABLE orders ADD COLUMN region VARCHAR(100);
ALTER TABLE orders ADD COLUMN tax_amount DECIMAL(10,2);

UPDATE orders SET region = 'California', tax_amount = 120.00 WHERE order_id = 1;
UPDATE orders SET region = 'Texas',      tax_amount = 95.00  WHERE order_id = 2;
UPDATE orders SET region = 'California', tax_amount = 135.00 WHERE order_id = 3;
UPDATE orders SET region = 'New York',   tax_amount = 88.50  WHERE order_id = 4;
UPDATE orders SET region = 'Florida',    tax_amount = 102.00 WHERE order_id = 5;
UPDATE orders SET region = 'Texas',      tax_amount = 99.00  WHERE order_id = 6;

select * from orders ;
-- 78. Total Tax Collected by Region

SELECT
  region,
  SUM(tax_amount) AS total_tax_collected
FROM orders
GROUP BY region
ORDER BY total_tax_collected DESC;

-- region  total_tax_collected
/*California	255.00
Florida			102.00
Texas			95.00
New York		88.50 */

-- 79. Total Tax Collected by Product Category
select * from sales;  -- sale_id  item_id  quantity_sold  sale_date channel_id payment_method_id 
select * from products; -- product_id name     description	category 	price 	cost 	stock_quantity 	created_at 	updated_at
select * from orders; -- order_id item_id quantity_sold unit_price order_date total_amount payment_method_id customer_id order_status region tax_amount

SELECT
  p.category,
  SUM(o.tax_amount) AS total_tax
FROM orders o
JOIN products p ON o.item_id = p.product_id
GROUP BY p.category
ORDER BY total_tax DESC;

-- Category		total_tax
/* Electronics	255.00
Furniture	197.00
Office supplies	88.50 */

-- 80. Tax Rate vs. Actual Tax Paid (Validation)
select * from sales;  -- sale_id  item_id  quantity_sold  sale_date channel_id payment_method_id 
select * from products; -- product_id name     description	category 	price 	cost 	stock_quantity 	created_at 	updated_at
select * from orders; -- order_id item_id quantity_sold unit_price order_date total_amount payment_method_id customer_id order_status region tax_amount

SELECT
  o.order_id,
  p.tax_rate,                                                        -- tax_rate column not available 
  ROUND(SUM(p.price * p.tax_rate / 100), 2) AS expected_tax,
  o.tax_amount AS actual_tax 
FROM orders o
JOIN sales s ON o.order_id = s.order_id
JOIN products p ON s.product_id = p.product_id
GROUP BY o.order_id, o.tax_amount, p.tax_rate
HAVING ROUND(SUM(p.price * p.tax_rate / 100), 2) != o.tax_amount;

ALTER TABLE products ADD COLUMN tax_rate DECIMAL(5,2);      -- 0 rows affected Records : 0 duplicates : 0
UPDATE products SET tax_rate = 10.00 WHERE category = 'Electronics'; -- 10%
UPDATE products SET tax_rate = 8.00 WHERE category = 'Clothing';     -- 8%
UPDATE products SET tax_rate = 5.00 WHERE category = 'Books';        -- 5%

SELECT
  p.category,
  p.tax_rate,
  ROUND(SUM(o.quantity_sold * o.unit_price * (p.tax_rate / 100)), 2) AS calculated_tax
FROM orders o
JOIN products p ON o.item_id = p.product_id
GROUP BY p.category, p.tax_rate
ORDER BY calculated_tax DESC;

-- category   tax_rate   calculated_tax
/*Electronics	10.00	25.50
Furniture		
Office supplies		*/

-- 81. Optional: Compare Actual vs. Calculated Tax
-- If you're also storing tax_amount directly in orders, you can compare both:

SELECT
  p.category,
  ROUND(SUM(o.tax_amount), 2) AS actual_tax,
  ROUND(SUM(o.quantity_sold * o.unit_price * (p.tax_rate / 100)), 2) AS calculated_tax
FROM orders o
JOIN products p ON o.item_id = p.product_id
GROUP BY p.category
ORDER BY calculated_tax DESC;

-- category    actual_tax		calculated_tax
/*Electronics	255.00	25.50
Furniture	197.00	
Office supplies	88.50	*/

-- 82.Tax Collected Over Time (CTE for Monthly Trends)

WITH tax_by_month AS (
  SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    SUM(tax_amount) AS monthly_tax
  FROM orders
  GROUP BY DATE_FORMAT(order_date, '%Y-%m')
)
SELECT * FROM tax_by_month
ORDER BY month;

-- month 		monthly_tax
/* 2025-08		540.50 */

-- 83.Subquery: Regions with Above-Average Tax Collection

SELECT region, total_tax
FROM (
  SELECT
    region,
    SUM(tax_amount) AS total_tax
  FROM orders
  GROUP BY region
) AS regional_tax
WHERE total_tax > (
  SELECT AVG(total_tax) FROM (
    SELECT SUM(tax_amount) AS total_tax FROM orders GROUP BY region
  ) AS avg_tax
);

-- region 		total_tax
/* California	255.00 */

-- 84. Multi-table: Tax by Channel and Region
select * from sales;  -- sale_id  item_id  quantity_sold  sale_date channel_id payment_method_id 
select * from orders; -- order_id item_id quantity_sold unit_price order_date total_amount payment_method_id customer_id order_status region tax_amount
select * from sales_channel;  -- channel_id   channel_name

SELECT
  sc.channel_name,
  o.region,
  SUM(o.tax_amount) AS total_tax
FROM orders o
JOIN sales s ON o.item_id = s.item_id  -- Join on item/product ID
JOIN sales_channel sc ON s.channel_id = sc.channel_id
GROUP BY sc.channel_name, o.region
ORDER BY total_tax DESC;

-- channel_name  region   total_tax
/*Online	California	510.00
Retail	Florida	102.00
Retail	Texas	95.00
Retail	New York	88.50  */

--  Customer Order Patterns: When joined with the customers table, analyzing repeat purchase behavior and customer lifetime value.

-- 85. Total Orders and Repeat Customers
select * from customers; -- customer_id first_name last_name email phone address city state postal_code country created_at updated-at
select * from orders;    -- order_id item_id quantity_sold unit_price order_date total_amount payment_method_id customer_id order_status region tax_amount

SELECT
  c.customer_id,
  CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
  COUNT(o.order_id) AS total_orders,
  MIN(o.order_date) AS first_order_date,
  MAX(o.order_date) AS last_order_date,
  SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING total_orders > 1
ORDER BY total_orders DESC;


-- customer_id  customer_name   total_orders   first_order_date   last_order_date  total_spent 
/* 1	Alice Smith	2	2025-08-01	2025-08-03	null
2	Bob Johnson	2	2025-08-02	2025-08-04	null  */

-- Customer Lifetime Value (CLV)
SELECT
  c.customer_id,
  c.first_name,
  COUNT(o.order_id) AS total_orders,
  SUM(o.total_amount) AS lifetime_value,
  ROUND(AVG(o.total_amount), 2) AS avg_order_value
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name
ORDER BY lifetime_value DESC;
-- CLV = Sum of all their orders
-- Shows you top customers by revenue and how valuable each customer is.

-- customer_id   first_name  total_orders   lifetime_value  avg_order_value 
/*  1			Alice			2		        null			null
2				Bob				2		        null			null
3				Carol			1				null             null*/

