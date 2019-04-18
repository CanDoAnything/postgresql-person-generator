select 
(select count(*) from person) as people_count,
((select max(insert_timestamp) from person) -
(select min(insert_timestamp) from person)) as Insert_time,
((select max(generated_timestamp) from person) -
(select min(generated_timestamp) from person)) as Generated_time,
(select version()) as version