--Philip Ward Run

--Schema

create table Customer
(c_custkey INTEGER NOT NULL PRIMARY KEY,
c_name VARCHAR(35),
c_address VARCHAR(50),
c_phone VARCHAR(12),
c_acctbal DECIMAL(15,2),
c_mktsegment VARCHAR(15) 
CONSTRAINT segmentCheck CHECK (c_mktsegment in ('AUTOMOBILE', 'BUILDING', 'HOUSEHOLD', 'MACHINERY', 'FURNITURE'))
);

create table Part
(p_partkey INTEGER NOT NULL PRIMARY KEY,
p_name VARCHAR(25),
p_mfr VARCHAR(25),
p_brand VARCHAR(25),
p_size INTEGER,
p_retailprice DECIMAL(15,2)
);

create table Supplier
(s_suppkey INTEGER NOT NULL PRIMARY KEY,
s_name VARCHAR(25),
s_address VARCHAR(50),
s_phone VARCHAR(12),
s_acctbal DECIMAL(15,2)
);

create table Orders
(o_orderkey INTEGER NOT NULL PRIMARY KEY,
o_custkey INTEGER NOT NULL REFERENCES Customer(c_custkey),
o_orderstatus VARCHAR(1),
o_totalprice DECIMAL(15,2),
o_orderdate VARCHAR(10),
o_orderpriority VARCHAR(15),
CONSTRAINT statusCheck CHECK (o_orderstatus in ('O', 'F', 'P')),
CONSTRAINT priorityCheck CHECK (o_orderpriority in ('1-URGENT', '2-HIGH', '3-MEDIUM', '4-NOT SPECIFIED', '5-LOW'))
);

create table Lineitem
(l_orderkey INTEGER NOT NULL REFERENCES Orders(o_orderkey),
l_linenumber INTEGER NOT NULL,
l_partkey INTEGER NOT NULL REFERENCES Part(p_partkey),
l_suppkey INTEGER NOT NULL REFERENCES Supplier(s_suppkey),
l_quantity INTEGER,
l_shipinstruct VARCHAR(30),
l_shipmode VARCHAR(7),
CONSTRAINT l_pk PRIMARY KEY(l_orderkey, l_linenumber),
CONSTRAINT instructCheck CHECK(l_shipinstruct IN ('NONE', 'TAKE BACK RETURN', 'COLLECT COD', 'DELIVER IN PERSON')),
CONSTRAINT modeCheck CHECK(l_shipmode IN('AIR', 'FOB', 'MAIL', 'RAIL', 'REG AIR', 'SHIP', 'TRUCK'))
);

create table Partsupp
(ps_partkey INTEGER NOT NULL REFERENCES Part(p_partkey),
ps_suppkey INTEGER NOT NULL REFERENCES Supplier(s_suppkey),
ps_availqty INTEGER,
ps_supplycost DECIMAL(15,2),
CONSTRAINT ps_pk PRIMARY KEY(ps_partkey, ps_suppkey)
);

--Insert

insert into Customer values(1, 'Customer#01','1 Address','989-741-2988',711.56,'BUILDING');
insert into Customer values(2,'Customer#02','2 Address','768-687-3665',121.65,'AUTOMOBILE');
insert into Customer values(3,'Customer#03','3 Address','719-748-3364',7498.12,'AUTOMOBILE');
insert into Customer values(4,'Customer#04','4 Address','128-190-5944',2866.83,'MACHINERY');
insert into Customer values(5,'Customer#05','5 Address','750-942-6364',794.47,'HOUSEHOLD');
insert into Customer values(6,'Customer#06','6 Address','114-968-4951',7638.57,'AUTOMOBILE');
insert into Customer values(7,'Customer#07','7 Address','190-982-9759',9561.95,'AUTOMOBILE');
insert into Customer values(8,'Customer#08','8 Address','147-574-9335',6819.74,'BUILDING');
insert into Customer values(9,'Customer#09','9 Address','338-906-3675',8324.07,'FURNITURE');
insert into Customer values(10,'Customer#10','10 Address','741-346-9870',2753.54,'HOUSEHOLD');


