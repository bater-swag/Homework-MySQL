USE shop;
-- 1
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    table_name varchar(50) NOT NULL,
    row_id INT UNSIGNED NOT NULL,
    row_name varchar(255),
    created_at datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE = Archive;

drop trigger if exists products_insert;
CREATE TRIGGER products_insert AFTER INSERT ON products FOR EACH ROW
BEGIN
  INSERT INTO logs VALUES (NULL, "products", NEW.id, NEW.name, DEFAULT);
END
//

drop trigger if exists users_insert;
CREATE TRIGGER users_insert AFTER INSERT ON users FOR EACH ROW
BEGIN
    INSERT INTO logs VALUES (NULL, "users", NEW.id, NEW.name, DEFAULT);
END
//

drop trigger if exists catalogs_insert;
CREATE TRIGGER catalogs_insert AFTER INSERT ON catalogs FOR EACH ROW
BEGIN
    INSERT INTO logs VALUES (NULL, "catalogs", NEW.id, NEW.name, DEFAULT);
END
//


INSERT INTO products (name) VALUES ('Samsung');
INSERT INTO users (name) VALUES ('Михаил');
INSERT INTO catalogs (name) VALUES ('Мониторы');


-- 2.
DROP TABLE IF EXISTS samples;
CREATE TABLE samples (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO samples(name) VALUES
  ('Иван'), ('Мария'),
  ('Ольга'), ('Юрий'),
  ('Екатерина'), ('Сергей'), 
  ('Анастасия'), ('Наталья'),
  ('Аркадий'), ('Владимир');


SELECT COUNT(*)
FROM
  samples AS s1, -- 10
  samples AS s2, -- 100
  samples AS s3,
  samples AS s4,
  samples AS s5,
  samples AS s6; -- 1000000

-- Практическое задание тема "NoSQL"
-- 1.
HINCRBY addresses '127.0.0.1' 1
HGETALL addresses

HINCRBY addresses '127.0.0.2' 1
HGETALL addresses

HGET addresses '127.0.0.1'

-- 2.
HSET emails 'igor' 'igorsimdyanov@gmail.com'
HSET emails 'sergey' 'sergey@gmail.com'
HSET emails 'olga' 'olga@mail.ru'

HGET emails 'igor'

HSET users 'igorsimdyanov@gmail.com' 'igor'
HSET users 'sergey@gmail.com' 'sergey'
HSET users 'olga@mail.ru' 'olga'

HGET users 'olga@mail.ru'

-- 3.

show dbs

use shop

db.createCollection('catalogs')
db.createCollection('products')

db.catalogs.insert({name: 'Процессоры'})
db.catalogs.insert({name: 'Мат.платы'})
db.catalogs.insert({name: 'Видеокарты'})

db.products.insert(
  {
    name: 'Intel Core i3-8100',
    description: 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.',
    price: 7890.00,
    catalog_id: new ObjectId("5b56c73f88f700498cbdc56b")
  }
);

db.products.insert(
  {
    name: 'Intel Core i5-7400',
    description: 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.',
    price: 12700.00,
    catalog_id: new ObjectId("5b56c73f88f700498cbdc56b")
  }
);

db.products.insert(
  {
    name: 'ASUS ROG MAXIMUS X HERO',
    description: 'Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX',
    price: 19310.00,
    catalog_id: new ObjectId("5b56c74788f700498cbdc56c")
  }
);

db.products.find()
db.products.find({catalog_id: ObjectId("5b56c73f88f700498cbdc56bdb")})
