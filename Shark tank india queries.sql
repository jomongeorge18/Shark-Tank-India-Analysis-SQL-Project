select * from [SQL Project]..Sheet1

---1. How many episodes in total were telecast?
select Count(distinct EpNo) as Total_no_Episodes from [SQL Project]..Sheet1
select Max(EpNo) as Total_no_Episodes from [SQL Project]..Sheet1

---2. how many Pitches were pitched in the show shark tank india?
select count(Brand) as No_of_pitches  from [SQL Project]..Sheet1

---3. how many pitches were able to raise the funding?
select CAST(sum(a.Raised_Funding) as float) / CAST( count (*) as  float ) * 100 as Percentage_Pitched_Raised_Funds from (
select [Amount Invested Lakhs] , case when [Amount Invested Lakhs] >0 then 1 else 0 end as Raised_Funding from [SQL Project]..Sheet1) a

---4. how many male and female contestants were participants and their Gender Ratio
select sum(Male) as Male_Contestants ,sum(Female) as Female_Contestants from [SQL Project]..Sheet1
select sum(Female) /sum(Male)*100 as Gender_Ratio from [SQL Project]..Sheet1

---5. what is the total Invested Amount ?
select sum([Amount Invested Lakhs]) as Total_Invested_Amount from [SQL Project]..Sheet1

---6. what is the Avg Equity taken in %  ?
select AVG(a.[Equity Taken %]) as Avg_Equity_taken_percnt from
(select * from [SQL Project]..Sheet1 where [Equity Taken %] > 0) a

---7. what is highest deal taken ?
select MAX([Amount Invested Lakhs]) as Highest_Amount_taken from [SQL Project]..Sheet1

---8. what is the highest Equity taken ?
select MAX([Equity Taken %]) as Highest_Equity_taken_precnt from [SQL Project]..Sheet1

---9. No. of startups had atleast one women
select sum(a.Female_count) as Startups_having_atleast_females from ( 
select [Female] , case when [Female]>0 then 1 else 0 end as Female_count from [SQL Project]..Sheet1) a

---10. No. of Pitches raised funds with atleast one women startup
select count(a.[Brand]) as Pitches_raised_funds_with_women from( 
select * from [SQL Project]..Sheet1 where [Deal] != 'No Deal' ) a where [Female]>0

---11. what are the avg age group of the contestant?
select [Avg age], count([Avg age]) as Count_of_Age_Group from [SQL Project]..Sheet1 group by [Avg age] order by Count_of_Age_Group desc

---12. what are locations contestants came from ?
select [Location], count([Location]) as Count_of_Contestants from [SQL Project]..Sheet1 group by [Location] order by Count_of_Contestants desc

---12. Which sector did most pitches came from ?
select [Sector], count([Sector]) as Count_of_Contestants from [SQL Project]..Sheet1 group by [Sector] order by Count_of_Contestants desc

--13. list of Partnership Deals
select [Partners], count([Partners]) as cnt from [SQL Project]..Sheet1 where [Partners] !='-' group by [Partners] order by cnt desc

---14. which are the startup that has invested highest amount in each sector?

select c.* from (
select [Brand],[Sector], [Amount Invested lakhs] , RANK() over (partition by [Sector] order by [Amount Invested lakhs] desc) rnk
from [SQL Project]..Sheet1 WHERE [Amount Invested lakhs] is not null ) c where c.rnk=1 


---15. Making the Matrix (Sharks, Amount Invested, Avg Equity taken, Total Episodes, Total deals)

(select m.keyy, c.Total_Invested, c.Total_Equity_Taken, m.Total_Episodes, m.Total_Deals from 
(select a.keyy, a.Total_Episodes, b.Total_Deals from 
(select 'Ashneer' as keyy, count([Ashneer Amount Invested]) as Total_Episodes 
from [SQL Project]..Sheet1 where [Ashneer Amount Invested] is not NULL) a
inner join 
(select 'Ashneer' as keyy, count([Ashneer Amount Invested]) as Total_Deals 
from [SQL Project]..Sheet1 where [Ashneer Amount Invested] is not NULL AND [Ashneer Amount Invested] !=0) b 
on a.keyy=b.keyy) m
inner join 
(select 'Ashneer' as keyy, sum([Ashneer Amount Invested]) as Total_Invested, AVG([Ashneer Equity Taken %]) as Total_Equity_Taken 
from [SQL Project]..Sheet1 where [Ashneer Equity Taken %] > 0 AND [Ashneer Equity Taken %] is not null) c
on m.keyy=c.keyy)