insert into Orders values(227,10,'O',46076.5,'1995-11-10','5-LOW');
insert into Orders values(320,1,'O',39835.5,'1997-11-21','2-HIGH');
insert into Orders values(902,10,'F',37348.6,'1994-07-27','4-NOT SPECIFIED');
insert into Orders values(1217,7,'F',40982.1,'1992-04-26','4-NOT SPECIFIED');
insert into Orders values(1222,10,'F',47623.9,'1993-02-05','3-MEDIUM');
insert into Orders values(1223,10,'O',26714.7,'1996-05-25','4-NOT SPECIFIED');
insert into Orders values(1602,1,'F',4225.26,'1993-08-05','5-LOW');
insert into Orders values(1603,2,'F',29305.5,'1993-07-31','4-NOT SPECIFIED');
insert into Orders values(1639,5,'O',104167,'1995-08-20','4-NOT SPECIFIED');
insert into Orders values(1669,2,'O',24362.4,'1997-06-09','3-MEDIUM');
insert into Orders values(1734,7,'F',44002.5,'1994-06-11','2-HIGH');
insert into Orders values(1860,10,'O',9103.4,'1996-04-04','3-MEDIUM');
insert into Orders values(1895,7,'F',44429.8,'1994-05-30','3-MEDIUM');
insert into Orders values(2016,8,'O',24347.4,'1996-08-16','3-MEDIUM');
insert into Orders values(2726,7,'F',47753,'1992-11-27','5-LOW');
insert into Orders values(2916,8,'O',20182.2,'1995-12-27','2-HIGH');
insert into Orders values(3142,8,'F',16030.2,'1992-06-28','3-MEDIUM');
insert into Orders values(3204,10,'F',41573.4,'1992-12-26','1-URGENT');
insert into Orders values(3266,4,'P',68309.3,'1995-03-17','5-LOW');
insert into Orders values(3329,4,'O',46107.7,'1995-07-03','2-HIGH');
insert into Orders values(3330,7,'F',43255.2,'1994-12-19','1-URGENT');
insert into Orders values(3428,10,'O',88047,'1996-04-07','5-LOW');
insert into Orders values(3843,10,'O',34035.2,'1997-01-04','4-NOT SPECIFIED');
insert into Orders values(3911,10,'P',35019.9,'1995-03-17','4-NOT SPECIFIED');
insert into Orders values(4097,10,'O',134308,'1996-05-24','1-URGENT');
insert into Orders values(4100,4,'O',3892.77,'1996-03-12','3-MEDIUM');
insert into Orders values(4165,4,'O',11405.4,'1997-07-25','3-MEDIUM');
insert into Orders values(4199,5,'F',30494.6,'1992-02-13','1-URGENT');
insert into Orders values(4388,10,'O',69668.2,'1996-03-28','2-HIGH');
insert into Orders values(4449,10,'O',48206.1,'1998-02-08','5-LOW');
insert into Orders values(4451,4,'F',92851.8,'1994-10-01','1-URGENT');
insert into Orders values(4704,2,'O',63873.1,'1996-08-16','4-NOT SPECIFIED');
insert into Orders values(4806,7,'F',35390.1,'1993-04-21','5-LOW');
insert into Orders values(4867,10,'F',9741.03,'1992-05-21','1-URGENT');
insert into Orders values(4928,4,'F',59931.4,'1993-10-04','4-NOT SPECIFIED');
insert into Orders values(5123,10,'O',11850.5,'1998-02-10','1-URGENT');
insert into Orders values(5154,8,'O',28070.9,'1997-04-13','3-MEDIUM');
insert into Orders values(5220,10,'F',24844.4,'1992-07-30','2-HIGH');
insert into Orders values(5446,7,'F',29920.8,'1994-06-21','5-LOW');
insert into Orders values(5893,2,'F',44777.6,'1992-07-08','4-NOT SPECIFIED');

