-- =========================================================================
-- PROJECT NAME: Retail Sales & Customer Performance Analysis
-- AUTHOR: Pawan Kumar (Data Analyst Fresher)
-- TOOLS USED: SQL Server / SSMS
-- =========================================================================

-- 1. DATABASE SETUP & INSPECTION
-- Sabse pehle poore data ko check karne ke liye taaki structure samajh sakein
SELECT TOP 10 * 
FROM SalesData;


-- 2. DATA CLEANING & PROCESSING
-- Aise orders ko dhoondhna jahan CustomerID missing (NULL) hai aur unhe analyze karna
SELECT OrderID, OrderDate, TotalAmount 
FROM SalesData
WHERE CustomerID IS NULL;

-- Standardizing Data: Delivery Status me blank spaces ko correct karna
UPDATE SalesData
SET DeliveryStatus = 'Delivered'
WHERE DeliveryStatus IS NULL OR DeliveryStatus = '';


-- 3. KEY BUSINESS PERFORMANCE METRICS (KPIs)
-- Business ka total revenue, total quantity sold aur total orders count karna
SELECT 
    SUM(TotalAmount) AS Total_Revenue,
    SUM(Quantity) AS Total_Products_Sold,
    COUNT(OrderID) AS Total_Orders_Placed
FROM SalesData;


-- 4. PRODUCT PERFORMANCE ANALYSIS
-- Top 5 sabse zyada bikne wale products aur unka revenue nikalna
SELECT TOP 5 
    ProductName, 
    COUNT(OrderID) AS Total_Orders,
    SUM(TotalAmount) AS Product_Revenue
FROM SalesData
GROUP BY ProductName
ORDER BY Product_Revenue DESC;


-- 5. CUSTOMER SEGMENTATION
-- Aise top customers ko filter karna jinhone business ko sabse zyada profit diya hai
SELECT TOP 10 
    CustomerID, 
    COUNT(OrderID) AS Number_Of_Purchases,
    SUM(TotalAmount) AS Total_Spent
FROM SalesData
GROUP BY CustomerID
ORDER BY Total_Spent DESC;


-- 6. MONTHLY SALES TRENDS (ADVANCED ANALYSIS)
-- Yeh check karna ki saal ke kis mahine me business sabse accha perform kar raha hai
SELECT 
    MONTH(OrderDate) AS Order_Month,
    YEAR(OrderDate) AS Order_Year,
    SUM(TotalAmount) AS Monthly_Revenue,
    COUNT(OrderID) AS Monthly_Orders
FROM SalesData
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
ORDER BY Order_Year, Order_Month;
