ALTER TABLE profiles
  ADD CONSTRAINT profiles_fk_photo_id
    FOREIGN KEY (photo_id) REFERENCES media(id),
  ADD CONSTRAINT profiles_users_fk_comm_id
    FOREIGN KEY (community_id) REFERENCES communities(id),
  ADD CONSTRAINT comm_users_fk_user_id
    FOREIGN KEY (user_id) REFERENCES users(id);
   
ALTER TABLE media
  ADD CONSTRAINT media_fk_media_type_id
    FOREIGN KEY (media_type_id) REFERENCES media_types(id),
  ADD CONSTRAINT media_fk_user_id
    FOREIGN KEY (user_id) REFERENCES users(id);  
      
ALTER TABLE likes 
  ADD CONSTRAINT likes_fk_target_type
    FOREIGN KEY (target_type_id) REFERENCES target_types(id),
  ADD CONSTRAINT likes_fk_user_id
    FOREIGN KEY (user_id) REFERENCES users(id); 

ALTER TABLE friendship 
  ADD CONSTRAINT friendship_fk_status_id
    FOREIGN KEY (status_id) REFERENCES friendship_statuses(id),
  ADD CONSTRAINT friendship_fk_fried_id
    FOREIGN KEY (friend_id) REFERENCES users(id),
  ADD CONSTRAINT friendship_fk_user_id
    FOREIGN KEY (user_id) REFERENCES users(id);

ALTER TABLE posts 
  ADD CONSTRAINT posts_fk_comm_id
    FOREIGN KEY (community_id) REFERENCES communities_users(community_id),
  ADD CONSTRAINT posts_fk_user_id
    FOREIGN KEY (user_id) REFERENCES users(id);
    
-- задание 3
SELECT
  gender_id,
  count(*) as "Количество лайков по гендерам"
FROM
  likes, profiles
WHERE
  (profiles.gender_id = '1' and likes.user_id = profiles.user_id) <> (profiles.gender_id = '2' and likes.user_id = profiles.user_id)
GROUP BY
  gender_id 
order by 
  count(*) DESC
  
-- задание 4
SELECT target_id, COUNT(*) as "Количество лайков" FROM (
SELECT target_id FROM likes INNER JOIN (
SELECT user_id FROM profiles ORDER BY birthday DESC) profiles on profiles.user_id = likes.target_id) rt GROUP BY target_id LIMIT 10;

-- задание 5 не успел сделать, доделаю потом

