-- drop table if exists users;
-- drop table televisions;
-- drop table remotecontrollers;
 drop table if exists products cascade;

create table if not exists users (
	id serial primary key,
	username varchar(255),
	password varchar(255),
	adress varchar(255),
	functie varchar(255),
	loonschaal integer,
	vakantiedagen integer
);

create table if not exists products(
	id serial unique primary key,
	name varchar(255),
	brand varchar(255),
	price decimal,
	currentstock integer,
	sold integer,
	datesold date,
	type varchar(255)
);

create table if not exists cimodules(
	id serial unique primary key,
	provider varchar(255),
	encoding varchar(255)
) inherits (products);

create table if not exists televisions(
	id serial unique primary key,
	height decimal,
	width decimal,
	screenquality varchar(255),
	screentype varchar(255),
	wifi boolean,
	smarttv boolean,
	voicecontrol boolean,
	hdr boolean,
	module_id integer,
	foreign key(module_id) references cimodules(id)
) inherits (products);

create table if not exists remotecontrollers(
	id serial unique primary key,
	smart boolean,
	batterytype varchar(255),
	television_id integer unique,
	foreign key (television_id) references televisions(id)
) inherits (products);

create table if not exists wallbrackets(
	id serial unique primary key,
	adjustable boolean,
	attachmentmethod varchar(255),
	height decimal,
	width decimal
) inherits (products);

create table if not exists televisionbrackets(
	id serial unique primary key,
	television_id integer,
	foreign key (television_id) references televisions(id),
	wallbracket_id integer,
	foreign key (wallbracket_id) references wallbrackets(id)
);

insert into cimodules (name, brand, price, currentstock, sold, datesold, type, provider, encoding)
values 
	('samsung ci module', 'samsung', 100, 10, 4, '2024-11-16', 'cimodule', 'samsungprovider', 'examplee1'), 
	('sony ci module', 'sony', 10, 1000, 470, '2024-12-16', 'cimodule', 'sonyprovider', 'examplee1'),
	('acer 1001xs', 'acer', 535, 1, 1, '2025-1-23', 'cimodule', 'acer', 'acesuperencoder9000');


insert into televisions (name, brand, price, currentstock, sold, datesold, type, height, width, screenquality, screentype, wifi, smarttv, voicecontrol, hdr, module_id)
values 
	('samsung gtx3334', 'samsung', 500, 8, 7, '2025-1-4', 'television', 100, 100, '1324pxHD', 'color', true, true, false, true, 1),
	('acer tv9032', 'acer', 121, 313, 300, '2025-1-1', 'television', 1000, 1000, '9999HD', 'color', true, true, true, true, 3),
	('sony tvmk1', 'sony', 1, 10000, 9999, '2025-1-23', 'television', 50, 50, '1pxhd', 'blackwhite', false, false, false, false, 2),
	('samsung fsfs33342', 'samsung', 212, 33, 1, '2024-11-22', 'television', 500, 600, '1313hd', 'color', true, false, false, true, 1);

insert into remotecontrollers (name, brand, price, currentstock, sold, datesold, type, smart, batterytype, television_id)
values
	('samsung remote controller', 'samsung', 123, 90, 30, '2025-1-20', 'remotecontroller', false, 'AA', 1),
	('acer super controller', 'acer', 59, 20, 10, '1500-2-1', 'remotecontroller', true, 'AAA', 2);

insert into wallbrackets (name, brand, price, currentstock, sold, datesold, type, adjustable, attachmentmethod, height, width)
values
	('samsung wallbracket1', 'samsung', 99, 10, 1, '2024-11-29', 'wallbracket', true, 'clip', 60, 60 ),
	('samsung wallbracket2', 'samsung', 24, 50, 20, '2025-1-22', 'wallbracket', false, 'clip', 50, 50),
	('acer bracket', 'acer', 99, 60, 20, '2025-5-12', 'wallbracket', true, 'screws', 100, 100);

insert into televisionbrackets (television_id, wallbracket_id)
values
	(1, 1),
	(1, 2),
	(4, 1),
	(4, 2),
	(2, 3);

-- get all users
select * from users;

-- get all products (do not access the primary key in this table, because each id is not unique due to the each inherited table having their own count)
select * from products;

--  get all televisions
select * from televisions;

-- get all cimodules
select * from cimodules;

-- get all remotecontrollers
select * from remotecontrollers;

-- get all wallbrackets
select * from wallbrackets;

-- get all linked wallbrackets and televisions
select * from televisionbrackets;

-- get all linked wallbrackets and television expanded
select t.type, t.name, t.brand, 'can use', wb.type, wb.name, wb.brand
from televisionbrackets as tb
inner join televisions as t on tb.television_id = t.id
inner join wallbrackets as wb on tb.wallbracket_id = wb.id;

-- get televisions with usable remote controllers
select t.type, t.name, t.brand, 'can use', rc.type, rc.name, rc.brand
from remotecontrollers as rc
inner join televisions as t on rc.television_id = t.id;

-- get televisions with usable cimodules
select t.type, t.name, t.brand, 'can use', cm.type, cm.name, cm.brand
from televisions as t
inner join cimodules as cm on t.module_id = cm.id;


 

