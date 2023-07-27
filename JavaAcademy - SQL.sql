CREATE DATABASE java_academy;
USE java_academy;
SELECT DATABASE();

#pizzasテーブル作成
CREATE TABLE pizzas(
	id INT,
	name VARCHAR(10),
	description TEXT,
	price INT,
	image MEDIUMBLOB
)

SHOW TABLES;

ALTER TABLE pizzas MODIFY id INT PRIMARY KEY;
DESCRIBE pizzas;


#データ投入
INSERT INTO pizzas(id, name, description, price, image) VALUES (1, 'マルゲリータ', 'トマトソース、モッツァレラチーズ、生のバジル', 1099, 'margherita.jpg');
INSERT INTO pizzas(id, name, description, price, image) VALUES (2, 'ペパロニ', 'トマトソース、モッツァレラチーズ、ペパロニ、赤ペッパーフレーク', 1299, 'pepperoni.jpg');
INSERT INTO pizzas(id, name, description, price, image) VALUES (3, 'ベジタリアン', 'トマトソース、モッツァレラチーズ、グリーンピーマン、キノコ、玉ねぎ', 1199, 'vegetarian.jpg');
INSERT INTO pizzas(id, name, description, price, image) VALUES (4, 'ハワイアン', 'トマトソース、モッツァレラチーズ、ハム、パインアップル、赤い玉ねぎ', 1399, 'hawaiian.jpg');
INSERT INTO pizzas(id, name, description, price, image) VALUES (5, 'ミートラバー', 'トマトソース、モッツァレラチーズ、ペパロニ、ソーセージ、ハム、ベーコン', 1599, 'meatlover.jpg');

#全ての列を選択
SELECT * FROM pizzas;

#名前と価格の列だけを選択
SELECT name, price FROM pizzas;

#価格が12ドル以上（１ドル100円と仮定）のピザを全て選択
SELECT * FROM pizzas WHERE price >= 1200;

#最高価格のピザの名前と説明を選択
SELECT name, description FROM pizzas ORDER BY price DESC LIMIT 1;

#全てのピザの平均価格を選択
SELECT AVG(price) AS "平均" FROM pizzas;

#"pizzas"テーブルのピザの数を選択
SELECT COUNT(name) AS "総数" FROM pizzas;

#toppingsテーブル作成
CREATE TABLE toppings(
	id INT PRIMARY KEY,
	name VARCHAR(10),
	price INT
)

SHOW TABLES;

#データ投入
INSERT INTO toppings(id, name, price) VALUES(1, '追加チーズ', 150);
INSERT INTO toppings(id, name, price) VALUES(2, 'ペパロニ', 75);
INSERT INTO toppings(id, name, price) VALUES(3, 'ソーセージ', 75);
INSERT INTO toppings(id, name, price) VALUES(4, 'ハム', 75);
INSERT INTO toppings(id, name, price) VALUES(5, 'ベーコン', 75);
INSERT INTO toppings(id, name, price) VALUES(6, 'グリーンピーマン', 50);
INSERT INTO toppings(id, name, price) VALUES(7, 'キノコ', 50);
INSERT INTO toppings(id, name, price) VALUES(8, '玉ねぎ', 50);
INSERT INTO toppings(id, name, price) VALUES(9, 'パインアップル', 50);
INSERT INTO toppings(id, name, price) VALUES(10, '赤ペッパーフレーク', 50);
INSERT INTO toppings(id, name, price) VALUES(11, '生のバジル', 25);

#pizzas_toppingsテーブル作成
CREATE TABLE pizzas_toppings(
	id INT PRIMARY KEY,
	pizza_id INT,
	toppings_id INT
)

SHOW TABLES;

