
-- 1
SELECT (SELECT gender_info FROM gender WHERE id = profiles.gender_id) as gender,
COUNT(*) AS total
from likes INNER JOIN profiles on profiles.user_id = likes.user_id
GROUP BY gender 
ORDER BY total DESC
LIMIT 1;

-- 2 
SELECT target_id, COUNT(*) as "Количество лайков" FROM (
SELECT target_id FROM likes INNER JOIN (
SELECT user_id FROM profiles ORDER BY birthday DESC) profiles on profiles.user_id = likes.target_id) rt GROUP BY target_id LIMIT 10;

-- 3

