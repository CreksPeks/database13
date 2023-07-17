DROP DATABASE IF EXISTS vk;
CREATE DATABASE IF NOT EXISTS vk;
USE vk;
CREATE TABLE IF NOT EXISTS users (
	id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(30),
    password_hash VARCHAR(300),
    last_seen DATETIME
);
CREATE TABLE IF NOT EXISTS chats (
	id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(50),
    description VARCHAR(200),
    owner_id INT,
    FOREIGN KEY(owner_id) REFERENCES users(id)
);
CREATE TABLE IF NOT EXISTS users_to_chats (
	user_id INT,
    chat_id INT,
    PRIMARY KEY(user_id, chat_id),
    enter_datetime DATETIME,
    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(chat_id) REFERENCES chats(id)
);
INSERT INTO users(username) VALUE
	('user 1'),
	('user 2'),
	('user 3');
INSERT INTO chats(title, description, owner_id) VALUE
	('chat 1', 'for car lovers', 1),
    ('chat 2', 'anime is the best kino', 2),
    ('chat 3', '', 3);
INSERT INTO users_to_chats VALUE
	(1, 1, '2022-01-01 00:00:15'),
    (1, 2, '2022-01-01 00:03:07'),
    (1, 3, '2022-01-05 10:03:47'),
    (2, 1, '2022-01-01 00:00:15'),
    (2, 3, '2022-01-03 17:56:37'),
    (3, 1, '2022-01-06 18:19:43'),
    (3, 2, '2022-01-05 12:19:57');

-- HOMEWORK
-- 1

-- select * from users;
-- select * from chats;
-- select * from users_to_chats;

select 
	c.title, 
	c.description 
from 
	users as u, 
	chats as c, 
    users_to_chats as uts
where 
	u.username = 'user 1' and 
	uts.user_id = u.id and 
	uts.chat_id = c.id
order by description desc;

select chats.title, chats.description from users, chats, users_to_chats
where users.username = 'user 2' and 
	users_to_chats.user_id = users.id and 
	users_to_chats.chat_id = chats.id
order by description desc;

select chats.title, chats.description from users, chats, users_to_chats
where users.username = 'user 3' and 
	users_to_chats.user_id = users.id and 
	users_to_chats.chat_id = chats.id
order by description desc;

-- 2

select chats.description, users_to_chats.enter_datetime from users, chats, users_to_chats
where users.username = 'user 1' and 
	users_to_chats.user_id = users.id and 
	users_to_chats.chat_id = chats.id
order by enter_datetime;

select chats.description, users_to_chats.enter_datetime from users, chats, users_to_chats
where users.username = 'user 2' and 
	users_to_chats.user_id = users.id and 
	users_to_chats.chat_id = chats.id
order by enter_datetime;

select chats.description, users_to_chats.enter_datetime from users, chats, users_to_chats
where users.username = 'user 3' and 
	users_to_chats.user_id = users.id and 
	users_to_chats.chat_id = chats.id
order by enter_datetime;

-- 3

select chats.title, users_to_chats.enter_datetime from users, chats, users_to_chats
where chats.title = 'chat 1' and 
	chats.owner_id = users_to_chats.chat_id
order by enter_datetime
limit 1;

select chats.title, users_to_chats.enter_datetime from users, chats, users_to_chats
where chats.title = 'chat 2' and 
	chats.owner_id = users_to_chats.chat_id
order by enter_datetime
limit 1;

select chats.title, users_to_chats.enter_datetime from users, chats, users_to_chats
where chats.title = 'chat 3' and 
	chats.owner_id = users_to_chats.chat_id
order by enter_datetime
limit 1;