#データ投入
INSERT INTO pizzas_toppings(id, pizza_id, toppings_id) VALUES(1, 1, 11);
INSERT INTO pizzas_toppings(id, pizza_id, toppings_id) VALUES(2, 2, 1);
INSERT INTO pizzas_toppings(id, pizza_id, toppings_id) VALUES(3, 2, 2);
INSERT INTO pizzas_toppings(id, pizza_id, toppings_id) VALUES(4, 3, 6);
INSERT INTO pizzas_toppings(id, pizza_id, toppings_id) VALUES(5, 3, 7);
INSERT INTO pizzas_toppings(id, pizza_id, toppings_id) VALUES(6, 3, 8);
INSERT INTO pizzas_toppings(id, pizza_id, toppings_id) VALUES(7, 4, 4);
INSERT INTO pizzas_toppings(id, pizza_id, toppings_id) VALUES(8, 4, 9);
INSERT INTO pizzas_toppings(id, pizza_id, toppings_id) VALUES(9, 4, 8);
INSERT INTO pizzas_toppings(id, pizza_id, toppings_id) VALUES(10, 5, 1);
INSERT INTO pizzas_toppings(id, pizza_id, toppings_id) VALUES(11, 5, 2);
INSERT INTO pizzas_toppings(id, pizza_id, toppings_id) VALUES(12, 5, 4);
INSERT INTO pizzas_toppings(id, pizza_id, toppings_id) VALUES(13, 5, 5);
INSERT INTO pizzas_toppings(id, pizza_id, toppings_id) VALUES(14, 5, 8);

#ピザ１に含まれているトッピングを全て選択
SELECT name FROM toppings WHERE id = (SELECT toppings_id FROM pizzas_toppings WHERE pizza_id = 1);

#ピザ２に含まれているトッピングの名前と価格を選択  複数の結果を返す場合はINを使う
SELECT name, price FROM toppings WHERE id IN (SELECT toppings_id FROM pizzas_toppings WHERE pizza_id = 2);

#ピザ２に含まれているトッピングの価格の合計を選択
SELECT SUM(price) AS "合計" FROM toppings WHERE id IN (SELECT toppings_id FROM pizzas_toppings WHERE pizza_id = 2);

#"pizzas"テーブルに含まれているピザのトッピング名と価格を全て選択
SELECT name, price FROM toppings WHERE id IN (SELECT toppings_id FROM pizzas_toppings);

#"pizzas"テーブルに含まれているピザのトッピング価格の平均値を選択
SELECT AVG(price) AS "平均" FROM toppings WHERE id IN (SELECT toppings_id FROM pizzas_toppings);

#全てのピザのトッピングの名前と価格の合計を選択
SELECT p.name, SUM(t.price) AS "トッピング合計価格" FROM pizzas p LEFT JOIN pizzas_toppings pt ON p.id = pt.pizza_id LEFT JOIN toppings t ON t.id = pt.toppings_id GROUP BY p.name;

#各ピザに含まれているトッピングの数を選択
SELECT p.name, COUNT(t.name) AS "トッピング数" FROM pizzas p LEFT JOIN pizzas_toppings pt ON p.id = pt.pizza_id LEFT JOIN toppings t ON t.id = pt.toppings_id GROUP BY p.name;

#"pizzas"テーブルから価格が¥100以上のピザを選択
SELECT name FROM pizzas WHERE price >= 100;

#"pizzas"テーブルから価格が1500以下のピザとトッピング名を選択
SELECT p.name, t.name FROM pizzas p LEFT JOIN pizzas_toppings pt ON p.id = pt.pizza_id LEFT JOIN toppings t ON t.id = pt.toppings_id WHERE p.price < 1500;

#"pizzas_toppings"からトッピングidが11であるピザを選択
SELECT * FROM pizzas p WHERE p.id IN (SELECT pizza_id FROM pizzas_toppings WHERE toppings_id = 11);

#"pizzas"テーブルから価格が最大のピザを選択
SELECT * FROM pizzas ORDER BY price DESC LIMIT 1;

#"pizzas"テーブルから価格が最小のピザとトッピング名を選択
SELECT p.*, t.name FROM pizzas p LEFT JOIN pizzas_toppings pt ON p.id = pt.pizza_id LEFT JOIN toppings t ON t.id = pt.toppings_id ORDER BY p.price LIMIT 1;

#"pizzas"テーブルと"pizzas_toppings"テーブルを結合し、各ピザに含まれているトッピングを全て選択
SELECT p.name, t.name FROM pizzas p LEFT JOIN pizzas_toppings pt ON p.id = pt.pizza_id LEFT JOIN toppings t ON t.id = pt.toppings_id;