insert into Part values(1,'Part#1','Manufacturer#1','Brand#13',7,901);
insert into Part values(2,'Part#2','Manufacturer#1','Brand#13',1,902);
insert into Part values(5,'Part#5','Manufacturer#3','Brand#32',15,905);
insert into Part values(6,'Part#6','Manufacturer#2','Brand#24',4,906);
insert into Part values(7,'Part#7','Manufacturer#1','Brand#11',45,907);
insert into Part values(8,'Part#8','Manufacturer#4','Brand#44',41,908);
insert into Part values(9,'Part#9','Manufacturer#4','Brand#43',12,909);
insert into Part values(12,'Part#12','Manufacturer#3','Brand#33',25,912.01);
insert into Part values(15,'Part#15','Manufacturer#1','Brand#15',45,915.01);
insert into Part values(16,'Part#16','Manufacturer#3','Brand#32',2,916.01);
insert into Part values(20,'Part#20','Manufacturer#1','Brand#12',48,920.02);
insert into Part values(26,'Part#26','Manufacturer#3','Brand#32',32,926.02);
insert into Part values(28,'Part#28','Manufacturer#4','Brand#44',19,928.02);
insert into Part values(29,'Part#29','Manufacturer#3','Brand#33',7,929.02);
insert into Part values(32,'Part#32','Manufacturer#4','Brand#42',31,932.03);
insert into Part values(38,'Part#38','Manufacturer#4','Brand#43',11,938.03);
insert into Part values(39,'Part#39','Manufacturer#5','Brand#53',43,939.03);
insert into Part values(41,'Part#41','Manufacturer#2','Brand#23',7,941.04);
insert into Part values(43,'Part#43','Manufacturer#4','Brand#44',5,943.04);
insert into Part values(52,'Part#52','Manufacturer#3','Brand#35',25,952.05);
insert into Part values(60,'Part#60','Manufacturer#1','Brand#11',27,960.06);
insert into Part values(63,'Part#63','Manufacturer#3','Brand#32',10,963.06);
insert into Part values(64,'Part#64','Manufacturer#2','Brand#21',1,964.06);
insert into Part values(65,'Part#65','Manufacturer#5','Brand#53',3,965.06);
insert into Part values(66,'Part#66','Manufacturer#3','Brand#35',46,966.06);
insert into Part values(70,'Part#70','Manufacturer#1','Brand#11',42,970.07);
insert into Part values(72,'Part#72','Manufacturer#2','Brand#23',25,972.07);
insert into Part values(74,'Part#74','Manufacturer#5','Brand#55',25,974.07);
insert into Part values(78,'Part#78','Manufacturer#1','Brand#14',24,978.07);
insert into Part values(79,'Part#79','Manufacturer#4','Brand#45',22,979.07);
insert into Part values(82,'Part#82','Manufacturer#1','Brand#15',12,982.08);
insert into Part values(83,'Part#83','Manufacturer#1','Brand#12',47,983.08);
insert into Part values(84,'Part#84','Manufacturer#4','Brand#45',26,984.08);
insert into Part values(92,'Part#92','Manufacturer#2','Brand#22',35,992.09);
insert into Part values(93,'Part#93','Manufacturer#2','Brand#24',2,993.09);
insert into Part values(100,'Part#100','Manufacturer#3','Brand#33',4,1000.1);
insert into Part values(111,'Part#111','Manufacturer#5','Brand#54',28,1011.11);
insert into Part values(113,'Part#113','Manufacturer#3','Brand#31',23,1013.11);
insert into Part values(118,'Part#118','Manufacturer#2','Brand#25',31,1018.11);
insert into Part values(119,'Part#119','Manufacturer#4','Brand#43',30,1019.11);
insert into Part values(120,'Part#120','Manufacturer#1','Brand#14',45,1020.12);
insert into Part values(122,'Part#122','Manufacturer#2','Brand#21',8,1022.12);
insert into Part values(123,'Part#123','Manufacturer#1','Brand#12',31,1023.12);
insert into Part values(134,'Part#134','Manufacturer#4','Brand#42',35,1034.13);
insert into Part values(136,'Part#136','Manufacturer#2','Brand#22',2,1036.13);
insert into Part values(138,'Part#138','Manufacturer#1','Brand#13',42,1038.13);
insert into Part values(141,'Part#141','Manufacturer#3','Brand#35',23,1041.14);
insert into Part values(144,'Part#144','Manufacturer#1','Brand#14',26,1044.14);
insert into Part values(147,'Part#147','Manufacturer#1','Brand#11',29,1047.14);
insert into Part values(149,'Part#149','Manufacturer#2','Brand#24',6,1049.14);
insert into Part values(151,'Part#151','Manufacturer#3','Brand#34',45,1051.15);
insert into Part values(154,'Part#154','Manufacturer#1','Brand#11',1,1054.15);
insert into Part values(155,'Part#155','Manufacturer#2','Brand#21',28,1055.15);
insert into Part values(159,'Part#159','Manufacturer#4','Brand#43',46,1059.15);
insert into Part values(160,'Part#160','Manufacturer#5','Brand#55',47,1060.16);
insert into Part values(161,'Part#161','Manufacturer#2','Brand#22',17,1061.16);
insert into Part values(164,'Part#164','Manufacturer#2','Brand#23',35,1064.16);
insert into Part values(165,'Part#165','Manufacturer#1','Brand#15',24,1065.16);
insert into Part values(166,'Part#166','Manufacturer#5','Brand#52',4,1066.16);
insert into Part values(171,'Part#171','Manufacturer#1','Brand#11',40,1071.17);
insert into Part values(174,'Part#174','Manufacturer#1','Brand#15',25,1074.17);
insert into Part values(175,'Part#175','Manufacturer#1','Brand#11',45,1075.17);
insert into Part values(183,'Part#183','Manufacturer#5','Brand#52',35,1083.18);
insert into Part values(187,'Part#187','Manufacturer#4','Brand#45',45,1087.18);
insert into Part values(190,'Part#190','Manufacturer#5','Brand#53',23,1090.19);
insert into Part values(193,'Part#193','Manufacturer#4','Brand#45',31,1093.19);
insert into Part values(198,'Part#198','Manufacturer#4','Brand#41',43,1098.19);
insert into Part values(200,'Part#200','Manufacturer#5','Brand#54',22,1100.2);


