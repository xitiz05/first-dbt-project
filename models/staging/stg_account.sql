{{ config(
    materialized = 'incremental',
    incremental_strategy = 'append',
    on_schema_change = 'sync_all_columns',
    indexes = [
        {'columns': ['tran_date']},
        {'columns': ['acid']}
    ]
) }}

-- Append only: new transactions are inserted, existing rows are never updated.
-- Watermark column: tran_date (rows newer than the latest tran_date in silver).

WITH src AS (
    SELECT
        *
    FROM
        {{ source(
            'crmuser',
            'transactions'
        ) }}

    {% if is_incremental() %}
    WHERE
        tran_date > (
            SELECT
                MAX(tran_date)
            FROM
                {{ this }}
        )
    {% endif %}
)
SELECT
    transaction_key,
    tran_id,
    part_tran_srl_num,
    acid,
    cust_id,
    tran_date,
    year,
    month,
    day,
    tran_particular,
    tran_rmks,
    tran_type,
    tran_sub_type,
    part_tran_type,
    tr_status,
    gl_sub_head_code,
    ref_num,
    acct_balance,
    sol_id,
    dth_init_sol_id,
    tran_amt,
    tran_crncy_code,
    ref_crncy_code,
    tran_channel_type,
    pstd_flg,
    lchg_time
FROM
    src