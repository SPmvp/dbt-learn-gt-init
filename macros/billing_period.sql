{#
  billing_start_date()
  Returns the first day of (current_year - 2), e.g. 2024-01-01 in 2026.
  Override at runtime: dbt run --vars '{billing_start_date: 2025-01-01}'
#}
{% macro billing_start_date() %}
  {%- if var('billing_start_date', none) is not none -%}
    {{ var('billing_start_date') }}
  {%- else -%}
    {{ (modules.datetime.date.today().year - 2) ~ '-01-01' }}
  {%- endif -%}
{% endmacro %}


{#
  billing_end_date()
  Returns the first day of (current_year + 1) — exclusive upper bound so the
  full current year is included, e.g. 2027-01-01 in 2026.
  Override at runtime: dbt run --vars '{billing_end_date: 2027-01-01}'
#}
{% macro billing_end_date() %}
  {%- if var('billing_end_date', none) is not none -%}
    {{ var('billing_end_date') }}
  {%- else -%}
    {{ (modules.datetime.date.today().year + 1) ~ '-01-01' }}
  {%- endif -%}
{% endmacro %}
