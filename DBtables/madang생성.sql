/* if 'madang' exists, remove user 'madang' */
DROP USER madang CASCADE;

CREATE USER madang 
IDENTIFIED BY madang
Default Tablespace users
Temporary Tablespace temp
profile default;

GRANT Connect, RESOURCE TO madang;
GRANT create view, create synonym to madang;

ALTER USER madang ACCOUNT unlock;

/* connect to user madang */
conn madang/madang

DROP TABLE Book;

CREATE TABLE Book (
bookid  NUMBER(2) PRIMARY KEY,
bookname VARCHAR2(40),
publisher VARCHAR2(40),
price NUMBER(8)
);

INSERT INTO Book VALUES(1, '축구의 역사','굿스포츠', 7000);
INSERT INTO Book VALUES(2, '축구아는 여자','나무수', 13000);
INSERT INTO Book VALUES(3, '축구의 이해','대한미디어', 22000);
INSERT INTO Book VALUES(4, '골프 바이블','대한미디어', 35000);
INSERT INTO Book VALUES(5, '피겨 교본','굿스포츠', 8000);
INSERT INTO Book VALUES(6, '역도 단계별기술','굿스포츠', 6000);
INSERT INTO Book VALUES(7, '야구의 추억','이상미디어', 20000);
INSERT INTO Book VALUES(8, '야구를 부탁해','이상미디어', 13000);
INSERT INTO Book VALUES(9, '올림픽 이야기','삼성당', 7500);
INSERT INTO Book VALUES(10, 'Olympic Champions','Pearson', 13000);

select * from Book;


DROP TABLE Customer;

CREATE TABLE Customer (
custid  NUMBER(2) PRIMARY KEY,
name  VARCHAR2(40),
address VARCHAR2(50),
phone VARCHAR2(20)
);

INSERT INTO Customer VALUES(1, '박지성','영국 맨체스터', '000-5000-0001');
INSERT INTO Customer VALUES(2, '김연아','대한민국 서울', '000-6000-0001');
INSERT INTO Customer VALUES(3, '장미란','대한민국 강원도', '000-7000-0001');
INSERT INTO Customer VALUES(4, '추신수','미국 클리브랜드', '000-8000-0001');
INSERT INTO Customer VALUES(5, '박세리','대한민국 대전', NULL);

select * from Customer;


DROP TABLE Orders;

CREATE TABLE Orders (
orderid NUMBER(2) PRIMARY KEY,
custid  NUMBER(2) REFERENCES Customer(custid),
bookid  NUMBER(2) REFERENCES Book(bookid),
salesprice  NUMBER(8),
orderdate DATE
);

INSERT INTO Orders VALUES(1, 1, 1, 6000, TO_DATE('2014-07-01', 'yyyy-mm-dd'));
INSERT INTO Orders VALUES(2, 1, 3, 21000, TO_DATE('2014-07-03', 'yyyy-mm-dd'));
INSERT INTO Orders VALUES(3, 2, 5, 8000, TO_DATE('2014-07-03', 'yyyy-mm-dd'));
INSERT INTO Orders VALUES(4, 3, 6, 6000, TO_DATE('2014-07-04', 'yyyy-mm-dd'));
INSERT INTO Orders VALUES(5, 4, 7, 20000, TO_DATE('2014-07-05', 'yyyy-mm-dd'));
INSERT INTO Orders VALUES(6, 1, 2, 12000, TO_DATE('2014-07-07', 'yyyy-mm-dd'));
INSERT INTO Orders VALUES(7, 4, 8, 13000, TO_DATE('2014-07-07', 'yyyy-mm-dd'));
INSERT INTO Orders VALUES(8, 3, 10, 12000, TO_DATE('2014-07-08', 'yyyy-mm-dd'));
INSERT INTO Orders VALUES(9, 2, 10, 7000, TO_DATE('2014-07-09', 'yyyy-mm-dd'));
INSERT INTO Orders VALUES(10, 3, 8, 13000, TO_DATE('2014-07-10', 'yyyy-mm-dd'));

select * from Orders;


DROP TABLE Imported_Book;

CREATE TABLE Imported_Book (
bookid  NUMBER,
bookname  VARCHAR2(40),
publisher VARCHAR2(40),
price NUMBER(8)
);

INSERT INTO Imported_Book VALUES(21, 'Zen Golf', 'Pearson', 12000);
INSERT INTO Imported_Book VALUES(22, 'Soccer Skills', 'Human Kinetics', 15000);

select * from Imported_Book;

-- Commit : 
COMMIT;

SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = "Book";


----------------------------------------------------------
select bookname, publisher, price
from book
where bookname LIKE '%축구%';

select * from User_Objects;



DROP table goodsinfo;

create table goodsinfo(
code char(5) not null primary key,
name varchar2(30) not null,
price NUMBER(8) not null,
maker varchar2(20)
);

insert into goodsinfo values ('10001','OLED TV',350000,'LG');
insert into goodsinfo values ('10002','DVD 플레이어',250000,'LG');
insert into goodsinfo values ('10003','삼성 카메라',210000,'삼성');
insert into goodsinfo values ('10004','컬러 텔레비젼',300000,'유니리버');

select * from goodsinfo;

commit;

----------------- 1/11
Create Table NewBook (
bookid number,
bookname Varchar2(20),
publisher varchar2(20),
price number
);
