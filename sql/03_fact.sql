-- Лабораторная работа №1
-- Заполнение таблицы фактов продаж

INSERT INTO fact_sales (
    sale_date_id,
    customer_id,
    pet_id,
    seller_id,
    product_id,
    store_id,
    supplier_id,
    sale_quantity,
    sale_total_price
)
SELECT
    d.date_id,
    c.customer_id,
    p.pet_id,
    s.seller_id,
    pr.product_id,
    st.store_id,
    sup.supplier_id,
    m.sale_quantity,
    m.sale_total_price
FROM mock_data m

-- Связь с измерением дат
JOIN dim_date d
    ON d.full_date = TO_DATE(m.sale_date, 'MM/DD/YYYY')

-- Связь с измерением покупателей
JOIN dim_customer c
    ON c.customer_id = m.sale_customer_id

-- Связь с измерением питомцев
JOIN dim_pet p
    ON p.pet_type = m.customer_pet_type
   AND p.pet_name = m.customer_pet_name
   AND p.pet_breed = m.customer_pet_breed

-- Связь с измерением продавцов
JOIN dim_seller s
    ON s.seller_id = m.sale_seller_id

-- Связь с измерением товаров
JOIN dim_product pr
    ON pr.product_id = m.sale_product_id

-- Связь с измерением магазинов
JOIN dim_store st
    ON st.store_name = m.store_name
   AND st.store_city = m.store_city
   AND st.store_country = m.store_country

-- Связь с измерением поставщиков
JOIN dim_supplier sup
    ON sup.supplier_name = m.supplier_name
   AND sup.supplier_email = m.supplier_email
   AND sup.supplier_phone = m.supplier_phone;
