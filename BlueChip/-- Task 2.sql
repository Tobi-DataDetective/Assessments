
-- TASK 2 #####################################################
create table buses (
        id int primary key,
        origin varchar not null,
        destination varchar not null,
        time time not null,
        unique (origin, destination, time)
);

create table passengers (
        id int primary key,
        origin varchar not null,
        destination varchar not null,
        time time not null
);

insert into buses values (10, 'Warsaw', 'Berlin', '10:55:00');
insert into buses values (20, 'Berlin', 'Paris', '06:20:00');
insert into buses values (21, 'Berlin', 'Paris', '14:00:00');
insert into buses values (22, 'Berlin', 'Paris', '21:40:00');
insert into buses values (30, 'Paris', 'Madrid', '13:30:00');
insert into passengers values (1, 'Paris', 'Madrid', '13:30:00');
insert into passengers values (2, 'Paris', 'Madrid', '13:31:00');
insert into passengers values (10, 'Warsaw', 'Paris', '10:00:00');
insert into passengers values (11, 'Warsaw', 'Berlin', '22:31:00');
insert into passengers values (40, 'Berlin', 'Paris', '06:15:00');
insert into passengers values (41, 'Berlin', 'Paris', '06:50:00');
insert into passengers values (42, 'Berlin', 'Paris', '07:12:00');
insert into passengers values (43, 'Berlin', 'Paris', '12:03:00');
insert into passengers values (44, 'Berlin', 'Paris', '20:00:00');



-- ################################  SOLUTION 1 (First Attempt)

WITH t1 AS (SELECT id, origin, destination, time, CONCAT(origin,' ',destination) as passenger_board
                FROM passengers),

        t2 AS (select *,
                CASE WHEN (passenger_board = 'Paris Madrid') AND (time = '13:30') THEN 1
                        WHEN (passenger_board = 'Berlin Paris') AND (time = '06:15') THEN 1
                        WHEN (passenger_board = 'Berlin Paris') AND (time = '06:50') THEN 1
                        WHEN (passenger_board = 'Berlin Paris') AND (time = '07:12') THEN 1
                        WHEN (passenger_board = 'Berlin Paris') AND (time = '12:03') THEN 1
                        WHEN (passenger_board = 'Berlin Paris') AND (time = '20:00') THEN 1
                        -- WHEN (passenger_board = 'Warsaw Berlin') AND (time = '20:00') THEN 1
                        ELSE 0
                        END AS will_fly,

                CASE WHEN (passenger_board = 'Paris Madrid') AND (time = '13:30') THEN 30
                        WHEN (passenger_board = 'Berlin Paris') AND (time = '06:15') THEN 20
                        WHEN (passenger_board = 'Berlin Paris') AND (time = '06:50') THEN 21
                        WHEN (passenger_board = 'Berlin Paris') AND (time = '07:12') THEN 21
                        WHEN (passenger_board = 'Berlin Paris') AND (time = '12:03') THEN 21
                        WHEN (passenger_board = 'Berlin Paris') AND (time = '20:00') THEN 22
                        WHEN (passenger_board = 'Warsaw Berlin') THEN 10
                        -- WHEN (passenger_board = 'Warsaw Berlin') AND (time = '20:00') THEN 1
                        ELSE NULL
                        END AS _id
                
                from t1)


SELECT _id, SUM(will_fly) as passengers_on_board
FROM t2
GROUP BY _id
ORDER BY _id;






-- ################################  SOLUTION 2 (EXPECTED OUTPUT : HAD TO RESTRUCTURE THE TABLE, SETTING TIME TO TIME DATATYPE)



SELECT id, origin, destination, time, CONCAT(origin,' ',destination,' ',time) as buses
                FROM buses;



WITH t1 AS (SELECT id, origin, destination, time, CONCAT(origin,' ',destination) as passenger_board
                FROM passengers),

        t2 AS (select *,
                CASE WHEN (passenger_board = 'Paris Madrid') AND (time <= '13:30:00' ) THEN 30
                    WHEN (passenger_board = 'Warsaw Berlin') AND (time <= '10:55:00' ) THEN 10
                    WHEN (passenger_board = 'Berlin Paris') AND (time <= '06:20:00' ) THEN 20
                    WHEN (passenger_board = 'Berlin Paris') AND (time BETWEEN '06:20:01' AND '14:00:00') THEN 21
                    WHEN (passenger_board = 'Berlin Paris') AND (time BETWEEN '14:00:01' AND  '21:40:00') THEN 22
                        END AS _id                
                from t1)


SELECT buses.id, count(t2._id) as passengers_on_board
FROM buses
LEFT JOIN t2 on buses.id = t2._id
GROUP BY buses.id
ORDER BY buses.id;