insert into Supplier values(1,'Supplier#1','Address 1','918-335-1736',5755.94);
insert into Supplier values(2,'Supplier#2','Address 2','679-861-2259',4032.68);
insert into Supplier values(3,'Supplier#3','Address 3','383-516-1199',4192.4);
insert into Supplier values(4,'Supplier#4','Address 4','843-787-7479',4641.08);
insert into Supplier values(5,'Supplier#5','Address 5','151-690-3663',-283.84);
insert into Supplier values(6,'Supplier#6','Address 6','696-997-4969',1365.79);
insert into Supplier values(7,'Supplier#7','Address 7','990-965-2201',6820.35);
insert into Supplier values(8,'Supplier#8','Address 8','498-742-3860',7627.85);
insert into Supplier values(9,'Supplier#9','Address 9','403-398-8662',5302.37);
insert into Supplier values(10,'Supplier#10','Address 10','852-489-8585',3891.91);
insert into Supplier values(11,'Supplier#11','Address 11','602-543-5611',516.11);
insert into Supplier values(12,'Supplier#12','Address 12','623-123-1212',1212.12);

insert into Partsupp values(1,8,8076,993.49);
insert into Partsupp values(1,9,3956,337.09);
insert into Partsupp values(2,9,3025,306.39);
insert into Partsupp values(5,10,6925,537.98);
insert into Partsupp values(6,10,6451,175.32);
insert into Partsupp values(7,2,2770,149.66);
insert into Partsupp values(8,3,396,957.34);
insert into Partsupp values(9,1,7054,84.2);
insert into Partsupp values(12,9,5454,901.7);
insert into Partsupp values(15,1,7047,835.7);
insert into Partsupp values(16,1,5282,709.16);
insert into Partsupp values(20,4,5905,546.66);
insert into Partsupp values(26,3,5020,683.96);
insert into Partsupp values(28,7,2452,744.57);
insert into Partsupp values(29,4,8106,981.33);
insert into Partsupp values(32,9,7975,747.14);
insert into Partsupp values(38,4,4237,662.75);
insert into Partsupp values(39,7,6259,737.86);
insert into Partsupp values(41,4,9040,488.55);
insert into Partsupp values(43,7,9506,493.65);
insert into Partsupp values(52,10,5524,424.93);
insert into Partsupp values(60,8,148,504.1);
insert into Partsupp values(63,1,1804,498.84);
insert into Partsupp values(63,5,6325,463.69);
insert into Partsupp values(64,2,5567,228.61);
insert into Partsupp values(64,6,9110,602.65);
insert into Partsupp values(65,10,2188,288.73);
insert into Partsupp values(66,6,1076,785.75);
insert into Partsupp values(70,9,9074,182.58);
insert into Partsupp values(72,10,4526,154.47);
insert into Partsupp values(74,2,3128,345.92);
insert into Partsupp values(74,3,2479,930.97);
insert into Partsupp values(78,9,9599,382.82);
insert into Partsupp values(79,2,4248,765.34);
insert into Partsupp values(82,1,7793,697.31);
insert into Partsupp values(83,5,8200,399.64);
insert into Partsupp values(83,7,5974,657.22);
insert into Partsupp values(84,3,2909,969.44);
insert into Partsupp values(92,6,3199,91.63);
insert into Partsupp values(93,1,3008,615.98);
insert into Partsupp values(100,1,7885,490.61);
insert into Partsupp values(111,2,1890,321.97);
insert into Partsupp values(113,2,9981,396.26);
insert into Partsupp values(113,3,3804,860.68);
insert into Partsupp values(118,1,694,744.73);
insert into Partsupp values(118,3,6326,325.61);
insert into Partsupp values(119,9,583,782.47);
insert into Partsupp values(120,3,5329,249.61);
insert into Partsupp values(122,2,2490,637.28);
insert into Partsupp values(123,2,9881,107.03);
insert into Partsupp values(134,10,6270,388.28);
insert into Partsupp values(136,1,2237,548.19);
insert into Partsupp values(138,3,2535,885.35);
insert into Partsupp values(141,2,1660,139.18);
insert into Partsupp values(144,3,6295,457.37);
insert into Partsupp values(147,4,7647,102.19);
insert into Partsupp values(149,7,4104,312.37);
insert into Partsupp values(155,3,7077,413.24);
insert into Partsupp values(159,2,9200,356.66);
insert into Partsupp values(159,3,3585,629.29);
insert into Partsupp values(160,4,8324,999.93);
insert into Partsupp values(161,8,679,893.72);
insert into Partsupp values(164,4,1295,341.95);
insert into Partsupp values(165,6,3780,730.28);
insert into Partsupp values(166,10,6713,631.58);
insert into Partsupp values(171,3,8561,22.69);
insert into Partsupp values(174,8,8404,126.2);
insert into Partsupp values(175,8,9456,978.56);
insert into Partsupp values(183,2,30,875.44);
insert into Partsupp values(187,4,8656,238.66);
insert into Partsupp values(190,2,5845,608.91);
insert into Partsupp values(190,5,4579,396.6);
insert into Partsupp values(193,4,4762,606.19);
insert into Partsupp values(198,3,6878,587.41);


