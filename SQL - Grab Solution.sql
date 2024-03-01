WITH temp1 AS (
    SELECT *,
    SUM(salary) OVER(PARTITION BY experience ORDER BY salary ASC) AS RN 
    FROM Candidates
)
, temp2 AS (      
SELECT * FROM temp1 WHERE experience = 'Senior' AND RN <= 70000
UNION
SELECT * FROM temp1 WHERE experience = 'Junior' AND RN < (SELECT 70000 - ISNULL(MAX(RN),0) FROM temp1 WHERE experience = 'Senior' AND RN < 70000)
)
-- SELECT * FROM temp2
SELECT experience, COUNT(experience) AS accepted_candidates
FROM temp2
GROUP BY experience