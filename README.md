# 📘 Practical SQL / Практический SQL

---

## Overview / Обзор

_Practical SQL for analysts who solve real problems, not just write queries._  
**Практический SQL для аналитиков, которые решают реальные задачи, а не просто пишут запросы.**

---

## What’s included / Что здесь есть

- Real-world analytical cases with carefully designed datasets  
  _Реальные аналитические кейсы с продуманными датасетами_  
- Exercises from basic to advanced levels (Junior → Senior)  
  _Задачи от базового до продвинутого уровня (Junior → Senior)_  
- Reference solutions with detailed comments and explanations  
  _Решения с подробными комментариями и объяснениями_  
- Mini-Challenges for hands-on practice  
  _Mini-Challenges для закрепления материала_  
- Tips for optimization and working with production data (Senior)  
  _Советы по оптимизации и работе с продакшн-данными (Senior)_

---

## Repository Structure / Структура репозитория

```text
practical-sql/
├── 01_foundations/              # Basics of SQL (Junior) / Основы SQL (Junior)
│   ├── exercises.md            # Exercises / Задания
│   ├── exercises.ru.md         # Exercises in Russian / Задания на русском
│   └── solutions.md            # Solutions with explanations / Решения и пояснения
├── 02_core_retention/           # Middle: Cohort analysis / Когортный анализ (Middle)
│   ├── exercises.md            # Exercises / Задания
│   ├── exercises.ru.md         # Exercises in Russian / Задания на русском
│   ├── retention_correct.sql
│   ├── retention_matrix.sql
│   ├── retention_window.sql
│   └── retention_wrong.sql
├── 03_advanced_cases/           # Senior: Advanced cases and optimization / Продвинутые кейсы (Senior)
│   ├── data_quality_issues.md      
│   ├── data_quality_issues.ru.md   
│   ├── exercises.md                # Exercises / Задания
│   ├── exercises.ru.md             # Exercises in Russian / Задания на русском
│   ├── retention_active_users.sql
│   ├── retention_excluding_day0.sql
├── data/                       # Schema and data generation scripts / Схема таблиц и генерация данных
│   ├── generate_events.sql     # Script to generate sample events data / Скрипт генерации тестовых данных событий
│   ├── generate_users.sql      # Script to generate sample users data / Скрипт генерации тестовых данных пользователей
│   ├── README.ru.md            # Instructions for data generation in Russian / Инструкции по генерации данных на русском
│   ├── README.md               # Instructions for data generation in English / Инструкции по генерации данных на английском
│   └── schema.sql              # SQL schema for creating tables / SQL схема создания таблиц            
└── README.md

## How to use / Как использовать

Create tables by running the schema script:  
data/schema.sql  
Создайте таблицы, выполнив скрипт:  
data/schema.sql

Generate user and event data:  
data/generate_users.sql and data/generate_events.sql  
Сгенерируйте данные для пользователей и событий:  
data/generate_users.sql и data/generate_events.sql

Start with exercises in the 01_foundations folder and proceed sequentially.  
Начните с заданий в папке 01_foundations и решайте по порядку.

Compare your solutions with reference solutions in .md and .sql files.  
Сравните свои решения с эталонными в файлах .md и .sql.

Practice Mini-Challenges to reinforce your skills.  
Осваивайте Mini-Challenges для закрепления материала.

## Videos / Видео

Each module has a YouTube walkthrough video:  
Для каждого модуля есть видеоразбор на YouTube:

Video #1: How analysts calculate retention incorrectly  
Видео #1: Как аналитики неправильно считают retention

(https://www.youtube.com/watch?v=TO95SdT32sE)
(https://www.youtube.com/watch?v=3tolyPsO3S8) 

## Advanced Level / Продвинутый уровень (Senior / Paid)

Advanced cases, optimizations, and Senior-level scenarios are available separately.  
Продвинутые кейсы и оптимизации, сценарии Senior уровня доступны отдельно.

### Benefits / Преимущества:

- Improve query performance  
  Повысить производительность запросов

- Work with real production data  
  Работать с реальными продакшн-данными

- Prepare for challenging interviews  
  Подготовиться к сложным собеседованиям

## Supported Databases / Используемые СУБД

Examples are written in PostgreSQL but can be adapted for MySQL, BigQuery, Redshift, and ClickHouse.  
Примеры написаны на PostgreSQL, но легко адаптируются под MySQL, BigQuery, Redshift и ClickHouse.

## Feedback / Обратная связь

Have questions, ideas, or bugs? Please open an Issue in the repository.  
Есть вопросы, предложения или баги? Открывайте Issue в репозитории.

Thank you for using Practical SQL! / Спасибо за использование Практического SQL!