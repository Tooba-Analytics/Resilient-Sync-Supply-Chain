import pandas as pd
import numpy as np
import os

def generate_weather_disruption_data(input_csv_path, output_csv_path):
    print("Reading primary supply chain transactional data...")
    if not os.path.exists(input_csv_path):
        raise FileNotFoundError(f"Source file not found at: {input_csv_path}")
        
    df = pd.read_csv(input_csv_path, encoding='latin1')

    # Force column names to be clean and lowercase
    df.columns = df.columns.str.strip()
    
    # Let's map columns by index directly if names are giving issues
    # Standard DataCo has Shipping Date around index 20-30 and Region around index 15-25
    shipping_col = None
    region_col = None
    
    for col in df.columns:
        if 'shipping date' in col.lower():
            shipping_col = col
        if 'order region' in col.lower() or 'region' in col.lower():
            region_col = col

    # Fallback to absolute indexes if string matching fails
    if not shipping_col or not region_col:
        print("Falling back to position-based column mapping...")
        shipping_col = df.columns[1] # standard fallback
        region_col = df.columns[14] if len(df.columns) > 14 else df.columns[-1]

    print("Extracting unique spatial-temporal granular combinations...")
    weather_base = df[[shipping_col, region_col]].drop_duplicates().copy()
    weather_base.rename(columns={shipping_col: 'Shipping_Date', region_col: 'Region'}, inplace=True)
    
    weather_base['Shipping_Date'] = pd.to_datetime(weather_base['Shipping_Date']).dt.date

    print("Simulating probabilistic environmental anomaly matrices...")
    conditions = ['Clear Sky', 'Heavy Rainfall', 'Typhoon / Cyclone', 'Dense Fog', 'Port Congestion Due to Storm']
    weights = [0.75, 0.12, 0.05, 0.05, 0.03]

    np.random.seed(42) 
    weather_base['Weather_Condition'] = np.random.choice(conditions, size=len(weather_base), p=weights)

    def calculate_operational_impact(condition):
        if condition == 'Clear Sky':
            return 0, 'Low'
        elif condition in ['Heavy Rainfall', 'Dense Fog']:
            return np.random.randint(1, 3), 'Medium'
        else:
            return np.random.randint(3, 7), 'High'

    print("Mapping cascading downstream delay metrics...")
    impact_metrics = weather_base['Weather_Condition'].apply(calculate_operational_impact)
    
    weather_base['Weather_Delay_Days'] = [metric[0] for metric in impact_metrics]
    weather_base['Risk_Severity'] = [metric[1] for metric in impact_metrics]

    print("Persisting processed dimension schema to file system...")
    weather_base.to_csv(output_csv_path, index=False)
    print(f"Success! Synthetic data framework written to target path: {output_csv_path}")

if __name__ == "__main__":
    INPUT_FILE = "C:\sql.data\DataCoSupplyChainDataset.csv"
    OUTPUT_FILE = "C:\sql.data\weather_disruption_log.csv"
    
    generate_weather_disruption_data(INPUT_FILE, OUTPUT_FILE)