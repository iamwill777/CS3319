-- Shows description of all products
SELECT description FROM product;
-- Shows city of all customers without repeats
SELECT DISTINCT city FROM customer;
-- Show all data in agent table order by city
SELECT * FROM agent ORDER BY city;
-- Shows first and last name of all customers from Springfield
SELECT firstname, lastname FROM customer WHERE city = 'Springfield';
-- Shows last name of all customer that deal with Regis
SELECT lastname FROM customer
	INNER JOIN agentDeals ON customer.customerid = agentDeals.customerid
    WHERE agentDeals.agentid = '11';
-- Shows description of any product with 'pad' in its name
SELECT description FROM product WHERE description LIKE '%pad%';
-- Shows last name, description of product and quantity they have purchased of that product for every customer who has bought something
SELECT customer.lastname, product.description, purchased.quantity FROM customer
	INNER JOIN purchased ON customer.customerid = purchased.customerid
    INNER JOIN product ON purchased.productid = product.productid
    WHERE quantity > 0;
-- Shows total number of items purchased by Homer
SELECT SUM(quantity) AS "Homer's Total Purchases" FROM purchased
	INNER JOIN customer ON purchased.customerid = customer.customerid
	WHERE firstname = 'Homer';
-- Shows first name, last name, total purchases and unique items purchased for every customer who has bought something
SELECT COUNT(customer.customerid) AS "Unique Items Purchased", SUM(purchased.quantity) AS "Total Items Purchased", customer.firstname, customer.lastname FROM purchased
	INNER JOIN customer ON customer.customerid = purchased.customerid
    WHERE quantity > 0
    GROUP BY customer.firstname, customer.lastname;
-- Shows description and quantity on hand of items that have not been purchased by anyone
SELECT description, numofitems FROM product
	LEFT JOIN purchased ON product.productid = purchased.productid
    WHERE purchased.productid IS NULL;
-- Shows description and quantity of any product that has not been bought by Fred Flintstone
SELECT description, numofitems FROM product WHERE description NOT IN
(
	SELECT description FROM product
	LEFT JOIN purchased ON product.productid = purchased.productid
    INNER JOIN customer ON customer.customerid = purchased.customerid
    WHERE customer.firstname = 'Fred' AND customer.lastname = 'Flintstone'
);
-- Shows first and last name of agent and customer if agent deals with customer in same city
SELECT agent.firstname, agent.lastname, customer.firstname, customer.lastname FROM agent
	INNER JOIN agentDeals ON agent.agentid = agentDeals.agentid
    INNER JOIN customer ON agentDeals.customerid = customer.customerid
    WHERE agent.city = customer.city;
-- Shows total number of knee pads purchased
SELECT SUM(quantity) AS "Total Knee Pads Purchased" FROM purchased WHERE productid = '78';
-- Shows all descriptions of products that have been purchased by 3 or more customers
SELECT description AS "Products That Have More than 3 Customers" FROM product
	INNER JOIN purchased ON product.productid = purchased.productid
    GROUP BY description
    HAVING COUNT(purchased.productid) > 3;
-- Shows first and last names of customers that have purchased knee pads
SELECT firstname, lastname FROM customer
	INNER JOIN purchased ON customer.customerid = purchased.customerid
    WHERE purchased.productid = '78';