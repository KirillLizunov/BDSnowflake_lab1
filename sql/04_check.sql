-- Лабораторная работа №1
-- Проверка заполнения таблиц и аналитические запросы

-- Проверка количества записей в таблицах измерений и таблице фактов
SELECT COUNT(*) AS customers FROM dim_customer;
SELECT COUNT(*) AS pets FROM dim_pet;
SELECT COUNT(*) AS sellers FROM dim_seller;
SELECT COUNT(*) AS categories FROM dim_category;
SELECT COUNT(*) AS products FROM dim_product;
SELECT COUNT(*) AS stores FROM dim_store;
SELECT COUNT(*) AS suppliers FROM dim_supplier;
SELECT COUNT(*) AS dates FROM dim_date;
SELECT COUNT(*) AS facts FROM fact_sales;

-- Проверка продаж по категориям товаров
-- Показывает суммарное количество продаж и общую выручку по каждой категории
SELECT
    c.category_name,
    SUM(f.sale_quantity) AS total_qty,
    SUM(f.sale_total_price) AS total_revenue
FROM fact_sales f
JOIN dim_product p ON f.product_id = p.product_id
JOIN dim_category c ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY total_revenue DESC;

-- Проверка продаж по магазинам
-- Показывает суммарную выручку по магазинам
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

-- Проверка продаж по поставщикам
-- Показывает суммарную выручку по поставщикам
SELECT
    sup.supplier_name,
    SUM(f.sale_total_price) AS total_revenue
FROM fact_sales f
JOIN dim_supplier sup ON f.supplier_id = sup.supplier_id
GROUP BY sup.supplier_name
ORDER BY total_revenue DESC
LIMIT 10;

-- Проверка нескольких строк из таблицы фактов
SELECT *
FROM fact_sales
LIMIT 10;

-- Проверка нескольких строк из таблицы покупателей
SELECT *
FROM dim_customer
LIMIT 10;

-- Проверка нескольких строк из таблицы товаров
SELECT *
FROM dim_product
LIMIT 10;

-- Проверка нескольких строк из таблицы дат
SELECT *
FROM dim_date
LIMIT 10;
