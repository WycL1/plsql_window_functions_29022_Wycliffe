CATEGORY 1: RANKING FUNCTIONS
-- Functions: RANK(), DENSE_RANK(), ROW_NUMBER(), PERCENT_RANK()
-- ================================================================

-- Query 1A: Rank branches by total transaction amount per region
SELECT 
    b.region,
    b.branch_name,
    COUNT(t.transaction_id) as total_transactions,
    SUM(t.amount) as total_amount,
    -- Different ranking functions
    RANK() OVER (PARTITION BY b.region ORDER BY SUM(t.amount) DESC) as rank_amount,
    DENSE_RANK() OVER (PARTITION BY b.region ORDER BY SUM(t.amount) DESC) as dense_rank_amount,
    ROW_NUMBER() OVER (PARTITION BY b.region ORDER BY SUM(t.amount) DESC) as row_num
FROM Branches b
LEFT JOIN Transactions t ON b.branch_id = t.branch_id
GROUP BY b.region, b.branch_name, b.branch_id
ORDER BY b.region, rank_amount;

-- Interpretation:
-- This query ranks branches in region by transaction volume. In Kigali , 
-- Gasabo Branch leads #1 with 4.7M RWF in transactions, followed by Nyarugenge ranks #2 with 
-- 4.05M RWF. The three ranking functions behave differently: RANK() can have gaps 
-- in numbering when there are ties, DENSE_RANK() also no gaps, and ROW_NUMBER() assigns 
-- unique numbers even for ties. This gives a very good indication to management as to identify branch rankings that are truly on top. 
-- in every region for best practice sharing.

GO

-- Query 1B: Rank top customers by total spending
SELECT 
    c.customer_name,
    c.customer_type,
    c.region,
    SUM(t.amount) as total_spent,
    RANK() OVER (ORDER BY SUM(t.amount) DESC) as customer_rank,
    PERCENT_RANK() OVER (ORDER BY SUM(t.amount) DESC) as percentile_rank
FROM Customers c
INNER JOIN Transactions t ON c.customer_id = t.customer_id
GROUP BY c.customer_name, c.customer_type, c.region, c.customer_id
ORDER BY customer_rank;

-- Interpretation:
-- This identifies top customers by total transaction value. AgriCoop Rwanda leads 
-- with 6.7M RWF, followed by BuildCo Ltd (5.5M RWF) and TechHub Ltd (4.8M RWF). All 
-- top three are corporate customers, confirming that corporate accounts generate 
-- significantly higher value. The PERCENT_RANK shows that AgriCoop is in the top 
-- 8% of all customers, making them critical VIP accounts requiring dedicated 
-- relationship management.

GO

-- ================================================================
-- CATEGORY 2: AGGREGATE WINDOW FUNCTIONS
-- Functions: SUM(), AVG(), MIN(), MAX() with OVER clause
-- Uses: ROWS and RANGE frames
-- ================================================================

