-- ============================================================
-- Marketing Campaign Performance Analysis
-- Step 2: SQL Analysis Queries
-- Author: Burugu Pallavi
-- Dataset: marketing_campaign_cleaned.csv
-- Tool: Run these in SQLiteOnline.com (free, no install needed)
--       → Go to https://sqliteonline.com
--       → Click "Import" and upload marketing_campaign_cleaned.csv
--       → The table name will be: marketing_campaign_cleaned
-- ============================================================


-- ============================================================
-- PREP: Clean acquisition_cost column
-- It is stored as "$16,174.00" — we strip $ and commas
-- and cast it to a number in every query using:
--   CAST(REPLACE(REPLACE(acquisition_cost, '$', ''), ',', '') AS REAL)
-- ============================================================


-- ============================================================
-- QUERY 1: OVERALL CAMPAIGN SNAPSHOT
-- Purpose : High-level summary of the entire dataset
-- Metrics : Total campaigns, total clicks, avg ROI,
--           avg conversion rate, avg engagement rate
-- ============================================================

SELECT
    COUNT(*)                                                        AS total_records,
    COUNT(DISTINCT campaign_id)                                     AS total_campaigns,
    COUNT(DISTINCT channel_used)                                    AS total_channels,
    COUNT(DISTINCT campaign_type)                                   AS total_campaign_types,
    ROUND(SUM(clicks) / 1000000.0, 2)                              AS total_clicks_millions,
    ROUND(AVG(roi), 2)                                             AS avg_roi,
    ROUND(AVG(conversion_rate) * 100, 2)                           AS avg_conversion_rate_pct,
    ROUND(AVG(engagement_rate), 2)                                 AS avg_engagement_rate
FROM marketing_campaign_cleaned;


-- ============================================================
-- QUERY 2: ROI BY CHANNEL
-- Purpose : Find which channel delivers the best return
-- Insight  : Tells you where to invest more budget
-- Resume   : "identify the top 2 highest-ROI channels"
-- ============================================================

SELECT
    channel_used,
    COUNT(*)                                                        AS total_records,
    ROUND(AVG(roi), 2)                                             AS avg_roi,
    ROUND(MIN(roi), 2)                                             AS min_roi,
    ROUND(MAX(roi), 2)                                             AS max_roi,
    ROUND(AVG(conversion_rate) * 100, 2)                           AS avg_conversion_rate_pct,
    ROUND(AVG(engagement_rate), 2)                                 AS avg_engagement_rate
FROM marketing_campaign_cleaned
GROUP BY channel_used
ORDER BY avg_roi DESC;


-- ============================================================
-- QUERY 3: CUSTOMER ACQUISITION COST (CAC) BY CHANNEL
-- Purpose : Find cheapest channel to acquire a customer
-- Insight  : Lower CAC = more efficient spend
-- Resume   : "customer acquisition cost (CAC)"
-- Note     : acquisition_cost needs $ and , stripped first
-- ============================================================

SELECT
    channel_used,
    COUNT(*)                                                        AS total_records,
    ROUND(
        AVG(CAST(REPLACE(REPLACE(acquisition_cost, '$', ''), ',', '') AS REAL)),
    2)                                                             AS avg_cac,
    ROUND(
        MIN(CAST(REPLACE(REPLACE(acquisition_cost, '$', ''), ',', '') AS REAL)),
    2)                                                             AS min_cac,
    ROUND(
        MAX(CAST(REPLACE(REPLACE(acquisition_cost, '$', ''), ',', '') AS REAL)),
    2)                                                             AS max_cac
FROM marketing_campaign_cleaned
GROUP BY channel_used
ORDER BY avg_cac ASC;


-- ============================================================
-- QUERY 4: ENGAGEMENT RATE BY CHANNEL
-- Purpose : Which channel gets the most audience interaction?
-- Insight  : High engagement = audience finds the ad relevant
-- Resume   : "engagement rates across 5 marketing channels"
-- ============================================================

SELECT
    channel_used,
    ROUND(AVG(engagement_rate), 4)                                 AS avg_engagement_rate,
    ROUND(AVG(engagement_score), 2)                                AS avg_engagement_score,
    SUM(impressions)                                               AS total_impressions,
    SUM(clicks)                                                    AS total_clicks,
    ROUND(SUM(clicks) * 100.0 / SUM(impressions), 4)              AS overall_ctr
FROM marketing_campaign_cleaned
GROUP BY channel_used
ORDER BY avg_engagement_rate DESC;


-- ============================================================
-- QUERY 5: FULL CHANNEL PERFORMANCE SCORECARD
-- Purpose : One table comparing all key metrics per channel
-- Insight  : This is the "executive summary" table
-- Resume   : "Built a Power BI report comparing channel performance"
-- ============================================================

SELECT
    channel_used,
    COUNT(*)                                                        AS total_campaigns,
    ROUND(AVG(roi), 2)                                             AS avg_roi,
    ROUND(
        AVG(CAST(REPLACE(REPLACE(acquisition_cost, '$', ''), ',', '') AS REAL)),
    2)                                                             AS avg_cac,
    ROUND(AVG(conversion_rate) * 100, 2)                           AS avg_conversion_rate_pct,
    ROUND(AVG(engagement_rate), 2)                                 AS avg_engagement_rate,
    SUM(clicks)                                                    AS total_clicks,
    SUM(impressions)                                               AS total_impressions
FROM marketing_campaign_cleaned
GROUP BY channel_used
ORDER BY avg_roi DESC;


