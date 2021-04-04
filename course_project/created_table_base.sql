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
model VARCHAR(100) NOT NULL UNIQUE COMMENT "������ ����", 
car_number VARCHAR(100) NOT NULL UNIQUE COMMENT "����� ����", 
color VARCHAR(100) NOT NULL UNIQUE COMMENT "���� ����",  
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "����� �������� ������",
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "����� ���������� ������" ) COMMENT "���������� � ����������";

CREATE TABLE orders ( id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "������������� ������", 
user_id INT UNSIGNED NOT NULL COMMENT "������ �� ������������",
driver_id INT UNSIGNED NOT NULL COMMENT "������ �� ��������",
status_id INT UNSIGNED NOT NULL COMMENT "������ �� ������ ������",
adress_from VARCHAR(100) NOT NULL UNIQUE COMMENT "������ ������", 
adress_to VARCHAR(100) NOT NULL UNIQUE COMMENT "�������� ������", 
payment INT UNSIGNED NOT NULL UNIQUE COMMENT "������ �� ������",
cost INT UNSIGNED NOT NULL COMMENT "��������� ������",
raiting_users_id INT UNSIGNED NOT NULL COMMENT "������ �� ������ ������������",
raiting_driver_id INT UNSIGNED NOT NULL COMMENT "������ �� ������ ��������",
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "����� �������� ������",
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "����� ���������� ������" ) COMMENT "������";


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
address VARCHAR(100) NOT NULL UNIQUE COMMENT "������",
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "����� �������� ������",
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "����� ���������� ������" ) COMMENT "��� ��������";

CREATE TABLE type_order ( id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "������������� ������", 
oreder_type VARCHAR(100) NOT NULL UNIQUE COMMENT "��� �������",
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "����� �������� ������",
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "����� ���������� ������" ) COMMENT "��� ������";


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
ADD car_id INT UNSIGNED NOT NULL COMMENT "����������� ������";

ALTER TABLE cars_info 
ADD date_inspection VARCHAR(100) NOT NULL COMMENT "���� ������������ �������";

ALTER TABLE users 
ADD favorite_address int UNSIGNED NOT NULL COMMENT "������� ������";

ALTER TABLE orders 
ADD type_order int UNSIGNED NOT NULL COMMENT "��� ������";