# 🔵 Level 3 — Retention × LTV & Predictive LTV

**Advanced level:** Build retention matrices and predictive LTV  

⏱ **Recommended time:** 40–50 minutes  
🎯 **Goal:** Understand retention dynamics and forecast LTV

---

## 📌 Task 1 — Retention Matrix per Cohort

**Goal:** Calculate user retention per cohort by lifetime month.  

**Instructions:**

1. Use `orders` and `users` tables  
2. Assign cohort month using `signup_date`  
3. Calculate **lifetime month** for each order:  
   - `lifetime_month = dateDiff('month', cohort_month, order_month)`  
4. Count **distinct users** retained in each lifetime month  
5. Optionally, calculate **retention rate** per cohort  

**Hint:**  
- Use a **cohort_sizes CTE** to get total users per cohort  
- Retention rate = `retained_users / cohort_size`

---

## 📌 Task 2 — LTV per Retained User

**Goal:** For each cohort and lifetime month, calculate **average LTV per retained user**.  

**Instructions:**

1. Sum profit per retained user: `revenue - cost` (non-refunded only)  
2. Divide cumulative profit by number of retained users  
3. Group by `cohort_month` and `lifetime_month`  

**Hint:**  
- Combines retention and LTV into one matrix  
- Good for **heatmap visualization**

---

## 📌 Task 3 — Predictive LTV

**Goal:** Forecast future LTV per cohort using historical data.  

**Instructions:**

1. Use historical LTV per user and per cohort  
2. Build **cumulative LTV** by lifetime month  
3. Apply a simple predictive model:
   - For example, exponential decay: `predictive_ltv = avg_ltv * exp(-0.1 * lifetime_month)`  
4. Compare cumulative vs predicted LTV  

**Hint:**  
- Even simple predictive formulas illustrate retention decay  
- Can be enhanced with statistical or ML models in production

---

## 📌 Task 4 — Retention & LTV Insights (Written)

Answer the following questions:

1. Which cohort shows the **best retention over time**?  
2. How does retention correlate with average LTV?  
3. What patterns do you notice in **early vs late lifetime months**?  
4. How could you improve predictive LTV models using more data?