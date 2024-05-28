-- create table lift (
-- 	id int primary key,
-- 	capacity_kg int not null 
-- )


-- insert into lift (id, capacity_kg)
-- values (1, 300),
-- 		(2, 350);
		

-- create table lift_passengers(
-- 	passenger_name varchar(255) not null,
-- 	weight_kg int not null,
-- 	lift_id int,
-- 	FOREIGN KEY (lift_id) REFERENCES lift(id)
-- )


-- insert into lift_passengers( passenger_name, weight_kg, lift_id )
-- values ('Rahul', 85, 1),
-- 		('Adasrsh', 73, 1),
-- 		('Riti',95, 1),
-- 		('Dheeraj', 80,1),
-- 		('Vimal', 83, 2),
-- 		('Neha', 77, 2),
-- 		('Priti', 73, 2),
-- 		('Himanshi', 85,2);


with cte as (
	select *,
	sum(weight_kg) over(partition by id order by id, weight_kg) as run_weight,
	case when capacity_kg >= sum(weight_kg) over(partition by id order by id, weight_kg) then 1 else 0 end as flag
	from lift l
	join lift_passengers p on l.id = p.lift_id

)

select lift_id, string_agg(passenger_name, ' , ') as  passenger_name
from cte
where flag = 1
group by 1;
