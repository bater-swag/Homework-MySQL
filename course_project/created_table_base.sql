USE uber;

CREATE TABLE users ( id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
first_name VARCHAR(100) NOT NULL COMMENT "Имя пользователя", 
last_name VARCHAR(100) NOT NULL COMMENT "Фамилия пользователя", 
email VARCHAR(100) NOT NULL UNIQUE COMMENT "Почта", 
phone VARCHAR(100) NOT NULL UNIQUE COMMENT "Телефон", 
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки" ) COMMENT "Пользователи";

CREATE TABLE driver_users ( id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
first_name VARCHAR(100) NOT NULL COMMENT "Имя водителя", 
last_name VARCHAR(100) NOT NULL COMMENT "Фамилия водителя", 
email VARCHAR(100) NOT NULL UNIQUE COMMENT "Почта", 
phone VARCHAR(100) NOT NULL UNIQUE COMMENT "Телефон",
car_id INT UNSIGNED NOT NULL COMMENT "Ссылка на автомобиль",
city VARCHAR(130) COMMENT "Город работы", 
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки" ) COMMENT "Водители";

CREATE TABLE cars_info ( id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
car_type INT UNSIGNED NOT NULL COMMENT "Ссылка на тип авто",  
model VARCHAR(100) NOT NULL UNIQUE COMMENT "Модель авто", 
car_number VARCHAR(100) NOT NULL UNIQUE COMMENT "Номер авто", 
color VARCHAR(100) NOT NULL UNIQUE COMMENT "Цвет авто",  
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки" ) COMMENT "Информация о автомобиле";

CREATE TABLE orders ( id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя",
driver_id INT UNSIGNED NOT NULL COMMENT "Ссылка на водителя",
status_id INT UNSIGNED NOT NULL COMMENT "Ссылка на статус заказа",
adress_from VARCHAR(100) NOT NULL UNIQUE COMMENT "Адресс вызова", 
adress_to VARCHAR(100) NOT NULL UNIQUE COMMENT "Конечный адресс", 
payment INT UNSIGNED NOT NULL UNIQUE COMMENT "Данные об оплате",
cost INT UNSIGNED NOT NULL COMMENT "Стоимость заказа",
raiting_users_id INT UNSIGNED NOT NULL COMMENT "Ссылка на оценку пользователя",
raiting_driver_id INT UNSIGNED NOT NULL COMMENT "Ссылка на оценку водителя",
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки" ) COMMENT "Заказы";


CREATE TABLE raiting_users ( id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
driver_id INT UNSIGNED NOT NULL COMMENT "Ссылка на водителя",
target_user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на водителя",
raiting INT UNSIGNED NOT NULL COMMENT "Оценка",
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки" ) COMMENT "Отзывы об пользователях";

CREATE TABLE raiting_drivers ( id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя",
target_driver_id INT UNSIGNED NOT NULL COMMENT "Ссылка на водителя",
raiting INT UNSIGNED NOT NULL COMMENT "Оценка",
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки" ) COMMENT "Отзывы об водителях";

CREATE TABLE status_order ( id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
status VARCHAR(100) NOT NULL UNIQUE COMMENT "Статус",  
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки" ) COMMENT "Информация о заказе";

CREATE TABLE payment_status ( id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
status VARCHAR(100) NOT NULL UNIQUE COMMENT "Статус",  
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки" ) COMMENT "Информация о статусе платежа";

CREATE TABLE car_type ( id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
class VARCHAR(100) NOT NULL UNIQUE COMMENT "Тип авто",  
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки" ) COMMENT "Тип авто";




ALTER TABLE orders 
  ADD CONSTRAINT orders_fk_user_id
    FOREIGN KEY (user_id) REFERENCES users(id),
  ADD CONSTRAINT orders_fk_driver_id
    FOREIGN KEY (driver_id) REFERENCES driver_users(id),
  ADD CONSTRAINT orders_fk_payment
    FOREIGN KEY (payment) REFERENCES payment_status(id),
  ADD CONSTRAINT orders_fk_status_id
    FOREIGN KEY (status_id) REFERENCES status_order(id);
   
ALTER TABLE orders 
  ADD CONSTRAINT orders_fk_rait_us
    FOREIGN KEY (raiting_users_id) REFERENCES raiting_users(id),
  ADD CONSTRAINT orders_fk_rait_dr
    FOREIGN KEY (raiting_driver_id) REFERENCES raiting_drivers(id);

    
ALTER TABLE driver_users 
  ADD CONSTRAINT driver_users_fk_car_id
    FOREIGN KEY (car_id) REFERENCES cars_info(id);

ALTER TABLE cars_info 
  ADD CONSTRAINT cars_info_fk_car_type
    FOREIGN KEY (car_type) REFERENCES car_type(id);   

ALTER TABLE raiting_drivers 
  ADD CONSTRAINT cars_info_fk_car_type
    FOREIGN KEY (car_type) REFERENCES car_type(id);      

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