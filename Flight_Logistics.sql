CREATE DATABASE flight_logistics;

CREATE TABLE airport
(
    code    CHAR(3) PRIMARY KEY,
    country VARCHAR(256) NOT NULL,
    city    VARCHAR(128) NOT NULL
);

CREATE TABLE aircraft
(
    id    SERIAL PRIMARY KEY,
    model VARCHAR(128) NOT NULL
);

CREATE TABLE seat
(
    aircraft_id INT REFERENCES aircraft (id),
    seat_no     VARCHAR(4) NOT NULL,
    PRIMARY KEY (aircraft_id, seat_no)
);

CREATE TABLE flight
(
    id                     BIGSERIAL PRIMARY KEY,
    flight_no              VARCHAR(16)                       NOT NULL,
    departure_date         TIMESTAMP                         NOT NULL,
    departure_airport_code CHAR(3) REFERENCES airport (code) NOT NULL,
    arrival_date           TIMESTAMP                         NOT NULL,
    arrival_airport_code   CHAR(3) REFERENCES airport (code) NOT NULL,
    aircraft_id            INT REFERENCES aircraft (id)      NOT NULL,
    status                 VARCHAR(32)                       NOT NULL
);

CREATE TABLE ticket
(
    id             BIGSERIAL PRIMARY KEY,
    passenger_no   VARCHAR(32)                   NOT NULL,
    passenger_name VARCHAR(128)                  NOT NULL,
    flight_id      BIGINT REFERENCES flight (id) NOT NULL,
    seat_no        VARCHAR(4)                    NOT NULL,
    cost           NUMERIC(8, 2)                 NOT NULL
);

INSERT INTO airport (code, country, city)
VALUES ('WSH', 'USA', 'Washington'),
       ('LDN', 'England', 'London'),
       ('HAI', 'Israel', 'Haifa'),
       ('BSL', 'Spain', 'Barcelona');

INSERT INTO aircraft (model)
VALUES ('Boeing 777-300'),
       ('Boeing 737-300'),
       ('Airbus A320-200'),
       ('Caravelle SE-210');

INSERT INTO seat (aircraft_id, seat_no)
SELECT id, s.column1
FROM aircraft
         CROSS JOIN (VALUES ('A1'),
                            ('A2'),
                            ('B1'),
                            ('B2'),
                            ('C1'),
                            ('C2'),
                            ('D1'),
                            ('D2')
                     ORDER BY 1) s;

INSERT INTO flight (flight_no, departure_date, departure_airport_code, arrival_date, arrival_airport_code, aircraft_id,
                    status)
VALUES ('MN3002', '2020-06-14T14:30', 'WSH', '2020-06-14T18:07', 'LDN', 1, 'ARRIVED'),
       ('MN3002', '2020-06-16T09:15', 'LDN', '2020-06-16T13:00', 'WSH', 1, 'ARRIVED'),
       ('BC2801', '2020-07-28T23:25', 'WSH', '2020-07-29T02:43', 'LDN', 2, 'ARRIVED'),
       ('BC2801', '2020-08-01T11:00', 'LDN', '2020-08-01T14:15', 'WSH', 2, 'DEPARTED'),
       ('TR3103', '2020-05-03T13:10', 'HAI', '2020-05-03T18:38', 'BSL', 3, 'ARRIVED'),
       ('TR3103', '2020-05-10T07:15', 'BSL', '2020-05-10T012:44', 'HAI', 3, 'CANCELLED'),
       ('CV9827', '2020-09-09T18:00', 'WSH', '2020-09-09T19:15', 'HAI', 4, 'SCHEDULED'),
       ('CV9827', '2020-09-19T08:55', 'HAI', '2020-09-19T10:05', 'WSH', 4, 'SCHEDULED'),
       ('QS8712', '2020-12-18T03:35', 'WSH', '2020-12-18T06:46', 'LDN', 2, 'ARRIVED');

