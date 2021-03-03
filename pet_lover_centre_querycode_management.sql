/*
select * from Branch_table;
select * from Branch_manager_table;
select * from Branch_time_table;

select * from Customer_table;
select * from Customer_name_table;

select * from Employee_table;

select *from Manager_table;

select *from Membership_customer_table;
select *from Membership_table;


select *from Order_table;

select *from Payment_table;
Select *from Payment_order_table;

select * from Product_table
select *from Stock_product_table
select *from Stock_table*/

/*----------------------- Basic SQL --------------------------*/
select Branch_name,branch_telephone from Branch_table; -- show the telephone of branch
select * from Branch_table where Branch_name Like '%Central%'; -- search the branches that have the keyword of central
select Branch_name,branch_telephone from Branch_table where Branch_name Like '%central%'; -- Search the Branch telephone that store on Central
select Branch_name, branch_email from Branch_table; -- Show the table of branch that show branch name and Branch email

select C_id,Email from Customer_table; -- Show the Email of Employee
select C_name,C_address from Customer_name_table; --Show the Table of customer name and address
select C_name,Sex from Customer_name_table; -- Show the Sex of Each Customer
select C_name, Citizen_id from Customer_name_table --Show the Citizen number of each customer.
select C_name,Birthday, DATEDIFF(Year, Birthday, GETDATE()) AS age from Customer_name_table order by age -- Show the age of Customer

select em_id,wage from Employee_table; -- Show the wage of employee
select em_id,check_in,check_out,all_hour from Employee_table;
select Firstname,Surname,Birthday, DATEDIFF(Year,Birthday,GETDATE()) AS age from Employee_name_table order by age;

select Manager_name, Education from Manager_table; -- show the table of Education of Manager;
select Manager_name,Experience from Manager_table; -- Show the table of Experience of Manager;
select manager_name, Workplace from Manager_table; -- Show the table of Workplace of Manager;
select manager_id, Manager_name, Experience from Manager_table where Experience ='nope';  -- Shwo the Manager who don't have the experience;

select C_id,Mem_number from Membership_customer_table;
select c_id, Mem_firstdate,Mem_enddate from Membership_customer_table;

select Order_id, order_status from Order_table; -- Show the Order Status
select  SUM(Net_price) as Sum_net_price from Order_table  -- Show the Sum of Net price

select *from Payment_table where pm_type = 'Prompay' -- Show the payment table that use the prompay to paid
select *from Payment_table where pm_type = 'Cash' -- Show the payment table that uset the Cash to paid
select Pm_id,Cash_date,Pm_type from Payment_table -- show the Cashdate of each payment and type of paid
select order_id, Amount  from Payment_order_table where amount>5000  -- Show the amount in Order that more than 5000 



/*--------------------------------------------------------------*/
/*-------------------------- Adv SQL----------------------------*/
--Show the Name of Manager Of each Branch
select branch_name,Manager_name,Manager_table.Manager_id from Branch_table inner join Manager_table on Branch_table.Manager_id = Manager_table.Manager_id;
-- Show the table of working time of each branch and location
select branch_table.Branch_name,Branch_time_table.Working_day,Branch_table.Branch_location,Branch_time_table.Working_hour from Branch_table inner join branch_time_table on Branch_table.Branch_name = Branch_time_table.Branch_name; 

-- Show the Customer telephone and Show the name of Customer 
Select Customer_name_table.C_name, Phone_number from Customer_name_table full outer join  Customer_table on Customer_name_table.Citizen_id = Customer_table.Citizen_id;
-- Show the Customer name and email other table 
Select Customer_name_table.C_name, Email from Customer_name_table left join Customer_table on Customer_name_table.Citizen_id = Customer_table.Citizen_id;

-- Table Show the Name and Phone_number of  Employee table
select Firstname,Surname,Phone_number from Employee_name_table inner join Employee_table on Employee_name_table.Citizen_id = Employee_table.Citizen_id;
-- table show the name and email of Employee
select em_id,Firstname,Surname, email from Employee_table right join Employee_name_table on Employee_name_table.Citizen_id = Employee_table.Citizen_id;
-- table show the name and Sex of Employee
select em_id,Firstname,Surname,Sex from Employee_table inner join Employee_name_table on Employee_name_table.Citizen_id = Employee_table.Citizen_id;

----- Show the table of Customer with Membership number
SELECT Membership_table.C_id, C_name, Mem_number
FROM Membership_table INNER JOIN (
	SELECT Customer_name_table.Citizen_id, C_name, Sex, C_address, C_id, Phone_number, Email
	FROM Customer_name_table INNER JOIN Customer_table
	ON Customer_name_table.Citizen_id = Customer_table.Citizen_id
) AS Customer_detail
ON Membership_table.C_id = Customer_detail.C_id;

----- Show the detail of manager table base on the employee table
SELECT Manager_id,Em_id, Manager_name, Education, Experience, Workplace, Work_hours, Wage, Phone_number, Email
FROM Manager_table INNER JOIN (
	SELECT CONCAT(Firstname, ' ', Surname) AS Employee_full_name,Em_id, Wage, Phone_number, Email
	FROM Employee_name_table INNER JOIN Employee_table
	ON Employee_name_table.Citizen_id = Employee_table.Citizen_id
) AS Employee_full
ON Manager_name = Employee_full.Employee_full_name;

-- Show the detail of paymeny method with date of customer and Order_id
select Pm_id,Order_id,C_id,C_name,Pm_type,Pm_status from Customer_name_table inner join
 (
   select Customer_table.C_id,Pm_id,Order_id,Pm_type,Pm_status,Citizen_id from Customer_table inner join
 (
   select pm_id, Cash_date,Pm_type,bank_transfer_status,Payment_order_table.Order_id,Amount,Pm_status,c_id
   from payment_table inner join Payment_order_table on payment_table.Order_id= Payment_order_table.Order_id
 )as Pm_name_full
    on Customer_table.C_id = Pm_name_full.c_id

 ) as Pm_cus
 On Customer_name_table.Citizen_id = Pm_cus.Citizen_id;



-- Show the stock with name of product and each Stock loaction ,catacity type and status
select  Stock_product_table.S_id,P_name,S_name,S_location,S_capacity,S_type,S_status from Stock_table inner join Stock_product_table on Stock_table.S_id = Stock_product_table.S_id

-- Product datail with Stock status
select P_id,product_table.S_id,P_name,P_type,P_detail,P_price,S_name,S_location,S_capacity,S_status from Product_table inner join Stock_table on Product_table.S_id = Stock_table.S_id
-- Product dail with Stock status with stock status out of stock
select P_id,product_table.S_id,P_name,P_type,P_detail,P_price,S_name,S_location,S_capacity,S_status from Product_table inner join Stock_table on Product_table.S_id = Stock_table.S_id where S_status = 'out of stock'
-- Product dail with Stock status with stock in caoacity of stock less than 500
select P_id,product_table.S_id,P_name,P_type,P_detail,P_price,S_name,S_location,S_capacity,S_status from Product_table inner join Stock_table on Product_table.S_id = Stock_table.S_id where S_capacity <500

/*--------------------------------------------------------------*/

