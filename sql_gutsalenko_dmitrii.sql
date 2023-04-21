ЗАДАЧА #1

SELECT max(TIMESTAMPDIFF(YEAR,birthday,CURRENT_DATE)) as max_year
FROM Student
JOIN Student_in_class
    ON Student.id=Student_in_class.student 
JOIN Class
    ON Student_in_class.class =Class.id 
WHERE Class.name LIKE '10%';

ЗАДАЧА #2

DELETE FROM Company
WHERE Company.id IN (
    SELECT company FROM Trip
    GROUP BY company 
    HAVING COUNT(id) = (SELECT MIN(count) FROM (SELECT  COUNT(id) AS count FROM Trip GROUP BY company) AS min_count)
);

ЗАДАЧА #3

WITH active_users AS ( 
  ( 
    SELECT user_id 
    FROM Reservations 
    GROUP BY user_id 
  ) 
  UNION 
  ( 
    SELECT owner_id 
    FROM Reservations 
      JOIN Rooms ON room_id = Rooms.id 
    GROUP BY owner_id 
  ) 
) 
SELECT ROUND(COUNT(active_users.user_id) * 100 / COUNT(Users.id), 2) AS percent 
FROM Users 
LEFT JOIN active_users ON active_users.user_id = Users.id