-- ============================================================
-- QUERY 6: ROI BY CAMPAIGN TYPE
-- Purpose : Which type of campaign (Email, Influencer etc.)
--           performs best?
-- Insight  : Helps decide what kind of campaign to run next
-- ============================================================

SELECT
    campaign_type,
    COUNT(*)                                                        AS total_records,
    ROUND(AVG(roi), 2)                                             AS avg_roi,
    ROUND(AVG(conversion_rate) * 100, 2)                           AS avg_conversion_rate_pct,
    ROUND(AVG(engagement_rate), 2)                                 AS avg_engagement_rate,
    ROUND(
        AVG(CAST(REPLACE(REPLACE(acquisition_cost, '$', ''), ',', '') AS REAL)),
    2)                                                             AS avg_cac
FROM marketing_campaign_cleaned
GROUP BY campaign_type
ORDER BY avg_roi DESC;


-- ============================================================
-- QUERY 7: ROI BY CUSTOMER SEGMENT
-- Purpose : Which audience segment gives the best ROI?
-- Insight  : Helps target future campaigns more precisely
-- ============================================================

SELECT
    customer_segment,
    COUNT(*)                                                        AS total_records,
    ROUND(AVG(roi), 2)                                             AS avg_roi,
    ROUND(AVG(conversion_rate) * 100, 2)                           AS avg_conversion_rate_pct,
    ROUND(AVG(engagement_rate), 2)                                 AS avg_engagement_rate
FROM marketing_campaign_cleaned
GROUP BY customer_segment
ORDER BY avg_roi DESC;


-- ============================================================
-- QUERY 8: BEST CHANNEL PER CUSTOMER SEGMENT
-- Purpose : Does channel effectiveness vary by audience?
-- Insight  : E.g. maybe Instagram works great for Fashionistas
--            but not for Tech Enthusiasts
-- ============================================================

SELECT
    customer_segment,
    channel_used,
    ROUND(AVG(roi), 2)                                             AS avg_roi,
    ROUND(AVG(conversion_rate) * 100, 2)                           AS avg_conversion_rate_pct,
    COUNT(*)                                                        AS total_records
FROM marketing_campaign_cleaned
GROUP BY customer_segment, channel_used
ORDER BY customer_segment, avg_roi DESC;


-- ============================================================
-- QUERY 9: PERFORMANCE BY CAMPAIGN DURATION
-- Purpose : Do longer campaigns perform better?
-- Insight  : Helps optimise how long to run a campaign
-- ============================================================

SELECT
    duration,
    COUNT(*)                                                        AS total_records,
    ROUND(AVG(roi), 2)                                             AS avg_roi,
    ROUND(AVG(conversion_rate) * 100, 2)                           AS avg_conversion_rate_pct,
    ROUND(AVG(engagement_rate), 2)                                 AS avg_engagement_rate,
    ROUND(
        AVG(CAST(REPLACE(REPLACE(acquisition_cost, '$', ''), ',', '') AS REAL)),
    2)                                                             AS avg_cac
FROM marketing_campaign_cleaned
GROUP BY duration
ORDER BY avg_roi DESC;


-- ============================================================
-- QUERY 10: TOP 2 HIGHEST ROI CHANNELS — FINAL ANSWER
-- Purpose : Directly answers your resume bullet point
-- Resume   : "identify the top 2 highest-ROI channels
--             for budget reallocation"
-- ============================================================

SELECT
    channel_used,
    ROUND(AVG(roi), 2)                                             AS avg_roi,
    ROUND(
        AVG(CAST(REPLACE(REPLACE(acquisition_cost, '$', ''), ',', '') AS REAL)),
    2)                                                             AS avg_cac,
    ROUND(AVG(conversion_rate) * 100, 2)                           AS avg_conversion_rate_pct,
    ROUND(AVG(engagement_rate), 2)                                 AS avg_engagement_rate
FROM marketing_campaign_cleaned
GROUP BY channel_used
ORDER BY avg_roi DESC
LIMIT 2;


-- ============================================================
-- QUERY 11: MONTHLY TREND — AVG ROI OVER TIME
-- Purpose : How did campaign performance change month by month?
-- Insight  : Spot seasonality or improving/declining trends
-- ============================================================

SELECT
    SUBSTR(date, 1, 7)                                             AS year_month,
    COUNT(*)                                                        AS total_campaigns,
    ROUND(AVG(roi), 2)                                             AS avg_roi,
    ROUND(AVG(conversion_rate) * 100, 2)                           AS avg_conversion_rate_pct,
    SUM(clicks)                                                    AS total_clicks
FROM marketing_campaign_cleaned
GROUP BY year_month
ORDER BY year_month ASC;


-- ============================================================
-- QUERY 12: LOCATION-WISE PERFORMANCE
-- Purpose : Which cities/regions have the best campaign ROI?
-- Insight  : Useful for geo-targeted budget decisions
-- ============================================================

SELECT
    location,
    COUNT(*)                                                        AS total_records,
    ROUND(AVG(roi), 2)                                             AS avg_roi,
    ROUND(AVG(conversion_rate) * 100, 2)                           AS avg_conversion_rate_pct,
    ROUND(
        AVG(CAST(REPLACE(REPLACE(acquisition_cost, '$', ''), ',', '') AS REAL)),
    2)                                                             AS avg_cac
FROM marketing_campaign_cleaned
GROUP BY location
ORDER BY avg_roi DESC;