INSERT INTO ticket (passenger_no, passenger_name, flight_id, seat_no, cost)
VALUES ('112233', 'Beatrice Vargas', 1, 'A1', 200),
       ('23234A', 'Elaine Gonzales', 1, 'B1', 180),
       ('SS988D', 'Dorothy Cooper', 1, 'B2', 175),
       ('QYASDE', 'Alice Patton', 1, 'C2', 175),
       ('POQ234', 'Carmen King', 1, 'D1', 160),
       ('898123', 'Shirley Parsons', 1, 'A2', 198),
       ('555321', 'John Reynolds', 2, 'A1', 250),
       ('QO23OO', 'Linda Russell', 2, 'B2', 225),
       ('9883IO', 'Velma Cummings', 2, 'C1', 217),
       ('123UI2', 'William Barnes', 2, 'C2', 227),
       ('SS988D', 'Carl Collins', 2, 'D2', 277),
       ('EE2344', 'Calvin Richards', 3, 'А1', 300),
       ('AS23PP', 'Jennifer Miller', 3, 'А2', 285),
       ('322349', 'Angela Todd', 3, 'B1', 99),
       ('DL123S', 'Mary Douglas', 3, 'B2', 199),
       ('MVM111', 'Maria Black', 3, 'C1', 299),
       ('ZZZ111', 'Nancy Lopez', 3, 'C2', 230),
       ('234444', 'Louise Phillips', 3, 'D1', 180),
       ('LLLL12', 'Eddie Keller', 3, 'D2', 224),
       ('RT34TR', 'Kenneth Kennedy', 4, 'A1', 129),
       ('999666', 'Ray Carlson', 4, 'A2', 152),
       ('234444', 'Helen Brown', 4, 'B1', 140),
       ('LLLL12', 'David Smith', 4, 'B2', 140),
       ('LLLL12', 'Joan Miller', 4, 'D2', 109),
       ('112233', 'Sara Martinez', 5, 'С2', 170),
       ('NMNBV2', 'Diane Neal', 5, 'С1', 185),
       ('DSA586', 'Elizabeth Martinez', 5, 'A1', 204),
       ('DSA583', 'Joe Thompson', 5, 'B1', 189),
       ('DSA581', 'Elaine Soto', 6, 'A1', 204),
       ('EE2344', 'James Barrett', 6, 'A2', 214),
       ('AS23PP', 'Karen Kelly', 6, 'B2', 176),
       ('112233', 'Cathy Bell', 6, 'B1', 135),
       ('309623', 'Catherine Thompson', 6, 'С1', 155),
       ('319623', 'Eva Miller', 6, 'D1', 125),
       ('322349', 'Judy Logan', 7, 'A1', 69),
       ('DIOPSL', 'Hilda Lewis', 7, 'A2', 58),
       ('DIOPS1', 'Allen Vasquez', 7, 'D1', 65),
       ('DIOPS2', 'Sara Richardson', 7, 'D2', 65),
       ('1IOPS2', 'William Crawford', 7, 'C2', 73),
       ('999666', 'Steven Foster', 7, 'B1', 66),
       ('23234A', 'Brian Wise', 7, 'C1', 80),
       ('QYASDE', 'Ray Hernandez', 8, 'A1', 100),
       ('1QAZD2', 'Donald Peters', 8, 'A2', 89),
       ('5QAZD2', 'Leonard Stewart', 8, 'B2', 79),
       ('2QAZD2', 'Donald Aguilar', 8, 'С2', 77),
       ('BMXND1', 'Patricia Patton', 8, 'В2', 94),
       ('BMXND2', 'Betty Washington', 8, 'D1', 81),
       ('SS988D', 'Mary Cannon', 9, 'A2', 222),
       ('SS978D', 'David Brown', 9, 'A1', 198),
       ('SS968D', 'Robert Cole', 9, 'B1', 243),
       ('SS958D', 'Mary Jones', 9, 'С1', 251),
       ('112233', 'Donald Hardy', 9, 'С2', 135),
       ('NMNBV2', 'Naomi Smith', 9, 'B2', 217),
       ('23234A', 'Sharon Johnson', 9, 'D1', 189),
       ('123951', 'Eva Miller', 9, 'D2', 234);

-- Who flew 2 years and 6 months ago (or later) on the Washington (WSH) - London (LDN) flight in place B1?
SELECT passenger_name
FROM ticket
         JOIN flight f
              ON f.id = ticket.flight_id
WHERE seat_no = 'B1'
  AND f.departure_airport_code = 'WSH'
  AND f.arrival_airport_code = 'LDN'
  AND f.departure_date::DATE >= (now() - INTERVAL '2 years 6 mons')::DATE;

-- How many seats are left unoccupied 2020-06-14 on flight MN3002?
SELECT t2.count - t1.count
FROM (SELECT f.aircraft_id, count(*)
      FROM ticket t
               JOIN flight f ON f.id = t.flight_id
      WHERE f.flight_no = 'MN3002'
        AND f.departure_date::DATE = '2020-06-14'
      GROUP BY f.aircraft_id) t1
         JOIN (SELECT aircraft_id, count(*)
               FROM seat
               GROUP BY aircraft_id) t2
              ON t1.aircraft_id = t2.aircraft_id;

-- Which 2 flights were the longest of all time?
SELECT f.id,
       f.departure_date,
       (f.arrival_date - f.departure_date)::TIME duration
FROM flight f
ORDER BY (f.arrival_date - f.departure_date) DESC
    LIMIT 2;

-- What is the maximum and minimum duration of flights between Washington and London
-- and how many such flights were there in total?
SELECT first_value((f.arrival_date - f.departure_date)::TIME)
           OVER (ORDER BY (f.arrival_date - f.departure_date) DESC) max,
       first_value((f.arrival_date - f.departure_date)::TIME)
       OVER (ORDER BY (f.arrival_date - f.departure_date))      min,
       count(*) OVER ()
FROM flight f
    JOIN airport a
ON a.code = f.arrival_airport_code
    JOIN airport b
    ON b.code = f.departure_airport_code
WHERE a.city = 'London'
  AND b.city = 'Washington'
    LIMIT 1;

-- Which names are most common and what proportion of all passengers do they make up?
SELECT t.passenger_name,
       count(*),
       round(100.0 * count(*) / (SELECT count(*) FROM ticket), 2)
FROM ticket t
GROUP BY t.passenger_name
ORDER BY 2 DESC;

-- Print the names of passengers, how many tickets each person with the same name bought,
-- and also how much this number is less from the passenger's name who bought the most tickets
SELECT t1.*,
       first_value(t1.count) OVER () - t1.count
FROM (SELECT t.passenger_no,
             t.passenger_name,
             count(*)
      FROM ticket t
      GROUP BY t.passenger_no, t.passenger_name
      ORDER BY 3 DESC) t1;

-- Display the cost of all routes in descending order.
-- Display the difference in cost between the current and the nearest routes in the sorted list
SELECT t1.*,
       COALESCE(lead(t1.summary_cost) OVER (ORDER BY t1.summary_cost),t1.summary_cost) - t1.summary_cost
FROM (
         SELECT t.flight_id,
                sum(t.cost) summary_cost
         FROM ticket t
         GROUP BY t.flight_id
         ORDER BY 2 DESC) t1;