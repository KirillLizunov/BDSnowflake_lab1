-- Лабораторная работа №1
-- Заполнение таблиц измерений из исходной таблицы mock_data

-- Очистка таблиц перед повторной загрузкой данных
TRUNCATE TABLE fact_sales RESTART IDENTITY CASCADE;
TRUNCATE TABLE dim_date RESTART IDENTITY CASCADE;
TRUNCATE TABLE dim_supplier RESTART IDENTITY CASCADE;
TRUNCATE TABLE dim_store RESTART IDENTITY CASCADE;
TRUNCATE TABLE dim_product RESTART IDENTITY CASCADE;
TRUNCATE TABLE dim_category RESTART IDENTITY CASCADE;
TRUNCATE TABLE dim_seller RESTART IDENTITY CASCADE;
TRUNCATE TABLE dim_pet RESTART IDENTITY CASCADE;
TRUNCATE TABLE dim_customer RESTART IDENTITY CASCADE;

-- Заполнение измерения покупателей
INSERT INTO dim_customer (
    customer_id,
    first_name,
    last_name,
    age,
    email,
    country,
    postal_code
)
SELECT DISTINCT ON (sale_customer_id)
    sale_customer_id,
    customer_first_name,
    customer_last_name,
    customer_age,
    customer_email,
    customer_country,
    customer_postal_code
FROM mock_data
ORDER BY sale_customer_id, id;

-- Заполнение измерения продавцов
INSERT INTO dim_seller (
    seller_id,
    first_name,
    last_name,
    email,
    country,
    postal_code
)
SELECT DISTINCT ON (sale_seller_id)
    sale_seller_id,
    seller_first_name,
    seller_last_name,
    seller_email,
    seller_country,
    seller_postal_code
FROM mock_data
ORDER BY sale_seller_id, id;

-- Заполнение измерения категорий товаров
INSERT INTO dim_category (category_name)
SELECT DISTINCT product_category
FROM mock_data
WHERE product_category IS NOT NULL;

-- Заполнение измерения товаров
INSERT INTO dim_product (
    product_id,
    product_name,
    category_id,
    product_price,
    product_weight,
    product_color,
    product_size,
    product_brand,
    product_material,
    product_description,
    product_rating,
    product_reviews,
    product_release_date,
    product_expiry_date,
    pet_category
)
SELECT DISTINCT ON (m.sale_product_id)
    m.sale_product_id,
    m.product_name,
    c.category_id,
    m.product_price,
    m.product_weight,
    m.product_color,
    m.product_size,
    m.product_brand,
    m.product_material,
    m.product_description,
    m.product_rating,
    m.product_reviews,
    TO_DATE(m.product_release_date, 'MM/DD/YYYY'),
    TO_DATE(m.product_expiry_date, 'MM/DD/YYYY'),
    m.pet_category
FROM mock_data m
JOIN dim_category c
    ON m.product_category = c.category_name
ORDER BY m.sale_product_id, m.id;

-- Заполнение измерения питомцев
INSERT INTO dim_pet (
    pet_type,
    pet_name,
    pet_breed
)
SELECT DISTINCT
    customer_pet_type,
    customer_pet_name,
    customer_pet_breed
FROM mock_data;

-- Заполнение измерения магазинов
INSERT INTO dim_store (
    store_name,
    store_location,
    store_city,
    store_state,
    store_country,
    store_phone,
    store_email
)
SELECT DISTINCT
    store_name,
    store_location,
    store_city,
    store_state,
    store_country,
    store_phone,
    store_email
FROM mock_data;

-- Заполнение измерения поставщиков
INSERT INTO dim_supplier (
    supplier_name,
    supplier_contact,
    supplier_email,
    supplier_phone,
    supplier_address,
    supplier_city,
    supplier_country
)
SELECT DISTINCT
    supplier_name,
    supplier_contact,
    supplier_email,
    supplier_phone,
    supplier_address,
    supplier_city,
    supplier_country
FROM mock_data;

-- Заполнение измерения дат
INSERT INTO dim_date (
    full_date,
    year,
    month,
    day
)
SELECT DISTINCT
    TO_DATE(sale_date, 'MM/DD/YYYY') AS full_date,
    EXTRACT(YEAR FROM TO_DATE(sale_date, 'MM/DD/YYYY'))::INT,
    EXTRACT(MONTH FROM TO_DATE(sale_date, 'MM/DD/YYYY'))::INT,
    EXTRACT(DAY FROM TO_DATE(sale_date, 'MM/DD/YYYY'))::INT
FROM mock_data;
