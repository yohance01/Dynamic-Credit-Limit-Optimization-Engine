# Dynamic-Credit-Limit-Optimization-Engine
DYNAMIC CREDIT LIMIT OPTIMIZATION ENGINE

###  Tech Stack
* **Database:** PostgreSQL
* **Languages & Core Libraries:** Python, Pandas, NumPy
* **Machine Learning:** XGBoost, Scikit-learn
* **Visualization:** Matplotlib, Seaborn

---

###  The Problem
Banks struggle to balance profitability and default risk. If credit limits are kept too high for risky customers, the bank suffers massive financial losses from defaults. However, blindly cutting credit lines shrinks the bank's active portfolio footprint and can cause deceptive shifts in net risk metrics without fixing the consumer's core financial distress.

---

###  Core Terms Explained Simply

* **Probability of Default (PD):** The statistical likelihood or chance that a customer will fail to pay back their debt over a set period.
* **Exposure at Default (EAD):** The total dollar amount a customer owes the bank at the exact moment they default.
* **Loss Given Default (LGD):** The actual percentage of money the bank permanently loses if a customer defaults (after attempting collections or recovery).
* **Expected Credit Loss (ECL):** The predicted dollar amount the bank expects to lose from defaults, calculated as: **ECL = PD × LGD × EAD**

---

###  Our Strategic Approaches

1. **Approach 1 — The Uncalibrated "Crush" Strategy (The Trap):** We attempted to aggressively slash credit limits down to current outstanding balances for any customer crossing a flat 15% annual risk threshold. This caused the net portfolio risk rate to artificially jump to **49.17%** due to *denominator shrinkage*—meaning we removed billions in available credit lines from our books while outstanding debt balances remained unchanged.
2. **Approach 2 — The Calibrated Bidirectional Playbook (The Balanced Fix):** We used relative statistical quantiles to isolate the top 15% highest-risk accounts and the bottom 50% safest accounts. We froze the high-risk accounts to block balance run-ups while safely granting a +20% limit expansion to active, low-risk customers. This stabilized the portfolio risk rate at a healthy **15.87%**.

---

###  Future Recommendations

Because adjusting credit lines on a screen cannot magically rewrite a consumer's underlying financial health, the remaining baseline risk must be minimized through cross-functional operational programs:

* **Balance Restructuring (The Good Debt Swap):** Transition high-risk, revolving card balances into structured, fixed-term personal installment loans to freeze additional re-borrowing capacity and stabilize payment collections.
* **Real-Time Transaction Authorization Rules:** Code point-of-sale programmatic blocks to dynamically decline transactions at high-liquidity merchants (e.g., casinos, ATMs, luxury retailers) for users tracking in high-risk deciles.
* **Asset Securitization:** Pool the absolute highest-risk distressed segments and sell off the debt pools to secondary market investors at an upfront discount, removing default volatility from the bank's balance sheet entirely.
