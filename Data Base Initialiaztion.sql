CREATE DATABASE Bank;
USE Bank;
Create Table Customers(
customer_id INT AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(50) ,
last_name VARCHAR(50) ,
date_of_birth date,
national_id VARCHAR(20) UNIQUE NOT NULL,
Phone VARCHAR(20),
email Varchar(100) UNIQUE,
address VARCHAR(255),
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

create table Branches(
branch_id INT AUTO_INCREMENT PRIMARY KEY,
barnch_name VARCHAR(50) NOT NULL,
city VARCHAR(50),
address VARCHAR(255),
phone VARCHAR(20)
);

CREATE TABLE Employees(
employee_id INT auto_increment primary KEY,
first_name VARCHAR(50) NOT NULL ,
last_name VARCHAR(50) NOT NULL,
position VARCHAR(50),
salary decimal(10,2) NOT NULL,
hire_date DATE,
branch_id INT ,
foreign key(branch_id)
references Branches(branch_id) ON DELETE SET NULL
);

CREATE TABLE Accounts(
account_id INT auto_increment primary KEY,
customer_id int,
branch_id INT ,
account_type VARCHAR(50) NOT NULL,
balance decimal(15,2) NOT NULL,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
status VARCHAR(20) DEFAULT 'Active',
foreign key(branch_id)
references Branches(branch_id) ON DELETE SET NULL,
FOREIGN KEY(customer_id)
references Customers(customer_id)ON DELETE SET NULL
);

CREATE TABLE Transfers(
transfer_id INT auto_increment PRIMARY KEY,
from_account_id int,
to_account_id int,
transfer_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
amount DECIMAL(15,2) NOT NULL,
status varchar(20) DEFAULT 'Completed',
foreign key(from_account_id )
references Accounts(account_id) ON DELETE SET NULL,
FOREIGN KEY(to_account_id)
references Accounts(account_id) ON DELETE SET NULL
);

CREATE TABLE Transactions(
transaction_id INT AUTO_INCREMENT PRIMARY KEY ,
account_id INT,
transaction_type VARCHAR(20) NOT NULL,
transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
amount Decimal(15,2) Not Null,
description Varchar(255),
foreign key(account_id)
references Accounts(account_id) ON DELETE SET NULL
);

CREATE TABLE Cards(
card_id INT AUTO_INCREMENT PRIMARY KEY,
account_id INT,
card_number INT(20) unique NOT NULL,
Card_type VARCHAR(20) not null,
expiry_date date not null,
cvv INT(4) NOT NULL,
status VARCHAR(20) DEFAULT 'Active',
foreign key(account_id)
references Accounts(account_id) ON DELETE SET NULL
);

CREATE TABLE Loans(
loan_id INT AUTO_INCREMENT PRIMARY KEY,
customer_id int,
loan_amount DECIMAL(15,2) NOT NULL,
interest_rate DECIMAL(5,2) NOT NULL,
start_Date DATE NOT NULL,
end_date DATE NOT NULL,
status VARCHAR(20) DEFAULT'Active',
foreign key(customer_id)
references Customers(customer_id) ON DELETE SET NULL
);

Create Table Loan_Payments(
payment_id INT AUTO_INCREMENT PRIMARY KEY,
loan_id INT,
amount DECIMAL(15,2) NOT NULL,
payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
foreign key(loan_id)
references Loans(loan_id) ON DELETE SET NULL
);