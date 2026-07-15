
Use teenmentalhealth;

select *
From mentalhealthanalysis;

-- Total male
Select gender,
		count(*) AS Total_male
From mentalhealthanalysis
Where gender = 'male';       

-- Total female
Select gender,
		count(*) AS Total_female
From mentalhealthanalysis
Where gender = 'female';   

-- Percentage of male and female
Select gender,
		count(*) AS count,
        Round( count(*) * 100.0 / sum(count(*)) over(), 2) AS percentage
From mentalhealthanalysis
Group by gender
order by percentage desc;

-- Gender VS Social media usage
Select gender, social_media_usage,
		count(*) AS total
From mentalhealthanalysis
Group by gender, social_media_usage
Order by total desc;

-- Age group VS Social media usage
Select age_group, social_media_usage,
		count(*) total
From mentalhealthanalysis
Group by age_group, social_media_usage
order by total desc;


-- Total count of platform usage
Select platform_usage,
		count(*) AS total_usage
From mentalhealthanalysis
Group by platform_usage;

-- Average sleep hours
select avg(sleep_hours)
From mentalhealthanalysis;

-- Social media usage
Select social_media_usage,
		count(*) AS total,
        round(count(*) *100.0 / sum(COUNT(*)) over(), 2) AS percentage,
        avg(sleep_hours),
        avg(academic_performance)
from mentalhealthanalysis
Group by social_media_usage
order by total desc;

-- Academic performance VS Social media usage
Select social_media_usage,
		academic_performance_rate,
		count(*) AS number_of_teens,
        Round(avg(academic_performance), 2) AS avg_academic_performance,
        Round(avg(sleep_hours), 2) AS avg_sleep_hours,
        Round(avg(physical_activity), 2) AS avg_physical_activity,
        Round(avg(addiction_level), 2) AS avg_addiction_level,
        Round(avg(case when depression_label = 1 then 100.0 else 0 end), 2) AS depression_rate_percentage
From mentalhealthanalysis
Group by  social_media_usage,academic_performance_rate
Order by  social_media_usage, academic_performance_rate desc;

-- Social media usage VS Social interaction
Select social_media_usage, social_interaction_level, academic_performance_rate,
        count(*) AS Total
From mentalhealthanalysis
Group by social_media_usage, social_interaction_level
order by total desc;


-- Mental health analysis
  Select social_media_usage,
		social_interaction_level,
        count(*) AS number_of_teens,
        round(avg(daily_social_media_hours), 2) AS avg_social_media_hours,
        round(avg(stress_level), 2) AS avg_stress_level,
        round(avg(anxiety_level), 2) AS avg_anxiety_level,
        round(avg(sleep_hours), 2) AS avg_sleep,
        round(avg(depression_label), 2)* 100 AS avg_depression_rate_percentage
From mentalhealthanalysis
Group by social_media_usage, social_interaction_level
order by social_media_usage, social_interaction_level;

-- Depression label distribution
Select  depression_label,
		count(*) AS total,
		round(count(*) * 100.0 / sum(count(*)) over(), 2) AS depression_rate
From mentalhealthanalysis
Group by depression_label;

