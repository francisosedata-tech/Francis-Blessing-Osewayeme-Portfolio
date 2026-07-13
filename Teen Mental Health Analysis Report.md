# Teen Mental Wellbeing Analysis Report

*Prepared by:* Francis Osewayeme  
*Date:* July 2026  
*Project:* Internship / Personal Data Analysis Project

## Executive Summary
This analysis examines the relationship between social media usage, academic performance, sleep patterns, and mental health indicators (stress, anxiety, addiction, depression) among teens using SQL and Power BI. Key finding: High social media usage correlates with elevated risks, though overall depression rates remain moderate at *2.58%*.

## Key Metrics
- *Total Teens:* 1,200
- *Depression Rate:* 2.58%
- *Avg. Social Media Hours:* 4.54
- *High Media Usage:* 42.58%
- *Female:* Most affected group

## Key Insights
1. *Depression by Gender:* Females (43.93% of depression cases) show higher vulnerability than males.
2. *Social Media Impact:*
   - High usage linked to higher average stress, anxiety, and addiction.
   - Low/medium usage shows better outcomes.
3. *Academic Performance:* Slight negative correlation with high social media hours; younger teens more affected in some segments.
4. *Platform Usage:* Instagram and TikTok dominate; combined usage common.
5. *Sleep & Screen Time:* Average sleep ~6.45 hours; screen time ~1.74 hours — room for improvement.

## Visualizations
![Teen Mental Wellbeing Dashboard](https://github.com/francisosedata-tech/Ose_Portfolio/blob/47d58b01bfd0474e0b2153b23a473c7f556e95bb/ccb740e6-9e5c-4ac6-8d8f-7a843d147e86.jpeg)  
![Academic Performance Dashboard](https://github.com/francisosedata-tech/Ose_Portfolio/blob/193e0502beac0891f8ffd0a3058ed32b7e7985e0/ede51689-394d-4ea4-b93a-70983466548a.jpeg)

## SQL Queries Used

Below are key SQL queries I wrote to explore and analyze the dataset:

### 1. Overall Summary Statistics
```sql
SELECT 
    COUNT(*) AS total_teens,
    AVG(daily_social_media_hours) AS avg_social_media_hours,
    AVG(sleep_hours) AS avg_sleep_hours,
    AVG(screen_time_before_sleep) AS avg_screen_time,
    AVG(academic_performance) AS avg_academic_performance,
    COUNT(CASE WHEN depression_label = 1 THEN 1 END) * 100.0 / COUNT(*) AS depression_rate_pct
FROM teen_mental_health;

### 1. Depression Rate by Gender and Social Media Usage
SELECT 
    gender,
    social_media_usage,
    COUNT(*) AS teen_count,
    AVG(depression_label) * 100 AS depression_rate_pct,
    AVG(stress_level) AS avg_stress,
    AVG(anxiety_level) AS avg_anxiety,
    AVG(addiction_level) AS avg_addiction
FROM teen_mental_health
GROUP BY gender, social_media_usage
ORDER BY depression_rate_pct DESC;

### 3. Academic Performance vs Social Media Usage

SELECT 
    social_media_usage,
    age_group,
    AVG(academic_performance) AS avg_academic_performance,
    AVG(sleep_hours) AS avg_sleep_hours,
    COUNT(*) AS teen_count
FROM teen_mental_health
GROUP BY social_media_usage, age_group
ORDER BY avg_academic_performance DESC;.


## Recommendations
- *Education Campaigns:* School programs on mindful social media use and sleep importance.
- *Targeted Support:* Focus on female and high-usage teens for counseling or digital wellness tools.
- *Parental/Policy Guidance:* Encourage balanced platform usage and monitor extreme cases.
- *Further Research:* Longitudinal studies to establish causality; explore protective factors like physical activity.
- *Business/Org Angle:* Partner with mental health nonprofits or ed-tech companies for dashboard deployment.

## Tools & Technologies
- *Power BI* – Interactive dashboards and DAX measures
- *Power Query* – Data cleaning & transformation
- *SQL* – Queries for aggregations and correlations
- *Excel* – Initial exploration

*Francis Osewayeme*  
Data Analyst | Turning messy data into actionable insights  
[LinkedIn](https://www.linkedin.com/in/ose-francis-0a3796411?utm_source=share_via&utm_content=profile&utm_medium=member_ios) | [X @DataAnalystOse](...) | [Email](mailto:francisose.data@gmail.com)
