-- Comment
-- SQL명령어를 끝낸 후 ; 필수
-- select는 테이블에 요청한 속성을 조회하는 명령어
-- *는 모든 속성을 가져오라는 명령어
-- from 테이블 : 테이블로 부터 가져오라는 명령어
select * from customer;

-- 1. selection : 시그마 명령어 - 행을 선택하는 명령어
--   - 'where 조건문' 형태 표현
select * from customer WHERE custid>=3;

-- 2. projection : 속성을 선택하는 명령어
--  - select name,address : 'select 원하는 속성이름' 형식
select name,address from customer WHERE custid>=3;

-- SELECT 찾고 싶은 속성명 FROM 정보를 가져올 테이블명 WHERE 조건문; -> 형식
SELECT phone 
FROM customer 
WHERE name='김연아';


SELECT bookname, price
FROM book;

SELECT bookid, bookname, publisher, price
FROM book;

SELECT * FROM book;

-- book테이블에 있는 publisher를 모두 출력함(중복도 함께 출력됨.)
SELECT publisher, price FROM book;

-- DISTINCT는 중복되는 원소 없이 출력함.
-- 오라클에서 해당 속성이 중복되는 행들을 처리하고 출력함.
-- 제약 사항이 많고, 사용되는 것이 한정되어 있음.
SELECT DISTINCT publisher 
FROM book; -- 6행

SELECT DISTINCT price
FROM book; -- 8행

--SELECT DISTINCT publisher DISTINCT price FROM book;
-- 오류: publisher price가 DISTINCT로 출력되는 행의 수가 다름


SELECT *
FROM Book
WHERE price < 20000;

SELECT * 
FROM book 
WHERE price BETWEEN 10000 AND 20000;


SELECT *
FROM book
WHERE price >= 10000 AND price <= 20000;

SELECT  *
FROM book 
WHERE publisher IN ('굿스포츠', '대한미디어');

SELECT  *
FROM book 
WHERE publisher = '굿스포츠' OR publisher = '대한미디어';

SELECT  *
FROM book
WHERE publisher NOT IN ('굿스포츠', '대한미디어');

SELECT  *
FROM book
WHERE price NOT BETWEEN 10000 AND 20000;

SELECT  bookname, publisher
FROM Book
WHERE bookname = '축구의 역사';
--WHERE bookname LIKE '축구의 역사';

SELECT  bookname, publisher
FROM Book
WHERE bookname LIKE '%축구%'; 
-- 책 이름에 '축구'가 포함된 모든 속성 조회
-- '%축구%' : 축구 앞뒤로 다른 문자가 존재할 수 있음
--WHERE bookname = '%축구%'; -> 조회되지 않음, LIKE는 어디서나 성립하는 = 아님.
--WHERE bookname LIKE '축구%'; -> 축구로 시작하는 모든 문자열 속성 조회
--WHERE bookname LIKE '%축구%'; -> 축구로 끝나는 모든 문자열 속성 조회

SELECT  *
FROM book
WHERE bookname LIKE '_구%';
-- _ : 한 개의 문자를 의미함. 어떤 문라도 괜찮다는 의미 
-- ex) _구 : 야구, 축구, 송파구, 강남구,,,
--WHERE bookname LIKE '__의%'; -> _를 2번 입력해 세번째 글자가 '의'인 속성 조회
--WHERE bookname LIKE '%기_'; -> 마지막 두번째 글자가 '기'인 속성 조회

SELECT  *
FROM book 
WHERE bookname LIKE '%축구%' AND price >= 20000;

SELECT  *
FROM book 
WHERE publisher LIKE '굿스포츠' OR publisher LIKE '대한미디어';

SELECT * 
FROM book
ORDER BY price;
-- ORDER BY : 오름차순으로 정렬(sorting) 조회 
-- 기본 조회는 데이터가 삽입된 순서로 조회됨.

SELECT * 
FROM book
ORDER BY price, publisher; 
-- ORDER BY price,publisher; 
-- -> price를 오름차순 정렬 후, price가 같을 경우 publisher를 오름차순 조회함.

