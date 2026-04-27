---
Marketing Campaign Performance Analysis
---
Project Overview
End-to-end data analytics project analyzing 200,000 marketing campaign records across 6 channels to evaluate ROI, Customer Acquisition Cost (CAC), conversion rates, and engagement performance. The goal was to identify the highest-performing channels and provide data-driven recommendations for budget reallocation.

Tools Used & Tool Purpose
---
Python (Pandas, NumPy)	- Data cleaning & preparation <br>
SQL (SQLite) -	Business queries & metric calculation<br>
Microsoft Excel -	Pivot tables & summary charts<br>
Power BI -	Interactive dashboard

Dataset
---
Source: [dataset link] (https://www.kaggle.com/datasets/manishabhatt22/marketing-campaign-performance-dataset)<br>
Size: 200,000 rows × 17 columns<br>
Channels: Facebook, Website, Google Ads, Email, Instagram, YouTube<br>
Campaign Types: Email, Influencer, Display, Search, Social Media<br>
Date Range: 2021 — 2022

Project Structure
---
marketing-campaign-analysis/<br>
│
├── data/<br>
│   └── marketing_campaign_cleaned.csv    ← cleaned dataset<br>
│
├── python/<br>
│   └── data_cleaning.py                  ← cleaning & EDA script<br>
│
├── sql/<br>
│   └── analysis_queries.sql              ← 12 business queries<br>
│
├── excel/<br>
│   └── marketing_campaign_analysis.xlsx  ← pivot tables & charts<br>
│
├── powerbi/<br>
│   └── marketing_campaign_dashboard.pbix ← interactive dashboard<br>
│
└── screenshots/<br>
    ├── page1_executive_summary.png<br>
    ├── page2_channel_deep_dive.png<br>
    └── page3_campaign_analysis.png

---
Step 1 — Data Cleaning (Python)
---
Performed the following cleaning operations on the raw dataset:<br>
Checked and confirmed zero duplicate rows and zero null values<br>
Standardised all column names to lowercase with underscores<br>
Standardised text values to consistent Title Case across all categorical columns<br>
Converted percentage strings to float values where needed<br>
Verified and retained pre-existing metrics: ROI, conversion rate, engagement rate<br>
Exported cleaned dataset to CSV for SQL and Power BI analysis

Step 2 — SQL Analysis (12 Queries)
---
Wrote 12 business queries in SQLite covering:<br>
Q1	Overall campaign snapshot<br>
Q2	ROI by channel<br>
Q3	Customer Acquisition Cost (CAC) by channel<br>
Q4	Engagement rate by channel<br>
Q5	Full channel performance scorecard<br>
Q6	ROI by campaign type<br>
Q7	ROI by customer segment<br>
Q8	Best channel per customer segment<br>
Q9	Performance by campaign duration<br>
Q10	Top 2 highest-ROI channels<br>
Q11	Monthly ROI trend over time<br>
Q12	Location-wise performance

Step 3 — Excel Analysis
---
Built 4 pivot tables with charts:<br>
PT1 — Average ROI by Channel<br>
PT2 — Average CAC by Channel<br>
PT3 — Average Conversion Rate by Campaign Type<br>
PT4 — Average Engagement Score by Customer Segment

Step 4 — Power BI Dashboard (3 Pages)
---
Page 1 — Executive Summary<br>
4 KPI cards: Total Campaigns (200K), Avg ROI (5.00), Avg CAC ($12,504), Avg Conversion Rate (8%)<br>
ROI by Channel bar chart<br>
CAC by Channel bar chart<br>
Page 2 — Channel Deep Dive<br>
Conversion Rate by Channel<br>
Engagement Rate by Channel<br>
Slicer to filter by channel interactively<br>
Page 3 — Campaign Analysis<br>
Conversion Rate by Campaign Type<br>
ROI by Customer Segment<br>
Engagement Score by Customer Segment<br>
Slicer to filter by campaign type interactively

Key Findings
---
1. Top 2 Highest-ROI Channels<br>
Channel	Avg ROI<br>
Facebook	5.02<br>
Website 	5.01<br>
2. Most Cost-Efficient Channel (Lowest CAC)<br>
Channel	Avg CAC<br>
YouTube	$12,481<br>
Website	$12,488<br>
3. Channel Performance is Balanced<br>
All 6 channels performed very similarly in ROI (range: 4.99–5.02) and CAC (~$12,500). This indicates a well-optimised channel mix — the bigger opportunity lies in improving conversion rates and engagement rather than shifting budget between channels.<br>
4. Recommendations<br>
Invest more in Facebook and Website — highest ROI at 5.02 and 5.01<br>
Scale YouTube campaigns — lowest customer acquisition cost at $12,481
Focus on conversion rate optimisation — since channel ROI is similar, improving landing pages and offers will have more impact than channel switching
---
Dashboard Screenshots
---
Page 1 — Executive Summary
![Executive Summary](page1.png)
Page 2 — Channel Deep Dive
![Channel Deep Dive](page2.png)
Page 3 — Campaign Analysis
![Campaign Analysis](page3.png)


SQL queries:
---
Go to https://sqliteonline.com<br>
Import `data/marketing_campaign_cleaned.csv`<br>
Run queries from `sql/analysis_queries.sql`<br>
Power BI dashboard:<br>
Download Power BI Desktop (free)<br>
Open `powerbi/marketing_campaign_dashboard.pbix`

Author<br>
Burugu Pallavi<br>
LinkedIn: [PallaviBurugu](https://www.linkedin.com/in/burugu-pallavi-18b462190/)<br>
GitHub: [PallaviBurugu](https://github.com/Pallavi63)
