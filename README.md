# Лабораторная работа №1
Студент: Лизунов Кирилл Романович
Группа: М80-315Б-23



## Нормализация данных в модель "снежинка" (Snowflake Schema)

---

## Описание

В данной лабораторной работе выполнена трансформация исходных данных из CSV-файлов в аналитическую модель данных типа **snowflake schema**.

Исходные данные содержат информацию о:

* покупателях
* продавцах
* товарах
* магазинах
* поставщиках
* питомцах

Все данные были загружены в таблицу `mock_data`, после чего нормализованы и разделены на таблицу фактов и таблицы измерений.

---

## Структура модели данных

### Таблица фактов

* `fact_sales` — хранит данные о продажах
  (дата, покупатель, товар, продавец, магазин, поставщик, количество, сумма)

---

### Таблицы измерений

* `dim_customer` — покупатели
* `dim_pet` — питомцы
* `dim_seller` — продавцы
* `dim_category` — категории товаров
* `dim_product` — товары
* `dim_store` — магазины
* `dim_supplier` — поставщики
* `dim_date` — даты

---

## Реализация схемы "снежинка"

Схема снежинка реализована за счёт нормализации измерений:

* `dim_product` → `dim_category`
* таблица фактов отделена от измерений
* дата вынесена в отдельную таблицу `dim_date`

---

## Структура проекта

```text
BDSnowflake-main/
├── docker-compose.yml
├── README.md
├── sql/
│   ├── 01_init.sql
│   ├── 02_dims.sql
│   ├── 03_fact.sql
│   └── 04_check.sql
└── исходные данные/
    ├── MOCK_DATA (1).csv
    ├── MOCK_DATA (2).csv
    ├── ...
    └── MOCK_DATA (10).csv
```

---

## Как запустить проект

1. Запустить PostgreSQL через Docker:

```bash
docker compose up -d
```

2. Подключиться к базе данных в DBeaver:

* Host: `localhost`
* Port: `5433`
* Database: `lab_db`
* User: `postgres`
* Password: `postgres`

3. Импортировать все CSV-файлы в таблицу `mock_data`

4. Выполнить SQL-скрипты:

```text
01_init.sql
02_dims.sql
03_fact.sql
04_check.sql
```

---

## Примеры аналитических запросов

### Продажи по категориям

```sql
SELECT
    c.category_name,
    SUM(f.sale_quantity) AS total_qty,
    SUM(f.sale_total_price) AS total_revenue
FROM fact_sales f
JOIN dim_product p ON f.product_id = p.product_id
JOIN dim_category c ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY total_revenue DESC;
```

---

### Продажи по магазинам

```sql
SELECT
    s.store_name,
    s.store_city,
    s.store_country,
    SUM(f.sale_total_price) AS total_revenue
FROM fact_sales f
JOIN dim_store s ON f.store_id = s.store_id
GROUP BY s.store_name, s.store_city, s.store_country
ORDER BY total_revenue DESC
LIMIT 10;
```

---

### Продажи по поставщикам

```sql
SELECT
    sup.supplier_name,
    SUM(f.sale_total_price) AS total_revenue
FROM fact_sales f
JOIN dim_supplier sup ON f.supplier_id = sup.supplier_id
GROUP BY sup.supplier_name
ORDER BY total_revenue DESC
LIMIT 10;
```

---

## Результат

* Загружено: **10000 строк** исходных данных
* Построена аналитическая модель данных
* Реализована схема **snowflake**
* Выполнены аналитические запросы

---

## Вывод

В ходе работы были освоены:

* загрузка данных из CSV в PostgreSQL
* нормализация данных
* построение модели "звезда/снежинка"
* написание SQL-запросов для аналитики

---



Студент: Лизунов Кирилл Романович
Группа: М80-315Б-23
