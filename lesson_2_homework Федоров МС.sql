--task1  (lesson2)
-- oracle: https://leetcode.com/problems/department-top-three-salaries/

select 
     Department,
     Employee,
     Salary
from
        (select 
          d.name as Department,
          e.name as Employee,
          e.salary as Salary,
          dense_rank() over(partition by d.name order by e.salary desc) as rank_dep_salary
        from Employee e
        join Department d on e.departmentId=d.id) a
where rank_dep_salary in (1,2,3)

--task2  (lesson2)
-- https://sql-academy.org/ru/trainer/tasks/17
select 
      fm.member_name,
      fm.status,
      sum(p.amount*p.unit_price) as costs
from FamilyMembers fm
join Payments p on fm.member_id=p.family_member
where year(p.date)=2005
GROUP BY fm.member_name,fm.status

--task3  (lesson2)
-- https://sql-academy.org/ru/trainer/tasks/13
select distinct name
from 
    (select pas.name,
           count(pas.name) as pas_count
    from Passenger pas 
    --join Pass_in_trip pit on pas.id=pit.passenger
    GROUP BY pas.name) a 
where pas_count>1

--task4  (lesson2)
-- https://sql-academy.org/ru/trainer/tasks/38
select count(a.student) as count
FROM 
    (select s.id,
           s.first_name,
           sic.student
    from Student s
    join Student_in_class sic on sic.student=s.id
    where first_name='Anna') a


--task5  (lesson2)
-- https://sql-academy.org/ru/trainer/tasks/35
select count(a.classroom) as count
from
    (select DISTINCT classroom from Schedule where date='2019-09-02') a


--task6  (lesson2)
-- https://sql-academy.org/ru/trainer/tasks/38
дубль, 38 задание было выше

--task7  (lesson2)
-- https://sql-academy.org/ru/trainer/tasks/32
select floor(avg(floor(datediff(now(),birthday)/365.5))) as age from FamilyMembers


--task8  (lesson2)
-- https://sql-academy.org/ru/trainer/tasks/27
select 
      good_type_name,
      sum(amount*unit_price) as costs
FROM Payments a
join (select good_type_name, good_id
      from Goods c
      join GoodTypes d on d.good_type_id=c.type) b on b.good_id=a.good
where year(date)=2005
group by good_type_name


--task9  (lesson2)
-- https://sql-academy.org/ru/trainer/tasks/37
select min(round(datediff(now(),birthday)/365.5)) as year from Student


--task10  (lesson2)
-- https://sql-academy.org/ru/trainer/tasks/44
select max(round(datediff(now(),a.birthday)/365.5)) as max_year 
from Student a
join (select c.student, d.name
      from Student_in_class c
      join Class d on d.id=c.class
      where d.name like '10%') b on a.id=b.student

--task11 (lesson2)
-- https://sql-academy.org/ru/trainer/tasks/20
select 
      e.status,
      e.member_name,
      sum(a.amount*a.unit_price) as costs
from Payments a
join (select good_id,good_type_name from Goods c
      join GoodTypes d on d.good_type_id=c.type
      where good_type_name='entertainment') b on b.good_id=a.good
join FamilyMembers e on e.member_id=a.family_member
group by e.status, e.member_name


--task12  (lesson2)
-- https://sql-academy.org/ru/trainer/tasks/55
DELETE FROM Company a
where a.id in
  (select c.company
  from    
    (select a.company, a.trip_count-min(a.trip_count) over() as min_trip_count
    from
        (select b.company,
                count(b.id) as trip_count
         from Trip b
         group by b.company) a) c
where c.min_trip_count=0)


вариант_2 с having
DELETE FROM Company a
where a.id in
      (select b.company
      from Trip b
      group by b.company
      having count(b.id)=(select min(d.trip_count) 
                          from (
                                select count(c.id) as trip_count 
                                from Trip c 
                                group by c.company) 
                           d)
       )



--task13  (lesson2)
-- https://sql-academy.org/ru/trainer/tasks/45
select classroom
from Schedule
GROUP BY classroom
having count(classroom)=(select max(count_cl) from (select count(classroom) as count_cl from Schedule GROUP BY classroom) a)


--task14  (lesson2)
-- https://sql-academy.org/ru/trainer/tasks/43
select last_name
from Teacher a
join (select teacher from Schedule c
      join Subject d on d.id=c.subject
      where d.name='Physical Culture') b on a.id=b.teacher  
order by last_name


--task15  (lesson2)
-- https://sql-academy.org/ru/trainer/tasks/63
select CONCAT(last_name,'.',left(first_name,1),'.',left(middle_name,1),'.') as name
from Student
order by name 
