create database E_database;

use E_database;

create table category(
cat_id int(5) auto_increment,
cat_name varchar(20) not null,
primary key(cat_id));

create table product(
pro_id int(5) auto_increment,
pro_name varchar(20) default 'Dummy',
pro_desc varchar(60),
cat_id int(5),
primary key(pro_id),
foreign key (cat_id) references category(cat_id));

create table supplier(
supp_id int(5) auto_increment,
supp_name varchar(50) not null,
supp_city varchar(50) not null,
supp_phone varchar(10) not null,
primary key(supp_id));

create table supplier_pricing(
pricing_id int(5) auto_increment,
pro_id int(5),
supp_id int(5),
supp_price int(5) default 0,
primary key(pricing_id),
foreign key (pro_id) references product(pro_id),
foreign key (supp_id) references supplier(supp_id));

create table customer(
cus_id int(5) auto_increment,
cus_name varchar(20) not null,
cus_phone varchar(10) not null,
cus_city varchar(30) not null,
cus_gender char,
primary key(cus_id));

create table orders (
ord_id int(5) auto_increment,
ord_date date not null,
cus_id int(5),
pricing_id int(5),
primary key(ord_id),
foreign key (cus_id) references customer(cus_id));

create table rating (
rat_id int(5) auto_increment,
ord_id int(5),
rat_ratstars int(1),
primary key(rat_id),
foreign key (ord_id) references orders(ord_id));

INSERT INTO `category` (`cat_id`, `cat_name`) VALUES
(1, 'BOOKS'),
(2, 'GAMES'),
(3, 'GROCERIES'),
(4, 'ELECTRONICS'),
(5, 'CLOTHES');

INSERT INTO `customer` (`cus_id`, `cus_name`, `cus_phone`, `cus_city`, `cus_gender`) VALUES
(1, 'AAKASH', '9999999999', 'DELHI', 'M'),
(2, 'AMAN', '9785463215', 'NOIDA', 'M'),
(3, 'NEHA', '9999999999', 'MUMBAI', 'F'),
(4, 'MEGHA', '9994562399', 'KOLKATA', 'F'),
(5, 'PULKIT', '7895999999', 'LUCKNOW', 'M');

INSERT INTO `orders` (`ord_id`, `ord_date`, `cus_id`, `pricing_id`) VALUES
(101, '2021-10-06', 2, 1),
(102, '2021-10-12', 3, 5),
(103, '2021-09-16', 5, 2),
(104, '2021-10-05', 1, 1),
(105, '2021-08-16', 4, 3),
(106, '2021-08-18', 1, 9),
(107, '2021-09-01', 3, 7),
(108, '2021-09-07', 5, 6),
(109, '2021-09-10', 5, 3),
(110, '2021-09-10', 2, 4),
(111, '2021-09-15', 4, 5),
(112, '2021-09-16', 4, 7),
(113, '2021-09-16', 1, 8),
(114, '2021-09-16', 3, 5),
(115, '2021-09-16', 5, 3),
(116, '2021-09-17', 2, 14);

INSERT INTO `product` (`pro_id`, `pro_name`, `pro_desc`, `cat_id`) VALUES
(1, 'GTA V', 'Windows 7 and above with i5 processor and 8GB RAM', 2),
(2, 'TSHIRT', 'SIZE-L with Black, Blue and White variations', 5),
(3, 'ROG LAPTOP', 'Windows 10 with 15inch screen, i7 processor, 1TB S', 4),
(4, 'OATS', 'Highly Nutritious from Nestle', 3),
(5, 'HARRY POTTER', 'Best Collection of all time by J.K Rowling', 1),
(6, 'MILK', '1L Toned MIlk', 3),
(7, 'Boat EarPhones', '1.5Meter long Dolby Atmos', 4),
(8, 'Jeans', 'Stretchable Denim Jeans with various sizes and col', 5),
(9, 'Project IGI', 'compatible with windows 7 and above', 2),
(10, 'Hoodie', 'Black GUCCI for 13 yrs and above', 5),
(11, 'Rich Dad Poor D', 'Written by RObert Kiyosaki', 1),
(12, 'Train Your Brai', 'By Shireen Stephen', 1);

