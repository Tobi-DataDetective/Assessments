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






-- Task1 | First Submission (Not understood yet)

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



-- Task 1 | Second Submission (Finally Understod)

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