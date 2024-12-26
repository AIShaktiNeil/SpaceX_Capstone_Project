select * from sql_eda_spacex_capstone sesc ;

#Task 1
#Display the names of the unique launch sites in the space mission
 select distinct Launch_Site from sql_eda_spacex_capstone sesc ;
 
#Task 2
#Display 5 records where launch sites begin with the string 'CCA'
select * from sql_eda_spacex_capstone sesc
where Launch_Site like "CCA%" limit 5;

#Task 3
#Display the total payload mass carried by boosters launched by NASA (CRS)
select sum(PAYLOAD_MASS__KG_) as Total_mass
from sql_eda_spacex_capstone sesc
where Customer ='NASA (CRS)';
#where Customer like "%NASA (CRS)%";

#Task 4
#Display average payload mass carried by booster version F9 v1.1
select avg(PAYLOAD_MASS__KG_) as AVG_Mass
from sql_eda_spacex_capstone sesc
where Booster_Version = 'F9 v1.1'
#where Booster_Version like "%F9 v1.1%";

#Task 5
#List the date when the first succesful landing outcome in ground pad was acheived.
#Hint:Use min function
select min(Date) as first_successful_landing_date
from sql_eda_spacex_capstone sesc 
where Landing_Outcome ='Success (ground pad)'

#Task 6
#List the names of the boosters which have success in drone ship and have payload mass greater than 4000 but less than 6000
select Booster_Version,PAYLOAD_MASS__KG_ from sql_eda_spacex_capstone sesc 
where Landing_Outcome ='Success (drone ship)' and PAYLOAD_MASS__KG_ between 4000 and 6000;

#Task 7
#List the total number of successful and failure mission outcomes
select Mission_Outcome, count(*) from sql_eda_spacex_capstone sesc 
group by Mission_Outcome ;

SELECT 
    CASE 
        WHEN Mission_Outcome LIKE 'Success%' THEN 'Success'
        WHEN Mission_Outcome LIKE 'Failure%' THEN 'Failure'
        ELSE 'Other'
    END AS outcome_category, 
    COUNT(*) AS total_count
FROM 
    sql_eda_spacex_capstone
GROUP BY 
    outcome_category;

#Task 8
#List the names of the booster_versions which have carried the maximum payload mass. Use a subquery
select Booster_Version, PAYLOAD_MASS__KG_ from sql_eda_spacex_capstone sesc 
where PAYLOAD_MASS__KG_ = (select max(PAYLOAD_MASS__KG_) from  sql_eda_spacex_capstone sesc );

#Task 9
#List the records which will display the month names, failure landing_outcomes in drone ship ,booster versions, launch_site for the months in year 2015
select Landing_Outcome,monthname(`Date`),Booster_Version,Launch_Site from sql_eda_spacex_capstone sesc
where Landing_Outcome ='Failure (drone ship)' and year(`Date`) ='2015';

#ask 10
#Rank the count of landing outcomes (such as Failure (drone ship) or Success (ground pad)) between the date 2010-06-04 and 2017-03-20, in descending order
select 
	case 
		when Landing_Outcome like 'Success (drone ship)%' then 'Success (drone ship)'
		when Landing_Outcome like 'Failure (drone ship)%' then 'Failure (drone ship)'
		else 'other'
	end as Landing_outcome,
	count(*) as Total_count 
from sql_eda_spacex_capstone sesc 
where `Date` between '2010-06-04' and '2017-03-20'
group by Landing_Outcome 
order by Total_count desc;


