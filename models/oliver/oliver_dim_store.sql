SELECT
    STORE_ID AS store_key,
    STORE_NAME,
    STREET,
    CITY,
    STATE,
    -- MANAGER column is not available in the source data, so it is omitted.
    -- We can concatenate the address components for a comprehensive 'location' field
    CONCAT_WS(', ', STREET, CITY, STATE) AS full_location_address
FROM
    {{ source('oliver_dw_source', 'store') }}