UNION

(select m.keyy, c.Total_Invested, c.Total_Equity_Taken, m.Total_Episodes, m.Total_Deals from 
(select a.keyy, a.Total_Episodes, b.Total_Deals from 
(select 'Namita' as keyy, count([Namita Amount Invested]) as Total_Episodes 
from [SQL Project]..Sheet1 where [Namita Amount Invested] is not NULL) a
inner join 
(select 'Namita' as keyy, count([Namita Amount Invested]) as Total_Deals 
from [SQL Project]..Sheet1 where [Namita Amount Invested] is not NULL AND [Namita Amount Invested] !=0) b 
on a.keyy=b.keyy) m
inner join 
(select 'Namita' as keyy, sum([Namita Amount Invested]) as Total_Invested, AVG([Namita Equity Taken %]) as Total_Equity_Taken 
from [SQL Project]..Sheet1 where [Namita Equity Taken %] > 0 AND [Namita Equity Taken %] is not null) c
on m.keyy=c.keyy)

union

(select m.keyy, c.Total_Invested, c.Total_Equity_Taken, m.Total_Episodes, m.Total_Deals from 
(select a.keyy, a.Total_Episodes, b.Total_Deals from 
(select 'Anupam' as keyy, count([Anupam Amount Invested]) as Total_Episodes 
from [SQL Project]..Sheet1 where [Anupam Amount Invested] is not NULL) a
inner join 
(select 'Anupam' as keyy, count([Anupam Amount Invested]) as Total_Deals 
from [SQL Project]..Sheet1 where [Anupam Amount Invested] is not NULL AND [Anupam Amount Invested] !=0) b 
on a.keyy=b.keyy) m
inner join 
(select 'Anupam' as keyy, sum([Anupam Amount Invested]) as Total_Invested, AVG([Anupam Equity Taken %]) as Total_Equity_Taken 
from [SQL Project]..Sheet1 where [Anupam Equity Taken %] > 0 AND [Anupam Equity Taken %] is not null) c
on m.keyy=c.keyy)

union

(select m.keyy, c.Total_Invested, c.Total_Equity_Taken, m.Total_Episodes, m.Total_Deals from 
(select a.keyy, a.Total_Episodes, b.Total_Deals from 
(select 'Vineeta' as keyy, count([Vineeta Amount Invested]) as Total_Episodes 
from [SQL Project]..Sheet1 where [Vineeta Amount Invested] is not NULL) a
inner join 
(select 'Vineeta' as keyy, count([Vineeta Amount Invested]) as Total_Deals 
from [SQL Project]..Sheet1 where [Vineeta Amount Invested] is not NULL AND [Vineeta Amount Invested] !=0) b 
on a.keyy=b.keyy) m
inner join 
(select 'Vineeta' as keyy, sum([Vineeta Amount Invested]) as Total_Invested, AVG([Vineeta Equity Taken %]) as Total_Equity_Taken 
from [SQL Project]..Sheet1 where [Vineeta Equity Taken %] > 0 AND [Vineeta Equity Taken %] is not null) c
on m.keyy=c.keyy)

UNION

(select m.keyy, c.Total_Invested, c.Total_Equity_Taken, m.Total_Episodes, m.Total_Deals from 
(select a.keyy, a.Total_Episodes, b.Total_Deals from 
(select 'Aman' as keyy, count([Aman Amount Invested]) as Total_Episodes 
from [SQL Project]..Sheet1 where [Aman Amount Invested] is not NULL) a
inner join 
(select 'Aman' as keyy, count([Aman Amount Invested]) as Total_Deals 
from [SQL Project]..Sheet1 where [Aman Amount Invested] is not NULL AND [Aman Amount Invested] !=0) b 
on a.keyy=b.keyy) m
inner join 
(select 'Aman' as keyy, sum([Aman Amount Invested]) as Total_Invested, AVG([Aman Equity Taken %]) as Total_Equity_Taken 
from [SQL Project]..Sheet1 where [Aman Equity Taken %] > 0 AND [Aman Equity Taken %] is not null) c
on m.keyy=c.keyy)