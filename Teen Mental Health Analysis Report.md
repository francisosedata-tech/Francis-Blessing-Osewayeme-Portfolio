# Teen Mental Wellbeing Analysis Report

*Prepared by:* Francis Osewayeme  
*Date:* July 2026  
*Project Type:* Internship / Independent Data Analysis Project

## Executive Summary
This analysis of 1,200 teens explores the interplay between *social media usage, academic performance, sleep patterns, and mental health indicators (stress, anxiety, addiction, depression). Using SQL for data extraction and Power BI for visualization, the study reveals moderate but concerning risks associated with high social media engagement. **Overall depression rate stands at 2.58%*, with females and high-usage teens most affected.

*Key Business/Social Impact:* Early interventions can significantly improve teen wellbeing and academic outcomes.

## Dataset
- *File:* teen_mental_health_project.(1,200 records)  
- *Download:* [teen_mental_health_project.csv](https://github.com/francisosedata-tech/Ose_Portfolio/blob/de68edb669d81baefd124b9ba4a5ab9b955d9eb6/Teen_Mental_health_project.csv)  
- *Key Columns:* age, age_group, gender, daily_social_media_hours, social_media_usage, platform_usage, sleep_hours, screen_time_before_sleep, academic_performance, stress_level, anxiety_level, addiction_level, depression_label

## SQL Queries Used

I wrote the following SQL queries to explore and analyze the dataset:

### 1. Overall Summary Statistics
```sql
SELECT 
    COUNT(*) AS total_teens,
    ROUND(AVG(daily_social_media_hours), 2) AS avg_social_media_hours,
    ROUND(AVG(sleep_hours), 2) AS avg_sleep_hours,
    ROUND(AVG(screen_time_before_sleep), 2) AS avg_screen_time,
    ROUND(AVG(academic_performance), 2) AS avg_academic_performance,
    ROUND(COUNT(CASE WHEN depression_label = 1 THEN 1 END) * 100.0 / COUNT(*), 2) AS depression_rate_pct
FROM teen_mental_health;

## Key Metrics & Insights
- *Total Teens Analyzed:* 1,200
- *Depression Rate:* 2.58%
- *High Social Media Usage:* 42.58%
- *Average Sleep Hours:* 6.45
- *Average Screen Time:* 1.74 hours
- *Gender Insight:* Females represent *43.93%* of depression cases despite balanced representation.
- *Platform Dominance:* Instagram and TikTok lead in usage.

*Visual Highlights:*
![Teen Mental Wellbeing Dashboard](https://github.com/francisosedata-tech/Ose_Portfolio/blob/47d58b01bfd0474e0b2153b23a473c7f556e95bb/ccb740e6-9e5c-4ac6-8d8f-7a843d147e86.jpeg)  
![Academic Performance vs Social Media](https://github.com/francisosedata-tech/Ose_Portfolio/blob/193e0502beac0891f8ffd0a3058ed32b7e7985e0/ede51689-394d-4ea4-b93a-70983466548a.jpeg)


*Core Findings:*
- High social media usage correlates with elevated *stress (5.6+), **anxiety, and **addiction* levels.
- Moderate negative relationship between daily social media hours and academic performance, especially among younger teens.
- Low/medium usage groups show better sleep and mental health indicators.

## Stakeholder-Specific Recommendations & Actions

### For *Schools & Educators*
- *Implement Digital Wellness Curriculum:* Integrate weekly modules on mindful social media use and sleep hygiene for students with high usage (>4.5 hours/day).
- *Early Screening:* Use similar dashboards to flag at-risk students (high media usage + low sleep) for counseling.
- *Parental Engagement:* Host workshops showing these visualizations to encourage home-school collaboration.

### For *Parents & Guardians*
- *Set Usage Boundaries:* Encourage <4 hours daily social media with family screen-free times, especially before bed.
- *Monitor & Communicate:* Focus conversations on quality over quantity of usage; promote physical activity as a buffer.
- *Model Behavior:* Parents should demonstrate balanced digital habits.

### For *Mental Health Organizations & Policymakers*
- *Targeted Campaigns:* Launch awareness drives focused on female teens and popular platforms (Instagram/TikTok).
- *Intervention Programs:* Develop or scale apps/tools that track usage and suggest breaks, aiming to reduce high-usage group risks.
- *Policy Advocacy:* Push for platform accountability on teen mental health features and support school-based data monitoring tools.

### For *Ed-Tech Companies & Researchers*
- *Product Features:* Build dashboards like this into learning platforms for real-time wellbeing insights.
- *Further Analysis:* Conduct longitudinal studies to measure intervention impact and explore protective factors (e.g., sports, strong social interaction).

## Tools & Technologies Used
- *Power BI* – Interactive dashboards, DAX measures, visualizations
- *Power Query* – Data cleaning and transformation
- *SQL* – Aggregations, correlations, and insights extraction
- *Excel* – Preliminary exploration

---

*Francis Osewayeme*  
Data Analyst | Transforming messy data into clear, actionable insights for business and social impact  
[LinkedIn](https://www.linkedin.com/in/ose-francis-0a3796411) | [X @DataAnalystOse](https://x.com/DataAnalystOse) | [Email](mailto:francisose.data@gmail.com) | [WhatsApp](https://wa.me/2348162572994)
