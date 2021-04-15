USE uber;

CREATE TABLE users ( id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "������������� ������", 
first_name VARCHAR(100) NOT NULL COMMENT "��� ������������", 
last_name VARCHAR(100) NOT NULL COMMENT "������� ������������", 
email VARCHAR(100) NOT NULL UNIQUE COMMENT "�����", 
phone VARCHAR(100) NOT NULL UNIQUE COMMENT "�������", 
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "����� �������� ������",
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "����� ���������� ������" ) COMMENT "������������";

CREATE TABLE driver_users ( id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "������������� ������", 
first_name VARCHAR(100) NOT NULL COMMENT "��� ��������", 
last_name VARCHAR(100) NOT NULL COMMENT "������� ��������", 
email VARCHAR(100) NOT NULL UNIQUE COMMENT "�����", 
phone VARCHAR(100) NOT NULL UNIQUE COMMENT "�������",
car_id INT UNSIGNED NOT NULL COMMENT "������ �� ����������",
city VARCHAR(130) COMMENT "����� ������", 
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "����� �������� ������",
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "����� ���������� ������" ) COMMENT "��������";

CREATE TABLE cars_info ( id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "������������� ������", 
car_type INT UNSIGNED NOT NULL COMMENT "������ �� ��� ����",  
model VARCHAR(100) NOT NULL COMMENT "������ ����", 
car_number VARCHAR(100) NOT NULL UNIQUE COMMENT "����� ����", 
color VARCHAR(100) NOT NULL COMMENT "���� ����",  
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "����� �������� ������",
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "����� ���������� ������",
date_inspection VARCHAR(100) NOT NULL COMMENT "���� ������������ �������" ) COMMENT "���������� � ����������";

CREATE TABLE orders ( id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "������������� ������", 
user_id INT UNSIGNED NOT NULL COMMENT "������ �� ������������",
driver_id INT UNSIGNED NOT NULL COMMENT "������ �� ��������",
status_id INT UNSIGNED NOT NULL COMMENT "������ �� ������ ������",
address_from_id INT UNSIGNED NOT NULL COMMENT "������ ������", 
address_to_id INT UNSIGNED NOT NULL COMMENT "�������� ������", 
payment INT UNSIGNED NOT NULL COMMENT "������ �� ������",
cost INT NOT NULL COMMENT "��������� ������",
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "����� �������� ������",
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "����� ���������� ������",
car_id int unsigned NOT NULL COMMENT "����������� ������",
type_order int UNSIGNED NOT NULL COMMENT "��� ������",
raiting_driver INT NOT NULL COMMENT "������ �� ������ ��������",
raiting_user INT NOT NULL COMMENT "������ �� ������ ������������" ) COMMENT "������";

CREATE TABLE status_order ( id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "������������� ������", 
status VARCHAR(100) NOT NULL UNIQUE COMMENT "������",  
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "����� �������� ������",
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "����� ���������� ������" ) COMMENT "���������� � ������";

CREATE TABLE payment_status ( id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "������������� ������", 
status VARCHAR(100) NOT NULL UNIQUE COMMENT "������",  
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "����� �������� ������",
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "����� ���������� ������" ) COMMENT "���������� � ������� �������";

CREATE TABLE car_type ( id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "������������� ������", 
class VARCHAR(100) NOT NULL UNIQUE COMMENT "��� ����",  
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "����� �������� ������",
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "����� ���������� ������" ) COMMENT "��� ����";

CREATE TABLE address ( id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "������������� ������", 
city VARCHAR(100) NOT NULL UNIQUE COMMENT "�����",
street VARCHAR(100) NOT NULL UNIQUE COMMENT "�����",
house_number VARCHAR(100) NULL UNIQUE COMMENT "����� ����",
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "����� �������� ������",
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "����� ���������� ������" ) COMMENT "�������";


CREATE TABLE favorite_address ( id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "������������� ������", 
address_id INT UNSIGNED NOT NULL COMMENT "������",
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "����� �������� ������",
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "����� ���������� ������" ) COMMENT "��� ��������";

CREATE TABLE type_order ( id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "������������� ������", 
oreder_type VARCHAR(100) NOT NULL UNIQUE COMMENT "��� �������",
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "����� �������� ������",
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "����� ���������� ������" ) COMMENT "��� ������";

-- ������� ��� ������ ����� csv ������
CREATE TABLE model (model VARCHAR(100) NOT NULL COMMENT "��� �����" ) COMMENT "��� ���";
CREATE TABLE number_1 (numbers VARCHAR(100) NOT NULL COMMENT "��� �������" ) COMMENT "��� �������";
DROP TABLE model;
DROP TABLE number_1;
-- ��������������
ALTER TABLE favorite_address DROP FOREIGN KEY fav_fk_address_id;
ALTER TABLE users DROP FOREIGN KEY users_fk_favorite_id;

