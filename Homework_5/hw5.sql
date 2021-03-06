USE shop;

-- ??????? 1

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT '??? ??????????',
  birthday_at DATE COMMENT '???? ????????',
  created_at VARCHAR(255),
  updated_at VARCHAR(255)
) COMMENT = '??????????';

INSERT INTO
  users (name, birthday_at)
VALUES
  ('????????', '1990-10-05'),
  ('???????', '1984-11-12'),
  ('?????????', '1985-05-20'),
  ('??????', '1988-02-14'),
  ('????', '1998-01-12'),
  ('?????', '2006-08-29'),
  ('???????', '1985-12-29'),
  ('?????', '1990-12-30')
  ;

SELECT * FROM users;
DESC users;

UPDATE
  users
SET
  created_at = NOW(),
  updated_at = NOW();

-- ??????? 2
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT '??? ??????????',
  birthday_at DATE COMMENT '???? ????????',
  created_at VARCHAR(255),
  updated_at VARCHAR(255)
) COMMENT = '??????????';

INSERT INTO
  users (name, birthday_at, created_at, updated_at)
VALUES
  ('????????', '1990-10-05', '07.01.2016 12:05', '07.01.2016 12:05'),
  ('???????', '1984-11-12', '20.05.2016 16:32', '20.05.2016 16:32'),
  ('?????????', '1985-05-20', '14.08.2016 20:10', '14.08.2016 20:10'),
  ('??????', '1988-02-14', '21.10.2016 9:14', '21.10.2016 9:14'),
  ('????', '1998-01-12', '15.12.2016 12:45', '15.12.2016 12:45'),
  ('?????', '2006-08-29', '12.01.2017 8:56', '12.01.2017 8:56'),
  ('???????', '1985-12-29', '15.04.2018 18:46', '15.04.2018 18:46'),
  ('?????', '1990-12-30', '17.01.2017 19:05', '17.01.2017 19:05')
  ;

SELECT * FROM users;

-- ???????????????
UPDATE users
SET created_at = STR_TO_DATE(created_at, '%d.%m.%Y %k:%i'),
    updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %k:%i');

ALTER TABLE users CHANGE created_at created_at DATETIME DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE users CHANGE updated_at updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

-- ??????? 3
DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
  id SERIAL PRIMARY KEY,
  storehouse_id INT UNSIGNED,
  product_id INT UNSIGNED,
  value INT UNSIGNED COMMENT '????? ?? ??????',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = '?????? ?? ??????';

INSERT INTO
  storehouses_products (storehouse_id, product_id, value)
VALUES
  (1, 543, 0),
  (1, 789, 2500),
  (1, 3432, 0),
  (1, 826, 30),
  (1, 719, 500),
  (1, 638, 1);

SELECT * FROM storehouses_products ORDER BY value;
SELECT * FROM storehouses_products ORDER BY value desc;

SELECT * FROM storehouses_products
ORDER BY CASE WHEN value = 0 then 1 else 0 end, value;

SELECT * FROM storehouses_products
ORDER BY CASE WHEN value = 0 THEN 4294967295 ELSE value END

SELECT ~0 as max_bigint_unsigned, ~0 >> 32 as max_int_unsigned;

-- ??????? 4
SELECT * FROM users;

SELECT name
  FROM users
  WHERE DATE_FORMAT(birthday_at, '%M') IN ('may', 'august');

-- ??????? 5
DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT '???????? ???????',
  UNIQUE unique_name(name(10))
) COMMENT = '??????? ????????-????????';

INSERT INTO catalogs VALUES
  (NULL, '??????????'),
  (NULL, '??????????? ?????'),
  (NULL, '??????????'),
  (NULL, '??????? ?????'),
  (NULL, '??????????? ??????');

SELECT * FROM catalogs
WHERE id IN (1, 2, 5)
ORDER BY FIELD(id, 5, 1, 2);

SELECT * FROM catalogs
WHERE id IN (5, 1, 2)
ORDER BY FIELD(id, 5, 1, 2);

-- ??????? 1
SELECT * FROM users;

SELECT avg(YEAR(now()) - YEAR(birthday_at)) AS age
FROM users;

-- ??????? 2

SELECT
  DATE_FORMAT(DATE(CONCAT_WS('-', YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at))), '%W') AS day,
  COUNT(*) AS total
FROM users
GROUP BY day
ORDER BY total DESC;

select name, birthday_at,
  DAYNAME(birthday_at),
  DAYNAME(DATE(CONCAT_WS('-', YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at))))
from users;

-- ??????? 3
SELECT ROUND(EXP(SUM(LN(id)))) FROM catalogs;
SELECT * FROM catalogs;