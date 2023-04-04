-- Roberto Conti, CB02, DATA MODELLING TEST

-------- DDL / Creating the table -------------



create table Movie
(
	movieId int,
	title varchar(25),
	Duration int,
	Genre varchar(20),
	AgeRestriction char(2),
	Screening char (2)

	constraint pk_movieId
		primary key (movieId)
);

create table Customer 
(
	customerId int,
	firstName varchar(50),
	lastName varchar(50),
	email varchar(64),
	password varchar(64)

	
	constraint pk_usedId
		primary key (customerId)

);
create table City 
(
	cityId int,
	name varchar(64),
	state varchar(64),
	zipCode varchar(64)

	constraint pk_city
		primary key (cityId)

);

create table Cinema 
(
	cinemaId int,
	Name varchar(64),
	total_cinema_auditorium int,
	cityId int 

	constraint pk_cinema
		primary key (cinemaId),
	
	constraint fk_cinema_city
		foreign key(cityId)
		references City (cityId)

);
create table Auditorium
(
	cinemaAuditoriumId int,
	Name varchar(64),
	 totalSeat int,
	 cinemaId int

	 constraint pk_cinemaAuditorium
		primary key (cinemaAuditoriumId),
		
	constraint fk_Auditorium_cinemaId
		foreign key (cinemaId)
		references Cinema (cinemaId)
);
create table Auditorium_Seat
(
	auditoriumSeatID int,
	seatNumber int,
	cinemaAuditoriumId int

	constraint pk_Auditorium_Seat
		primary key (auditoriumSeatID),

	constraint fk_Auditorium_Seat_Auditorium
		foreign key (cinemaAuditoriumId)
		references Auditorium (cinemaAuditoriumId)

);
create table Show_Schedule 
(
	showId int,
	date date,
	startTime decimal(4,2),
	endTime decimal(4,2),
	movieId int,
	cinemaAuditoriumId int

	constraint pk_Show_scheduleID
		primary key (showId)
	
	constraint fk_Show_scheduleID_movieId
		foreign key (movieId)
		references Movie (movieId)


);

alter table Show_schedule 
add 
constraint fk_Show_scheduleID_auditorium 
	foreign key (cinemaAuditoriumId)
	references Auditorium (cinemaAuditoriumId);


create table Ticket
(
	ticketId int,
	numberOfSeats int,
	Date date,
	customerId int,
	showId int

	constraint pk_ticket
		primary key (ticketId),

	constraint fk_ticket_customer
		foreign key (customerId)
		references Customer (customerId),

	
	constraint fk_ticket_showSchedule
		foreign key (showId)
		references Show_schedule (showId)

);


create table Show_Schedule_Seat
(
	showSeatId int,
	custType varchar(20),
	price decimal(6,2),
	auditoriumSeatID int,
	showId int,
	ticketId int

	constraint pk_ShowSchedule_Seat
		primary key (showSeatId),

	constraint pk_ShowSchedule_Seat_auditoriumSeat
		foreign key (auditoriumSeatID)
		references Auditorium_Seat (auditoriumSeatID),

	constraint pk_ShowSchedule_Seat_show
		foreign key (showId)
		references Show_schedule (showId),

constraint pk_ShowSchedule_Seat_ticket
		foreign key (ticketId)
		references Ticket (ticketId)

);

create table Payment
(
	paymentId int,
	total decimal (6,2),
	ticketId int

	constraint pk_payment
		primary key (paymentId),


);

alter table Payment
add constraint fk_payment_ticket
	foreign key (ticketId)
	references Ticket (ticketId);


alter table Payment
add constraint unique_ticket unique (ticketId) 

alter table Customer
add constraint unique_email unique (email)

alter table Movie
Add EndDate Date

--- Did not put trailer because I do not know the data type, he has to be insert into movie




-------- DML / Insert data inside the tables -------------


INSERT INTO  Customer (customerId, firstName, lastName, email, password)
values 
(150, 'Sara', 'Belli', 'sarai32@gmail.com', '53454'),
(180, 'Federico', 'Sileoni', 'fedesily@gmail.com', 'd9438h9j'),
(196, 'Roberto', 'Canoti', 'robertoCanoti@gmail.com', '3289jdvv' );

INSERT INTO City (cityId, name, state, zipCode)
values 
(25, 'Bristol', 'England', '3454'),
(30, 'London', 'England', '43545');

