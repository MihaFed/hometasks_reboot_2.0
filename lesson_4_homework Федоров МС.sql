--task1  (lesson7)

--task2  (lesson7)
-- oracle: https://leetcode.com/problems/duplicate-emails/
select distinct email
from (
  select email, count(*)
  from Person
  group by email
  having count(*)>1
) a


--task3  (lesson7)
-- oracle: https://leetcode.com/problems/employees-earning-more-than-their-managers/
select c.name as Employee
from
     (select 
           a.id, 
           a.name, 
           a.salary,
           b.salary as salary_manager
     from Employee a
     join Employee b on a.managerId=b.id) c
where c.salary > c.salary_manager


--task4  (lesson7)
-- oracle: https://leetcode.com/problems/rank-scores/
select
      score,
      dense_rank() over(order by score desc) as rank
from Scores


--task5  (lesson7)
-- oracle: https://leetcode.com/problems/combine-two-tables/
select 
      a.firstName,
      a.lastName,
      case when b.city is null then null else b.city end as city,
      case when b.state is null then null else b.state end as state
from Person a
left join Address b on a.personId = b.personId
