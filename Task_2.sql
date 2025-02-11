CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    EmployeeID INT,
    Amount DECIMAL(10,2),
    SaleDate DATE
);
INSERT INTO Sales (SaleID, EmployeeID, Amount, SaleDate) VALUES
(1, 101, 500, '2024-01-10'),
(2, 102, 700, '2024-01-12'),
(3, 101, 900, '2024-02-01'),
(4, 103, 400, '2024-02-05'),
(5, 102, 1100, '2024-03-10'),
(6, 101, 650, '2024-03-15'),
(7, 103, 850, '2024-04-05');

/*  
Using Window Functions
Ranking Employees by Total Sales */

SELECT EmployeeID, 
       SUM(Amount) AS TotalSales,
       RANK() OVER (ORDER BY SUM(Amount) DESC) AS SalesRank
FROM Sales
GROUP BY EmployeeID;

/*
Using Subqueries
Find Employees Who Made Sales Above the Average
*/

SELECT EmployeeID, Amount, SaleDate
FROM Sales
WHERE Amount > (SELECT AVG(Amount) FROM Sales);

/*
Using CTEs (Common Table Expressions)
Find Running Total of Sales Per Employee
*/

WITH RunningSales AS (
    SELECT EmployeeID, SaleDate, Amount,
           SUM(Amount) OVER (PARTITION BY EmployeeID ORDER BY SaleDate) AS RunningTotal
    FROM Sales
)
SELECT * FROM RunningSales;