-- Query 2A: Running total of monthly transactions (cumulative revenue)
SELECT 
    YEAR(transaction_date) as year,
    MONTH(transaction_date) as month,
    DATENAME(MONTH, transaction_date) as month_name,
    COUNT(transaction_id) as monthly_transactions,
    SUM(amount) as monthly_revenue,
    -- Running total using ROWS frame
    SUM(SUM(amount)) OVER (ORDER BY YEAR(transaction_date), MONTH(transaction_date) 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as running_total,
    -- Average using RANGE frame (3-month moving average)
    AVG(SUM(amount)) OVER (ORDER BY YEAR(transaction_date), MONTH(transaction_date) 
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) as three_month_avg
FROM Transactions
GROUP BY YEAR(transaction_date), MONTH(transaction_date), DATENAME(MONTH, transaction_date)
ORDER BY year, month;

-- Interpretation:
-- This shows cumulative revenue growth over montsh and years. By Jan 2025, total cumulative 
-- revenue reached 33.83M RWF. The running total describes consistent growth with 
-- Dec 2024 showing the top monthly revenue (15.78M RWF) due to year-end 
-- corporate transactions. The three-month moving average helps smooth out monthly 
-- fluctuations and reveals an upward trend, indicating healthy business expansion.

GO

-- Query 2B: Branch performance with aggregate comparisons
SELECT 
    b.branch_name,
    b.region,
    COUNT(t.transaction_id) as branch_transactions,
    ISNULL(SUM(t.amount), 0) as branch_total,
    -- Aggregate functions over partitions
    SUM(COUNT(t.transaction_id)) OVER (PARTITION BY b.region) as region_total_transactions,
    SUM(SUM(t.amount)) OVER (PARTITION BY b.region) as region_total_amount,
    AVG(SUM(t.amount)) OVER (PARTITION BY b.region) as region_avg_amount,
    MAX(SUM(t.amount)) OVER (PARTITION BY b.region) as region_max_amount,
    MIN(SUM(t.amount)) OVER (PARTITION BY b.region) as region_min_amount
FROM Branches b
LEFT JOIN Transactions t ON b.branch_id = t.branch_id
GROUP BY b.branch_name, b.region, b.branch_id
ORDER BY b.region, branch_total DESC;

-- Interpretation:
-- This compares each branch against regional performance metrics.  The window 
-- functions help us to see both individual-branch performance and regional context 
-- simultaneously, helping identify branches that need improvement versus those that 
-- can serve as regional models.

GO

-- ================================================================
-- CATEGORY 3: NAVIGATION FUNCTIONS
-- Functions: LAG(), LEAD()
-- Purpose: Period-to-period comparisons
-- ================================================================

-- Query 3A: Month-over-month transaction growth
SELECT 
    YEAR(transaction_date) as year,
    MONTH(transaction_date) as month,
    DATENAME(MONTH, transaction_date) as month_name,
    COUNT(transaction_id) as transaction_count,
    SUM(amount) as monthly_revenue,
    -- Previous month data using LAG
    LAG(SUM(amount), 1) OVER (ORDER BY YEAR(transaction_date), MONTH(transaction_date)) as previous_month_revenue,
    -- Next month data using LEAD
    LEAD(SUM(amount), 1) OVER (ORDER BY YEAR(transaction_date), MONTH(transaction_date)) as next_month_revenue,
    -- Calculate growth percentage
    CASE 
        WHEN LAG(SUM(amount), 1) OVER (ORDER BY YEAR(transaction_date), MONTH(transaction_date)) IS NOT NULL 
        THEN ROUND(((SUM(amount) - LAG(SUM(amount), 1) OVER (ORDER BY YEAR(transaction_date), MONTH(transaction_date))) 
             / LAG(SUM(amount), 1) OVER (ORDER BY YEAR(transaction_date), MONTH(transaction_date)) * 100), 2)
        ELSE NULL
    END as growth_percentage
FROM Transactions
GROUP BY YEAR(transaction_date), MONTH(transaction_date), DATENAME(MONTH, transaction_date)
ORDER BY year, month;

-- Interpretation:
-- This analysis reveals transaction growth patterns across months. November 2024 
-- showed 75.8% growth compared to October, while December experienced an impressive 
-- 128.4% surge driven by year-end corporate activities. January 2025 showed modest 
-- 7.6% growth, indicating a return to normal patterns after holiday seasonality. 
-- The LAG function enables direct comparison with prior periods, helping predict 
-- future trends and identify seasonal patterns critical for resource planning.

GO

-- Query 3B: Customer transaction frequency comparison
SELECT 
    c.customer_name,
    t.transaction_date as current_transaction_date,
    t.amount as current_amount,
    LAG(t.transaction_date, 1) OVER (PARTITION BY c.customer_name ORDER BY t.transaction_date) as previous_transaction_date,
    LAG(t.amount, 1) OVER (PARTITION BY c.customer_name ORDER BY t.transaction_date) as previous_amount,
    -- Days between transactions
    DATEDIFF(DAY, 
        LAG(t.transaction_date, 1) OVER (PARTITION BY c.customer_name ORDER BY t.transaction_date),
        t.transaction_date) as days_since_last_transaction,
    -- Amount change
    t.amount - LAG(t.amount, 1) OVER (PARTITION BY c.customer_name ORDER BY t.transaction_date) as amount_change
FROM Customers c
INNER JOIN Transactions t ON c.customer_id = t.customer_id
ORDER BY c.customer_name, t.transaction_date;

-- Interpretation:
-- This tracks individual customer  patterns over time. Customers like 
-- Kamanzi David show consistent high-value transactions every 2+ months, indicating 
-- regular business cycles. In contrast, Uwera Claudine shows increasing transaction 
-- frequency (from 71 to 56 days between visits) and rising  amounts, suggesting 
-- deepening engagement. These insights supports the management to  tailor customer relationship within individual strategies, 
-- identifying which customers need receding efforts versus those showing organic rise.

GO

-- ================================================================
-- CATEGORY 4: DISTRIBUTION FUNCTIONS
-- Functions: NTILE(), CUME_DIST()
-- Purpose: Customer segmentation and percentile analysis
-- ================================================================

-- Query 4A: Segment customers into 4 quartiles by spending
SELECT 
    c.customer_name,
    c.customer_type,
    c.region,
    COUNT(t.transaction_id) as total_transactions,
    SUM(t.amount) as total_spent,
    -- Divide customers into 4 equal groups (quartiles)
    NTILE(4) OVER (ORDER BY SUM(t.amount) DESC) as customer_quartile,
    -- Cumulative distribution (percentage of customers below this one)
    ROUND(CUME_DIST() OVER (ORDER BY SUM(t.amount) DESC) * 100, 2) as cumulative_percent
FROM Customers c
INNER JOIN Transactions t ON c.customer_id = t.customer_id
GROUP BY c.customer_name, c.customer_type, c.region, c.customer_id
ORDER BY total_spent DESC;

-- Interpretation:
-- This segments customers into four quartiles based on their spending. Quartile 1 
-- have high-rise customers (AgriCoop Rwanda, BuildCo Ltd, TechHub Ltd) who have 
-- spent over 4.8M RWF and represent the top 1/4 above by value. These  customers should 
-- be treated within a high level compared to lower-Quartile. 
-- Quartile 4 customers represent opportunities for upselling and engagement campaigns 
-- to move them into higher value segments.

GO

-- Query 4B: Distribution by region and account type
SELECT 
    c.region,
    c.customer_name,
    c.account_type,
    SUM(t.amount) as total_spent,
    -- Create 4 groups WITHIN each region
    NTILE(4) OVER (PARTITION BY c.region ORDER BY SUM(t.amount) DESC) as regional_quartile,
    -- Cumulative distribution within region
    ROUND(CUME_DIST() OVER (PARTITION BY c.region ORDER BY SUM(t.amount) DESC) * 100, 2) as regional_cumulative_percent
FROM Customers c
INNER JOIN Transactions t ON c.customer_id = t.customer_id
GROUP BY c.region, c.customer_name, c.account_type, c.customer_id
ORDER BY c.region, total_spent DESC;

-- Interpretation:
-- This creates region-specific customer groups, identifying top performers within 
-- each geographic area rather than nationally. For example, in the Kigali , 
-- TechHub Ltd ranks in Quartile 1 , while smaller customers in other regions 
-- can also reach  Quartile 1 status within their region. This regional segmentation 
-- enables customized-specialized marketing strategies that assists for different market sizes and 
-- economic conditions across regions.

GO
