select*
from project.dbo.project_output


--How many States were represented in the race
select COUNT(Distinct State) as distinct_count
from project.dbo.project_output

--What was the average time of Men Vs Women
Select Gender, AVG(Total_minutes) as avg_time
from project.dbo.project_output
group by Gender

--What were the youngest and oldest ages in the race
SELECT Gender, Min(age) as youngest, Max(age) as oldest
From project.dbo.project_output
Group by Gender

--What was the average time for each age group

with age_buckets as (
Select Total_Minutes,
     case when age < 30 then 'age_20-29'
	      when age < 40 then 'age_30-39'
		  when age < 50 then 'age_40-49'
		  when age < 60 then 'age_50-59'
	else 'age_60+' end as age_group
from project.dbo.project_output
)

Select age_group, avg(total_minutes) avg_race_time
from age_buckets
group by age_group

--Top 3 males and females

with gender_rank as (
Select rank() over ( partition by Gender order by total_minutes asc) as gender_rank,
fullname,
gender,
total_minutes
from project.dbo.project_output
)

Select*
from gender_rank
where gender_rank < 4
order by total_minutes
