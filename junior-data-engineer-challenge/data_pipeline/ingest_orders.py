import requests
import pandas as pd
from sqlalchemy import create_engine
from dotenv import load_dotenv
import os

load_dotenv()

DB_HOST = os.getenv("DB_HOST")
DB_PORT = os.getenv("DB_PORT")
DB_NAME = os.getenv("DB_NAME")
DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")

URL = "https://jzozteoirwfczccltcdr.supabase.co/rest/v1/orders_raw?apikey=sb_publishable_Xwjiw--qkKcbMuSbKd6I2w_wN9mpNTv"

response = requests.get(URL)

if response.status_code != 200:
    raise Exception(f"API Error: {response.status_code}")

data = response.json()

df = pd.DataFrame(data)

print(f"Rows downloaded: {len(df)}")

engine = create_engine(
    f"postgresql+psycopg2://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"
)

df.to_sql(
    "orders_raw",
    engine,
    if_exists="replace",
    index=False
)

print("orders_raw loaded successfully!")