SELECT r.name as RegionName, COUNT(s.name) NumberOfSalesReps
FROM region as r
LEFT JOIN sales_reps as s
ON r.id = s.region_id
GROUP BY r.name
ORDER BY NumberOfSalesReps;




SELECT a.name ,
        max(total_amt_usd) as "Total Amount"
FROM accounts as a
JOIN orders as o
ON a.id = o.account_id
GROUP BY a.name
ORDER BY "Total Amount" DESC
LIMIT 1;

-- Task1 | First Submission
with t2 as (select experience, count(experience) as count
            FROM assessments
            GROUP BY experience
            ),

     t3 as (select experience as exp, max(experience) as max
            FROM assessments
            GROUP BY experience),

     t1 as (SELECT DISTINCT experience
            FROM assessments),

     t4 as (SELECT t1.experience, t2.count, t3.max
            FROM t1
            JOIN t2 ON t1.experience=t2.experience
            JOIN t3 ON t1.experience=t3.exp
)

SELECT * FROM t4
ORDER BY experience DESC;

-- Task 2 | Second Submission

WITH t1 AS (select *, 
CASE WHEN (sql = 100) and (algo = 100) and (bug_fixing = 100) THEN 3
       WHEN (sql = 100) and (algo = 100) and (bug_fixing<=100 OR algo IS NULL) THEN 2
       WHEN (sql = 100) and (algo <=100 OR algo IS NULL)and (bug_fixing = 100) THEN 1
       WHEN (sql = 100) and (algo <=100 OR algo IS NULL) and (bug_fixing<=100 OR algo IS NULL) THEN 1
       WHEN (bug_fixing<=100 OR algo IS NULL) and (algo = 100) and (bug_fixing = 100) THEN 2
       WHEN (bug_fixing<=100 OR algo IS NULL) and (algo = 100) and (bug_fixing<=100 OR algo IS NULL) THEN 1
       WHEN (bug_fixing<=100 OR algo IS NULL) and (algo<=100 OR algo IS NULL) and (bug_fixing = 100) THEN 1
--        WHEN (sql = 100) and (algo <= 100) and (bug_fixing<=100 OR algo IS NULL) THEN 2
        ELSE 1
        END AS max,
        
CASE WHEN (sql Between 0 AND 100) and (algo Between 0 AND 100) and (bug_fixing Between 0 AND 100) THEN 3
       WHEN (sql IS NULL) and (algo IS NULL) and (bug_fixing IS NULL) THEN 0
        ELSE 2
        END AS count
        
FROM assessments)

SELECT experience, count(count) AS count, count(max) AS max
FROM t1
GROUP BY experience
ORDER BY experience DESC;


standard_qty = 0 OR standard_qty IS NULL






Task 2#######################################################################


create table assessments (
    id int not null,
    experience int not null,
    sql int,
    algo int,
    bug_fixing int,
    unique(id)
)


insert into assessments values ( 1, 3, 100, NULL, 50);
insert into assessments values ( 2, 5, NULL, 100, 100);
insert into assessments values ( 3, 1, 100, 100, 100);
insert into assessments values ( 4, 5, 100, 50, NULL);
insert into assessments values ( 5, 5, 100, 100, 100);


TASK 2 #####################################################
create table buses (
        id int primary key,
        origin varchar not null,
        destination varchar not null,
        time varchar not null,
        unique (origin, destination, time)
);

create table passengers (
        id int primary key,
        origin varchar not null,
        destination varchar not null,
        time varchar not null
);


################################  SOLUTION

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

