# 📘 Practical SQL / Практический SQL

## Обзор / Overview  
**Практический SQL для аналитиков, которые решают реальные задачи, а не просто пишут запросы.**  
_Practical SQL for analysts who solve real problems, not just write queries._

---

## 🔹 Что здесь есть / What’s included

- Реальные аналитические кейсы с продуманными датасетами  
  _Real-world analytical cases with carefully designed datasets_  
- Задачи от базового до продвинутого уровня (Junior → Senior)  
  _Exercises from basic to advanced levels (Junior → Senior)_  
- Решения с подробными комментариями и объяснениями  
  _Reference solutions with detailed comments and explanations_  
- Mini-Challenges для закрепления материала  
  _Mini-Challenges for hands-on practice_  
- Советы по оптимизации и работе с продакшн-данными (Senior)  
  _Tips for optimization and working with production data (Senior)_

---

## 🔹 Структура репозитория / Repository Structure

```text
practical-sql/
├── 01_foundations/          # Основы SQL (Junior)
│   ├── exercises.md         # Задания по базовому уровню
│   └── solutions.md         # Решения и пояснения
├── 02_core_retention/       # Когортный анализ (Middle)
│   ├── exercises.md
│   ├── retention_correct.sql
│   ├── retention_matrix.sql
│   ├── retention_window.sql
│   └── retention_wrong.sql
├── 03_advanced_cases/       # Продвинутые кейсы (Senior)
│   ├── data_quality_issues.md
│   ├── exercises.md
│   ├── retention_active_users.sql
│   └── retention_excluding_day0.sql
├── data/                    # Схема таблиц и генерация данных
│   ├── schema.sql
│   ├── generate_users.sql
│   ├── generate_events.sql
│   └── README.md            # Описание генерации данных
└── README.md                # Этот файл — общий обзор
🔹 Как использовать / How to use

Создайте таблицы, выполнив скрипт data/schema.sql
Create tables by running data/schema.sql

Сгенерируйте данные для пользователей и событий
Generate data using data/generate_users.sql and data/generate_events.sql

Начните с заданий в 01_foundations/exercises.md и решайте по порядку
Start with exercises in 01_foundations/exercises.md and proceed step-by-step

Сравните свои решения с эталонными в solutions.md и .sql файлах
Compare your solutions with reference solutions in solutions.md and .sql files

Осваивайте Mini-Challenges для практики
Practice Mini-Challenges to reinforce your skills
🔹 Видео / Video

Для каждого модуля есть видеоразбор на YouTube:
Each module has a corresponding YouTube walkthrough:

Видео #1: Как аналитики неправильно считают retention
Video #1: How analysts calculate retention incorrectly
🔹 Продвинутый уровень / Advanced Level (Senior / Paid)

Продвинутые кейсы и оптимизации, сценарии Senior уровня доступны отдельно.
Advanced cases and optimizations, Senior-level scenarios are available separately.

Помогает:

Повысить производительность запросов

Работать с реальными продакшн-данными

Подготовиться к сложным собеседованиям
🔹 Используемая СУБД / Database

Примеры написаны на PostgreSQL, но легко адаптируются под MySQL, BigQuery, Redshift и ClickHouse.
Examples are written in PostgreSQL but can be adapted for MySQL, BigQuery, Redshift, and ClickHouse.

🔹 Обратная связь / Feedback

Есть вопросы, предложения или баги? Открывайте Issue в репозитории.
Have questions, ideas, or bugs? Please open an Issue in the repository.