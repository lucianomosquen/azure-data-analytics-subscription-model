/* ============================================================
   01_create_tables.sql
   Creación de tablas raw y clean
   ============================================================ */

IF OBJECT_ID('dbo.subscriptions_raw', 'U') IS NOT NULL
    DROP TABLE dbo.subscriptions_raw;

IF OBJECT_ID('dbo.subscriptions_clean', 'U') IS NOT NULL
    DROP TABLE dbo.subscriptions_clean;

CREATE TABLE dbo.subscriptions_raw (
    customerID        nvarchar(50),
    gender            nvarchar(20),
    SeniorCitizen     int,
    Partner           nvarchar(10),
    Dependents        nvarchar(10),
    tenure            nvarchar(20),
    PhoneService      nvarchar(10),
    MultipleLines     nvarchar(50),
    InternetService   nvarchar(50),
    OnlineSecurity    nvarchar(50),
    OnlineBackup      nvarchar(50),
    DeviceProtection  nvarchar(50),
    TechSupport       nvarchar(50),
    StreamingTV       nvarchar(50),
    StreamingMovies   nvarchar(50),
    Contract          nvarchar(50),
    PaperlessBilling  nvarchar(10),
    PaymentMethod     nvarchar(100),
    MonthlyCharges    nvarchar(50),
    TotalCharges      nvarchar(50),
    Churn             nvarchar(10),
    loaded_at_utc     datetime2(3) NOT NULL
);

CREATE TABLE dbo.subscriptions_clean (
    user_id            nvarchar(50)  NOT NULL,
    gender             nvarchar(20),
    senior_citizen     bit,
    partner            bit,
    dependents         bit,
    tenure_months      int,

    contract_raw       nvarchar(50),
    contract_type      nvarchar(20),

    payment_method     nvarchar(100),
    paperless_billing  bit,

    monthly_fee        decimal(10,2),
    total_charges      decimal(12,2),

    churn_raw          nvarchar(10),
    churn_flag         bit,

    internet_service   nvarchar(50),
    online_security    nvarchar(50),
    tech_support       nvarchar(50),
    streaming_tv       nvarchar(50),
    streaming_movies   nvarchar(50),

    loaded_at_utc      datetime2(3) NOT NULL,
    cleaned_at_utc     datetime2(3) NOT NULL DEFAULT SYSUTCDATETIME(),

    CONSTRAINT PK_subscriptions_clean PRIMARY KEY (user_id)
);
