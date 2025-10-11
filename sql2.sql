create database Insurance;
use Insurance;
create table person(driver_id varchar(10) primary key,name varchar(20),address varchAR(30));
create table car(reg_num varchar(10)primary key,model varchar(10),year int);
create table accident(report_num int primary key,accident_date date,location varchar(20));
create table owns(driver_id varchar(10),reg_num varchar(10),primary key(driver_id,reg_num),foreign key(driver_id)references person(driver_id),foreign key(reg_num)references car(reg_num));
create table participated(driver_id varchar(10),reg_num varchar(10),report_num int,damage_amount int,
primary key(driver_id,reg_num,report_num),foreign key(driver_id)references person(driver_id),
foreign key(reg_num)references car(reg_num),
foreign key(report_num)references accident(report_num));
insert into person values('A01','Richard','Srinivas nagar'),('A02','Pradeep','Rajaji nagar'),('A03','Smith','Ashok nagar'),('A04','Venu','NR Colony'),('A05','Jhon','Hanumanth nagar');
insert into car values('KA052250','Indica',1990),('KA031181','Lancer',1957),('Ka095477','Toyoya',1998),('Ka053408','Honda',2008),('KA041702','Audi',2005);
insert into owns values('A01','KA052250'),('A02','KA053408'),('A03','KA031181'),('A04','KA095477'),("A05",'KA041702');
insert into accident values(11,'2003-01-01','Mysore Road'),(12,'2004-02-02','South End Circle'),(13,'2003-01-21','Bull Temple Road'),(14,'2008-02-17','Mysore Road'),(15,'2005-05-04','Kanakpura Road');
insert into participated values('A01','KA052250',11,10000),('A02','KA053408',12,50000),("A03","KA095477",13,25000),('A04','KA031181',14,3000),('A05','KA041702',15,5000);
select accident_date,location from accident;
select p.name,p.driver_id,d.damage_amount from person p,participated d
where p.driver_id=d.driver_id and d.damage_amount>=25000;
select p.name,c.model from person p,car c,owns o
where p.driver_id=o.driver_id and c.reg_num=o.reg_num;
select p.name,d.damage_amount,a.accident_date,a.location
from person p,participated d,accident a
where p.driver_id=d.driver_id and a.report_num=d.report_num;
select d.report_num,sum( d.damage_amount)
from participated d
group by d.report_num;
select driver_id
from participated 
group by driver_id
having count(distinct report_num)>1;
select c.reg_num,c.model
from car c
where reg_num not in (select reg_num  from  participated);
select * from accident 
order by accident_date desc
limit 1;
select avg(d.damage_amount),p.name
from participated d,person p
where p.driver_id=d.driver_id
group by d.driver_id;
update participated 
set damage_amount=25000
where report_num=11;
select *
from participated
where damage_amount=25000;
select max(distinct d.damage_amount),d.driver_id,p.name
from person p,participated d
where p.driver_id=d.driver_id
group by d.driver_id;
select c.model,d.damage_amount
from car c,participated d
where c.reg_num=d.reg_num and  d.damage_amount>20000;
CREATE VIEW Summary as
SELECT driver_id, COUNT(driver_id) from participated as participants;
desc Summary;
