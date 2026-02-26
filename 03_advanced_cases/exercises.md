# 🔴 Level 3 — Advanced Cases (Senior)

This section tests advanced analyst skills and data quality awareness.

⏱ Recommended time: 40–60 minutes  
🎯 Goal: Learn to handle exceptions, segment users, and detect data issues.

---

## 📌 Task 1 — Exclude Day 0

Calculate retention excluding events that occurred on the signup day.

**Hint:** filter `event_time > signup_date`.  
💡 **Why this matters:** Day 0 often artificially inflates retention.

---

## 📌 Task 2 — Retention for Active Users Only

Calculate retention only for users who had more than one event.

**Hint:** first identify “active” users (`COUNT(event_id) > 1`), then perform cohort analysis.

---

## 📌 Task 3 — Data Quality Check

Answer in writing:

- Are there users without events?  
- Are there events without a user?  
- Are there duplicate events?  
- What other issues might distort retention?

---

## 📌 Optional / Bonus

- Try rewriting previous solutions using **CTEs vs inline queries**  
- Think about which **indexes or materialized views** could speed up retention calculations  
- Build **retention by segments**: device, traffic source, geography