insert into Lineitem values(227,1,166,10,19,'NONE','RAIL');
insert into Lineitem values(227,2,175,8,24,'COLLECT COD','SHIP');
insert into Lineitem values(320,1,5,10,30,'NONE','RAIL');
insert into Lineitem values(320,2,193,4,13,'TAKE BACK RETURN','AIR');
insert into Lineitem values(902,1,111,2,3,'COLLECT COD','MAIL');
insert into Lineitem values(902,2,118,3,8,'COLLECT COD','RAIL');
insert into Lineitem values(902,3,165,6,24,'NONE','FOB');
insert into Lineitem values(1217,1,60,8,45,'COLLECT COD','AIR');
insert into Lineitem values(1222,1,72,10,12,'TAKE BACK RETURN','RAIL');
insert into Lineitem values(1222,2,159,3,12,'TAKE BACK RETURN','REG AIR');
insert into Lineitem values(1222,3,8,3,26,'TAKE BACK RETURN','MAIL');
insert into Lineitem values(1223,1,100,1,28,'TAKE BACK RETURN','MAIL');
insert into Lineitem values(1602,1,183,2,4,'NONE','RAIL');
insert into Lineitem values(1603,1,39,7,1,'TAKE BACK RETURN','REG AIR');
insert into Lineitem values(1603,2,66,6,29,'NONE','SHIP');
insert into Lineitem values(1639,1,187,4,24,'COLLECT COD','REG AIR');
insert into Lineitem values(1639,2,43,7,38,'TAKE BACK RETURN','FOB');
insert into Lineitem values(1639,3,171,3,41,'DELIVER IN PERSON','FOB');
insert into Lineitem values(1669,1,79,2,24,'DELIVER IN PERSON','RAIL');
insert into Lineitem values(1734,1,155,3,38,'COLLECT COD','FOB');
insert into Lineitem values(1734,2,118,3,4,'DELIVER IN PERSON','AIR');
insert into Lineitem values(1860,1,113,2,9,'DELIVER IN PERSON','TRUCK');
insert into Lineitem values(1895,1,161,8,43,'NONE','AIR');
insert into Lineitem values(2016,1,147,4,2,'DELIVER IN PERSON','TRUCK');
insert into Lineitem values(2016,2,63,5,15,'TAKE BACK RETURN','MAIL');
insert into Lineitem values(2016,3,122,2,8,'TAKE BACK RETURN','SHIP');
insert into Lineitem values(2726,1,1,9,50,'COLLECT COD','TRUCK');
insert into Lineitem values(2916,1,83,5,21,'NONE','REG AIR');
insert into Lineitem values(3142,1,120,3,15,'DELIVER IN PERSON','AIR');
insert into Lineitem values(3204,1,12,9,10,'COLLECT COD','SHIP');
insert into Lineitem values(3204,2,7,2,39,'TAKE BACK RETURN','MAIL');
insert into Lineitem values(3266,1,64,6,31,'COLLECT COD','MAIL');
insert into Lineitem values(3266,2,38,4,43,'COLLECT COD','AIR');
insert into Lineitem values(3329,1,138,3,36,'DELIVER IN PERSON','TRUCK');
insert into Lineitem values(3329,2,6,10,9,'COLLECT COD','MAIL');
insert into Lineitem values(3329,3,123,2,1,'COLLECT COD','REG AIR');
insert into Lineitem values(3330,1,20,4,49,'DELIVER IN PERSON','TRUCK');
insert into Lineitem values(3428,1,198,3,4,'NONE','REG AIR');
insert into Lineitem values(3428,2,118,1,35,'COLLECT COD','TRUCK');
insert into Lineitem values(3428,3,136,1,47,'NONE','REG AIR');
insert into Lineitem values(3843,1,15,1,7,'TAKE BACK RETURN','SHIP');
insert into Lineitem values(3843,2,1,8,30,'DELIVER IN PERSON','AIR');
insert into Lineitem values(3911,1,113,3,10,'COLLECT COD','FOB');
insert into Lineitem values(3911,2,119,9,14,'NONE','RAIL');
insert into Lineitem values(3911,3,92,6,12,'COLLECT COD','FOB');
insert into Lineitem values(4097,1,74,2,50,'DELIVER IN PERSON','MAIL');
insert into Lineitem values(4097,2,74,3,46,'COLLECT COD','AIR');
insert into Lineitem values(4097,3,174,8,42,'NONE','FOB');
insert into Lineitem values(4100,1,74,2,4,'TAKE BACK RETURN','FOB');
insert into Lineitem values(4165,1,41,4,12,'TAKE BACK RETURN','REG AIR');
insert into Lineitem values(4199,1,70,9,16,'COLLECT COD','TRUCK');
insert into Lineitem values(4199,2,9,1,18,'DELIVER IN PERSON','RAIL');
insert into Lineitem values(4388,1,65,10,30,'DELIVER IN PERSON','FOB');
insert into Lineitem values(4388,2,84,3,28,'TAKE BACK RETURN','RAIL');
insert into Lineitem values(4388,3,52,10,13,'DELIVER IN PERSON','REG AIR');
insert into Lineitem values(4449,1,32,9,42,'NONE','FOB');
insert into Lineitem values(4449,2,141,2,10,'NONE','SHIP');
insert into Lineitem values(4451,1,164,4,40,'DELIVER IN PERSON','RAIL');
insert into Lineitem values(4451,2,63,1,34,'COLLECT COD','SHIP');
insert into Lineitem values(4451,3,159,2,19,'COLLECT COD','FOB');
insert into Lineitem values(4704,1,78,9,14,'DELIVER IN PERSON','TRUCK');
insert into Lineitem values(4704,2,28,7,7,'DELIVER IN PERSON','SHIP');
insert into Lineitem values(4704,3,64,2,44,'DELIVER IN PERSON','REG AIR');
insert into Lineitem values(4806,1,16,1,26,'DELIVER IN PERSON','SHIP');
insert into Lineitem values(4806,2,72,10,6,'TAKE BACK RETURN','SHIP');
insert into Lineitem values(4806,3,29,4,8,'NONE','TRUCK');
insert into Lineitem values(4867,1,82,1,7,'COLLECT COD','FOB');
insert into Lineitem values(4867,2,160,4,3,'NONE','AIR');
insert into Lineitem values(4928,1,100,1,4,'TAKE BACK RETURN','REG AIR');
insert into Lineitem values(4928,2,93,1,20,'DELIVER IN PERSON','SHIP');
insert into Lineitem values(4928,3,149,7,34,'DELIVER IN PERSON','AIR');
insert into Lineitem values(5123,1,26,3,13,'COLLECT COD','MAIL');
insert into Lineitem values(5154,1,190,2,11,'NONE','RAIL');
insert into Lineitem values(5154,2,144,3,15,'NONE','AIR');
insert into Lineitem values(5220,1,83,7,27,'DELIVER IN PERSON','RAIL');
insert into Lineitem values(5446,1,190,5,27,'TAKE BACK RETURN','RAIL');
insert into Lineitem values(5893,1,134,10,43,'TAKE BACK RETURN','RAIL');
insert into Lineitem values(5893,2,2,9,2,'NONE','RAIL');


