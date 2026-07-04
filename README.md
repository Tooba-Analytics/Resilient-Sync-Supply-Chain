# 🌐 Resilient-Sync: Global Supply Chain Risk & Operational Analytics
## 🚀 Executive Summary
Resilient-Sync is a high-impact analytical framework developed to solve complex supply chain inefficiencies. By architecting an end-to-end pipeline that bridges operational data with environmental and geopolitical risk models, this project provides a prescriptive solution for logistics optimization, achieving a 4x improvement over baseline efficiency benchmarks.

## 🛠 Technical Architecture
**Data Engineering & Synthetic Simulation (Python)**
To simulate real-world volatility, I built a custom Python pipeline that generates probabilistic disruption scenarios.

Probabilistic Matrix: Using np.random.choice with weighted probabilities, I simulated five environmental conditions (ranging from 'Clear Sky' to 'Port Congestion').

Deterministic Simulation: Implemented np.random.seed(42) to ensure the reproducibility of the disruption scenarios during analysis.

Impact Mapping: Created a custom function (calculate_operational_impact) to correlate weather conditions with Weather_Delay_Days and Risk_Severity (Low/Medium/High), providing a quantitative basis for risk assessment.

**Geopolitical Intelligence Integration**
I curated a master Geopolitical_data.csv table that maps regional chokepoints to operational risks.

Strategic Mapping: Each Port_Region is mapped to a Geopolitical_Risk_Score and an Alternative_Route_Penalty_Cost.

Unified Source of Truth: This table was integrated with the transactional data via PostgreSQL, allowing for cross-regional risk analysis and "Impact-vs-Ease" mitigation planning in the dashboard.

**Database Management (PostgreSQL):** Designed a relational model to integrate disparate datasets. Executed complex CTEs (Common Table Expressions) and JOIN operations to create a unified source of truth for supply chain performance.

**Decision Intelligence (Power BI):** Developed a dynamic dashboard utilizing DAX-driven analytics. The visualization layer features an Impact-versus-Ease Matrix to prioritize risk-mitigation initiatives effectively.

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
![Page 1]("C:\Resilient-Sync-Supply-Chain\dashboard\page1.png")

**Page 2: Risk & Financial Exposure**
![Page 2](dashboard/page2.png)

**Page 3: Strategic Roadmap**
![Page 3](dashboard/page3.png)


### 📂 Data Source
The dataset used for this project is sourced from Kaggle. You can access it here: 
[Click here to view the DataCo Supply Chain Dataset](https://www.kaggle.com/datasets/shashwatwork/dataco-smart-supply-chain-for-big-data-analysis)


## ⚙️ Prerequisites & Setup

Ensure you have Python 3.x and PostgreSQL installed.

To reproduce the analysis, run the data generation scripts in the /scripts folder before executing the SQL models in /database.
