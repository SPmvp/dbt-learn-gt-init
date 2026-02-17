{{ config(materialized='view') }}

-- Query the 'case' table from cwa schema
select
    *
from cwa.[case]

-- You can add transformations here:
-- where status = 'active'
-- order by created_date desc