commit;


--Queries

create view customersWithOrder as
select c.c_custkey, C.c_name, C.c_phone, C.c_acctbal, C.c_mktsegment
from Customer C, Orders O
where o.o_custkey=c.c_custkey
group by C.c_custkey, C.c_name, C.c_phone, C.c_acctbal, C.c_mktsegment;

create view customerWithUrgentOrder as
select C.c_custkey
from Customer C, Orders O
where C.c_custkey = O.o_custkey and o.o_orderpriority = '1-URGENT'
group by C.c_custkey;

create view customersWithoutUrgentOrder as
select C.c_name as customerName, C.c_phone as phone, C.c_acctbal as accountBalance, C.c_mktsegment as marketSegment
from customersWithOrder C
where not exists(select *
  from customerWithUrgentOrder U
  where U.C_CUSTKEY = C.c_custkey)
  order by C.c_name;

create view OrdersWithOneLineItem as
select O.o_orderkey as orderKey, O.o_custkey as customerKey, O.o_orderdate as orderDate, O.o_totalprice as orderTotal
from lineItem L, orders O
where O.o_orderkey = L.l_orderkey
group by O.o_orderkey, O.o_custkey, O.o_orderdate, O.o_totalprice
having count(L.l_linenumber)=1
order by O.o_orderdate;

create view supplierSupplyCostGreater800 as
select S.s_name as supplierName, PS.ps_partkey as partkey, PS.ps_supplycost as supplyCost
from Partsupp PS, supplier S
where PS.ps_suppkey = S.s_suppkey
group by S.s_name, PS.ps_partkey, PS.ps_supplycost
having PS.ps_supplycost > 800
order by PS.ps_supplycost DESC;

create view supplierSupplyCostGreater900 as
select S.s_name as supplierName, PS.ps_partkey as partkey, PS.ps_supplycost as supplyCost
from Partsupp PS, supplier S
where PS.ps_suppkey = S.s_suppkey
group by S.s_name, PS.ps_partkey, PS.ps_supplycost
having PS.ps_supplycost > 900
order by PS.ps_supplycost DESC;
