use info6210project;



-- trips taken between two given dates
delimiter $
create procedure tripsbetweentwodates()
begin
select * from tripdetails where tripdate between '2016-10-24' and '2017-10-26';
end
$
delimiter ;
call tripsbetweentwodates();


delimiter $
create procedure distributionforafareid(in takenfareid int)
begin
select a.surgepercentage, a.basefare,a.incrementalfare,a.taxpercentage,
 (b.distanceinmiles*a.incrementalfare+a.basefare+a.surgepercentage)*(1+(a.taxpercentage/100)) 
from Faretable as a inner join  tripdetails as b
on a.fareid=b.FareTable_Fareid where a.fareid=takenfareid ;
-- set @x= y;
end
$
delimiter ;
call distributionforafareid(401);


-- for a perticular fare id wat is the distribution or percentage compsition of basefare, surge pricing, tax and incremental fare
delimiter $
create procedure fareidcompdist(in takenfareid int)
begin
select surgepercentage, basefare,incrementalfare,taxpercentage from Faretable where fareid=takenfareid;
-- set @x= y;
end
$
delimiter ;
call fareidcompdist(401);






delimiter //
create trigger faretrig3 
after insert on tripdetails
for each row
begin
set @newtrip= new.tripid;
set @newd= new.distanceinmiles;
set @newfare= new.faretable_fareid;
set @userid= new.usercustomer_usercustomerid;

select a.surgepercentage into @x
from Faretable as a inner join tripdetails as b on b.FareTable_Fareid=a.fareid  
where a.fareid=@newfare
limit 1;
select a.basefare into @y
from Faretable as a inner join tripdetails as b on b.FareTable_Fareid=a.fareid  
where a.fareid=@newfare
limit 1;
select a.incrementalfare into @l
from Faretable as a inner join tripdetails as b on b.FareTable_Fareid=a.fareid  
where a.fareid=@newfare
limit 1;
select a.taxpercentage into @m
from Faretable as a inner join tripdetails as b on b.FareTable_Fareid=a.fareid  
where a.fareid=@newfare
limit 1;

insert into transactionstable (tripid,paymentmethods_paymentmethodid,totalfare,promocodetable_promocode)
values(@newtrip,503,((@x+@y+(@newd*@l))*(1+(@m/100))),99);
end;
//

insert into tripdetails values(9,'Tremont Street','Huntington Ave',1.5,13,102,'2017-10-29', '11:34:09',401);




-- this trigger is when a new feedback is given by the customer in the customerfeedback table for a driver,
-- the average rating and no. of trips completed columns in the driver table get updated.
delimiter //
create trigger ratngupdate 
after insert on customerfeedback
for each row
begin
set @nt= new.tripid;
set @newrtng= new.userrating;

update driver
-- set @a=totaltripscompleted;
set totaltripscompleted=totaltripscompleted+1
where driverid=(select driver_driverid from tripdetails where tripid=@nt);
update driver
set averagerating= (averagerating*(totaltripscompleted)+ @newrtng)/(totaltripscompleted+1)
where driverid=(select driver_driverid from tripdetails where tripid=@nt);
end;
//


insert into customerfeedback values(9,301,4.7);




drop procedure view_feedbackfor_driver

delimiter $
create procedure view_feedbackfor_driver()
begin
create view feedbackview
as select t.usercustomer_usercustomerid,t.tripid, t.driver_driverid,t.source, t.destination,
 f.feedback, cf.userrating
from tripdetails as t inner join customerfeedback as cf on t.tripid=cf.tripid 
inner join feedbacktable as f on f.feedbackid=cf.feedbackid;
end
$
delimiter ;
call view_feedbackfor_driver();
select * from feedbackview;


-- show top 3 drivers by current ratings by users
drop view top3drivers;
create view top3drivers
as select * from driver where TotalTripsCompleted>=25 
order by AverageRating desc
limit 3;

select * from top3drivers;



-- see refunnd requests and reasons, source, destination, and driverid for refund requests for  a particular tripID

create view refundrequestsview1
as select ref.rcrequestid, ref.reason, tp.driver_driverid as driver, tp.usercustomer_usercustomerid as CustomerServed,
 tp.tripdate,dr.driverid, dr.drivername, dr.licenseregistrationnumber from refundscomplainttable as ref 
 inner join tripdetails as tp on ref.tripdetails_tripid= tp.tripid 
 inner join driver as dr on tp.driver_driverid = dr.driverid
order by tp.tripdate desc;
select * from refundrequestsview1;


-- see the cars who have not being assigned any drivers yet using subqueries
select carregistrationnumber,carmake, carmodel, noofseats from cardetails
where CarID not in (select cardetails_carid from driver);


-- procedure to calculate discount for promocodes on the total fare
delimiter $
create procedure calcdiscountfrompromocodes(inout discfare double, in promo VARCHAR(25))
begin
select @x:=p.discount, @y:=t.totalfare
from transactionstable as t inner join promocodetable as p on  p.promocode=t.PromocodeTable_Promocode
where p.Promocode=promo;
set discfare= @y*(1-(@x/100));
end
$
delimiter ;

set @df:=40;
call calcdiscountfrompromocodes(@df,88);
select(@df);





-- users and priveledges
create user usercustomer identified by 'userpass';
revoke all privileges,grant option from usercustomer;
grant select on info6210project.driver to usercustomer;
grant select on info6210project.tripdetails to usercustomer;
grant select,update on info6210project.usercustomer to usercustomer;
grant select,insert on info6210project.faretable to usercustomer;
grant select,insert on info6210project.feedbacktable to usercustomer;
grant select,insert on info6210project.customerfeedback to usercustomer;
grant all on info6210project.paymentdetails to usercustomer;

create user driver identified by 'driverpass';
revoke all privileges,grant option from driver;
grant update on info6210project.driver to driver;
grant select on info6210project.tripdetails to driver;

create user admin identified by 'adminpass';
revoke all privileges,grant option from driver;
grant all on info6210project.* to admin;






