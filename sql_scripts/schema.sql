================================================================
-- EcoBank Rwanda Database Schema
-- Course: INSY 8311 - Database Development with PL/SQL
-- Student: ISHIMWE Wycliffe
-- Student ID: 29022
-- Date: 8 February 2025
-- ================================================================
-- ================================================================
-- Table 1: Customers
-- Purpose: Store customer information including account details
-- ================================================================
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    customer_type VARCHAR(20) CHECK (customer_type IN ('Individual', 'Corporate')),
    account_type VARCHAR(20) CHECK (account_type IN ('Savings', 'Current', 'Fixed Deposit')),
    region VARCHAR(50),
    registration_date DATE
);
GO

-- ================================================================
-- Table 2: Branches
-- Purpose: Store branch information across different regions
-- ================================================================
CREATE TABLE Branches (
    branch_id INT PRIMARY KEY,
    branch_name VARCHAR(100) NOT NULL,
    region VARCHAR(50),
    branch_manager VARCHAR(100),
    opening_date DATE
);
GO

-- ================================================================
-- Table 3: Transactions
-- Purpose: Record all banking transactions linking customers and branches
-- ================================================================
CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    branch_id INT NOT NULL,
    transaction_date DATE NOT NULL,
    transaction_type VARCHAR(20) CHECK (transaction_type IN ('Deposit', 'Withdrawal', 'Transfer')),
    amount DECIMAL(15,2) NOT NULL,
    CONSTRAINT fk_customer FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    CONSTRAINT fk_branch FOREIGN KEY (branch_id) REFERENCES Branches(branch_id)
);
GO
