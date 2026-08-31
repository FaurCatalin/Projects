from sqlalchemy import create_engine, text
from dotenv import load_dotenv
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

sql_files = [
    "../sql/customer_spend_eur.sql",
    "../sql/country_category_breakdown.sql"
]

with engine.begin() as connection:
    for file_path in sql_files:
        with open(file_path, "r", encoding="utf-8") as file:
            sql = file.read()

        connection.execute(text(sql))
        print(f"Executed: {file_path}")

print("Reports refreshed successfully!")