# 📘 Practical SQL / Практический SQL
## My first update
**Практический SQL для аналитиков, которые решают реальные задачи, а не просто пишут запросы.**  
_Practical SQL для тех, кто хочет учиться на реальных кейсах, а не только изучать синтаксис._  

Practical SQL — это проект и одноимённый YouTube-канал:  
_Practical SQL is a project and its eponymous YouTube channel:_  

- **Practical SQL RU** — для русскоязычных / for Russian-speaking audience  
- **Practical SQL EN** — для англоязычных / for English-speaking audience  

---

## 🔹 Что здесь есть / What’s included

- Реальные аналитические кейсы / Real-world SQL cases  
- Продуманные датасеты для практики / Carefully designed practice datasets  
- SQL задачи разной сложности (Junior → Senior) / SQL exercises from Junior to Senior  
- Решения с объяснением логики / Reference solutions with explanations  
- Mini-Challenges для закрепления материала / Mini-Challenges for hands-on practice  

---

## 🔹 Для кого / Who is this for

- Аналитики данных (Junior / Middle / Senior) / Data analysts (Junior / Middle / Senior)  
- Продуктовые и бизнес-аналитики / Product and business analysts  
- Те, кто хочет развивать **мышление аналитика в SQL**, а не просто синтаксис / Those who want to develop **analytical thinking in SQL**, not just syntax  
- Готовящиеся к собеседованиям / Preparing for SQL interviews  

---

## 🔹 Структура репозитория / Repository structure

```text
practical-sql/
├── data/               # Схема таблиц и генерация данных / Table schema & data generation
│   ├── schema.sql
│   ├── generate_users.sql
│   └── generate_events.sql
├── queries/            # Примеры неправильных и правильных запросов / Example queries (wrong & correct)
│   ├── retention_wrong.sql
│   └── retention_correct.sql
├── exercises/          # Мини-челленджи для практики / Mini-Challenges for practice
│   └── retention_challenge.md
├── solutions/          # Решения и объяснения / Reference solutions
│   ├── retention_solutions.sql
│   └── README.md
└── README.md           # Этот файл / This file
🔹 Как работать / How to use

Создайте таблицы из data/schema.sql
 / Create tables from data/schema.sql

Сгенерируйте данные (generate_users.sql
, generate_events.sql
) / Generate sample data (generate_users.sql
, generate_events.sql
)

Попробуйте решить задачи из exercises/
 / Try solving the exercises in exercises/

Сравните своё решение с эталонным в solutions/
 / Compare your solution with the reference solutions in solutions/

Mini-Challenge для закрепления: retention_challenge.md

Mini-Challenge for practice: retention_challenge.md

🔹 Видео / Video

Каждому модулю соответствует видео-разбор на YouTube / Each module has a corresponding YouTube video:

Видео #1: Как аналитики неправильно считают retention

Video #1: How analysts calculate retention incorrectly

🔹 Advanced / Платные кейсы / Advanced / Paid cases

Продвинутые кейсы, оптимизации и сценарии Senior уровня доступны отдельно.
Advanced cases, optimizations, and Senior-level scenarios are available separately.

Помогает:

улучшить производительность запросов / improve query performance

работать с реальными продакшн-данными / work with real production-like data

подготовиться к сложным интервью / prepare for challenging interviews

🔹 Используемая база данных / Database

Все примеры написаны для PostgreSQL, но легко адаптируются под MySQL, BigQuery или Redshift.
All examples are written for PostgreSQL, but can be adapted to MySQL, BigQuery, or Redshift.

🔹 Контакты / Feedback

Если есть вопросы, идеи или баги — открывайте Issue
 в репозитории.
For questions, ideas, or bugs — open an Issue
 in the repository.