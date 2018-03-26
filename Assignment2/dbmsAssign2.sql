CREATE TABLE AIRPORT(airport_code INT PRIMARY KEY, city VARCHAR(20), state VARCHAR(20), airport_name VARCHAR(20));
CREATE TABLE AIRPLANE_TYPE(type_name VARCHAR(20) PRIMARY KEY, max_seats INT, company VARCHAR(20));
CREATE TABLE AIRPLANE(airplane_id INT PRIMARY KEY, total_seats INT, type_name VARCHAR(20) REFERENCES AIRPLANE_TYPE);
CREATE TABLE CAN_LAND(airport_code INT, type_name VARCHAR(20));

CREATE TABLE FLIGHT(flight_number VARCHAR(10) PRIMARY KEY, airline VARCHAR(20), weekdays INT);
CREATE TABLE FARE(code VARCHAR(10), amount INT, restrictions VARCHAR(20), flight_number VARCHAR(10) REFERENCES FLIGHT ON DELETE CASCADE, 
PRIMARY KEY(code, flight_number));
CREATE TABLE FLIGHT_LEG(leg_no INT, flight_number VARCHAR(10) REFERENCES FLIGHT ON DELETE CASCADE, PRIMARY KEY(leg_no, flight_number));
CREATE TABLE DEPARTURE_AIRPORT(airport_code INT, leg_no INT, flight_number VARCHAR(10), scheduled_dep_time VARCHAR(10));
CREATE TABLE ARRIVAL_AIRPORT(airport_code INT, leg_no INT, flight_number VARCHAR(10), scheduled_arr_time VARCHAR(10));
CREATE TABLE LEG_INSTANCE(no_of_avail_seats INT, date1 DATE, leg_no INT, flight_number VARCHAR(10), PRIMARY KEY(date1, leg_no, flight_number), FOREIGN KEY(leg_no, flight_number) REFERENCES FLIGHT_LEG);

CREATE TABLE ASSIGNED(airplane_id INT, date1 DATE, leg_no INT, flight_number VARCHAR(10));
CREATE TABLE DEPARTS(airport_code INT, date1 DATE, leg_no INT, flight_number VARCHAR(10), dep_time INT);
CREATE TABLE ARRIVES(airport_code INT, date1 DATE, leg_no INT, flight_number VARCHAR(10), arr_time INT);

CREATE TABLE SEAT(seat_no INT, cust_name VARCHAR(20), cust_ph CHAR(10), date1 DATE, leg_no INT,
flight_number VARCHAR(10), PRIMARY KEY(seat_no, date1, leg_no, flight_number),
FOREIGN KEY(date1, leg_no, flight_number) REFERENCES LEG_INSTANCE);

SELECT cust_name, COUNT(*) FROM SEAT
GROUP BY cust_name
HAVING COUNT(*)= (SELECT MAX(COUNT(*)) FROM SEAT GROUP BY cust_name);

SELECT flight_leg.flight_number FROM flight_leg, departure_airport, arrival_airport
WHERE departure_airport.leg_no=flight_leg.leg_no AND arrival_airport.leg_no=flight_leg.leg_no 
AND departure_airport.flight_number=flight_leg.flight_number AND arrival_airport.flight_number=flight_leg.flight_number
AND departure_airport.airport_code=(SELECT airport_code FROM airport WHERE city='B')
AND arrival_airport.airport_code=(SELECT airport_code FROM airport WHERE city='M');

SELECT MIN(f) AS minifare
FROM (SELECT flight_leg.flight_number, fare.amount AS f FROM departure_airport, arrival_airport, flight_leg, flight, fare
WHERE departure_airport.flight_number=flight_leg.flight_number AND arrival_airport.flight_number=flight_leg.flight_number
AND departure_airport.leg_no=flight_leg.leg_no AND arrival_airport.leg_no=flight_leg.leg_no 
AND departure_airport.airport_code=(SELECT airport_code FROM airport WHERE city='A')
AND arrival_airport.airport_code=(SELECT airport_code FROM airport WHERE city='B') AND flight_leg.flight_number=flight.flight_number AND fare.flight_number=flight.flight_number)

SELECT flight.flight_number, flight.airline FROM arrival_airport, departure_airport, flight_leg, flight
WHERE departure_airport.leg_no=flight_leg.leg_no AND arrival_airport.leg_no=flight_leg.leg_no
AND departure_airport.flight_number=flight_leg.flight_number AND arrival_airport.flight_number=flight_leg.flight_number
AND flight_leg.flight_number=flight.flight_number AND flight.weekdays=7 
AND departure_airport.airport_code=(SELECT airport_code FROM airport WHERE city='A')
AND arrival_airport.airport_code=(SELECT airport_code FROM airport WHERE city='B');

SELECT departure_airport.flight_number, departure_airport.leg_no FROM departure_airport
WHERE departure_airport.airport_code=(SELECT airport_code FROM airport WHERE city='X');

SELECT assigned.flight_number, assigned.leg_no FROM assigned, airplane
WHERE assigned.airplane_id=airplane.airplane_id AND airplane.total_seats>=200;

SELECT COUNT(*) FROM seat, leg_instance, flight_leg, departure_airport
WHERE seat.date1=leg_instance.date1 AND seat.leg_no=leg_instance.leg_no AND seat.flight_number=leg_instance.flight_number
AND leg_instance.leg_no=flight_leg.leg_no AND leg_instance.flight_number=flight_leg.leg_no
AND departure_airport.leg_no=flight_leg.leg_no AND departure_airport.flight_number=flight_leg.leg_no
AND departure_airport.airport_code=(SELECT airport_code FROM airport WHERE city='X')
AND seat.date1='01-JAN-2014';

SELECT departs.flight_number, departs.leg_no FROM departs
WHERE departs.airport_code=(SELECT airport_code FROM airport WHERE city='X')
AND (dep_time>=1700 AND dep_time<=2000);

SELECT company FROM airplane_type WHERE type_name='AIRBUS123';

COMMIT;