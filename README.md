# 🌐 Resilient-Sync: Global Supply Chain Risk & Operational Analytics
## 🚀 Executive Summary
Resilient-Sync is a high-impact analytical framework developed to solve complex supply chain inefficiencies. By architecting an end-to-end pipeline that bridges operational data with environmental and geopolitical risk models, this project provides a prescriptive solution for logistics optimization, achieving a 4x improvement over baseline efficiency benchmarks.

## 🛠 Technical Architecture
### Data Engineering & Synthetic Simulation (Python)

**Pipeline Development:** Architected a custom Python pipeline, weather_simulator.py, to simulate real-world supply chain volatility.

**Probabilistic Matrix:** Utilized np.random.choice with weighted probabilities to simulate five distinct environmental conditions, ranging from 'Clear Sky' to 'Port Congestion Due to Storm'.

**Deterministic Reproducibility:** Implemented np.random.seed(42) to ensure that all generated disruption scenarios remain reproducible across different analytical runs.

**Impact Mapping:** Engineered the calculate_operational_impact function to quantitatively correlate weather variables with Weather_Delay_Days and Risk_Severity (Low/Medium/High).

### Geopolitical Intelligence Integration

**Dataset Curation:** Curated a Geopolitical_data.csv master table by manually mapping critical global chokepoints to operational risk profiles.

**Strategic Mapping:** Linked every Port_Region with a proprietary Geopolitical_Risk_Score and Alternative_Route_Penalty_Cost to quantify the financial impact of regional tensions.

**Unified Source of Truth:** Integrated this intelligence into the PostgreSQL pipeline using sql_script_for_resilient_sync.sql, enabling cross-regional risk analysis and data-backed mitigation planning.

### Database Management (PostgreSQL)

**Relational Schema Design:** Designed a robust relational model to harmonize disparate transactional datasets with external weather and geopolitical logs.

**Unified View Creation:** Executed complex Common Table Expressions (CTEs) within sql_script_for_resilient_sync.sql to de-duplicate and join datasets, creating the UNIFIED_SUPPLY_CHAIN_ANALYSIS view.

**Data Integrity & Audits:** Implemented automated validation scripts to identify unmapped regional names and ensure 100% data fidelity by comparing row counts between the source and the final analytical view.

### Decision Intelligence (Power BI)

**DAX-Driven Analytics:** Developed a dynamic, multi-page dashboard utilizing advanced DAX measures to visualize supply chain performance and shipping delay variances.

**Strategic Prioritization:** Built an "Impact-versus-Ease" Matrix, providing stakeholders with a clear framework to prioritize high-value risk-mitigation initiatives based on the integrated dataset.


## 📊 Strategic Performance Insights

### 1. Operational Bottlenecks
**Fulfillment Health:** Current 45.18 Overall Health Score identifies systemic inefficiencies.

**Primary Detractor:** The 'Standard Class' shipping mode accounts for a 54.83% late delivery rate, pinpointing the exact segment requiring process re-engineering.

**Throughput Constraint:** High accumulation of 'Pending/Processing' orders is creating fulfillment backlogs that degrade overall customer satisfaction.

### 2. Risk & Financial Exposure
**Exposure Assessment:** 4.17 Risk Exposure Index necessitates proactive monitoring of regional transit channels.

**Financial Impact:** Logistical failures (Typhoons, Cyclones, and Port Congestion) have incurred ~$2.8 billion in total penalty costs.

**Strategic Choke Points:** Geopolitical tensions in West Asia, the Suez Canal, and the Horn of Africa are the primary drivers of volatility.

### 3. Value Generation & Strategic Roadmap
**Efficiency Gain:** Achieved $635.24M in penalty savings, a 4x performance increase over the $162.41M initial benchmark.

**Margin Integrity:** High-growth segments ('Water Sports', 'Women’s Apparel') maintain a 10.78% net profit margin, providing a critical financial hedge against supply chain shocks.

**Future-Proofing:** Initiated the 'Route Diversification' and 'Weather Monitoring' programs, ranked as high-priority initiatives via the Impact-versus-Ease assessment.

## Dashboard Overview

**Page 1: Logistics Performance**
[Page 1](dashboard/page1.png)

**Page 2: Risk & Financial Exposure**
[Page 2](dashboard/page2.png)

**Page 3: Strategic Roadmap**
[Page 3](dashboard/page3.png)


### 📂 Data Source
The dataset used for this project is sourced from Kaggle. You can access it here: 
[Click here to view the DataCo Supply Chain Dataset](https://www.kaggle.com/datasets/shashwatwork/dataco-smart-supply-chain-for-big-data-analysis)


## ⚙️ Prerequisites & Setup

Ensure you have Python 3.x and PostgreSQL installed.

To reproduce the analysis, run the data generation scripts in the /scripts folder before executing the SQL models in /database.
