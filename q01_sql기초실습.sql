

--1. 마당서점의 고객이 요구하는 다음 질문에 대해 SQL 문을 작성하시오.

--(1) 도서번호가 1인 도서의 이름
SELECT BOOKNAME 도서명 FROM BOOK WHERE BOOKID = 1;

--(2) 가격이 20,000원 이상인 도서의 이름
SELECT BOOKNAME 도서명 FROM BOOK WHERE PRICE >= 20000;

--(3) 박지성의 총 구매액
SELECT SUM(SALESPRICE) "총구매액(원)" 
FROM ORDERS 
WHERE CUSTID IN (SELECT CUSTID 
                 FROM CUSTOMER 
                 WHERE NAME = '박지성');

--(4) 박지성이 구매한 도서의 수
SELECT COUNT(*) "총구매도서(권)" 
FROM ORDERS
WHERE CUSTID = (SELECT CUSTID 
                FROM CUSTOMER 
                WHERE NAME = '박지성');
                 
--(5) 박지성이 구매한 도서의 출판사 수
SELECT COUNT(B.PUBLISHER) 
FROM ORDERS od, BOOK B
WHERE OD.BOOKID = B.BOOKID AND CUSTID = (SELECT CUSTID  
                                         FROM CUSTOMER 
                                         WHERE NAME = '박지성');

--(6) 박지성이 구매한 도서의 이름, 가격, 정가와 판매가격의 차이
SELECT BOOKNAME 도서명, PRICE 도서가격  
FROM ORDERS od, BOOK B
WHERE OD.BOOKID = B.BOOKID AND CUSTID = (SELECT CUSTID  
                                         FROM CUSTOMER 
                                         WHERE NAME = '박지성');

--(7) 박지성이 구매하지 않은 도서의 이름
SELECT BOOKNAME 도서명
FROM ORDERS od, BOOK B
WHERE OD.BOOKID = B.BOOKID AND CUSTID <> (SELECT CUSTID  
                                          FROM CUSTOMER 
                                          WHERE NAME = '박지성');
                                          
                                          
-- 2. 마당서점의 운영자와 경영자가 요구하는 다음 질문에 대해 SQL 문을 작성하시오.

--(1) 마당서점 도서의 총 개수
SELECT COUNT(*) 전체도서수 FROM BOOK;

--(2) 마당서점에 도서를 출고하는 출판사의 총 개수
SELECT COUNT(DISTINCT PUBLISHER) 출고출판사수 FROM BOOK;

--(3) 모든 고객의 이름, 주소
SELECT NAME 고객명, ADDRESS 주소 FROM CUSTOMER;

--(4) 2014년 7월 4일~7월 7일 사이에 주문받은 도서의 주문번호
SELECT BOOKID 주문도서번호 FROM ORDERS 
WHERE ORDERDATE BETWEEN '2014/07/04' AND '2014/07/07';

--(5) 2014년 7월 4일~7월 7일 사이에 주문받은 도서를 제외한 도서의 주문번호
SELECT BOOKID 주문도서번호 FROM ORDERS 
WHERE ORDERDATE NOT BETWEEN '2014/07/04' AND '2014/07/07';

--(6) 성이 ‘김’ 씨인 고객의 이름과 주소
SELECT NAME, ADDRESS FROM CUSTOMER
WHERE NAME LIKE '김%';

--(7) 성이 ‘김’ 씨이고 이름이 ‘아’로 끝나는 고객의 이름과 주소
SELECT NAME, ADDRESS FROM CUSTOMER
WHERE NAME LIKE '김%아';

--(8) 주문하지 않은 고객의 이름(부속질의 사용)
SELECT NAME "미주문 고객" -- 집합A : 고객들
FROM CUSTOMER 
MINUS   SELECT NAME -- 집합B : 주문한 고객
        FROM CUSTOMER
        WHERE CUSTID IN (SELECT CUSTID
                         FROM ORDERS);                        

--(9) 주문 금액의 총액과 주문의 평균 금액
SELECT  SUM(SALESPRICE) 총주문금액, AVG(SALESPRICE) 주문평균금액 FROM ORDERS;

--(10) 고객의 이름과 고객별 구매액
SELECT NAME 고객명, SUM(SALESPRICE) 구매총액 FROM  ORDERS od ,CUSTOMER cs
WHERE CS.CUSTID = OD.CUSTID
GROUP BY CS.NAME;

--(11) 고객의 이름과 고객이 구매한 도서 목록
SELECT NAME 고객명 , BOOKNAME 구매도서  
FROM CUSTOMER cS , ORDERS od , BOOK B
WHERE CS.CUSTID = OD.CUSTID AND OD.BOOKID = B.BOOKID;

--(12) 도서의 가격(Book 테이블)과 판매가격(Orders 테이블)의 차이가 가장 많은 주문
SELECT * FROM ORDERS 
WHERE ORDERID = (SELECT ORDERID
                 FROM ORDERS od, BOOK b
                 WHERE OD.BOOKID = B.BOOKID 
                 AND ABS(PRICE-SALESPRICE) =(SELECT MAX(ABS(PRICE-SALESPRICE))
                                             FROM ORDERS od, BOOK b
                                             WHERE OD.BOOKID = B.BOOKID));


--(13) 도서의 판매액 평균보다 자신의 구매액 평균이 더 높은 고객의 이름  
SELECT NAME 고객명 FROM CUSTOMER cs , ORDERS od 
WHERE CS.CUSTID = OD.CUSTID
GROUP BY CS.NAME
HAVING AVG(SALESPRICE) > (SELECT AVG(SALESPRICE) FROM ORDERS);


