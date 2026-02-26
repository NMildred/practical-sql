# 🟢 Level 1 — Foundations

This section tests basic SQL skills and understanding of data structure.

⏱ Recommended time: 20–30 minutes  
🎯 Goal: Learn how to explore data before calculating retention.

---

## 📌 Task 1 — Daily Registrations

How many users registered each day?

**Requirements:**  
- Output the registration date  
- Output the number of users  
- Sort results by date  

**Hint:** Use `GROUP BY signup_date`

---

## 📌 Task 2 — Active Users

How many users performed at least one event?

**Requirements:**  
- Count unique users  
- Use the `events` table  

**Hint:** `COUNT(DISTINCT user_id)`  

⚠️ **Important:** This is NOT retention.

---

## 📌 Task 3 — Share of Returning Users

What share of users performed at least one event after registration?

**Requirements:**  
- Join `users` and `events`  
- Calculate the proportion of users with activity  
- Return a number between 0 and 1  

**Hint:** Use `LEFT JOIN`

---

## 📌 Task 4 — Average Events per User

Calculate the average number of events per user.

**Requirements:**  
- Include only users with events  
- Return a single number  

**Hint:** Think about `GROUP BY + AVG`

---

## 📌 Task 5 — Data Quality Check

Answer in writing:  

- Are there users without events?  
- Are there events without users?  
- What potential data issues might exist?  

This task tests analytical thinking.