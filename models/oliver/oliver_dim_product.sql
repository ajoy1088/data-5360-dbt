SELECT
    PRODUCT_ID AS product_key,
    PRODUCT_NAME,
    DESCRIPTION, -- Using DESCRIPTION as an available attribute
    UNIT_PRICE AS price
    -- COST is not available in the source data, so it is omitted.
    -- CATEGORY is not available in the source data, so it is omitted.
FROM
    {{ source('oliver_dw_source', 'product') }}