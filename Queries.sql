-- Ahmed Salama 
-- List all customers (First and Last name) who were born before the year 1990.
SELECT first_name, last_name
FROM Customers
Where year(date_of_birth)>1990;
-- Find all active accounts with a balance greater than 50,000.
SELECT *
FROM Accounts 
Where status='Active' AND balance >50000;
-- Show all branches located in 'Cairo' or 'Giza'.
SELECT * 
FROM Branches 
Where city IN ('Cairo','Giza');
-- List the employees who were hired in 2021, showing their names and positions.
SELECT concat(first_name," ", last_name) AS full_name, position 
FROM Employees
WHERE YEAR(hire_date)=2021;
-- Find all transactions of type 'Withdrawal' where the amount is more than 2,000.
SELECT * 
FROM Transactions
WHERE transaction_type='Withdrawal' AND amount >2000;
-- Count how many customers the bank has in each city.
Select count(*),substring_index(address,',',1) as city
from Customers
group by city;
-- Calculate the total balance of all accounts combined.
SELECT SUM(balance)
from Accounts;
-- Find the average salary of employees for each branch (show Branch ID and Average Salary).
SELECT branch_id,AVG(salary)
FROM Employees
GROUP BY branch_id
-- Get the maximum and minimum loan amounts ever given by the bank.
SELECT MAX(loan_amount), MIN(loan_amount)
FROM Loans
-- Find the total amount of loan payments made for each loan_id.
SELECT loan_id, SUM(amount) 
From Loan_Payments
group by loan_id
-- Show the full name of each customer alongside their account type and balance.
SELECT CONCAT(c.first_name, " ",c.last_name) as Full_name ,account_type, balance
FROM Accounts as a
LEFT join Customers as c
ON a.customer_id=c.customer_id;
-- List all employees and the name of the branch they work in.
SELECT CONCAT(e.first_name, " ",e.last_name) as full_name, barnch_name
FROM Employees as e
 Join Branches as b
ON b.branch_id=e.branch_id;
-- Retrieve all transfers, showing the From_Account_ID, To_Account_ID, and the Amount, but include the Sender's First Name.
SELECT from_account_id, to_account_id, amount, e.first_name
FROM Transfers
JOIN Accounts AS a ON t.from_account_id = a.account_id
JOIN Customers AS c ON a.customer_id = c.customer_id;
-- Find all customers who have a loan, showing their name, loan amount, and interest rate.
SELECT l.loan_id, c.first_name,c.last_name, l.loan_amount, l.interest_rate
FROM loans as l
left join Customers as c 
ON l.customer_id=c.customer_id;
-- List all cards and the owner's email associated with each card's account.
SELECT ca.card_id,ca.account_id,ca.card_number, ca.Card_type,ca.expiry_date, ca.cvv,ca.status,c.email
from Cards as ca
left join accounts as a
on ca.account_id=a.account_id
left join customers as c
on c.customer_id=a.customer_id
-- Level 4: Advanced Joins & Filtering
-- Find the names of customers who have accounts in the 'Main Branch'.
SELECT CONCAT(c.first_name, " ",c.last_name) as full_name, b.city
from Customers as c
join accounts as a
on a.customer_id=c.customer_id
join branches as b
on b.branch_id=a.branch_id
where b.city='Cairo';
-- Show all transactions made by customers living in 'Alexandria'.
SELECT t.transaction_id,t.account_id,t.transaction_type,t.transaction_date,t.amount,t.description,address
from transactions as t
join accounts as a
on t.account_id=a.account_id
join customers as c
on c.customer_id=a.customer_id
where substring_index(address,',',1) ='Alexandria';
-- List branches that have more than 5 employees.
SELECT Distinct b.branch_id,count(employee_id)
FROM Branches as b
JOIN Employees as e
on b.branch_id=e.branch_id
group by b.branch_id
HAVING count(employee_id)>5;
-- Retrieve a list of loans and the total amount paid so far for each loan (Join Loans and Loan_Payments).
SELECT l.loan_id, SUM(p.amount)  as Total_Amount
FROM Loans as l
LEFT JOIN loan_payments as p
on p.loan_id=l.loan_id
group by l.loan_id;
-- Show all accounts that have never made a single transaction (Hint: Use Left Join and check for NULL).
SELECT a.account_id, transaction_id,t.account_id FROM Accounts as a
LEFT JOIN Transactions as t
ON t.account_id=a.account_id
WHERE t.account_id IS NULL;
-- Level 5: Subqueries & Complex Logic (The Pro Level)
-- Find the names of customers whose account balance is higher than the average balance of all accounts.
SELECT CONCAT(c.first_name," ",c.last_name) as Full_name,a.balance
FROM Customers AS c
Join Accounts as a
ON a.customer_id=c.customer_id
where a.balance > (SELECT AVG(balance) FROM Accounts );
-- List the employees who earn a salary higher than the salary of the manager in 'Main Branch' (Branch ID 1).
SELECT first_name, last_name , position, salary 
FROM Employees 
WHERE salary > (Select salary from Employees Where position='Manager' AND branch_id =1);
-- Show the details of the last transaction made for each account (Use a subquery to find the max transaction_date).
SELECT * FROM Transactions
Where (account_id,transaction_date) IN (SELECT account_id,MAX(transaction_date) FROM Transactions GROUP BY account_id );
-- Identify customers who have both an active Loan AND an active Credit Card.
SELECT c.customer_id, c.first_name,c.last_name,l.status,ca.status FROM Customers as c
join Loans as l
on l.customer_id=c.customer_id
Join accounts as a
on a.customer_id=c.customer_id
join Cards as ca 
on ca.account_id=a.account_id
where l.status='Active' AND ca.status='Active' ;
