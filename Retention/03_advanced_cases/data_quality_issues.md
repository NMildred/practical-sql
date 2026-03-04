# 03_advanced_cases/solutions/data_quality_issues.md

## Data Quality Checks and Potential Issues

1. **Users without events**  
   - Users who registered but never performed any events.  
   - **Solution:** LEFT JOIN users → events, COUNT NULLs.

2. **Events without a user**  
   - Events with a `user_id` not present in the users table.  
   - **Solution:** LEFT JOIN events → users and check for NULLs.

3. **Duplicates**  
   - Repeated events by the same user within the same week can distort retention.  
   - **Solution:** use DISTINCT on `(user_id, cohort_week, activity_week)`.

4. **Day 0**  
   - Events occurring on the signup day can artificially inflate retention.  
   - **Solution:** filter `event_time > signup_date`.

5. **Different time zones and date formats**  
   - Events may come in with different time zones → incorrect weekly aggregation.  
   - **Solution:** normalize all dates to a single time zone.

6. **Missing indexes**  
   - MergeTree / ClickHouse tables or PostgreSQL tables without indexes → slow calculations.  
   - **Solution:** index `user_id`, `event_time`, `signup_date`.

7. **Tracking “active” users**  
   - Calculate retention only for users with >1 event to remove noise from one-off visits.