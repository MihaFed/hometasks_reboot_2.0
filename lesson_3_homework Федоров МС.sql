--task1  (lesson3)
-- oracle: https://www.hackerrank.com/challenges/the-report/problem
select
      case when b.grade<8 then NULL else a.name end as Name,
      b.grade as Grade,
      a.marks as Mark
from Students a
join Grades b on a.marks >= b.min_mark and a.marks <= b.max_mark
order by grade desc, name, marks;


--task2  (lesson3)
-- oracle: https://www.hackerrank.com/challenges/occupations/problem
with temp_1 as(
select Professor, row_number() over(order by Professor) as row_num
from
   (select 
     case when Occupation='Professor' then Name else Null end as Professor
   from OCCUPATIONS order by Professor)),
temp_2 as( 
  select Doctor, row_number() over(order by Doctor) as row_num
  from
   (select 
     case when Occupation='Doctor' then Name else Null end as Doctor
   from OCCUPATIONS order by Doctor)),
temp_3 as( 
  select Singer, row_number() over(order by Singer) as row_num
  from
   (select 
     case when Occupation='Singer' then Name else Null end as Singer
   from OCCUPATIONS order by Singer)),
temp_4 as( 
  select Actor, row_number() over(order by Actor) as row_num
  from
   (select 
     case when Occupation='Actor' then Name else Null end as Actor
   from OCCUPATIONS order by Actor))
select Doctor,Professor,Singer,Actor 
from temp_1 
join temp_2 on temp_1.row_num=temp_2.row_num
join temp_3 on temp_1.row_num=temp_3.row_num
join temp_4 on temp_1.row_num=temp_4.row_num
where Doctor is not NULL or Professor is not NULL or Singer is not NULL or Actor is not NULL;


--task3  (lesson3)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-9/problem
select distinct City 
from station
where upper(substr(City,1,1)) not in ('A','E','I','O','U');


--task4  (lesson3)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-10/problem
select distinct City 
from station
where upper(substr(City,length(City),1)) not in ('A','E','I','O','U');



--task5  (lesson3)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-11/problem
select distinct City 
from station
where upper(substr(City,1,1)) not in ('A','E','I','O','U') or upper(substr(City,length(City),1)) not in ('A','E','I','O','U');


--task6  (lesson3)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-12/problem
select distinct City 
from station
where upper(substr(City,1,1)) not in ('A','E','I','O','U') and upper(substr(City,length(City),1)) not in ('A','E','I','O','U');


--task7  (lesson3)
-- oracle: https://www.hackerrank.com/challenges/salary-of-employees/problem
select name 
from Employee
where salary > 2000 and months < 10
order by employee_id;


--task8  (lesson3)
-- oracle: https://www.hackerrank.com/challenges/the-report/problem
совпадает с первым заданием
