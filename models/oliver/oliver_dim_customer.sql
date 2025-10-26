SELECT
    CUSTOMER_ID AS customer_key, -- Corrected column name to CUSTOMER_ID
    FIRST_NAME,
    LAST_NAME,
    EMAIL,
    PHONE_NUMBER,
    STATE
FROM
    {{ source('oliver_dw_source', 'customer') }}