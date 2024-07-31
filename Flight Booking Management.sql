create database airline;
USE DATABASE airline;

create table flights
(flight_id int primary key,
 flight_number varchar(10),
 departure_date_time datetime,
 arrival_date_time datetime,
 origin_airport_code varchar(3),
 destination_airport_code varchar(3),
 available_seats int);
 INSERT INTO flights VALUES
  (1, 'AA123', '2024-07-01 08:00:00', '2024-07-01 11:30:00', 'JFK', 'LAX', 150),
  (2, 'UA456', '2024-07-02 06:15:00', '2024-07-02 09:45:00', 'ORD', 'SFO', 180),
  (3, 'DL789', '2024-07-03 15:30:00', '2024-07-03 18:00:00', 'ATL', 'MIA', 120);
  
Create table passengers
(passenger_id int primary key,
 first_name varchar(50),
 last_name varchar(50),
 email varchar(100),
 passport_number varchar(20)
 );
 INSERT INTO passengers VALUES
  (1, 'John', 'Doe', 'john.doe@email.com', 'AB1234567'),
  (2, 'Jane', 'Smith', 'jane.smith@email.com', 'CD7654321'),
  (3, 'Bob', 'Johnson', 'bob.johnson@email.com', 'EF2468013');
  
Create table bookings
(booking_id int PRIMARY key,
 flight_id int,
 passenger_id int,
 seat_number varchar(5),
 booking_date_time datetime,
 foreign key (flight_id) REFERENCES flights(flight_id),
 FOREIGN key (passenger_id) REFERENCES passengers(passenger_id)
 );
 INSERT INTO bookings VALUES
  (1001, 1, 1, '10A', '2024-06-15 14:23:00'),
  (1002, 2, 2, '15C', '2024-06-20 09:41:00'),
  (1003, 3, 3, '7D', '2024-06-25 17:52:00');
  
Create table payments
(payment_id int primary key,
 booking_id unique,
 payment_method varchar(50),
 amount decimal(10,2),
 transaction_date_time datetime,
 foreign key (booking_id) REFERENCES bookings(booking_id)
 );
 INSERT INTO payments VALUES
  (101, 1001, 'Credit Card', 450.00, '2024-06-15 14:25:00'),
  (102, 1002, 'PayPal', 550.00, '2024-06-20 09:43:00'),
  (103, 1003, 'Credit Card', 400.00, '2024-06-25 17:54:00');

-- List all the flights with their flight number, departure and arrival times, and available seats.
select flight_id, flight_number, departure_date_time, arrival_date_time, available_seats from flights;

-- Retrieve the passenger details (first name, last name, email) for all passengers.
select first_name, last_name, email from passengers;

-- Find the booking details (booking ID, flight ID, passenger ID, seat number, booking date and time) for all bookings.
select * from bookings;

-- Get the payment details (payment ID, booking ID, payment method, amount, transaction date and time) for all payments.
select * from payments;

-- Retrieve the flight details (flight number, departure and arrival airports, departure and arrival times) for flights departing from 'JFK' airport.
select * from flights where origin_airport_code='JFK';

-- Find the passenger name and booking details for all bookings made on '2024-06-15'.
select passengers.first_name, passengers.last_name, * from bookings inner join passengers on bookings.passenger_id=passengers.passenger_id where booking_date_time='2024-06-15';

-- Calculate the total revenue generated from all bookings.
select bookings.booking_id, payments.amount from bookings inner join payments on payments.booking_id=bookings.booking_id;

-- Find the top 3 most popular flights based on the number of bookings.
select flights.flight_id from flights inner join bookings on flights.flight_id=bookings.flight_id order by (select count(booking_id) from bookings) limit 3;

-- Retrieve the flight details, passenger details, and payment details for a specific booking (e.g., BookingID = 1001).
select passengers., flights., bookings., payments. from bookings
join passengers on passengers.passenger_id=bookings.passenger_id
join flights on flights.flight_id=bookings.flight_id
join payments on payments.booking_id=bookings.booking_id
where bookings.booking_id=1001;

-- Generate a report showing the total number of bookings, total revenue, and average booking amount for each month.
SELECT 
  MONTH(b.booking_date_time) AS Month,
  COUNT(b.booking_id) AS TotalBookings,
  SUM(p.amountmount) AS TotalRevenue,
  AVG(p.amount) AS AvgBookingAmount
FROM bookings b
JOIN payments p ON b.BookingID = p.BookingID
GROUP BY MONTH(b.booking_date_time)
ORDER BY Month;