--4. [사원 데이터베이스] 다음은 scott 데이터베이스에 저장된 사원 데이터베이스다. 
--다음 질문에 대해 SQL 문을 작성하시오

--(1) 사원의 이름과 직위를 출력하시오. 
--단, 사원의 이름은 ‘사원이름’, 직위는 ‘사원직위’머리글이 나오도록 출력한다.
SELECT ENAME 사원명, JOB FROM EMP;

--(2) 30번 부서에 근무하는 모든 사원의 이름과 급여를 출력하시오.
SELECT ENAME 사원명, SAL 급여 FROM EMP
WHERE DEPTNO = 30;

--(3) 사원 번호와 이름, 현재 급여와 10% 인상된 급여(열 이름은 ‘인상된 급여’)를 출력하시오. 
--단, 사원 번호순으로 출력한다. 증가된 급여분에 대한 열 이름은 ‘증가액’으로 한다.
SELECT ENAME, SAL "현재급여",(SAL*0.01) "증가액",
              SAL+(SAL*0.01) "인상된 급여"
FROM EMP 
ORDER BY EMPNO;

--(4) ‘S’로 시작하는 모든 사원과 부서번호를 출력하시오.
SELECT * FROM EMP;
SELECT EMPNO 사원번호 , ENAME 사원명 , DEPTNO 부서번호 FROM EMP
WHERE UPPER(ENAME) LIKE UPPER('S%'); 

--(5) 모든 사원의 최대 및 최소 급여, 합계 및 평균 급여를 출력하시오. 열 이름은 각각 MAX, MIN,SUM, AVG로 한다. 
--단, 소수점 이하는 반올림하여 정수로 출력한다.
SELECT  MAX(SAL) 최고급여,
        MIN(SAL) 최저급여,
        SUM(SAL) 전체급여,
        ROUND(AVG(SAL)) 평균급여
FROM EMP;

--(6) 업무이름과 업무별로 동일한 업무를 하는 사원의 수를 출력하시오. 
--열 이름은 각각 ‘업무’와 ‘업무별 사원수’로 한다.
SELECT * FROM EMP;
SELECT JOB 업무, COUNT(JOB) "업무별 사원수" FROM EMP GROUP BY JOB;

--(7) 사원의 최대 급여와 최소 급여의 차액을 출력하시오.
SELECT * FROM EMP;
SELECT  MAX(SAL) 최고급여,
        MIN(SAL) 최저급여,
        MAX(SAL)-MIN(SAL)"최고최저급여 차액"
FROM EMP;

--(8) 30번 부서의 구성원 수와 사원들 급여의 합계와 평균을 출력하시오.
SELECT  COUNT(*) 구성원수,
        ROUND(AVG(SAL)) 평균급여,
        SUM(SAL) 총급여
FROM EMP
WHERE DEPTNO = 30;

--(9) 평균급여가 가장 높은 부서의 번호를 출력하시오.
SELECT DISTINCT DEPTNO "부서번호" FROM EMP 
GROUP BY DEPTNO
HAVING AVG(SAL) = (SELECT MAX(AVG(SAL))
                  FROM EMP
                  GROUP BY DEPTNO);

--(10) 세일즈맨을 제외하고, 각 업무별 사원들의 총 급여가 3000 이상인 각 업무에 대해서, 
--업무명과 각 업무별 평균 급여를 출력하되, 평균급여의 내림차순으로 출력하시오.

SELECT JOB 업무 , AVG(SAL) 평균급여 FROM EMP 
GROUP BY JOB
HAVING JOB <> 'SALESMAN' AND AVG(SAL) >= 3000
ORDER BY AVG(SAL) DESC;

--(11) 전체 사원 가운데 직속상관이 있는 사원의 수를 출력하시오.
SELECT COUNT(*)"사원수" FROM EMP
WHERE MGR IS NOT NULL;


--(12) Emp 테이블에서 이름, 급여, 커미션 금액, 총액(sal + comm)을 구하여 총액이 많은 순서대로 출력하시오. 
--단, 커미션이 NULL인 사람은 제외한다.
SELECT * FROM EMP;
SELECT ENAME 사원명, SAL 급여, COMM 커미션, SAL+COMM 총액 FROM EMP
WHERE COMM IS NOT NULL
ORDER BY SAL+COMM DESC;

--(13) 각 부서별로 같은 업무를 하는 사람의 인원수를 구하여 부서번호, 업무명, 인원수를 출력하시오.


--(14) 사원이 한 명도 없는 부서의 이름을 출력하시오.
SELECT DNAME "사원이 없는 부서" FROM DEPT LEFT OUTER JOIN EMP 
USING(DEPTNO)
WHERE EMPNO IS NULL;

--(15) 같은 업무를 하는 사람의 수가 4명 이상인 업무와 인원수를 출력하시오.
--SELECT * FROM DEPT LEFT OUTER JOIN EMP 
--USING(DEPTNO);

--(16) 사원번호가 7400 이상 7600 이하인 사원의 이름을 출력하시오.

--(17) 사원의 이름과 사원의 부서를 출력하시오.

--(18) 사원의 이름과 팀장의 이름을 출력하시오.

--(19) 사원 SCOTT보다 급여를 많이 받는 사람의 이름을 출력하시오.

--(20) 사원 SCOTT가 일하는 부서번호 혹은 DALLAS에 있는 부서번호를 출력하시오.
