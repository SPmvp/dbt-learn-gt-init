{{ config(materialized='view') }}

-- Query the 'case' table from cwa schema
select
    *
from {{ source('cwa', 'Case') }}

-- You can add transformations here:
-- where status = 'active'
-- order by created_date desc
