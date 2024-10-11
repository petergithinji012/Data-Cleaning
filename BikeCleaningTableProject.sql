# Data Cleaning
# Selecting the database to use.
use practice;

# Viewing all the tables in the database and selecting the table am working on 'bikecleaned'
show tables;
drop table if exists bikecleaned;
select * from bikecleaned;


# Cleaning the Age_Group column and updating the changes to the table
select distinct(Age_Group) from bikecleaned;
select (case when Age_Group = 'Adults (35-64)' then 'Adults'
when Age_Group = 'Young Adults (25-34)' then 'Young Adults'
when Age_Group = 'Youth (<25)' then 'Youth'
else 'Children' end) as Age_Groups
from bikecleaned;

update bikecleaned
set Age_Group = case when Age_Group = 'Adults (35-64)' then 'Adults'
when Age_Group = 'Young Adults (25-34)' then 'Young Adults'
when Age_Group = 'Youth (<25)' then 'Youth'
else 'Children' end;

select * from bikecleaned;

# Removing the dollar sign in currency columns and casting the columns as decimals fro
# mathematicals calculations.
select cast(replace (Unit_Cost,'$','') as decimal(10,1)),
cast(replace (Unit_Price,'$','') as decimal(10,1)),
cast(replace (Profit,'$','') as decimal(10,1)),
cast(replace (Cost,'$','') as decimal(10,1)),
cast(replace (Revenue,'$','') as decimal(10,1))
from bikecleaned;

update bikecleaned
set Unit_Cost = cast(replace (Unit_Cost,'$','') as decimal(10,1)),
 Unit_Price = cast(replace (Unit_Price,'$','') as decimal(10,1)),
 Profit = cast(replace (Profit,'$','') as decimal(10,1)),
 Cost = cast(replace (Cost,'$','') as decimal(10,1)),
 Revenue = cast(replace (Revenue,'$','') as decimal(10,1));
 
select * from bikecleaned;


# adding an id column to distinguish each field uniquely to enable me find duplicates in the table
alter table bikecleaned
add id int auto_increment primary key first;

with cte as(
select *,row_number() over (partition by Date,
Customer_Age,Customer_Gender,Country,Product_Category,Product_Description
order by id) as row_num from bikecleaned)
select * from cte where row_num>1
order by id;
 
 # Performing some quick analysis
select * from bikecleaned;
select Country, sum(Revenue) as Revenue 
from bikecleaned 
group by Country
order by Revenue desc;

select sum(Revenue), Month from bikecleaned 
group by Month;
# cleaning column month after noticing December was split by two
select (case when Month = 'Decmber' then 'December'
else Month end ) as Month from bikecleaned;

update bikecleaned
set Month = case when Month = 'Decmber' then 'December'
else Month end ;



 
 