INSERT INTO `supplier` (`supp_id`, `supp_name`, `supp_city`, `supp_phone`) VALUES
(1, 'Rajesh Retails', 'Delhi', '1234567890'),
(2, 'Appario Ltd.', 'Mumbai', '2589631470'),
(3, 'Knome products', 'Banglore', '9785462315'),
(4, 'Bansal Retails', 'Kochi', '8975463285'),
(5, 'Mittal Ltd.', 'Lucknow', '7898456532');

INSERT INTO `supplier_pricing` (`pricing_id`, `pro_id`, `supp_id`, `supp_price`) VALUES
(1, 1, 2, 1500),
(2, 3, 5, 30000),
(3, 5, 1, 3000),
(4, 2, 3, 2500),
(5, 4, 1, 1000),
(6, 12, 2, 780),
(7, 12, 4, 789),
(8, 3, 1, 31000),
(9, 1, 5, 1450),
(10, 4, 2, 999),
(11, 7, 3, 549),
(12, 7, 4, 529),
(13, 6, 2, 105),
(14, 6, 1, 99),
(15, 2, 5, 2999),
(16, 5, 2, 2999);

/* (4) Display the total number of customers based on gender who have placed individual order of worth at lease Rs. 3000 */


SELECT c.cus_gender,
    count(distinct c.cus_id) AS Total_Customers
    FROM customer c
    JOIN orders o ON c.cus_id = o.cus_id
    WHERE o.amount >=3000
    GROUP BY c.cus_gender;



/* (5)	Display all the orders along with product name ordered by a customer having Customer_Id=2 */


select p.pro_name, o.* from orders o, supplier_pricing sp, product p
where o.cus_id=2 and
o.pricing_id=sp.pricing_id and sp.pro_id=p.pro_id;


/*
6)	Display the Supplier details who can supply more than one product.
*/

select supplier.* from supplier
where supplier.supp_id in
(select supp_id from supplier_pricing group by supp_id having
count(supp_id)>1)
group by supplier.supp_id;


/*
7)	Find the least expensive product from each category and print the table with category id, name, product name and price of the product
*/


select category.cat_id,category.cat_name, min(t3.min_price) as Min_Price from category inner join
(select product.cat_id, product.pro_name, t2.* from product inner join
(select pro_id, min(supp_price) as Min_Price from supplier_pricing group by pro_id)
as t2 where t2.pro_id = product.pro_id)
as t3 where t3.cat_id = category.cat_id group by t3.cat_id;

/*
8)	Display the Id and Name of the Product ordered after “2021-10-05”.
*/


select product.pro_id as ID,product.pro_name  as ProductName 
from orders 
inner join supplier_pricing 
on supplier_pricing.pricing_id= orders.pricing_id 
inner join product
on product.pro_id=supplier_pricing.pro_id where orders.ord_date>"2021-10-05";

/*
9)	Display customer name and gender whose names start or end with character 'A'.
*/

select customer.cus_name as Customer_Name,customer.cus_gender as Gender 
from customer 
where customer.cus_name like 'A%' or customer.cus_name like '%A';


/*
10)	Create a stored procedure to display supplier id, name, rating and Type_of_Service. For Type_of_Service, If rating =5, print “Excellent Service”,If rating >4 print “Good Service”, If rating >2 print “Average Service” else print “Poor Service”.
*/


    DELIMITER //
CREATE PROCEDURE GetSupplierRatingAndService()
BEGIN
    SELECT
        supplier.supp_id,
        supplier.supp_name,
        AVG(rating.rat_ratstars) AS Avg_Rating,
        CASE
            WHEN AVG(rating.rat_ratstars) = 5 THEN 'Excellent Service'
            WHEN AVG(rating.rat_ratstars) > 4 THEN 'Good Service'
            WHEN AVG(rating.rat_ratstars) > 2 THEN 'Average Service'
            ELSE 'Poor Service'
        END AS Type_of_Service
    FROM
        supplier
    LEFT JOIN supplier_pricing ON supplier.supp_id = supplier_pricing.supp_id
    LEFT JOIN Orders ON supplier_pricing.pricing_id = Orders.pricing_id
    LEFT JOIN rating ON Orders.ord_id = rating.ord_id
    GROUP BY supplier.supp_id, supplier.supp_name;
END //
DELIMITER ;

