create table if not exists `post` (
  `id` int(10) unsigned not null auto_increment,
  `slug` varchar(100) not null,
  `publish_date` date default null,
  `summary` varchar(250) not null,
  `content` text not null,
  `title` varchar(100) not null,
  `is_draft` boolean null,
  `author_id` int(10) unsigned not null,
  PRIMARY KEY (`id`)
);

create table if not exists `tag` (
	`id` int(10) unsigned not null auto_increment,
	`name` varchar(25) not null,
	`game_name` varchar(50) not null,
	PRIMARY KEY (`id`)
);

create table if not exists `post_tag` (
	`id` int(10) unsigned not null auto_increment,
	`post_id` int(10) unsigned not null,
	`tag_id` int(10) unsigned not null,
	PRIMARY KEY (`id`)
);

create table `score` (
  `id` int(10) unsigned not null auto_increment,
  `player_name` varchar(20) default null,
  `score` int(10) unsigned default null,
  `leaderboard_name` varchar(100) default null,
  PRIMARY KEY (`id`)
);


create table if not exists `user_account` (
  `id` int(10) unsigned not null auto_increment,
  `name` varchar(20) not null,
  `password_hash` char(100) not null,
  `catch_phrase` varchar(100) not null,
  PRIMARY KEY (`id`)
);

insert into user_account (name, password_hash, `catch_phrase`)
values ('Baer', 'pbkdf2:sha1:1000$zY3PR51v$17c6ff01a34f9560fb3d63d694755bae8b311942', 'Director of Snacks');

insert into user_account (name, password_hash, `catch_phrase`)
values ('Matt', 'pbkdf2:sha1:1000$zY3PR51v$17c6ff01a34f9560fb3d63d694755bae8b311942', 'Hey guys, this is Matt!');

insert into user_account (name, password_hash, `catch_phrase`)
values ('TJ', 'pbkdf2:sha1:1000$zY3PR51v$17c6ff01a34f9560fb3d63d694755bae8b311942', 'Distinguished Vice President of Network Architecture and Master Google Engineer');