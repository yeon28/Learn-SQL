
-- dual :  dummy table
SELECT ABS(-78), ABS(+78)
FROM Dual;

-- ROUND : 반올림 
-- 두번째 매개변수는 소수점 이하 자리 수를 의미함.
SELECT  ROUND(562.845, 1)
FROM    dual;
-- 두번째 매개변수는 소수점 이상 자리 수를 의미함.
SELECT  ROUND(562.845, -2)
FROM    dual;

SELECT * FROM dual;


-- 질의 4-3 고객별 평균 주문 금액을 백 원 단위로 반올림한 값을 구하시오.
SELECT  *
FROM    Orders;

SELECT  custid "고객번호",
        ROUND(SUM(salesprice)/COUNT(*), -2) "평균금액"
        -- '매출총합/매출건수' 의 소수점2자리 이상 자리수 반올림.
FROM    Orders
GROUP BY custid;



--REPLACE : 문자열을 치환하는 함수
-- 질의 4-4 도서제목에 야구가 포함된 도서를 농구로 변경한 후 도서 목록을 보이시오.
SELECT   bookid, 
REPLACE (bookname, '야구', '농구') "bookname", 
         publisher, 
         price
FROM     Book;


-- LENGTH : 글자의 수를 세어주는 함수 (단위가 바이트(byte)가 아닌 문자 단위)
-- 질의 4-5 굿스포츠에서 출판한 도서의 제목과 제목의 글자 수를 확인하시오.
-- (한글은 2바이트 혹은 UNICODE 경우는 3바이트를 차지함)
-- LENGTH: 한글 영어 상관없이 1바이트로 인식함.
-- LENGTHB: 한글은 3 영어는 1
SELECT  bookname "제목",
        LENGTH(bookname) "글자수",
        LENGTHB(bookname) "바이트수"
FROM    Book
WHERE   publisher='굿스포츠';



-- SUBSTR(문자열, 시작위치, 갯수) : 지정한 길이만큼의 문자열을 반환하는 함수
--   - 문자열에서 특정 문자열을 잘라서 return하는 함수.
--   - 시작 위치가 1 부터 시작함.
SELECT  SUBSTR('ABCDEFG',3,4)
FROM    dual;

-- 질의 4-6 마당서점의 고객 중에서 같은 성(姓)을 가진 사람이 몇 명이나 되는지 성별 인원수를구하시오.
--(+ 오름차순 정렬)
SELECT      SUBSTR(name, 1, 1) "성",
            COUNT(*) "인원"
FROM        Customer
GROUP BY    SUBSTR(name, 1, 1)
ORDER BY    SUBSTR(name, 1, 1);

SELECT      *
FROM        Customer;

----------------------------- SQL 내장 함수 - 날짜•시간 함수

-- 질의 4-7 마당서점은 주문일로부터 25일 후 매출을 확정한다. 각 주문의 확정일자를 구하시오.
SELECT  orderid "주문번호", 
        orderdate "주문일", 
        orderdate+25 "확정"
FROM    Orders;

-- TO_DATE : 문자형으로 저장된 날짜를 날짜형으로 변환하는 함수
-- TO_CHAR : 날짜형을 문자형으로 변환하는 함수
SELECT  orderid "주문번호",
        TO_CHAR(orderdate, 'yyyy-mm-dd dy') "주문일",
        custid "고객번호",
        bookid "도서번호"
FROM    Orders
WHERE   orderdate = TO_DATE('20140707', 'yyyymmdd');


-- SYSDATETIME : 오라클의 현재 날짜와 시간을 반환하는 함수
-- SYSTIMESTAMP : 현재 날짜, 시간과 함께 초 이하의 시간과 서버의 TIMEZONE까지 출력함
-- 질의 4-8 DBMS 서버에 설정된 현재 시간과 오늘 날짜를 확인하시오. 
SELECT  SYSDATE, -- SYSDATE: 현재시간
        TO_CHAR(SYSDATE, 'yyyy/mm/dd dy hh12:mi:ss') "SYSDATE_1"
        -- TO_CHAR : 문자열 타입으로 변환
FROM    Dual;

SELECT * FROM orders;


------------------------------



INSERT INTO Book VALUES(11, 'Olympic Champions2','Pearson', null);

SELECT price + 10 "10더한가격"
FROM book;

-- 합계 평균 집계함수 사용시, null 값은 제외함.
SELECT  SUM(price),
        AVG(price),
        COUNT(*),
        COUNT(price)
FROM    book;

-- 동작하지 않는 sql명령어 : 이유는 null은 '='로 표현 불가
-- '='은 is로 대체 , '!=' 은 is not
SELECT * FROM book
--WHERE   price = null;
WHERE   price is null;


--NVL : NULL 값을 다른 값으로 대치하여 연산하거나 다른 값으로 출력
--NVL(속성, 값) /* 속성 값이 NULL이면 '값'으로 대치한다 */
--질의 4-10 이름, 전화번호가 포함된 고객목록을 보이시오. 단, 전화번호가 없는 고객은‘연락처없음’ 으로 표시한다.
SELECT  name "이름", 
        NVL(phone, '연락처없음') "전화번호"
