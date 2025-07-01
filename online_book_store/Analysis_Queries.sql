/* 1)Retrive all the books in the "Fiction" genre:*/
SELECT * FROM Book 
WHERE Genre="Fiction";

/* 2)Find books published after the year 1950:*/
SELECT Title FROM Book
WHERE Published_Year>1950;

/*3)List all the customers from Canada:*/
SELECT * FROM Customer
WHERE Country LIKE '%Canada%';

/*4)Show orders placed in November 2023*/
SELECT * FROM Orders
WHERE Order_Date BETWEEN '2023-11-01' AND '2023-11-30';

/*5)Retrive total stock of books available:*/
SELECT SUM(Stock) from Book;

/*6)Find the details of expensive book:*/
SELECT * FROM Book 
WHERE Price=(SELECT MAX(Price) FROM Book);

SELECT *FROM Book ORDER BY Price DESC LIMIT 1;

/*7)Show all the customers who ordered more than 1 quantity of a book*/
SELECT Customer_ID FROM Orders 
WHERE Quantity>1;

/*8)Retrive all orders where total amount exceeds $20*/
SELECT * FROM Orders
WHERE Total_Amount>20;

/*9)List all Genres available in the Book table:*/
SELECT DISTINCT Genre from Book;

/*10) Find the book with lowest stock:*/
SELECT * FROM Book
WHERE Stock=(SELECT MIN(Stock) FROM Book);

SELECT * FROM Book
ORDER BY Stock LIMIT 5;

/*11) Calculate the total revenue generated from all orders:*/
SELECT SUM(Total_Amount)AS Total_Revenue 
FROM Orders;

/*Advanced Queries*/
/*1)Retrive total number of book sold for each genre:*/
SELECT b.Genre,SUM(o.Quantity)
FROM Orders as o
JOIN Book as b ON b.Book_ID=o.Order_ID
GROUP BY b.Genre;

/*2)Find the average price of books in the "Fantasy" Genre:*/
SELECT AVG(Price) 
FROM Book
WHERE Genre="Fantasy";

/*3)List Customer who have placed at least 2 orders:*/
SELECT c.name,COUNT(o.Quantity),o.Customer_ID 
FROM Orders o
JOIN Customer c ON o.Customer_ID=c.Customer_ID
GROUP BY o.Customer_ID,c.name
HAVING COUNT(o.Quantity)>=2;

/*4)Find the most frequently ordered book*/
SELECT b.Title,COUNT(o.Quantity)
FROM Orders as o
JOIN Book as b ON b.Book_ID=o.Book_ID
GROUP BY b.Title
ORDER BY COUNT(o.Quantity) DESC
Limit 10;

/*5)Show the top 3 most expensive books of 'Fantasy' Genre:*/
SELECT Book_ID,Title,Price 
FROM Book
WHERE Genre='Fantasy'
ORDER BY Price DESC
LIMIT 3;

/*6)Retrive the total quantity of books sold by each author:*/
SELECT b.Author,SUM(o.Quantity)
FROM  Orders o
JOIN Book b ON o.Book_ID=b.Book_ID
Group BY b.Author;

/*7)List the cities where customer who spent over $30 are located:*/
SELECT DISTINCT c.City,o.Total_Amount
FROM Orders o
JOIN Customer c ON o.Customer_ID=c.Customer_ID
WHERE Total_Amount>=30;

 /*8)Find the customer who spent the most on orders*/
 SELECT c.name,o.Customer_ID ,SUM(o.Total_Amount)AS Total_Spent
 FROM Orders o
 JOIN Customer c ON o.Customer_ID=c.Customer_ID
GROUP BY c.name,o.Customer_ID
ORDER BY Total_Spent DESC LIMIT 1;

/*9) Calculate the stock remaining after fulfilling all orders:*/
SELECT b.Stock,b.Book_ID,b.Title,COALESCE(SUM(Quantity),0) AS Order_Quantity,b.Stock-COALESCE(SUM(Quantity),0) AS remaining_quantity
FROM Book b
LEFT JOIN Orders o ON o.Book_ID=b.Book_ID
GROUP BY b.Book_ID;