SELECT * 
FROM book
ORDER BY price DESC, publisher ASC; 
-- DESC : 내림차순
-- ASC : 오름차순 (ORDER BY에서 ASC 생략해도 오름차순 정렬)

SELECT * FROM orders;
SELECT SUM(salesprice)
FROM orders;
--SELECT SUM(salesprice) -> salesprice의 값의 합을 하나의 행으로 표현
--SUM(속성명) : 집계함수

--SELECT SUM(salesprice) , custid 
-- sum은 1행, custid는 다행임. 
-- 오류: 집계 함수, distinct 등 여러 개의 행을 압축하여 단축행으로 변환되는 명령어는 일반적인 속성죄회와 동시 사용 불가


SELECT SUM(salesprice) as 총매출
--SELECT SUM(salesprice) 총매출 -> as 생략 가능
FROM orders;
-- as 속성별명 : 속성별명으로 출력함


SELECT  *
FROM customer 
WHERE name = '김연아';

SELECT SUM(salesprice) as 총매출
FROM orders
WHERE custid =2;

SELECT  SUM(salesprice) as Total,
        AVG(salesprice) as Average,
        MIN(salesprice) as Minimum,
        MAX(salesprice) as Maximum
FROM    orders;

SELECT  COUNT(*)
--SELECT  COUNT(*) -> 갯수
FROM    orders;


SELECT  custid, -- 고객 아이디 
        COUNT(*) as 도서수량 , -- 주문한 도서수량
        SUM(salesprice) as 총액 -- 주문한 총 금액
-- custid는 기본 속성이지만,GROUP BY를 적용했기 때문에 다른 함수들과 함께 사용할 수 있음.       
FROM    orders
GROUP BY custid;
--GROUP BY custid; -> GROUP BY와 집계 함수를 같이 사용하면, custid를 기준으로 집계함.



SELECT  custid ,
        COUNT(*) as 도서수량

FROM    orders              -- 1. 테이블 가져옴
WHERE   salesprice >= 8000  -- 2. 8000원 이상인 도서

GROUP BY custid         -- 3. 고객 아이디를 기준으로 group
HAVING  COUNT(*) >= 2;  -- 4. group by 결과로 나온 행 대상으로 합이 2이상인 경우 출력

-- HAVING + 조건문: GROUP BY로 나온 결과를 필터링 하는 조건절
-- -> 조건문으로 사용할 수 있는 속성은 select된 속성만 사용가능
-- from-where , group-having



SELECT  *
FROM    customer, orders;  
-- cartersian product : 두개의 테이블을 중복하게 합침.
-- 

SELECT  *
FROM    customer, orders
WHERE   customer.custid = orders.custid;
--WHERE customer.custid = orders.custid; -> 서로 다른 두 테이블에 custid가 같음
-- 동등 조인
 
SELECT  *
FROM    customer, orders
WHERE   customer.custid = orders.custid
ORDER BY customer.custid;


SELECT  name, 
        salesprice
FROM    customer,
        orders
WHERE   orders.custid = customer.custid;


SELECT  name,
        SUM(salesprice)
FROM    customer,
        orders
WHERE   orders.custid = customer.custid
GROUP BY    customer.name
ORDER BY    customer.name;


SELECT  customer.name,
        book.bookname
FROM    customer,
        orders,
        book
WHERE   customer.custid = orders.custid
        AND orders.bookid = book.bookid;
     
        
SELECT  customer.name,
        book.bookname,
        book.price
FROM    customer,
        orders,
        book
WHERE   orders.custid = customer.custid
        AND orders.bookid = book.bookid
        AND book.price = 20000;

-- ANSI SQL문 : 모든 dbms에서 지원하는 SQL명령어
-- ANSI : 미국 국가 표준 협회
SELECT  customer.name,
        orders.salesprice
FROM    customer LEFT OUTER JOIN orders
            ON orders.custid = customer.custid;
-- on : where 같은 의미

        