ALTER TABLE users 
  ADD CONSTRAINT users_fk_favorite_address_id
    FOREIGN KEY (favorite_address) REFERENCES favorite_address(id);

DROP TABLE favorite_address;

ALTER TABLE favorite_address 
  ADD CONSTRAINT fav_fk_address_id
    FOREIGN KEY (address_id) REFERENCES address(id);

ALTER TABLE orders DROP FOREIGN KEY order_address_to_fk_address_id;
ALTER TABLE orders DROP FOREIGN KEY order_address_from_fk_address_id;

ALTER TABLE orders 
  ADD CONSTRAINT order_address_to_fk_address_id
    FOREIGN KEY (address_to_id) REFERENCES address(id),
  ADD CONSTRAINT order_address_from_fk_address_id
 	FOREIGN KEY (address_from_id) REFERENCES address(id);

-- ��������� ������
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
   

ALTER TABLE cars_info 
  ADD CONSTRAINT cars_info_fk_car_type
    FOREIGN KEY (car_type) REFERENCES car_type(id);   
   
ALTER TABLE orders 
  ADD CONSTRAINT car_fk_car_id
    FOREIGN KEY (car_id) REFERENCES cars_info(id);        

ALTER TABLE orders 
  ADD CONSTRAINT order_address_to_fk_address
    FOREIGN KEY (adress_to) REFERENCES address(id),
  ADD CONSTRAINT order_address_from_fk_address
 	FOREIGN KEY (adress_from) REFERENCES address(id);

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
ADD car_id INT UNSIGNED NOT NULL COMMENT "����������� ������";

ALTER TABLE cars_info 
ADD date_inspection VARCHAR(100) NOT NULL COMMENT "���� ������������ �������";

ALTER TABLE users 
ADD favorite_address int UNSIGNED NOT NULL COMMENT "������� ������";

ALTER TABLE orders 
ADD type_order int UNSIGNED NOT NULL COMMENT "��� ������";

ALTER TABLE orders 
ADD raiting_driver int NOT NULL COMMENT "������ ��������";

ALTER TABLE orders 
ADD raiting_user int NOT NULL COMMENT "������ ������������";


-- ���������� ������� � �������� ����������� ������ filldb.info

INSERT INTO type_order (oreder_type) VALUES ('Delivery'), ('The cheapest'), ('Kids'), ('Black');
INSERT INTO car_type (class) VALUES ('Minivan'), ('Premium sedan'), ('Economy sedan'), ('SUV'), ('Station wagon');
INSERT INTO status_order (status) VALUES ('Order created'), ('Search for a performer'), ('Waiting for the car'), ('Start of execution'), ('End of trip'), ('Waiting for payment'), ('Order cancelled'), ('Order completed');
INSERT INTO payment_status (status) VALUES ('Waiting'), ('Failed'), ('Completed'), ('In processing');

UPDATE orders SET cost=ROUND((RAND()* 2500),1000) WHERE cost=1500;
UPDATE orders SET cost=ROUND((RAND()* 400),100) WHERE cost<100;


-- �������� �� ������������
UPDATE favorite_address 
SET
  address_id = (SELECT id FROM address ORDER BY rand() LIMIT 1)
;

UPDATE users 
SET
  favorite_address = (SELECT id FROM favorite_address ORDER BY rand() LIMIT 1)
;

UPDATE cars_info 
SET
  car_type = (SELECT id FROM car_type ORDER BY rand() LIMIT 1)
;

UPDATE cars_info 
SET
  model = (SELECT model FROM model ORDER BY rand() LIMIT 1)
;

UPDATE cars_info 
SET
  car_number = (SELECT numbers FROM number_1 ORDER BY rand() LIMIT 1)
;

UPDATE orders 
SET
  address_from_id = (SELECT id FROM address ORDER BY rand() LIMIT 1),
  address_to_id = (SELECT id FROM address ORDER BY rand() LIMIT 1),
  status_id = (SELECT id FROM status_order ORDER BY rand() LIMIT 1),
  payment = (SELECT id FROM payment_status ORDER BY rand() LIMIT 1),
  user_id = (SELECT id FROM users ORDER BY rand() LIMIT 1),
  driver_id = (SELECT id FROM driver_users ORDER BY rand() LIMIT 1),
  type_order = (SELECT id FROM type_order ORDER BY rand() LIMIT 1),
  car_id = (SELECT id FROM cars_info ORDER BY rand() LIMIT 1)
;


