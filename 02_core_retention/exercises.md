# 🟡 Level 2 — Core Retention (Cohort Analysis)

This section tests your ability to build cohort analysis and calculate weekly retention.

⏱ Recommended time: 40–60 minutes  
🎯 Goal: Learn how to build retention matrices and apply different calculation approaches.

---

## 📌 Task 1 — Weekly Cohorts

Create weekly user cohorts based on the registration date.

**Hint:** Use `toStartOfWeek(signup_date)`

---

## 📌 Task 2 — Weekly Retention

For each cohort, calculate how many users returned in subsequent weeks.

**Hint:** First define the cohort, then join user activity.

---

## 📌 Task 3 — Retention Using Window Functions

The solution must use ClickHouse window functions to calculate retention relative to each cohort.

---

## 📌 Task 4 — Retention Matrix

Build a table where:  

- **Rows** represent the cohort (registration week)  
- **Columns** represent the number of weeks after registration (week 0, week 1, week 2…)  
- **Values** represent the number of retained users  

**Hint:** Use `dateDiff('week', cohort_week, activity_week)`

---

## 💡 Recommendation

1. First, try to build a naive version (`retention_wrong.sql`)  
2. Then fix it (`retention_correct.sql`)  
3. Improve it using window functions (`retention_window.sql`)  
4. Finally, build the full matrix (`retention_matrix.sql`)