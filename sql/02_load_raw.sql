/* ============================================================
   02_load_raw.sql
   Carga desde tabla técnica creada por ADF
   ============================================================ */

INSERT INTO dbo.subscriptions_raw (
    customerID, gender, SeniorCitizen, Partner, Dependents, tenure,
    PhoneService, MultipleLines, InternetService, OnlineSecurity,
    OnlineBackup, DeviceProtection, TechSupport, StreamingTV,
    StreamingMovies, Contract, PaperlessBilling, PaymentMethod,
    MonthlyCharges, TotalCharges, Churn, loaded_at_utc
)
SELECT
    customerID,
    gender,
    TRY_CONVERT(int, SeniorCitizen),
    Partner,
    Dependents,
    tenure,
    PhoneService,
    MultipleLines,
    InternetService,
    OnlineSecurity,
    OnlineBackup,
    DeviceProtection,
    TechSupport,
    StreamingTV,
    StreamingMovies,
    Contract,
    PaperlessBilling,
    PaymentMethod,
    MonthlyCharges,
    TotalCharges,
    Churn,
    SYSUTCDATETIME()
FROM [dbo.subscriptions_raw].[WA_Fn-UseC_-Telco-Customer-Churn];
