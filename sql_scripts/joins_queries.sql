-- 1. INNER JOIN
-- Purpose: Retrieve all transactions with customer and branch details
-- Business Use: Show all valid transactions with complete information
-- ================================================================
SELECT 
    t.transaction_id,
    c.customer_name,
    c.account_type,
    b.branch_name,
    b.region,
    t.transaction_date,
    t.transaction_type,
    t.amount
FROM Transactions t
INNER JOIN Customers c ON t.customer_id = c.customer_id
INNER JOIN Branches b ON t.branch_id = b.branch_id
ORDER BY t.transaction_date DESC;

-- Interpretation:
-- This query shows all 30 completed transactions with full customer and branch 
-- information. It shows that corporate customers like TechHub Ltd and AgriCoop Rwanda 
-- have significantly higher transaction amounts (averaging 2.5M RWF) compared to 
-- individual customers (averaging 450K RWF). 

GO

-- ================================================================
-- 2. LEFT JOIN
-- Purpose: Identify customers with no transactions (inactive accounts)
-- Business Use: Find customers who need re-engagement campaigns
-- ================================================================
SELECT 
    c.customer_id,
    c.customer_name,
    c.customer_type,
    c.account_type,
    c.region,
    c.registration_date,
    COUNT(t.transaction_id) as total_transactions
FROM Customers c
LEFT JOIN Transactions t ON c.customer_id = t.customer_id
GROUP BY c.customer_id, c.customer_name, c.customer_type, c.account_type, c.region, c.registration_date
HAVING COUNT(t.transaction_id) = 0
ORDER BY c.registration_date;

-- Interpretation:
-- This query provides 8 customers who registered accounts however they havent  made 
-- any transactions. These inactive accounts represent missed revenue opportunities 
-- and should be targeted for re-engagement campaigns.

GO

-- ================================================================
-- 3. RIGHT JOIN
-- Purpose: Identify branches with no transaction activity
-- Business Use: Find underperforming branches that need attention
-- ================================================================
SELECT 
    b.branch_id,
    b.branch_name,
    b.region,
    b.branch_manager,
    COUNT(t.transaction_id) as total_transactions,
    ISNULL(SUM(t.amount), 0) as total_amount
FROM Transactions t
RIGHT JOIN Branches b ON t.branch_id = b.branch_id
GROUP BY b.branch_id, b.branch_name, b.region, b.branch_manager
HAVING COUNT(t.transaction_id) = 0
ORDER BY b.region, b.branch_name;

-- Interpretation:
-- This query describes  3 branches (Gicumbi, Kayonza, and Kirehe) that have  
-- zero transactions despite being open and functioning.  Management should dive in and have a look  whether these branches need additional 
-- marketing support, staff training, or potential closure to optimize resources.

GO

-- ================================================================
-- 4. FULL OUTER JOIN
-- Purpose: Complete view of all customers and branches including unmatched
-- Business Use: Comprehensive business intelligence overview
-- ================================================================
SELECT 
    c.customer_name,
    c.customer_type,
    c.region as customer_region,
    b.branch_name,
    b.region as branch_region,
    t.transaction_id,
    t.transaction_date,
    t.amount
FROM Customers c
FULL OUTER JOIN Transactions t ON c.customer_id = t.customer_id
FULL OUTER JOIN Branches b ON t.branch_id = b.branch_id
ORDER BY 
    CASE 
        WHEN t.transaction_id IS NULL THEN 1 
        ELSE 0 
    END,
    t.transaction_date DESC;

-- Interpretation:
-- This comprehensive query shows all customers and branches regardless of transaction 
-- history. It reveals both active relationships (customers with transactions at specific 
-- branches) and gaps ot space for improvement in the business (inactive customers and underutilized branches). 
-- This full view is essential for strategic planning, aiding management to  identify 
-- which customer-branch combinations are performing well and which need attention or restructuring.

GO

-- ================================================================
-- 5. SELF JOIN
-- Purpose: Compare customers within the same region
-- Business Use: Identify regional customer clusters for referral programs
-- ================================================================
SELECT 
    c1.customer_name AS Customer_1,
    c2.customer_name AS Customer_2,
    c1.region AS Shared_Region,
    c1.customer_type AS Customer1_Type,
    c2.customer_type AS Customer2_Type,
    c1.account_type AS Customer1_Account,
    c2.account_type AS Customer2_Account
FROM Customers c1
INNER JOIN Customers c2 
    ON c1.region = c2.region 
    AND c1.customer_id < c2.customer_id
ORDER BY c1.region, c1.customer_name;

-- Interpretation:
-- This query provides customer pairs within the same places, useful for analyzing 
-- regional market density and potential referral opportunities.  This analysis can help design region-specific  programs where 
-- existing customers refer others in their area, or identify regions with low customer 
-- density that need targeted advertisements campaigns.

GO
