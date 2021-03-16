USE vk;

-- Создаём таблицу like
CREATE TABLE like_info (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  id_like INT UNSIGNED NOT NULL COMMENT "Ссылка на лайк",
  user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя",
  media_type_id INT UNSIGNED NOT NULL COMMENT "Ссылка на тип контента",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Лайки пользователей";

-- Создаём таблицу post информация
CREATE TABLE post_info (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  post_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пост",
  id_like INT UNSIGNED NOT NULL COMMENT "Ссылка на лайк",
  user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя",
  media_type_id INT UNSIGNED NOT NULL COMMENT "Ссылка на тип контента",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Пост информация";