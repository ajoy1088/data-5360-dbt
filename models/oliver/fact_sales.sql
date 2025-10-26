WITH order_details AS (
    SELECT
        t1.ORDER_ID,
        t1.CUSTOMER_ID,
        t1.EMPLOYEE_ID,
        t1.STORE_ID,
        t1.ORDER_DATE,
        t1.TOTAL_AMOUNT AS order_header_total, -- Total for the whole order
        t2.PRODUCT_ID,
        t2.ORDER_LINE_ID,
        t2.QUANTITY,
        t2.UNIT_PRICE,
        (t2.QUANTITY * t2.UNIT_PRICE) AS sales_amount -- Total for this line item
    FROM
        {{ source('oliver_dw_source', 'orders') }} AS t1
    JOIN
        {{ source('oliver_dw_source', 'orderline') }} AS t2 ON t1.ORDER_ID = t2.ORDER_ID
),
-- Calculate date_key using the same logic as dim_date
dated_orders AS (
    SELECT
        *,
        -- FIX: Use generate_surrogate_key
        {{ dbt_utils.generate_surrogate_key(['DATE(ORDER_DATE)']) }} AS date_key
    FROM order_details
)
SELECT
    -- FIX: Use generate_surrogate_key
    {{ dbt_utils.generate_surrogate_key(['ORDER_ID', 'ORDER_LINE_ID']) }} AS sales_key,
    ORDER_ID,
    ORDER_LINE_ID,
    date_key,
    CUSTOMER_ID AS customer_key,
    EMPLOYEE_ID AS employee_key,
    STORE_ID AS store_key,
    PRODUCT_ID AS product_key,
    ORDER_DATE,
    QUANTITY,
    UNIT_PRICE,
    sales_amount, -- Line item total
    order_header_total
FROM
    dated_orders