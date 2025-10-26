WITH unique_dates AS (
    -- Extract unique dates from the ORDER_DATE column in the orders source table
    SELECT DISTINCT DATE(ORDER_DATE) AS date_day
    FROM {{ source('oliver_dw_source', 'orders') }}
),
date_parts AS (
    SELECT
        date_day,
        YEAR(date_day) AS year,
        MONTH(date_day) AS month,
        DAYOFMONTH(date_day) AS day_of_month,
        DAYOFWEEK(date_day) AS day_of_week,
        DAYOFYEAR(date_day) AS day_of_year,
        WEEKOFYEAR(date_day) AS week_of_year,
        QUARTER(date_day) AS quarter,
        MONTHNAME(date_day) AS month_name,
        DAYNAME(date_day) AS day_name,
        CONCAT(YEAR(date_day), '-', LPAD(MONTH(date_day), 2, '0')) AS year_month
    FROM unique_dates
)
SELECT
    -- GENERATE_SURROGATE_KEY is the new, correct macro name
    {{ dbt_utils.generate_surrogate_key(['date_day']) }} AS date_key,
    date_day,
    year,
    month,
    day_of_month,
    day_of_week,
    day_of_year,
    week_of_year,
    quarter,
    month_name,
    day_name,
    year_month
FROM date_parts