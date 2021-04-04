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

CREATE TABLE address ( id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
city VARCHAR(100) NOT NULL UNIQUE COMMENT "Город",
street VARCHAR(100) NOT NULL UNIQUE COMMENT "Улица",
house_number VARCHAR(100) NULL UNIQUE COMMENT "Номер дома",
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки" ) COMMENT "Адресса";


CREATE TABLE favorite_address ( id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
address VARCHAR(100) NOT NULL UNIQUE COMMENT "Адресс",
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки" ) COMMENT "Топ адрессов";

CREATE TABLE type_order ( id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
oreder_type VARCHAR(100) NOT NULL UNIQUE COMMENT "Тип поездки",
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки" ) COMMENT "Тип заказа";


ALTER TABLE favorite_address 
  ADD CONSTRAINT fav_fk_address
    FOREIGN KEY (address) REFERENCES address(id);

ALTER TABLE orders 
  ADD CONSTRAINT order_type_fk_order_type
    FOREIGN KEY (type_order) REFERENCES type_order(id);   

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

    

ALTER TABLE cars_info 
  ADD CONSTRAINT cars_info_fk_car_type
    FOREIGN KEY (car_type) REFERENCES car_type(id);   
        

ALTER TABLE orders 
  ADD CONSTRAINT order_address_to_fk_address
    FOREIGN KEY (adress_to) REFERENCES address(id),
  ADD CONSTRAINT order_address_from_fk_address
 	FOREIGN KEY (adress_from) REFERENCES address(id);

ALTER TABLE orders 
  ADD CONSTRAINT car_fk_car_id
    FOREIGN KEY (car_id) REFERENCES cars_info(id);
   
ALTER TABLE users 
  ADD CONSTRAINT users_fk_favorite_id
    FOREIGN KEY (favorite_address) REFERENCES favorite_address(id);
   
ALTER TABLE orders 
  ADD CONSTRAINT orders_fk_driver_id
    FOREIGN KEY (driver_id) REFERENCES driver_users(id);
   
USE uber;

ALTER TABLE driver_users DROP FOREIGN KEY driver_users_fk_car_id;
ALTER TABLE orders DROP FOREIGN KEY orders_fk_rait_us;


ALTER TABLE orders 
ADD car_id INT UNSIGNED NOT NULL COMMENT "Индефикатор машины";

ALTER TABLE cars_info 
ADD date_inspection VARCHAR(100) NOT NULL COMMENT "Дата технического осмотра";

ALTER TABLE users 
ADD favorite_address int UNSIGNED NOT NULL COMMENT "Любимые адреса";

ALTER TABLE orders 
ADD type_order int UNSIGNED NOT NULL COMMENT "Тип заказа";