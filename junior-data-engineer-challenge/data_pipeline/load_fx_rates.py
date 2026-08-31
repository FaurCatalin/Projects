import pandas as pd
from sqlalchemy import create_engine
from dotenv import load_dotenv
import requests
import os

load_dotenv()

DB_HOST = os.getenv("DB_HOST")
DB_PORT = os.getenv("DB_PORT")
DB_NAME = os.getenv("DB_NAME")
DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")

engine = create_engine(
    f"postgresql+psycopg2://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"
)

dates = pd.date_range(
    start="2026-08-23",
    end="2026-09-03"
)

rates = []

for current_date in dates:
    date_str = current_date.strftime("%Y-%m-%d")

    url = (
        f"https://api.frankfurter.app/{date_str}"
        "?from=RON&to=EUR"
    )

    response = requests.get(url)
    data = response.json()

    rates.append(
        {
            "rate_date": date_str,
            "base_currency": "RON",
            "target_currency": "EUR",
            "rate": data["rates"]["EUR"]
        }
    )

df = pd.DataFrame(rates)

df.to_sql(
    "fx_rates",
    engine,
    if_exists="replace",
    index=False
)

print(df)
print("\nFX rates loaded successfully!")