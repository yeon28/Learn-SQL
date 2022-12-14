
CREATE TABLE DEPT_COPY
AS
SELECT * FROM DEPT;

CREATE TABLE EMP_COPY
AS
SELECT * FROM EMP;

SELECT * FROM DEPT_COPY;
SELECT * FROM EMP_COPY;

--------------
--1.2 뷰 정의(생성)하기 - CREATE
CREATE VIEW EMP_VIEW30
AS
SELECT EMPNO, ENAME, DEPTNO
FROM EMP_COPY
WHERE DEPTNO=30;

DESC EMP_VIEW30;

SELECT * FROM EMP_VIEW30;
-- SELECT EMPNO, ENAME, DEPTNO FROM EMP_COPY WHERE DEPTNO=30; 과 같은 의미
SELECT * FROM EMP_COPY;

INSERT INTO EMP_COPY (EMPNO, ENAME, JOB, DEPTNO)
VALUES(8200,'TEST','TEST',30);

SELECT * FROM EMP;
SELECT * FROM EMP_COPY; -- 뷰에서 위 테스트 INSERT 생성됨.

SELECT ENAME FROM EMP_VIEW30;
-- 뷰 테이블도 그냥 테이블처러 일부 데이터만 뽑아서 사용할 수 있음.


-- 뷰테이블 생성 추가 실습하기 
CREATE VIEW EMP_VIEW20
AS
SELECT EMPNO, ENAME, DEPTNO, MGR
FROM EMP_COPY
WHERE DEPTNO=20;

SELECT * FROM EMP_VIEW20; -- 뷰테이블 조건 생성 확인하기

SELECT VIEW_NAME, TEXT 뷰테이블조건
FROM USER_VIEWS; -- 뷰 테이블 리스트 출력

INSERT INTO EMP_VIEW30
VALUES(1111, 'AAAA', 30); -- 뷰 테이블에 데이터 값 추가하기.

SELECT * FROM EMP_VIEW30; -- 뷰 테이블에 추가됨.
SELECT * FROM EMP_COPY; -- 뷰 테이블의 부모 테이블에도 추가됨.

INSERT INTO EMP_VIEW30
VALUES(8000, 'ANGEL', 30);
SELECT * FROM EMP_VIEW30;

-- 뷰 테이블을 생성할 때 새로운 속성 이름으로 지정 가능함.
-- CREATE OR REPLACE : DROP VIEW와 CREATE VIEW를 사용할 필요 없음
-- --> 만약 존재하는 뷰 테이블라면 변경하고, 없다면 생성하라는
CREATE OR REPLACE VIEW EMP_VIEW(사원번호, 사원명, 급여, 부서번호)
AS
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP_COPY;

SELECT * FROM EMP_VIEW
WHERE 부서번호=30;

CREATE OR REPLACE VIEW EMP_VIEW(사원번호, 사원명, 부서번호) 
AS
SELECT EMPNO, ENAME, DEPTNO
FROM EMP_COPY;

SELECT * FROM EMP_VIEW
WHERE deptno=30;
-- error :  "DEPTNO": invalid identifier 부서번호라는 별칭을 설정 했음으로 별칭으로 검색해야함.
SELECT * FROM EMP_VIEW
WHERE 부서번호=30; -- 출력 완

-- 그룹 함수를 사용하여 뷰 테이블을 만들 때, 반드시 별명(alias)을 지정해줘야함.
CREATE VIEW VIEW_SAL
AS
SELECT DEPTNO, SUM(SAL) AS "SalSum", AVG(SAL) AS "SalAvg"
FROM EMP_COPY
GROUP BY DEPTNO;

SELECT * FROM VIEW_SAL;

CREATE OR REPLACE VIEW VIEW_SAL
AS
SELECT DEPTNO, SUM(SAL), AVG(SAL)
FROM EMP_COPY
GROUP BY DEPTNO;
-- ERROR :  "must name this expression with a column alias" 별명(alias)을 지정해 줘야함.

INSERT INTO EMP_SAL
VALUES(20, 900, 2800);
-- ERROR:  "table or view does not exist" 
-- 뷰 테이블에서 데이터 추가하면 원본 테이블에 추가 되는데, 그룹 함수 인경우 원본 테이블이 없음으로 추가할 방법이 없음.  

--
CREATE OR REPLACE VIEW EMP_ANNUALSAL
AS
SELECT EMPNO, ENAME, SAL*12 AS AnnualSal
FROM EMP_COPY;

SELECT * FROM EMP_ANNUALSAL;

INSERT INTO EMP_ANNUALSAL
VALUES(222, 'BBBB', 18000);
-- ERROR :  "virtual column not allowed here"
-- 원본 테이블에 SAL은 있지만 AnnualSal은 없음.

SELECT DISTINCT(JOB) FROM EMP_VIEW;
-- ERROR: "JOB": invalid identifier
-- DISTINCT는 사용 가능하지만, DML은 사용할 수 없음.

--복합뷰 만들기(생성하기).
CREATE VIEW EMP_VIEW_DEPT
AS
SELECT E.EMPNO, E.ENAME, E.SAL, E.DEPTNO, D.DNAME, D.LOC
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
ORDER BY EMPNO DESC;

SELECT * FROM EMP_VIEW_DEPT;

DROP VIEW VIEW_SAL;

--FRCE 옵션
--: 원본 테이블이 없더라도 뷰 테이블 생성
--NOFORCE 옵션 - (default)
--: 원본 테이블이 없으면 뷰 테이블 생성 불가

--FORCE 사용하기
CREATE OR REPLACE FORCE VIEW NOTABLE_VIEW
AS
SELECT EMPNO, ENAME, DEPTNO
FROM EMPLOYEES
WHERE DEPTNO=30;
--경고: 컴파일 오류와 함께 뷰가 생성되었습니다.