FROM    Customer;

SELECT * FROM book;
SELECT * FROM customer;

-----------------------------
-- SQL 고급(2) - 0914

SELECT  *   FROM    Customer;

-- `ROWNUM` : select 문에서 where조건절에서 통과한 행들에 대하여 동적으로 순번을 출력함
-- 순번은 1번부터 시작함.
-- 테이블을 정렬하여 상위 5행 하위 5행을 가져올 경우에 사용함.

-- 질의 4-11 고객 목록에서 고객번호, 이름, 전화번호를 앞의 두 명만 보이시오. 
SELECT  ROWNUM "순번", 
        custid, 
        name, 
        phone
FROM    customer
WHERE   ROWNUM <=2;


-- rownum은 ORDER BY에 영향을 받음
SELECT  ROWNUM "순번", bookid, bookname, price
FROM    book
WHERE   ROWNUM <=6
ORDER BY  price;


-- 가격이 가장 낮은 책 5권 출력
SELECT  ROWNUM, b.*
FROM    (select * from book ORDER BY price) b;

SELECT  ROWNUM, b.*
FROM    (select * from book ORDER BY price) b
            -- from에 'select문'이 있으면 SQL은 내부적으로 테이블로 간주함.
WHERE   ROWNUM <=3;


----------------------


--  질의 4-12 마당서점의 고객별 판매액을 보이시오(결과는 고객이름과 고객별 판매액을 출력).
SELECT (SELECT	name 
        FROM 	customer cs 
        WHERE	cs.custid = od.custid) "name", 
        Sum(od.salesprice) "Total"
FROM    orders od
group by custid;

---------------------------

-- 비교 연산자
-- 질의 4-15 평균 주문금액 이하의 주문에 대해서 주문번호와 금액을 보이시오.

SELECT  orderid,
        salesprice
FROM    orders
WHERE   salesprice <= (SELECT   AVG(salesprice)
                        FROM   orders);
--질의 4-16 각 고객의 평균 주문금액보다 큰 금액의 주문 내역에 대해서 주문번호, 고객번호,금액을 보이시오.
SELECT  orderid "주문번호",
        custid "고객아이디",
        salesprice "주문금액"
FROM    orders od
WHERE   salesprice > (SELECT   AVG(salesprice)
                        FROM   orders so
                        WHERE   od.custid = so.custid);
                        

----------------

-- 질의 4-14 고객번호가 2 이하인 고객의 판매액을 보이시오.(결과는 고객이름과 고객별 판매액 출력)
SELECT  cs.name, 
        SUM(od.salesprice)"Total"
        
FROM   (SELECT  custid,name
        FROM    customer
        WHERE   custid <=2) cs, 
        orders od
        
WHERE   cs.custid = od.custid
GROUP BY cs.name;

-- 위 질의 부속질의 사용하지 않고 출력하기.
SELECT  cs.name, 
        SUM(od.salesprice)"Total"       
FROM    customer cs, 
        orders od     
WHERE   cs.custid = od.custid AND cs.custid <=2
GROUP BY cs.name;


-- IN, NOT IN
--질의 4-16 대한민국에 거주하는 고객에게 판매한 도서의 총판매액을 구하시오.

SELECT  SUM(salesprice) "Total"
FROM    orders
WHERE   custid IN  (SELECT  custid
                    FROM    customer
                    WHERE   address LIKE '%대한민국%');

--ALL, SOME(ANY)
-- ALL : 모두 출력
-- SOME(ANY): 최소한 한 개를 만족하는 경우 모두 출력

-- 질의 4-18 3번 고객이 주문한 도서의 최고 금액보다 더 비싼 도서를 구입한 주문의 주문번호와 금액을 보이시오.
SELECT  orderid,
        salesprice
FROM    orders   
WHERE   salesprice > ALL(SELECT  salesprice -- MAX(salesprice)
                         FROM    orders
                         WHERE   custid = '3');


SELECT  orderid,
        salesprice
FROM    orders   
WHERE   salesprice > SOME(SELECT  salesprice -- MIN(salesprice)
                         FROM    orders
                         WHERE   custid = '3');


-- EXISTS, NOT EXISTS
-- EXISTS : 데이터의 존재 유무를 확인함.

-- 질의 4-19 EXISTS 연산자로 대한민국에 거주하는 고객에게 판매한 도서의 총 판매액을 구하시오.
SELECT  SUM(salesprice) "Total"
FROM    orders od
WHERE   EXISTS(SELECT *
                FROM customer cs
                WHERE address LIKE '%대한민국%' 
                                AND cs.custid = od.custid);

SELECT  SUM(salesprice) "Total"
FROM    orders od
WHERE   custid IN(SELECT custid
                FROM customer 
                WHERE address LIKE '%대한민국%');
-----------------------


ROLLBACK;
