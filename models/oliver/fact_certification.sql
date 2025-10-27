{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
)}}

select
    -- 1. Dimension Keys (Foreign Keys)
    e.employee_key,
    d.date_key as certification_date_key,

    -- 2. Fact Attributes/Measures
    c.certification_name,
    c.certification_cost

from {{ ref('stg_employee_certifications') }} c
-- Join to dim_employee using the common natural key (email)
inner join {{ ref('dim_employee') }} e
    on c.employee_email = e.employee_email
-- Join to dim_date using the certification awarded date
inner join {{ ref('dim_date') }} d
    on d.date_key = c.certification_awarded_date