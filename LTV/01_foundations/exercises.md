# 🟢 Level 1 — Foundations

**Beginner level:** Historical LTV calculation per user  

⏱ **Recommended time:** 20–30 minutes  
🎯 **Goal:** Learn to calculate net profit (LTV) per user using production-style data

---

## 📌 Task 1 — Historical LTV per User

**Goal:** Calculate net profit for each user.  

**Instructions:**

1. Use the `orders` table  
2. Consider only **non-refunded orders** (`refunded = 0`)  
3. Profit = `revenue - cost`  
4. Group by `user_id`  
5. Sort by LTV in **descending order**  

**Hint:**  
- Use `SUM(if(refunded = 0, revenue - cost, 0))`  

---

## 📌 Task 2 — Top 5 Users by LTV

**Goal:** Identify the most valuable users.  

**Instructions:**

1. Reuse the LTV calculation from Task 1  
2. Sort in descending order  
3. Limit the result to **top 5 users**

**Hint:**  
- Add `LIMIT 5` at the end  
- Ensure sorting by LTV in descending order  

---

## 📌 Task 3 — Data Check (Written)

Answer the following questions:

1. Are there users with **zero LTV**? Why?  
2. Are there users with **negative profit**? How does it happen?  
3. How do **refunds** affect the overall LTV?  
4. What **potential issues** might exist in this LTV calculation?  

**Hint:**  
- Think about users with no orders  
- Consider cases where `cost > revenue`  
- Consider outliers and refunds