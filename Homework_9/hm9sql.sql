USE shop;
SELECT * FROM shop.users;
SELECT * FROM sample.users;

START TRANSACTION;
  INSERT INTO sample.users SELECT * FROM shop.users WHERE id = 1;
  DELETE FROM shop.users WHERE id = 1;
COMMIT;


-- 2.

CREATE OR REPLACE VIEW products_catalogs AS
SELECT
  p.name AS product,
  c.name AS catalog
FROM products AS p
JOIN catalogs AS c ON p.catalog_id = c.id;


-- 3.

-- Вариант с временной таблицей
truncate TABLE posts;
CREATE TABLE IF NOT EXISTS posts (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  created_at DATE NOT NULL
);

INSERT INTO posts VALUES
(NULL, 'первая запись', '2018-08-01'),
(NULL, 'вторая запись', '2018-08-04'),
(NULL, 'третья запись', '2018-08-16'),
(NULL, 'четвертая запись', '2018-08-17');

CREATE TEMPORARY TABLE last_days (
  day INT
);

INSERT INTO last_days VALUES
(0), (1), (2), (3), (4), (5), (6), (7), (8), (9), (10),(11), (12), (13), (14), (15),
(16), (17), (18), (19), (20), (21), (22), (23), (24), (25), (26), (27), (28), (29), (30);


SELECT
  DATE(DATE('2018-08-31') - INTERVAL l.day DAY) AS day,
  -- p.name,
  NOT ISNULL(p.name) AS order_exists
FROM last_days AS l
LEFT JOIN posts AS p
ON DATE(DATE('2018-08-31') - INTERVAL l.day DAY) = p.created_at
ORDER BY day;

-- 4.
TRUNCATE TABLE posts;

DROP TABLE IF EXISTS posts;
CREATE TABLE IF NOT EXISTS posts (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  created_at DATE NOT NULL
);


INSERT INTO posts VALUES
(NULL, 'первая запись', '2018-11-01'),
(NULL, 'вторая запись', '2018-11-02'),
(NULL, 'третья запись', '2018-11-03'),
(NULL, 'четвертая запись', '2018-11-04'),
(NULL, 'пятая запись', '2018-11-05'),
(NULL, 'шестая запись', '2018-11-06'),
(NULL, 'седьмая запись', '2018-11-07'),
(NULL, 'восьмая запись', '2018-11-08'),
(NULL, 'девятая запись', '2018-11-09'),
(NULL, 'десятая запись', '2018-11-10'),
(NULL, 'одиннадцатая запись', '2018-11-11'),
(NULL, 'двенадцатая запись', '2018-11-12');

SELECT * FROM posts;

SELECT * FROM posts
JOIN (
  SELECT created_at
  FROM posts
  ORDER BY created_at DESC
  LIMIT 5, 1
) AS delpst
ON posts.created_at <= delpst.created_at;

DELETE posts FROM posts
JOIN (
  SELECT created_at
  FROM posts
  ORDER BY created_at DESC
  LIMIT 5, 1
) AS delpst
ON posts.created_at <= delpst.created_at;

SELECT * FROM posts;


-- 1.

DROP USER IF EXISTS 'shop_read'@'localhost';
CREATE USER IF NOT EXISTS 'shop_read'@'localhost' identified BY 'password';
GRANT SELECT, SHOW VIEW ON shop.* TO 'shop_read'@'localhost';

DROP USER IF EXISTS 'shop'@'localhost';
CREATE USER IF NOT EXISTS 'shop'@'localhost' identified BY 'password';
GRANT ALL ON shop.* TO 'shop'@'localhost';

SHOW grants FOR 'shop'@'localhost';
SHOW grants FOR 'shop_read'@'localhost';

-- 2.

DROP TABLE IF EXISTS accounts;
CREATE TABLE IF NOT EXISTS accounts (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  password VARCHAR(255)
);

INSERT INTO accounts (name, password) VALUES
  ('Геннадий', 'Qt3X08VetW'),
  ('Наталья', 'hvg0b057Br'),
  ('Александр', 'a4YGUJjRLk'),
  ('Сергей', 'YYug1IeyWl'),
  ('Иван', 'oKoo7KXvTE'),
  ('Мария', 'w5r4yvfo9f');

CREATE OR REPLACE VIEW username AS
SELECT id, name FROM accounts;

DROP USER IF EXISTS 'user_read'@'localhost';
CREATE USER IF NOT EXISTS 'user_read'@'localhost' identified BY 'password';
GRANT SELECT(id, name) ON shop.username TO 'user_read'@'localhost';

SHOW grants FOR 'user_read'@'localhost';


-- 1.
USE shop;

DROP FUNCTION IF EXISTS hello;

DELIMITER ~~

CREATE FUNCTION hello()
RETURNS TINYTEXT NO SQL
BEGIN
  DECLARE hour INT;
  SET hour = HOUR(NOW());
  CASE
    WHEN hour BETWEEN 0 AND 5 THEN
      RETURN "Доброй ночи";
    WHEN hour BETWEEN 6 AND 11 THEN
      RETURN "Доброе утро";
    WHEN hour BETWEEN 12 AND 17 THEN
      RETURN "Добрый день";
    WHEN hour BETWEEN 18 AND 23 THEN
      RETURN "Добрый вечер";
  END CASE;
END
~~

DELIMITER ;

SELECT NOW(), hello();

-- 2.

DROP TRIGGER IF EXISTS validate_name_description_insert;
DROP TRIGGER IF EXISTS validate_name_description_update;

DELIMITER //
CREATE TRIGGER validate_name_description_insert BEFORE INSERT ON products FOR EACH ROW
BEGIN
  IF NEW.name IS NULL AND NEW.description IS NULL THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Cannot INSERT if name & description are NULL';
  END IF;
END//

CREATE TRIGGER validate_name_description_update BEFORE UPDATE ON products FOR EACH ROW
BEGIN
  IF NEW.name IS NULL AND NEW.description IS NULL THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Cannot UPDATE if name & description are NULL';
  END IF;
END//
DELIMITER ;

SELECT * FROM products;

INSERT INTO products
  (name, description, price, catalog_id)
VALUES
  (NULL, NULL, 9360.00, 2);

UPDATE products
  SET name = NULL, description = NULL
WHERE id = 1;

INSERT INTO products
  (name, description, price, catalog_id)
VALUES
  ('ASUS PRIME Z370-P', 'HDMI, SATA3, PCI Express 3.0,, USB 3.1', 9360.00, 2);

INSERT INTO products
  (name, description, price, catalog_id)
VALUES
  (NULL, 'HDMI, SATA3, PCI Express 3.0,, USB 3.1', 9360.00, 2);

INSERT INTO products
  (name, description, price, catalog_id)
VALUES
  ('ASUS PRIME Z370-P', NULL, 9360.00, 2);

SELECT * FROM products;

-- 3.

DROP FUNCTION FIBONACCI;

DELIMITER //
CREATE FUNCTION FIBONACCI(num INT)
RETURNS INT DETERMINISTIC
BEGIN
  DECLARE fs DOUBLE;
  SET fs = SQRT(5);
  RETURN (POW((1 + fs) / 2.0, num) + POW((1 - fs) / 2.0, num)) / fs; -- Формула Бине
END//

DELIMITER ;

SELECT FIBONACCI(10);