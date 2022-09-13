
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

ROLLBACK;
