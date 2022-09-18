SELECT SUM(SALESPRICE) 판매총액 FROM ORDERS WHERE CUSTID = 2;

-- 도서 판매 건수를 조회..
SELECT COUNT(*) 도서판매건수 FROM ORDERS;

--고객별 주문한 도석의 총 수량, 총 판매액 조회...
SELECT CUSTID 고객아이디, COUNT(*) 도서수량 , SUM(SALESPRICE)판매총액 FROM ORDERS GROUP BY CUSTID;

-- 가격이 8천원 이상인 도서를 구매한 고객별 주문 도서의 총 수량 조회..
-- 단, 책 2권이상 구매한 고객만 조회...
SELECT * FROM ORDERS;
SELECT CUSTID 고객아이디, SUM(SALESPRICE) 판매총액 FROM ORDERS 
WHERE SALESPRICE >=8000 
GROUP BY CUSTID 
HAVING COUNT(*) >=2;

-- 연습문제 풀기
-- [고객요구 데이터]
-- 1) 도서번호가 1인 도서명
SELECT BOOKID 도서번호, BOOKNAME 도서명 FROM BOOK WHERE BOOKID = 1;
-- 2) 가격이 2만원 이상인 도서명
SELECT BOOKNAME 도서명, PRICE 도서가격 FROM BOOK WHERE PRICE >= 20000;
-- 3) 박지성 고객의 총 구매액
SELECT SUM(SALESPRICE) 구매액 FROM ORDERS OD, CUSTOMER CS
WHERE OD.CUSTID = CS.CUSTID AND NAME = '박지성';
-- 4) 박자성 고객이 구매한 도서수
SELECT COUNT(*) 총구매도서수량 FROM ORDERS OD, CUSTOMER CS
WHERE OD.CUSTID = CS.CUSTID AND NAME = '박지성';
--[운영자,경영자요구 데이터]
-- 1) 마당서점 도서 총 개수
SELECT COUNT(*) 전체도서개수 FROM BOOK;
-- 2) 마당서점에 도서를 출고하는 출판사 총 개수
SELECT PUBLISHER FROM BOOK  GROUP BY PUBLISHER; -- 출판사 종류
SELECT COUNT(DISTINCT PUBLISHER) 전체출고출판사 FROM BOOK;
-- 3) 모든 고객의 이름, 주소
SELECT NAME 고객명, ADDRESS 주소 FROM CUSTOMER;
-- 4) 2014년7월4일 ~ 7일 사이에 받은 도서의 주문 번호
SELECT * FROM ORDERS WHERE ORDERDATE BETWEEN '2014/07/04' AND '2014/07/07';
SELECT ORDERDATE 주문일, ORDERID 주문번호 FROM ORDERS WHERE ORDERDATE BETWEEN '2014/07/04' AND '2014/07/07';
-- 5) 2014년7월4일 ~ 7일 사이에 받은 도서를 제외한 주문 번호
SELECT ORDERDATE 주문일, ORDERID 주문번호 FROM ORDERS WHERE ORDERDATE NOT BETWEEN '2014/07/04' AND '2014/07/07';
-- 6) 성이 '김'씨인 고객의 이름과 주소
SELECT NAME 고객명, ADDRESS 주소 FROM CUSTOMER WHERE NAME LIKE '김%';
-- 7) 성이 '김'씨이고 이름이 '아'로 끝나는 고객의 이름과 주소
SELECT NAME 고객명, ADDRESS 주소 FROM CUSTOMER WHERE NAME LIKE '김%아';

-- 고객과 주문에 관한 모든 데이터 검색...
SELECT * FROM CUSTOMER, ORDERS WHERE ORDERS.CUSTID = CUSTOMER.CUSTID;

-- 고객과 주문에 관한 데이터를 고객순으로 정렬 검색..
SELECT * FROM CUSTOMER, ORDERS WHERE ORDERS.CUSTID = CUSTOMER.CUSTID
ORDER BY CUSTOMER.CUSTID;

-- 고객명과 고객이 주문한 도서의 판매가격을 검색...
SELECT NAME 고객명,SALESPRICE 주문도서가격 FROM CUSTOMER cs, ORDERS od 
WHERE OD.CUSTID = CS.CUSTID;

