CREATE TABLE credit_portfolio (
    id INT PRIMARY KEY,
    limit_bal NUMERIC(12, 2),
    sex INT CHECK (sex IN (1, 2)),
    education INT CHECK (education IN (0, 1, 2, 3, 4, 5, 6)),
    marriage INT CHECK (marriage IN (0, 1, 2, 3)),
    age INT,
    pay_1 INT, pay_2 INT, pay_3 INT, pay_4 INT, pay_5 INT, pay_6 INT,
    bill_amt1 NUMERIC(12, 2), bill_amt2 NUMERIC(12, 2), bill_amt3 NUMERIC(12, 2),
    bill_amt4 NUMERIC(12, 2), bill_amt5 NUMERIC(12, 2), bill_amt6 NUMERIC(12, 2),
    pay_amt1 NUMERIC(12, 2), pay_amt2 NUMERIC(12, 2), pay_amt3 NUMERIC(12, 2),
    pay_amt4 NUMERIC(12, 2), pay_amt5 NUMERIC(12, 2), pay_amt6 NUMERIC(12, 2),
    is_default INT CHECK (is_default IN (0, 1))
);
SELECT COUNT(*) FROM credit_portfolio;

CREATE OR REPLACE VIEW engineered_risk_features AS
WITH calculated_metrics AS (
    SELECT 
        id,
        limit_bal,
        is_default,
        
        CASE WHEN bill_amt1 < 0 THEN 0.0 ELSE bill_amt1 END AS ead,
        
        (pay_amt1 + pay_amt2 + pay_amt3 + pay_amt4 + pay_amt5 + pay_amt6) AS total_payments,
        
        CASE 
            WHEN (bill_amt1 + bill_amt2 + bill_amt3 + bill_amt4 + bill_amt5 + bill_amt6) < 0 THEN 0.0
            ELSE (bill_amt1 + bill_amt2 + bill_amt3 + bill_amt4 + bill_amt5 + bill_amt6)
        END AS total_billings,
        
        -- Frequency of hitting Stressed thresholds (2+ months late)
        (CASE WHEN pay_1 >= 2 THEN 1 ELSE 0 END +
         CASE WHEN pay_2 >= 2 THEN 1 ELSE 0 END +
         CASE WHEN pay_3 >= 2 THEN 1 ELSE 0 END +
         CASE WHEN pay_4 >= 2 THEN 1 ELSE 0 END +
         CASE WHEN pay_5 >= 2 THEN 1 ELSE 0 END +
         CASE WHEN pay_6 >= 2 THEN 1 ELSE 0 END) AS months_in_delinquency
    FROM credit_portfolio
    WHERE limit_bal > 0 -- Outlier cleaning to drop missing/corrupted limit rows
)
SELECT 
    id,
    limit_bal,
    ead,
    months_in_delinquency,
    is_default,
    
    -- Average Credit Utilization Ratio
    ROUND((total_billings / 6.0) / NULLIF(limit_bal, 0), 4) AS avg_utilization_ratio,
    
    -- Clean Historical Repayment Ratio
    CASE 
        WHEN total_billings <= 0 THEN 1.0  -- If they had no bills, count them as 100% paid
        WHEN total_payments >= total_billings THEN 1.0 -- Cap ratio at 1.0 if they overpaid
        ELSE ROUND(total_payments / total_billings, 4)
    END AS historical_repayment_ratio
FROM calculated_metrics;
