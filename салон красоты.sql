create database svetlana_beauty;
create schema salon;

drop table salon.salons;

create table salon.salons (
	id serial primary key,  
	name_salon varchar(100) unique not null,
	contact_phone varchar(100) unique not null,
	address	varchar(100) unique not null
	);

insert into salon.salons (name_salon, contact_phone, address)
values ('Красотка', '89773456789', 'г.Москва, ул. Проспект Мира д. 14');
insert into salon.salons (name_salon, contact_phone, address)
values ('Прованс', '89770987468', 'г.Москва, ул. Очаково д. 8');
insert into salon.salons (name_salon, contact_phone, address)
values ('Beauty', '89298754790', 'г.Москва, ул. Патриции д. 7');
insert into salon.salons (name_salon, contact_phone, address)
values ('Леди', '89777894523', 'г.Москва, ул. Ринальского д 4');
insert into salon.salons (name_salon, contact_phone, address)
values ('Роза', '89771235623', 'г.Москва, ул. Дорофеева д. 1');

select * from salon.salons 
;

drop table salon.employees;
create table salon.employees (
	id serial primary key,  
	name_employees varchar(100) unique not null,
	contact_phone varchar(100) unique not null
);
insert into salon.employees (name_employees, contact_phone)
values ('Рашидова', '89773456789');

select * from salon.employees 
;
create table salon.clients (
	id serial primary key, 
	name_clients varchar(100) unique not null,
	contact_phone varchar(100) unique not null
);
insert into salon.clients (name_clients, contact_phone)
values ('Муханов', '89775456349');
insert into salon.clients (name_clients, contact_phone)
values ('Михеева', '89290987890');
insert into salon.clients (name_clients, contact_phone)
values ('Грицеева', '8977789679');
insert into salon.clients (name_clients, contact_phone)
values ('Ришаева', '89298907450');
insert into salon.clients (name_clients, contact_phone)
values ('Миганов', '89773452367');

select * from salon.clients 
;
drop table salon.services;

select * from salon.services; 

create table salon.services (
	id serial primary key, 
	name_services varchar(100) unique not null,
	name_price int not null
);
insert into salon.services (name_services, name_price)
values ('Стрижка', 1000);
insert into salon.services (name_services, name_price)
values ('Укладка', 2000);
insert into salon.services (name_services, name_price)
values ('Мойка волос', 300);
insert into salon.services (name_services, name_price)
values ('Стрижка машинкой', 700);
insert into salon.services (name_services, name_price)
values ('Окрашивание', 5000);



drop table salon.visits;
create table salon.visits (
	id serial primary key, 
	service_id int not null,
	date_time TIMESTAMP not null default now(),
	salon_id int not null,
	client_id int not null
);	
insert into salon.visits (salon_id, client_id, service_id)
values (1, 5, 1);
insert into salon.visits (date_time, salon_id, client_id, service_id)
values ('2024-09-18 15:54:00', 2, 8, 1);
insert into salon.visits (date_time, salon_id, client_id, service_id)
values ('2024-08-16 15:54:00', 1, 3, 3);
insert into salon.visits (date_time,salon_id, client_id, service_id)
values ('2024-06-18 15:26:00', 1, 8, 4);
insert into salon.visits (date_time, salon_id, client_id, service_id)
values ('2024-08-16 15:26:00', 2, 8, 5);
insert into salon.visits (date_time, salon_id, client_id, service_id)
values ('2024-04-17 15:23:00', 1, 5, 3);
insert into salon.visits (date_time, salon_id, client_id, service_id)
values ('2024-07-10 15:34:00', 2, 5, 1);
insert into salon.visits (date_time, salon_id, client_id, service_id)
values ('2024-08-10 15:34:00', 2, 5, 3);
insert into salon.visits (date_time, salon_id, client_id, service_id)
values ('2024-09-11 16:34:00', 2, 5, 14);

update salon.visits 
set 
	salon_id = 10
where id in (3,16);

select * from salon.visits;

;

create or replace view visits_list as
select
	c.name_clients, v.date_time, 
	s.id ,s.name_salon, s.contact_phone
	,ser.name_services, ser.name_price
from salon.visits v
left join salon.clients c on v.client_id = c.id
left join salon.salons s on v.salon_id = s.id
left join salon.services ser on v.service_id = ser.id
;
drop view visits_list;

select * from visits_list;
--1
select count(*), sum(name_price) 
from visits_list
;

--2
select count(*), sum(name_price)
from visits_list
where date_time >= '2025-01-01'
;
--3
select *
from visits_list
where name_clients = 'Миганов' and id is null
;
--4
select name_salon, name_services, count(*)
from visits_list
group by name_salon, name_services
order by count(*) desc
limit 5
;