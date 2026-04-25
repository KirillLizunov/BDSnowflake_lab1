-- Лабораторная работа №1
-- Создание таблиц измерений и таблицы фактов для схемы "снежинка"

-- Удаление таблиц, если они уже существуют
DROP TABLE IF EXISTS fact_sales;
DROP TABLE IF EXISTS dim_date;
DROP TABLE IF EXISTS dim_supplier;
DROP TABLE IF EXISTS dim_store;
DROP TABLE IF EXISTS dim_product;
DROP TABLE IF EXISTS dim_category;
DROP TABLE IF EXISTS dim_seller;
DROP TABLE IF EXISTS dim_pet;
DROP TABLE IF EXISTS dim_customer;

-- Таблица измерения покупателей
CREATE TABLE dim_customer (
    customer_id INT PRIMARY KEY,
    first_name TEXT,
    last_name TEXT,
    age INT,
    email TEXT,
    country TEXT,
    postal_code TEXT
);

-- Таблица измерения питомцев
CREATE TABLE dim_pet (
    pet_id SERIAL PRIMARY KEY,
    pet_type TEXT,
    pet_name TEXT,
    pet_breed TEXT
);

-- Таблица измерения продавцов
CREATE TABLE dim_seller (
    seller_id INT PRIMARY KEY,
    first_name TEXT,
    last_name TEXT,
    email TEXT,
    country TEXT,
    postal_code TEXT
);

-- Таблица измерения категорий товаров
CREATE TABLE dim_category (
    category_id SERIAL PRIMARY KEY,
    category_name TEXT UNIQUE
);

-- Таблица измерения товаров
CREATE TABLE dim_product (
    product_id INT PRIMARY KEY,
    product_name TEXT,
    category_id INT REFERENCES dim_category(category_id),
    product_price NUMERIC(10,2),
    product_weight NUMERIC(10,2),
    product_color TEXT,
    product_size TEXT,
    product_brand TEXT,
    product_material TEXT,
    product_description TEXT,
    product_rating NUMERIC(10,2),
    product_reviews INT,
    product_release_date DATE,
    product_expiry_date DATE,
    pet_category TEXT
);

-- Таблица измерения магазинов
CREATE TABLE dim_store (
    store_id SERIAL PRIMARY KEY,
    store_name TEXT,
    store_location TEXT,
    store_city TEXT,
    store_state TEXT,
    store_country TEXT,
    store_phone TEXT,
    store_email TEXT
);

-- Таблица измерения поставщиков
CREATE TABLE dim_supplier (
    supplier_id SERIAL PRIMARY KEY,
    supplier_name TEXT,
    supplier_contact TEXT,
    supplier_email TEXT,
    supplier_phone TEXT,
    supplier_address TEXT,
    supplier_city TEXT,
    supplier_country TEXT
);

-- Таблица измерения дат
CREATE TABLE dim_date (
    date_id SERIAL PRIMARY KEY,
    full_date DATE UNIQUE,
    year INT,
    month INT,
    day INT
);

-- Таблица фактов продаж
CREATE TABLE fact_sales (
    fact_id SERIAL PRIMARY KEY,
    sale_date_id INT REFERENCES dim_date(date_id),
    customer_id INT REFERENCES dim_customer(customer_id),
    pet_id INT REFERENCES dim_pet(pet_id),
    seller_id INT REFERENCES dim_seller(seller_id),
    product_id INT REFERENCES dim_product(product_id),
    store_id INT REFERENCES dim_store(store_id),
    supplier_id INT REFERENCES dim_supplier(supplier_id),
    sale_quantity INT,
    sale_total_price NUMERIC(10,2)
);
