# 🟡 Level 2 — Cohort Analysis & Average LTV

**Intermediate level:** Analyze LTV by user cohorts  

⏱ **Recommended time:** 30–40 minutes  
🎯 **Goal:** Learn to calculate LTV per user cohort and average LTV

---

## 📌 Task 1 — LTV per User with Cohorts

**Goal:** Calculate LTV for each user along with their cohort month.  

**Instructions:**

1. Use the `orders` and `users` tables  
2. Consider only **non-refunded orders**  
3. Profit = `revenue - cost`  
4. Assign each user to a **cohort month** using `signup_date`  
5. Group by `user_id` and `cohort_month`  
6. Sort by `cohort_month` and LTV descending  

**Hint:**  
- Use `toStartOfMonth(u.signup_date)` for cohort month  
- Join `orders` and `users` on `user_id`

---

## 📌 Task 2 — Average LTV per Cohort

**Goal:** Calculate **average and median LTV** per cohort month.  

**Instructions:**

1. Use the LTV per user calculation from Task 1  
2. Group by `cohort_month`  
3. Calculate:
   - Average LTV: `AVG(ltv)`  
   - Median LTV: `quantile(0.5)(ltv)`  
4. Sort by `cohort_month` ascending  

**Hint:**  
- Consider using a **CTE or subquery** to calculate per-user LTV first  
- Median LTV helps handle outliers

---

## 📌 Task 3 — Cohort Insights (Written)

Answer the following questions:

1. Which cohort month has the highest **average LTV**?  
2. Are there cohorts with unusually **high or low LTV**? Why?  
3. How could refunds affect cohort-level LTV?  
4. Why is **median LTV** sometimes better than average LTV?