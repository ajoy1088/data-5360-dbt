{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
)}}

select
    employee_id,
    employee_email,
    PARSE_JSON(certification_json):certification_name::VARCHAR AS certification_name,
    PARSE_JSON(certification_json):certification_cost::FLOAT AS certification_cost,
    PARSE_JSON(certification_json):certification_awarded_date::DATE AS certification_awarded_date,
    created_at
from {{ source('oliver_landing', 'employee_certifications')}}