SELECT
    -- Fact Measures and Keys
    t1.order_id,
    t1.order_line_id,
    t1.order_date,
    t1.quantity,
    t1.unit_price,
    t1.sales_amount,

    -- Date Attributes
    t2.date_day,
    t2.year,
    t2.month_name,
    t2.quarter,

    -- Customer Attributes
    t3.first_name AS customer_first_name,
    t3.last_name AS customer_last_name,
    t3.email AS customer_email,
    t3.state AS customer_state,

    -- Employee Attributes
    t4.first_name AS employee_first_name,
    t4.last_name AS employee_last_name,
    t4.position AS employee_position,

    -- Store Attributes
    t5.store_name,
    t5.full_location_address AS store_address,
    t5.city AS store_city,

    -- Product Attributes
    t6.product_name,
    t6.description AS product_description,
    t6.price AS product_list_price

FROM
    {{ ref('fact_sales') }} AS t1
JOIN
    {{ ref('oliver_dim_date') }} AS t2 ON t1.date_key = t2.date_key
JOIN
    {{ ref('oliver_dim_customer') }} AS t3 ON t1.customer_key = t3.customer_key
JOIN
    {{ ref('oliver_dim_employee') }} AS t4 ON t1.employee_key = t4.employee_key
JOIN
    {{ ref('oliver_dim_store') }} AS t5 ON t1.store_key = t5.store_key
JOIN
    {{ ref('oliver_dim_product') }} AS t6 ON t1.product_key = t6.product_key