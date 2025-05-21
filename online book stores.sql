-- Create Tables
DROP TABLE IF EXISTS Books;
CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);
DROP TABLE IF EXISTS customers;
CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);
DROP TABLE IF EXISTS orders;
CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;




COPY Books(Book_ID, Title, Author, Genre, Published_Year, Price, Stock)
FROM 'C:\Users\pkksh\OneDrive\Desktop\SQL\Books.csv' 
DELIMITER ',' 
CSV HEADER;

COPY Customers(Customer_ID, Name, Email, Phone, City, Country)
FROM 'C:\Users\pkksh\OneDrive\Desktop\SQL\Customers.csv'
DELIMITER ',' 
CSV HEADER;

COPY Orders(Order_ID, Customer_ID, Book_ID, Order_Date, Quantity, Total_Amount) 
FROM 'C:\Users\pkksh\OneDrive\Desktop\SQL\Orders.csv'
DELIMITER ',' 
CSV HEADER;


-- 1) Retrieve all books in the "Fiction" genre:

     select * from Books
	 where genre = 'Fiction';

-- 2) Find books published after the year 1950:
       select * from Books
	   where published_year >=1950;

-- 3) List all customers from the Canada:
       select * from customers
	   where country = 'Canada';
      
-- 4) Show orders placed in November 2023:
       select *from orders
	   where order_date Between '2023-11-01' AND '2023-11-30';

-- 5) Retrieve the total stock of books available:
        select sum(Stock) as Total_Stock from Books;

-- 6) Find the details of the most expensive book:
      select *from Books
	  order by price desc limit 1;

-- 7) Show all customers who ordered more than 1 quantity of a book:
       select *from orders
	   where quantity > 1;

-- 8) Retrieve all orders where the total amount exceeds $20:
         select * from orders
		 where total_amount >20;

-- 9) List all genres available in the Books table:
      select genre from Books;

-- 10) Find the book with the lowest stock:
     select min(Stock) as Lowest_Stock from Books;

-- 11) Calculate the total revenue generated from all orders:
      select sum(total_amount) as total_revenue from orders;

-- Advance Questions : 

-- 1) Retrieve the total number of books sold for each genre:
      select b.genre, sum(o.quantity) as total_sold_books
	  from Books b
	  join orders o
	  on b.book_id = o.order_id
	  group by genre;
	  


-- 2) Find the average price of books in the "Fantasy" genre:

      select avg(price) from Books
	  where genre = 'Fantasy';

-- 3) List customers who have placed at least 2 orders:
      select customer_id, quantity from orders 
      where quantity = 2 ;     


-- 4) Find the most frequently ordered book:
      select * from orders
	  order by quantity desc limit 1;

-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
      select * from books
	  where genre = 'Fantasy' 
	  order by price desc limit 3 ;


-- 6) Retrieve the total quantity of books sold by each author:
      select b.author, sum(o.quantity) as total_sold_books
	  from orders o
	  join books b
	  on b.book_id = o.book_id
	  group by author;

-- 7) List the cities where customers who spent over $30 are located:
       
     SELECT DISTINCT c.city, total_amount
     FROM orders o
     JOIN customers c ON o.customer_id=c.customer_id
     WHERE o.total_amount > 30;

	   
-- 8) Find the customer who spent the most on orders:
     SELECT c.customer_id, c.name, SUM(o.total_amount) AS Total_Spent
     FROM orders o
     JOIN customers c ON o.customer_id=c.customer_id
     GROUP BY c.customer_id, c.name
     ORDER BY Total_spent Desc LIMIT 1;


--9) Calculate the stock remaining after fulfilling all orders:
      SELECT b.book_id, b.title, b.stock, COALESCE(SUM(o.quantity),0) AS Order_quantity,  
	   b.stock- COALESCE(SUM(o.quantity),0) AS Remaining_Quantity
       FROM books b
       LEFT JOIN orders o ON b.book_id=o.book_id
       GROUP BY b.book_id ORDER BY b.book_id;









