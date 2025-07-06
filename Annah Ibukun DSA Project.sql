

CREATE TABLE KMS_ORDERS (
      [ROW ID] INT,
	  [ORDER ID] INT,
	  [ORDER DATE] DATE,
	  [ORDER PRIORITY] VARCHAR(50),
	  [ORDER QUANTITY] INT,
	  SALES DECIMAL(10,2),
	  DISCOUNT DECIMAL(10,2),
	  [SHIP MODE] VARCHAR(50),
	  PROFIT DECIMAL(10,2),
	  [UNIT PRICE] DECIMAL(10,2),
	  [SHOPPING COST] DECIMAL(10,2),
	  [CUSTOMER NAME] VARCHAR(255),
	  PROVINCE VARCHAR(100),
	  REGION VARCHAR(100),
	  [CUSTOMER SEGMENT] VARCHAR(100),
	  [PRODUCT CATEGORY] VARCHAR(100),
	  [PRODUCT SUB-CATEGORY] VARCHAR(100),
	  [PRODUCT NAME] VARCHAR(MAX),
	  [PRODUCT CONTAINER] VARCHAR(100),
	  [PRODUCT BASE MARGIN] DECIMAL(10,2),
	  [SHIP DATE] DATE
	  )

SELECT * FROM KMS_ORDERS

USE PROJECT_DB;
GO
SELECT * FROM [KMS ]

-----1. Product Category that had the highest sales----

SELECT 
      Product_Category,
	  SUM(Sales) AS Total_Sales
	  FROM [KMS ]
	  GROUP BY Product_Category
	  ORDER BY Total_Sales DESC

----- Technology had the highest sales -------


-----2a. The Top 3 regions in terms of sales----

SELECT 
      TOP 3 Region,
	  SUM(Sales) AS Total_Sales
	  FROM [KMS ]
	  GROUP BY Region
	  Order BY Total_Sales desc

-----2b.  The Bottom 3 regions in terms of sales----
SELECT 
      TOP 3 Region,
	  SUM(Sales) AS Total_Sales
	  FROM [KMS ]
	  GROUP BY Region
	  Order BY Total_Sales asc

-----3. Total Sales of Appliances in Ontario----

SELECT 
      Product_Sub_Category,
	  SUM(Sales) AS Total_Sales
	  FROM [KMS ]
	  WHERE Region = 'Ontario'
	  GROUP BY Product_Sub_Category

-----4. Bottom 10 customers-----

SELECT
      TOP 10 Customer_Name,Product_Category,Shipping_cost,Discount,unit_price,
	  SUM(Order_Quantity) AS Total_Order_Quantity
	  FROM [KMS ]
	  GROUP BY Customer_Name,Product_Category,Shipping_Cost,Sales,Discount,Unit_Price
	  Order BY Total_Order_Quantity asc

-----Insights from the Data----
---1. Each of these customers has made only one purchase.
---2. Some customers like Allen Rosenblatt and Ann Brume paid high shipping fees.
---3. Discounts were given to some , but not all.

---Recommendations---
---1. Reduce shipping cost on Technology purchases.
---2. Offer special discounts or limited-time offers.
---3. Introduce a loyalthy program that gives points or discounts after multiple purchases.
---4. Collect feedback from these customers to ask why they havent returned.


-----5. KMS incurred the most shipping cost using which shipping method?

SELECT
      Ship_Mode,
	  SUM(Shipping_Cost) AS Total_Shipping_Cost
	  FROM [KMS ]
	  GROUP BY Ship_Mode
	  Order BY Total_Shipping_Cost desc

----KMS incurred the most shipping cost using Delivery Truck.

-----6. Who are the most valuable customers, and what products or services do they typically purchase?

SELECT 
      Customer_Segment,Product_Sub_Category,Customer_Name,
	  Sum(Sales) AS Total_Sales
	  FROM [KMS ]
	  GROUP BY Customer_Segment,Product_Sub_Category,Customer_Name
	  Order BY Total_Sales desc


-----7. Which small business customer had the highest sales?

SELECT 
      TOP 1 *
	  FROM [KMS ]
	  WHERE Customer_Segment = 'SMALL BUSINESS'
	  ORDER BY Sales desc
     
------Dennis Kane had the highest sales.


-----8. Which Corporate Customer placed the most number of orders in 2009 – 2012?

SELECT 
      TOP 1 *
	  FROM [KMS ]
	  WHERE Customer_Segment = 'Corporate'
	  ORDER BY Order_Quantity desc

-----Barry Weirich placed the most number of orders.


-----9. Which consumer customer was the most profitable one?

SELECT 
      TOP 1 *
	  FROM [KMS ]
	  WHERE Customer_Segment = 'Consumer'
	  ORDER BY Profit desc

-----Emily Phan was the most profitable consumer customer.

USE PROJECT_DB;
GO
SELECT * FROM [KMS ]


-----10. Which customer returned items, and what segment do they belong to?

SELECT
      Customer_Name,Customer_Segment,
	  COUNT(*) AS Returned_Items,
	  SUM(Profit) AS Total_Negative_Profit
	  FROM [KMS ]
	  WHERE Profit < 0
	  GROUP BY Customer_Name,Customer_Segment
	  ORDER BY Total_Negative_Profit asc


SELECT * FROM [KMS ]

-----11. If the delivery truck is the most economical but the slowest shipping method and Express Air is the fastest but the most expensive one, do you think the company appropriately spent shipping costs based on the Order Priority? Explain your answer

SELECT
      Order_Priority,Ship_Mode,
	  SUM(Shipping_Cost) AS Total_Shipping_Cost
	  FROM [KMS ]
	  WHERE Ship_Mode IN ('Delivery Truck','Express Air')
	  GROUP BY Order_Priority,Ship_Mode
	  ORDER BY Total_Shipping_Cost desc

-----Analysis-----
----The company didnt appropriately spend shipping cost based on order priority.

-----Reasons----
---Since delivery truck is the most economical, its supposed to incurr less cost but from the data, it incurred the highest cost.
-----Express Air incurred less cost.
---- The company needs to change their shipping strategy. Since Express Air is the fastest, it should be used for critical and high order priority while Delivery Truck should be used for Medium and Low Order Priority.






     



