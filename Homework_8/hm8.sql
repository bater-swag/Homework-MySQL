USE vk;
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
SELECT users.id,
  COUNT(DISTINCT messages.id) + 
  COUNT(DISTINCT likes.id) +
  COUNT(DISTINCT media.id) AS activity 
FROM users 
LEFT JOIN messages ON users.id = messages.from_user_id
LEFT JOIN likes ON users.id = likes.user_id
LEFT JOIN media ON users.id = media.user_id
GROUP BY users.id
ORDER BY activity
LIMIT 10;
