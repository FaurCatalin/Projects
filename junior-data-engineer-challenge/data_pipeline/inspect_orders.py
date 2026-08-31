import requests
import pandas as pd

URL = "https://jzozteoirwfczccltcdr.supabase.co/rest/v1/orders_raw?apikey=sb_publishable_Xwjiw--qkKcbMuSbKd6I2w_wN9mpNTv"

response = requests.get(URL)

print(f"Status Code: {response.status_code}")

data = response.json()

df = pd.DataFrame(data)

# =====================================================
# BASIC INFO
# =====================================================

print("\n=== INFO ===")
print(df.info())

print("\n=== MISSING VALUES ===")
print(df.isnull().sum())

print("\n=== CURRENCIES ===")
print(df["currency"].value_counts())

print("\n=== CATEGORIES ===")
print(df["category"].value_counts(dropna=False))

print("\n=== STATUSES ===")
print(df["status"].value_counts())

print("\n=== COUNTRIES ===")
print(df["country"].value_counts())

# =====================================================
# DUPLICATES
# =====================================================

print("\n=== DUPLICATE ROWS ===")
print(df.duplicated().sum())

print("\n=== DUPLICATE ORDER IDs ===")
print(df["order_id"].duplicated().sum())

print("\n=== ORDERS WITH MOST LINE ITEMS ===")
print(
    df.groupby("order_id")
      .size()
      .sort_values(ascending=False)
      .head(20)
)

# =====================================================
# NULL ANALYSIS
# =====================================================

print("\n=== NULL customer_id SAMPLE ===")
print(
    df[df["customer_id"].isnull()]
    .head(10)
)

print("\n=== NULL category SAMPLE ===")
print(
    df[df["category"].isnull()]
    .head(10)
)

# =====================================================
# NUMERIC ANALYSIS
# =====================================================

print("\n=== QTY SUMMARY ===")
print(df["qty"].describe())

print("\n=== UNIT PRICE SUMMARY ===")
print(df["unit_price"].describe())

print("\n=== NEGATIVE QTY ===")
print((df["qty"] < 0).sum())

print("\n=== NEGATIVE PRICE ===")
print((df["unit_price"] < 0).sum())

print("\n=== ZERO QTY ===")
print((df["qty"] == 0).sum())

print("\n=== ZERO PRICE ===")
print((df["unit_price"] == 0).sum())

# =====================================================
# DATE ANALYSIS
# =====================================================

print("\n=== DATE RANGE ===")
print("Order TS Min:", df["order_ts"].min())
print("Order TS Max:", df["order_ts"].max())

print("\n=== FX DATE RANGE ===")
print("FX Date Min:", df["fx_reference_date"].min())
print("FX Date Max:", df["fx_reference_date"].max())

# =====================================================
# PRODUCT ANALYSIS
# =====================================================

print("\n=== TOP PRODUCTS ===")
print(df["product_name"].value_counts().head(20))

print("\n=== TOP SKU ===")
print(df["sku"].value_counts().head(20))

# =====================================================
# REFUND / NEGATIVE QTY ANALYSIS
# =====================================================

print("\n=== REFUNDED WITH NEGATIVE QTY ===")
print(
    df[df["qty"] < 0]["status"]
    .value_counts(dropna=False)
)

print("\n=== NEGATIVE QTY SAMPLE ===")
print(
    df[df["qty"] < 0]
    .head(20)
)

# =====================================================
# PRICE OUTLIERS
# =====================================================

print("\n=== ROWS WITH PRICE = 999999 ===")
print(
    df[df["unit_price"] == 999999]
)

print("\n=== ROWS WITH PRICE = 0 ===")
print(
    df[df["unit_price"] == 0]
    .head(20)
)

print("\n=== POSSIBLE OUTLIERS (PRICE > 10000) ===")
print(
    df[df["unit_price"] > 10000][[
        "order_id",
        "sku",
        "product_name",
        "unit_price",
        "currency"
    ]]
)

# =====================================================
# EMAIL / CUSTOMER ANALYSIS
# =====================================================

print("\n=== EMAIL -> CUSTOMER_ID CONSISTENCY ===")

email_customer = (
    df.groupby("customer_email")["customer_id"]
      .nunique()
)

print(email_customer[email_customer > 1])

print("\n=== MISSING CUSTOMER_ID EMAILS ===")

print(
    df[df["customer_id"].isnull()]
    [["customer_email"]]
    .drop_duplicates()
    .head(20)
)

# =====================================================
# CATEGORY CONSISTENCY
# =====================================================

print("\n=== SKU -> CATEGORY CONSISTENCY ===")

sku_category = (
    df.groupby("sku")["category"]
      .nunique(dropna=True)
)

print(sku_category[sku_category > 1])

print("\n=== PRODUCT -> CATEGORY CONSISTENCY ===")

product_category = (
    df.groupby("product_name")["category"]
      .nunique(dropna=True)
)

print(product_category[product_category > 1])

# =====================================================
# EMAIL VALIDATION
# =====================================================

print("\n=== INVALID EMAILS ===")

invalid_emails = df[
    ~df["customer_email"].str.contains("@", na=False)
]

print(invalid_emails.head(20))
print("Count:", len(invalid_emails))

# =====================================================
# SKU FORMAT VALIDATION
# =====================================================

print("\n=== SUSPICIOUS SKU FORMATS ===")

print(
    df[
        ~df["sku"].str.match(
            r"^SKU-[A-Z]{2}-\d{3}$",
            na=False
        )
    ]["sku"]
    .value_counts()
)

# =====================================================
# COUNTRY VS CURRENCY
# =====================================================

print("\n=== COUNTRY BY CURRENCY ===")

print(
    pd.crosstab(
        df["country"],
        df["currency"]
    )
)

# =====================================================
# STATUS VS QTY SIGN
# =====================================================

print("\n=== STATUS BY QTY SIGN ===")

df["qty_sign"] = df["qty"].apply(
    lambda x: "negative" if x < 0 else "positive"
)

print(
    pd.crosstab(
        df["status"],
        df["qty_sign"]
    )
)

# =====================================================
# REVENUE ANALYSIS
# =====================================================

df["line_amount"] = df["qty"] * df["unit_price"]

print("\n=== REVENUE BY CURRENCY ===")

print(
    df.groupby("currency")["line_amount"]
      .sum()
      .sort_values(ascending=False)
)

print("\n=== TOP 20 CUSTOMERS BY ORDER COUNT ===")

print(
    df.groupby("customer_email")
      .size()
      .sort_values(ascending=False)
      .head(20)
)