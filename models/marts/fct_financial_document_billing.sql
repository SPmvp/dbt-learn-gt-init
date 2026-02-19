{{
    config(
        materialized = 'view',
        description  = 'Billing rows for Nemhandel and MaterialSupplier — one row per CaseId per item '
                     + 'where the first occurrence falls within the billing period. '
                     + 'Materialized as a view because the heavy work is done in the upstream table.'
    )
}}

WITH first_occurrence AS (
    SELECT * FROM {{ ref('int_financial_document_first_occurrence') }}
),

cases AS (
    SELECT
        Id,
        number,
        Tenant,
        Company,
        CaseType
    FROM {{ source('cwa', 'Case') }}
),

filtered AS (
    SELECT *
    FROM first_occurrence
    WHERE first_date >= CAST('{{ billing_start_date() }}' AS DATE)
      AND first_date <  CAST('{{ billing_end_date() }}'   AS DATE)
)

SELECT
    ISNULL(c.number,  '')      AS claimnumber,
    c.Tenant                   AS tenant,
    c.Company                  AS company,
    c.CaseType                 AS case_type,
    CAST(fo.first_date AS DATE) AS date,
    fo.item,
    CAST(1 AS INT)             AS value,
    CASE
        WHEN fo.item = 'Nemhandel'        THEN 'h37'
        WHEN fo.item = 'MaterialSupplier' THEN 'h34'
    END                        AS price_code,
    'CWA SP DW'                AS source_database,
    '[cwa].[FinancialDocument]' AS source_table
FROM filtered fo
INNER JOIN cases c ON c.Id = fo.CaseId
