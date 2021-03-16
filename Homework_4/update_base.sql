ALTER TABLE profiles 
ADD patronymic_name VARCHAR(100) COMMENT "Отчество пользователя" AFTER user_id;

ALTER TABLE profiles 
ADD first_name varchar(100) NOT NULL COMMENT "Имя пользователя" AFTER user_id,
ADD last_name varchar(100) NOT NULL COMMENT "Фамилия пользователя" AFTER first_name;

ALTER TABLE messages 
ADD is_read BOOLEAN COMMENT "Признаки прочтения" AFTER is_delivered;

CREATE TABLE user_statuses (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Индентификатор строки",
	name VARCHAR(100) NOT NULL COMMENT "Название статуса",
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Справочник статусов пользователя";

INSERT INTO user_statuses (name) VALUES ('Single'), ('Married');

ALTER TABLE profiles RENAME COLUMN status TO user_status_id;
UPDATE profiles set user_status_id = null;
ALTER TABLE profiles MODIFY COLUMN user_status_id INT UNSIGNED;

CREATE TABLE gender (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Индентификатор строки",
	gender VARCHAR(25) COMMENT "Название пола",
	gender_info VARCHAR(150) COMMENT "Информация о поле",
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP  ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Варианты полов";

INSERT INTO gender (gender, gender_info) VALUES ('M', 'Male'), ('F', 'Female');

UPDATE profiles set gender = null;
ALTER TABLE profiles MODIFY COLUMN gender INT UNSIGNED;
ALTER TABLE profiles RENAME COLUMN gender TO gender_id;


truncate TABLE friendship_statuses;
truncate TABLE media_types;

INSERT INTO friendship_statuses (name) VALUES ('Requested'), ('Approved'), ('Declined');
INSERT INTO media_types (name) VALUES ('Image'), ('Video'), ('Audio');

UPDATE profiles p 
SET 
	p.first_name = (SELECT u.first_name FROM users u WHERE id = p.user_id),
	p.last_name = (SELECT u.last_name FROM users u WHERE id = p.user_id),
	p.patronymic_name = (SELECT u.first_name FROM users u WHERE id = p.user_id)
;

SELECT id FROM gender ORDER BY rand() LIMIT 1;

UPDATE profiles p
SET
	gender_id = (SELECT id FROM gender ORDER BY rand() LIMIT 1)
;

UPDATE profiles p
SET
	user_status_id = (SELECT id FROM user_statuses ORDER BY rand() LIMIT 1)
;

UPDATE media 
SET
	media_type_id = (SELECT id FROM media_types ORDER BY rand() LIMIT 1)
;

UPDATE friendship f
SET
	friend_id = (SELECT u.id FROM users u WHERE u.id != f.user_id ORDER BY rand() LIMIT 1)
;

UPDATE friendship
SET
	status_id = (SELECT id FROM friendship_statuses ORDER BY rand() LIMIT 1)
;


UPDATE messages m
SET
	m.to_user_id = (SELECT u.id FROM users u WHERE u.id != m.from_user_id ORDER BY rand() LIMIT 1)
;

UPDATE messages
SET
	is_read = IF(RAND() > 0.5, 0, 1)
	WHERE is_delivered = 1;

UPDATE profiles p
SET p.photo_id = (
	SELECT m.id FROM media m
	WHERE m.media_type_id = (SELECT id FROM media_types WHERE name = 'Image')
	AND m.user_id = p.user_id 
	ORDER BY rand() LIMIT 1
);

ALTER TABLE users DROP COLUMN first_name;
ALTER TABLE users DROP COLUMN last_name;

