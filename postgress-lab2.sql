-- Grouping and Aggregate Functions
-- Get average prices from the titles table for each type of book, and convert type to char(30).

select substr(type,1,30), avg (price::numeric) as Average from titles group by type; 

-- Print the difference between (to a resolution of days) the earliest and latest publication date in titles

select max(pubdate) - min(pubdate) as "Resolution of days" from titles;
select age(max(pubdate),min(pubdate)) from titles;

-- Print the average, min and max book prices within the titles table organised into groups based on type and publisher id.

select pub_id, type, avg(price::numeric), min(price::numeric), max(price::numeric) from titles group by type, pub_id ;


-- Refine the previous question to show only those types whose average price is > $20 and output the results sorted on the average price.

select pub_id, type, avg(price::numeric), min(price::numeric), max(price::numeric) from titles group by type, pub_id having avg(price::numeric) > 20 ;


-- List the books in order of the length of their title

select title from titles order by length(title) desc;

-- Business Queries

-- What is the average age in months of each type of title?
select type, avg(date_part('month', age(current_date, pubdate))) as "average months" from titles group by type; 
select type, avg(date_part('year', age(current_date, pubdate)) *12 + date_part('month', age(current_date, pubdate))) as "average months" from titles group by type; 

-- How many authors live in each city?
select city, count(au_id) from authors a2 group by city ;
select city, count(au_id) from authors a2 group by city order by count(au_id) ;

-- What is the longest title?
select title from titles order by length(title) desc  fetch first 1 row only;
-- How many books have been sold by each store and how many books have been sold in total?
select stor_id, sum(qty) from sales group by stor_id;
select sum(qty) as "Total books" from sales;



