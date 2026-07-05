import pandas as pd
import io
from sqlalchemy import create_engine

# Database Connection
engine = create_engine('postgresql://postgres@localhost:5432/supply_chain_db')

file_path = r'c:\sql.data\DataCoSupplyChainDataset.csv' 

print("Loading data from:", file_path)
final_df = pd.read_csv(file_path, encoding='latin1')

def fast_load(df, table_name, engine):
    print(f"Loading {len(df)} rows into {table_name}...")
    df.head(0).to_sql(table_name, engine, if_exists='replace', index=False)
    conn = engine.raw_connection()
    cur = conn.cursor()
    output = io.StringIO()
    df.to_csv(output, sep='\t', header=False, index=False)
    output.seek(0)
    try:
        cur.copy_from(output, table_name, null="", columns=df.columns)
        conn.commit()
        print("SUCCESS! Data has been loaded.")
    except Exception as e:
        print(f"Error: {e}")
    finally:
        cur.close()
        conn.close()

fast_load(final_df, 'master_supply_chain', engine)