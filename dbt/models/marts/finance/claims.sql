-- =====================================================================
-- MART LAYER: claims  (Finance / RCM pillar)
-- Purpose: adds AR aging calc, matching post_claims.csv target shape.
-- Target: standard TABLE, overwritten by scheduled query.
-- Feeds: Power BI RCM Overview page (Claims Aging Distribution visual,
--        Avg Days in A/R, Denied Charges by Denial Reason)
-- =====================================================================

WITH as_of AS (
  -- Snapshot date = latest claim_date in the dataset itself, not wall-clock.
  -- Same principle as the DAX pattern: MAXX(ALL(claims), claims[claim_date]).
  -- Keeps aging stable and realistic even as real-world time moves past
  -- this frozen synthetic dataset.
  SELECT MAX(claim_date) AS snapshot_date
  FROM {{ ref('stg_claims') }}
),

aging AS (
  SELECT
    c.*,
    -- Open claims (Pending/Denied) age against the dataset's own "as of" date;
    -- Paid claims are closed -> NULL
    CASE
      WHEN c.claim_status IN ('Pending', 'Denied')
        THEN DATE_DIFF(a.snapshot_date, c.claim_date, DAY)
      ELSE NULL
    END AS days_open
  FROM {{ ref('stg_claims') }} c
  CROSS JOIN as_of a
)

SELECT
  claim_id,
  encounter_id,
  patient_id,
  provider_id,
  claim_date,
  units,
  charge_amount,
  allowed_amount,
  insurance_paid,
  patient_responsibility,
  claim_status,
  denial_reason,
  claim_submitted_date,
  claim_paid_date,
  cpt_id,
  insurance_name_id,
  icd10_id,
  days_open,
  CASE
    WHEN days_open IS NULL THEN NULL
    WHEN days_open <= 30           THEN '0-30 days'
    WHEN days_open BETWEEN 31 AND 60  THEN '31-60 days'
    WHEN days_open BETWEEN 61 AND 90  THEN '61-90 days'
    WHEN days_open BETWEEN 91 AND 120 THEN '91-120 days'
    ELSE '120 +'
  END AS aging_bucket,
  CASE
    WHEN days_open IS NULL THEN 6
    WHEN days_open <= 30           THEN 1
    WHEN days_open BETWEEN 31 AND 60  THEN 2
    WHEN days_open BETWEEN 61 AND 90  THEN 3
    WHEN days_open BETWEEN 91 AND 120 THEN 4
    ELSE 5
  END AS aging_bucket_rank
FROM aging
