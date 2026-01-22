/* ============================================================
   03_build_clean.sql
   Construcción de capa clean
   ============================================================ */

TRUNCATE TABLE dbo.subscriptions_clean;

INSERT INTO dbo.subscriptions_clean (
    user_id, gender, senior_citizen, partner, dependents,
    tenure_months,
    contract_raw, contract_type,
    payment_method, paperless_billing,
    monthly_fee, total_charges,
    churn_raw, churn_flag,
    internet_service, online_security, tech_support,
    streaming_tv, streaming_movies,
    loaded_at_utc
)
SELECT
    r.customerID,
    r.gender,

    CASE WHEN r.SeniorCitizen = 1 THEN 1
         WHEN r.SeniorCitizen = 0 THEN 0
         ELSE NULL END,

    CASE WHEN r.Partner = 'Yes' THEN 1
         WHEN r.Partner = 'No'  THEN 0
         ELSE NULL END,

    CASE WHEN r.Dependents = 'Yes' THEN 1
         WHEN r.Dependents = 'No'  THEN 0
         ELSE NULL END,

    TRY_CONVERT(int, r.tenure),

    r.Contract,
    CASE
        WHEN r.Contract = 'Month-to-month' THEN 'Monthly'
        WHEN r.Contract = 'One year'       THEN '1y'
        WHEN r.Contract = 'Two year'       THEN '2y'
        ELSE r.Contract
    END,

    r.PaymentMethod,

    CASE WHEN r.PaperlessBilling = 'Yes' THEN 1
         WHEN r.PaperlessBilling = 'No'  THEN 0
         ELSE NULL END,

    TRY_CONVERT(decimal(10,2), r.MonthlyCharges),
    TRY_CONVERT(decimal(12,2), NULLIF(LTRIM(RTRIM(r.TotalCharges)), '')),

    r.Churn,
    CASE WHEN r.Churn = 'Yes' THEN 1 ELSE 0 END,

    r.InternetService,
    r.OnlineSecurity,
    r.TechSupport,
    r.StreamingTV,
    r.StreamingMovies,

    r.loaded_at_utc
FROM dbo.subscriptions_raw r;
