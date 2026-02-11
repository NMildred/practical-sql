## Mini-Retention Challenge

### Описание
В этом мини-челлендже вам нужно посчитать **retention** для пользователей, зарегистрировавшихся в разные недели.

### Задание
1. Используя таблицы `users` и `events`, посчитайте количество пользователей, которые вернулись в продукт на второй неделе после их регистрации.
2. Сделайте это с использованием:
   - **Ошибочного подхода**: с использованием `COUNT(DISTINCT user_id)` без учёта когорт.
   - **Правильного подхода**: с использованием когорты и времени активности.

### Указания
- Для первого подхода достаточно использовать запрос, который вы видели в видео.
- Для второго подхода обязательно создайте когорты с учётом времени регистрации пользователей и посчитайте активность.

### Бонус
Попробуйте изменить период "второй недели" на другие и посмотрите, как меняются результаты.

#### Пример решения
```sql
WITH cohorts AS (
    SELECT
        user_id,
        signup_date,
        DATE_TRUNC('week', signup_date) AS cohort_week
    FROM users
),
activity AS (
    SELECT
        c.cohort_week,
        DATE_TRUNC('week', e.event_time) AS activity_week,
        c.user_id
    FROM cohorts c
    JOIN events e ON c.user_id = e.user_id
)
SELECT
    cohort_week,
    activity_week,
    COUNT(DISTINCT user_id) AS retained_users
FROM activity
GROUP BY 1, 2
ORDER BY 1, 2;