-- �������
CREATE INDEX orders_ui_di_si_idx ON orders(user_id, driver_id, status_id);
CREATE INDEX orders_ui_afi_ati_idx ON orders(user_id, address_from_id, address_to_id);
CREATE INDEX orders_ui_p_c_idx ON orders(user_id, payment, cost);
CREATE INDEX orders_ui_ru_idx ON orders(user_id, raiting_user);
CREATE INDEX orders_ui_rd_idx ON orders(user_id, raiting_driver);
CREATE INDEX orders_di_to_idx ON orders(driver_id, type_order);
CREATE INDEX orders_ui_to_idx ON orders(user_id, type_order);
CREATE INDEX orders_ui_afi_idx ON orders(user_id, address_from_id);
CREATE INDEX orders_ui_ati_idx ON orders(user_id, address_to_id);

CREATE INDEX cars_info_ct_m_cn_idx ON cars_info(car_type, model, car_number);
CREATE INDEX cars_info_di_idx ON cars_info(date_inspection);

CREATE INDEX address_c_s_hn_idx ON address(city, street, house_number);

CREATE INDEX driver_users_fn_ln_p_idx ON driver_users(first_name, last_name, phone);
CREATE INDEX driver_users_c_idx ON driver_users(city);

CREATE INDEX users_fn_ln_p_idx ON users(first_name, last_name, phone);
CREATE INDEX users_fa_idx ON users(favorite_address);


-- ������� 
-- ��������� ������ � ���������� ����������� ������� �� ��� ������� �����
SELECT city, COUNT(driver_users.id) AS total_type_order
FROM driver_users 
JOIN orders ON driver_users.id = orders.user_id and orders.type_order = '3'
GROUP BY city
ORDER BY total_type_order DESC
LIMIT 1;

-- ��������� ����� ����������������� ������ ���� � ���������� ������
SELECT ci.model, city, COUNT(orders.car_id) AS total_model
FROM orders
JOIN address a2 ON a2.id = orders.address_from_id
JOIN cars_info ci on orders.car_id = ci.id
GROUP BY ci.model, city
ORDER BY total_model DESC
LIMIT 1;

-- ��������� ����� � �������� ������ �� ��������� ���� �����
SELECT ps.status, user_id, COUNT(orders.user_id) AS total_status
FROM orders
JOIN payment_status ps ON ps.id = orders.payment and ps.status = 'Failed'
GROUP BY ps.status, user_id
ORDER BY total_status DESC
LIMIT 1;


-- ��������� ���������� ������� �� ��������
SELECT status_id, COUNT(driver_id) AS count_order
  FROM orders o2 
  LEFT JOIN driver_users du ON du.id = o2.driver_id
  GROUP BY status_id
  ORDER BY count_order DESC
  LIMIT 10
;

-- � ����� ������� ������� �������
SELECT driver_id, sum(raiting_driver)/count(raiting_driver) AS sum_raiting 
  FROM orders 
  GROUP BY driver_id
  ORDER BY sum_raiting DESC
  LIMIT 1
;

-- ������������� 
DROP VIEW information_driver_fav_car;

CREATE VIEW information_driver_fav_car 
as SELECT driver_users.first_name, cars_info.car_type , orders.id 
FROM driver_users, orders, cars_info
WHERE driver_users.id=orders.driver_id and orders.car_id = cars_info.id 
ORDER BY driver_users.first_name;

SELECT * FROM information_driver_fav_car;

DROP VIEW information_city;

CREATE VIEW information_city
as SELECT orders.id , address.city as address_city, driver_users.city as driver_city
FROM orders, address, driver_users
WHERE driver_users.id=orders.driver_id and address.city = driver_users.city  
ORDER BY orders.id;

SELECT * FROM information_city;

-- ���������/��������;
DELIMITER //
CREATE PROCEDURE OrdersSummaryInf()
BEGIN
  SELECT orders.id AS orders, driver_users.phone, users.phone 
  FROM orders 
  INNER JOIN driver_users ON driver_users.id = orders.driver_id 
  INNER JOIN users ON users.id = orders.user_id
END//
DELIMITER ;

CALL OrdersSummaryInf();

DROP PROCEDURE IF EXISTS information();
CREATE PROCEDURE information()
BEGIN
SELECT NOW() AS Time , VERSION() AS Version, COUNT(id) FROM orders;
END//

CALL information();


DELIMITER //
CREATE TRIGGER validate_first_name_description_insert BEFORE INSERT ON users FOR EACH ROW
BEGIN
  IF NEW.first_name IS NULL AND NEW.description IS NULL THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Cannot INSERT if first_name & description are NULL';
  END IF;
END//

CREATE TRIGGER validate_name_description_update BEFORE UPDATE ON driver_users FOR EACH ROW
BEGIN
  IF NEW.phone IS NULL AND NEW.description IS NULL THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Cannot UPDATE if phone & description are NULL';
  END IF;
END//
DELIMITER ;