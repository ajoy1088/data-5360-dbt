SELECT
    EMPLOYEE_ID AS employee_key,
    FIRST_NAME,
    LAST_NAME,
    EMAIL,
    PHONE_NUMBER,
    POSITION,
    HIRE_DATE
FROM
    {{ source('oliver_dw_source', 'employee') }}