INSERT INTO Movie (movieId, title, Duration, Genre, AgeRestriction, Screening)
values
(1045, 'Fantastic Beasts', 150, 'Fantasy', 'U', '3D'),
(1080, 'Matrix', 120, 'Action', '15', '2d');

INSERT INTO Cinema (cinemaId, Name,total_cinema_auditorium, cityId)
values
(1, 'BristolSpace', 5 , 25);

INSERT INTO  Auditorium (cinemaAuditoriumId, Name, totalSeat, cinemaId)
values 
(1, 'Yellow', 150, 1 ),
(2, 'Red', 1050, 1 ),
(3, 'Purplue', 150, 1 ),
(4, 'Green', 150, 1 ),
(5, 'Blue', 150, 1 );


INSERT INTO  Auditorium_Seat (auditoriumSeatID, seatNumber, cinemaAuditoriumId)
values
(233, 20, 1 ),
(234, 40, 1 ),
(235, 41, 1 ),
(240, 80, 1 ),
(400, 2, 3 ),
(450, 3, 3 );


INSERT INTO Show_Schedule (showId, date, startTime, endTime, movieId, cinemaAuditoriumId)
values 
(1, '05-04-2022', 20.50, 22.00, 1045, 1 ),
(2, '05-04-2022', 20.50, 22.00, 1045, 3 ),
(3, '05-04-2022', 18.00, 20.00, 1045, 1 ),
(4, '05-04-2022', 20.50, 22.00, 1080, 4 ),
(5, '05-04-2022', 17.00, 19.00, 1080, 4 );

INSERT INTO Show_Schedule (showId, date, startTime, endTime, movieId, cinemaAuditoriumId)
values 
(6, '01-01-2022',  17.00, 19.00, 1045, 5) ;


INSERT INTO Ticket (ticketId, numberOfSeats, Date, customerId, showId)
values 
(1, 3, '05-04-2022', 150, 1),
(2, 2, '01-01-2022', 150, 6);

INSERT INTO Show_Schedule_Seat (showSeatId, custType, price, auditoriumSeatID, showId, ticketId)
values
(1, 'senior', 12.99, 233, 1, 1 ),
(2, 'student', 12.99, 234, 1, 1 ),
(3, 'adult', 14.99, 235, 1, 1 );


insert into Payment (paymentId, total, ticketId)
values
(1, 40.97, 1)




----- Query --------------

--	For each auditorium, how many tickets were sold today in City “Bristol”.

select a.Name, count (*) sellingTicket
from Ticket t
inner join Show_schedule s  on t.showId = s.showId
inner join Auditorium a on s.cinemaAuditoriumId = a.cinemaAuditoriumId
inner join Cinema c on a.cinemaAuditoriumId = c.cinemaId
inner join City ci on c.cityId = ci.cityId
where ci.name = 'Bristol'
and t.Date = '05-04-2022'
group by (a.Name)


 -- All tickets bought by customer sarai32@gmail.com (all info of tickets)

 select distinct email, numberOfSeats, Ticket.Date, Ticket.customerId, Ticket.showId, total, custType,
 startTime, endTime, Auditorium. Name as AuditoriumName, City.name as City, Auditorium_Seat.seatNumber
 from Ticket
 inner join Customer on Ticket.customerId = Customer.customerId
  inner join Payment on Ticket.ticketId = Payment.paymentId
  inner join Show_Schedule_Seat on Ticket.ticketId = Show_Schedule_Seat.ticketId
  inner join Auditorium_Seat on Show_Schedule_Seat.auditoriumSeatID = Auditorium_Seat.auditoriumSeatID
  inner join Show_Schedule on Ticket.showId = Show_Schedule.showId
  inner join Auditorium on Show_Schedule.cinemaAuditoriumId = Auditorium.cinemaAuditoriumId
  inner join Cinema  on Auditorium.cinemaId = Cinema.cinemaId
  inner join City on Cinema.cityId = City.cityId
 where email = 'sarai32@gmail.com'
 

 ---	An overview of the total turnover per movie, per City, and how many days it showed. (or, the starting date and ending date)

 select title, Ticket.Date, total
 from Payment
 inner join Ticket on Payment.ticketId = Ticket.ticketId
 inner join Show_Schedule on Ticket.showId = Show_Schedule.showId
 inner join Movie on Show_Schedule.movieId = Movie.movieId
