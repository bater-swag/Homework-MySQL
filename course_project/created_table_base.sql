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


CREATE TABLE raiting_users ( id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "������������� ������", 
driver_id INT UNSIGNED NOT NULL COMMENT "������ �� ��������",
target_user_id INT UNSIGNED NOT NULL COMMENT "������ �� ��������",
raiting INT UNSIGNED NOT NULL COMMENT "������",
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "����� �������� ������",
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "����� ���������� ������" ) COMMENT "������ �� �������������";

CREATE TABLE raiting_drivers ( id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "������������� ������", 
user_id INT UNSIGNED NOT NULL COMMENT "������ �� ������������",
target_driver_id INT UNSIGNED NOT NULL COMMENT "������ �� ��������",
raiting INT UNSIGNED NOT NULL COMMENT "������",
created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "����� �������� ������",
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "����� ���������� ������" ) COMMENT "������ �� ���������";

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