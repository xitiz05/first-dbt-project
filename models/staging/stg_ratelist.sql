{{ config(
    materialized = 'table'
) }}

WITH src AS (
    SELECT
        *
    FROM
        {{ source(
            'crmuser',
            'ratelist'
        ) }}
),
FINAL AS (
    SELECT
        rtlist_date,
        rtlist_num,
        fxd_crncy_code,
        var_crncy_code,
        ratecode,
        fxd_crncy_units,
        var_crncy_units,
        cust_var_crncy_units,
        low_slab_amt,
        high_slab_amt,
        slab_crncy_code,
        srl_num,
        bank_id,
        lchg_user_id,
        lchg_time
    FROM
        src
)
SELECT
    *
FROM
    FINAL