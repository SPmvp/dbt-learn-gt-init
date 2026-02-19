{{
    config(
        materialized = 'view',
        description  = 'All-time first occurrence date per CaseId for Nemhandel (EAN) and MaterialSupplier. '
                     + 'No date filter intentionally — downstream models filter by billing period. '
                     + 'Materialized as a view — change to table once a refresh schedule is in place.'
    )
}}

WITH nemhandel AS (
    SELECT
        f.CaseId,
        'Nemhandel'      AS item,
        MIN(f.IssueDate) AS first_date
    FROM {{ source('cwa', 'FinancialDocument') }} f
    WHERE f.IsEan = 1
    GROUP BY f.CaseId
),

material_supplier AS (
    SELECT
        f.CaseId,
        'MaterialSupplier' AS item,
        MIN(f.IssueDate)   AS first_date
    FROM {{ source('cwa', 'FinancialDocument') }} f
    INNER JOIN {{ source('cwa', 'FinancialDocumentLine') }} fdl
        ON fdl.ExpenseId = f.Id
    WHERE fdl.FulfilledBy = 'Materialeleverandør'
    GROUP BY f.CaseId
)

SELECT CaseId, item, first_date FROM nemhandel
UNION ALL
SELECT CaseId, item, first_date FROM material_supplier
