{{ config(
    materialized = 'table'
) }}

WITH src AS (
    SELECT
        *
    FROM
        {{ source(
            'crmuser',
            'lien'
        ) }}
),
FINAL AS (
    SELECT
        b2k_id,
        acid,
        sol_id,
        lien_amt,
        lien_reason_code,
        lien_remarks,
        lien_start_date,
        lien_expiry_date,
        requested_by_desc,
        request_department,
        contact_num,
        b2k_type,
        entity_cre_flg,
        del_flg,
        lchg_user_id,
        lchg_time
    FROM
        src
)
SELECT
    *
FROM
    FINAL