-- 고객별 주문한 도서의 총 판매액을 검색...
SELECT NAME 고객명, SUM(SALESPRICE) 총판매액 FROM CUSTOMER cs, ORDERS od  
WHERE OD.CUSTID = CS.CUSTID 
GROUP BY CS.NAME;

-- 고객명과 고객이 주문한 도서의 이름을 검색...
SELECT NAME 고객명, BOOKNAME 도서명 
FROM CUSTOMER cs, ORDERS od , BOOK b
WHERE CS.CUSTID = OD.CUSTID AND B.BOOKID = OD.BOOKID
ORDER BY CS.NAME;

-- 가격이 2만원인 도서를 주문한 고객명과 도서명 검색...
SELECT NAME 고객명, BOOKNAME 도서명, PRICE 도서가격 
FROM BOOK bk, CUSTOMER cs, ORDERS od 
WHERE OD.CUSTID = CS.CUSTID AND OD.BOOKID = BK.BOOKID AND PRICE = 20000;

-- 도서를 구매하지 않은 고객 포함 고객의 이름과 주문한 도서의 판매가격 검색
SELECT NAME 고객명, SALESPRICE 구매액
FROM CUSTOMER cs LEFT OUTER JOIN ORDERS od 
ON OD.CUSTID = CS.CUSTID; 
--OUTER JOIN은 기준테이블 속성에 해당하는 내용을 조인테이블에서 가져옴 
-- 조인값이 NULL이 나올 수 있음
-- 기준 테이블 속성은 NULL 없음

-- 가장 비싼 도서의 이름 검색...
SELECT BOOKNAME FROM BOOK b WHERE PRICE =(SELECT MAX(PRICE) FROM BOOK);

-- 도서를 구매한 적이 있는 고객의 이름 검색..
SELECT NAME 고객명 FROM CUSTOMER WHERE CUSTID IN (SELECT CUSTID FROM ORDERS);

-- '대한미디어' 출판도서를 구매한 적이 있는 고객의 이름 검색..
SELECT NAME 고객명 
FROM CUSTOMER 
WHERE CUSTID IN (SELECT CUSTID 
                 FROM ORDERS
                 WHERE BOOKID IN   (SELECT BOOKID
                                    FROM BOOK
                                    WHERE PUBLISHER = '대한미디어'));
                                    
-- 출판사별 평균도서 가격보다 비싼 도서 검색...
SELECT * FROM BOOK;
SELECT AVG(PRICE), BOOK.PUBLISHER FROM BOOK GROUP BY BOOK.PUBLISHER;

SELECT BOOKNAME
FROM BOOK b1
WHERE b1.PRICE > (SELECT AVG(b2.PRICE)
                  FROM BOOK b2
                  WHERE B2.PUBLISHER = B1.PUBLISHER);

-- 도서를 주문하지 않은 고객의 이름을 검색..
SELECT NAME, ORDERID 
FROM CUSTOMER cs LEFT OUTER JOIN ORDERS od
ON OD.CUSTID = CS.CUSTID
WHERE OD.ORDERID IS NULL;

-- MINUS : 차집합
SELECT NAME  -- 집합A : 고객들
FROM CUSTOMER 
MINUS   SELECT NAME -- 집합B : 주문한 고객
        FROM CUSTOMER
        WHERE CUSTID IN (SELECT CUSTID
                         FROM ORDERS);
-->> 주문 안 한 고객

-- UNION : 합집합                    
SELECT NAME -- 집합A : 고객들
FROM CUSTOMER 
UNION   SELECT NAME -- 집합B : 주문한 고객
        FROM CUSTOMER
        WHERE CUSTID IN (SELECT CUSTID
                         FROM ORDERS);
-->> 전체 고객 (주문한 고객 + 주문 안 한 고객)

-- INTERSECT : 교집합                    
SELECT NAME -- 집합A : 고객들
FROM CUSTOMER 
INTERSECT   SELECT NAME -- 집합B : 주문한 고객
            FROM CUSTOMER
            WHERE CUSTID IN (SELECT CUSTID
                             FROM ORDERS);
 -->> 주문한 고객들                            
                             
 --                             
                             
                             
                             
                             
                             
                             
                             
                             
                             
                             