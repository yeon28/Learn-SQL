select * from emp;

commit;

select * from dept;


------------------------


select empno, ename, sal  from emp where sal >= 3000;
-- 연봉 3000 이상
select empno, ename, sal  from emp where sal <= 3000;
-- 연봉 3000 이하
select empno, ename, sal  from emp where sal <> 3000;
-- 3000이 아닌 사람

SELECT * from emp where deptno =10;

-- 1. 급여가 1500 이하인 사원의 사원번호, 사원 이름, 급여를 출력
SELECT empno, ename , sal from emp where sal < = 1500;


-----------------


SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE ENAME='FORD';
--WHERE ENAME='FoRD'; 대소문자 구별 불가.

-- 2. 사원이름이 SCOTT 인 사원의 사원번호, 사원 이름, 급여를 출력
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE ENAME='SCOTT';


---------------------- 날짜 출력
SELECT * FROM EMP WHERE HIREDATE <= '1982/01/01';
SELECT * FROM EMP WHERE HIREDATE <= '1982-01-01';

UPDATE EMP SET hiredate = TO_DATE('13-07-1987', 'dd-mm-yyyy') WHERE empno = 7876;
-- ORACLE에서  DATE타입으에서도 문자열 비교 기능


-----------------논리연산
SELECT * FROM EMP WHERE DEPTNO = 10 AND job = 'MANAGER';

SELECT * FROM EMP WHERE DEPTNO = 10 OR job = 'MANAGER';

SELECT * FROM EMP WHERE NOT DEPTNO = 10 ;
SELECT * FROM EMP WHERE DEPTNO <> 10 ;
SELECT * FROM EMP WHERE DEPTNO = 10 OR NOT job = 'MANAGER';

SELECT * FROM EMP WHERE SAL>=2000 AND SAL<=3000;
SELECT * FROM EMP WHERE COMM = 300 OR COMM = 500 OR COMM = 1400;


/*
3. 7521 이거나 7654 이거나 7844 인 사원들의 사원 번호와 급여를 검색하는 쿼리문을 비교 연산자와 OR 논리 연산자 사
용하여 작성하시오.
*/
SELECT EMPNO, SAL FROM EMP  WHERE DEPTNO = 7521 OR DEPTNO = 7654 OR DEPTNO = 7844;

SELECT * FROM EMP WHERE SAL BETWEEN 2000 AND 3000;

SELECT * FROM EMP WHERE  COMM IN (300,500,1400);

--5. 사원 번호가 7521도 아니고 7654도 아니고 7844도 아닌 사원들을 검색
SELECT EMPNO, ENAME FROM EMP WHERE  EMPNO <> 7521 
                                    AND EMPNO <> 7654 
                                    AND EMPNO <> 7844;
SELECT EMPNO, ENAME FROM EMP WHERE  EMPNO NOT IN (7521 ,7654 ,7844);


------------- % 문자열

SELECT * FROM EMP WHERE ENAME LIKE 'F%';

-- 6. 사원들 중에서 이름이 J로 시작하는 사람만을 찾는 쿼리문
SELECT * FROM EMP WHERE ENAME LIKE 'J%';

-- 7. 이번에는 이름 중 A를 포함하는 사원을 검색
SELECT * FROM EMP WHERE ENAME LIKE '%A%';

SELECT ENAME FROM EMP WHERE ENAME LIKE '__A%';

---------------- NULL

SELECT job FROM EMP WHERE COMM IS NULL;
SELECT job FROM EMP WHERE COMM IS NOT NULL;

-- 8. 상관이 없는 사원(CEO 가 되겠지요!)을 검색
SELECT * FROM EMP WHERE MGR IS NULL; -- 사장님등장~!


---------------------------- 주요 함수
----------정렬 ORDER BY

SELECT JOB, SAL FROM EMP ORDER BY SAL ASC; -- 오름차순
SELECT JOB, SAL FROM EMP ORDER BY SAL DESC; -- 내림차순

-- 9. EMP 테이블의 자료를 입사일을 오름차순으로 정렬
SELECT EMPNO, ENAME, JOB, hiredate FROM EMP ORDER BY hiredate ASC;

/*
11. 부서 번호가 빠른 사원부터 출력하되 같은 부서내의 사원을 출력할 경우 최
근에 입사한 사원부터 출력하도록 하되 사원 번호, 입사일, 사원 이름, 급여
순으로 출력하시오.
*/
SELECT * FROM EMP ORDER BY DEPTNO ASC, hiredate DESC;


----------------

DESC DUAL; 
DESC EMP;   --TABLE에 속성이름과 속성 데이터 타입, 속성 제한자(NULL여부) 정보 제공함.

---------

SELECT -10, ABS(-10) "-10 절대값" FROM DUAL;

---------

-- (TRUNCATE)
-- TRUNC 는 반올림X, 그냥 잘라냄O.
SELECT TRUNC(12.3456, 2), TRUNC(12.3456, -1), TRUNC(12.3456) FROM DUAL;

----------

-- MOD 함수는 나누기 연산을 한 후에 구한 몫이 아닌 나머지를 결과로 되돌려주는 함수
SELECT MOD(27,2)"27%2 값", MOD(27,5)"27%5 값", MOD(27,7)"27%7 값" FROM DUAL;


-- 1. 사번(EMPNO)이 홀수인 사람들을 검색
SELECT * FROM EMP WHERE MOD(EMPNO,2) = 1;

----------------------------
-- 2022.09.15

--------------문자열 

SELECT 'Welcome to Oracle' "입력된 문자열", UPPER('Welcome to Oracle')"문자열UPPER" FROM DUAL;
SELECT 'Welcome to Oracle'"입력된 문자열", LOWER('Welcome to Oracle')"문자열LOWER" FROM DUAL;

-- 첫번째 문자를 대문자로 출력
SELECT 'wElCoMe tO oRaCLe' "입력된 문자열" , INITCAP('wElCoMe tO oRaCLe')"문자열INITCAP" FROM DUAL;

-- 2. 다음과 같이 쿼리문을 구성하면 과연 직급이 'manager'인 사원을 검색
SELECT '그냥찾음',EMPNO, ENAME, JOB FROM EMP WHERE JOB = 'manager'; -- 없음

SELECT EMPNO, ENAME, JOB FROM EMP WHERE LOWER(JOB) = 'manager';

-- 실무시 데이터의 대소문자 여부를 판단하기 힘듦
SELECT EMPNO, ENAME, JOB FROM EMP WHERE UPPER(JOB) =  UPPER('Manager');
-- 찾는 데이터의 대소문 형식을 맞춰줌

-------------

SELECT LENGTH('Oracle'), LENGTH('오라클') FROM DUAL;
-- 영문을 2바이트 한글은 1바이트로 인식함.

-------

SELECT SUBSTR('Welcom to Oracle',  4,3) FROM DUAL; -- com
-- 4번째 문자부터 3개만 출력
SELECT SUBSTR('Welcom to Oracle',  -4,3) FROM DUAL; -- acl
-- 역행 4번째 문자부터 순행 3개 출력

SELECT HIREDATE FROM EMP; -- 81/11/17 형식 출력
SELECT SUBSTR(HIREDATE, 1,2) 년도, SUBSTR(HIREDATE, 4,2) 달 FROM EMP;


SELECT HIREDATE FROM EMP; -- 81/11/17 형식 출력
SELECT * FROM EMP WHERE SUBSTR(HIREDATE, 4,2) = '09';

--2. 87년도에 입사한 직원을 알아내기
SELECT * FROM EMP WHERE SUBSTR(HIREDATE, 1,2) = '87';
--3. 이름이 E로 끝나는 사원을 검색
SELECT * FROM EMP WHERE SUBSTR(ENAME , -1,1) = 'E';

SELECT SUBSTR('오라클',3,4) , SUBSTRB('오라클', 3,4) FROM DUAL;
-- SUBSTRB 문자가 메모리에 저장되는 바이트 수를 계산함.
SELECT SUBSTR('Welcome to Oracle',3,4), SUBSTRB('Welcome to Oracle', 3,4) FROM DUAL;
-- 영문자는 1바이트로 저장됨

--INSTR 함수는 대상 문자열이나 칼럼에서 특정 문자가 나타나는 위치
SELECT INSTR('WELCOME TO ORACLE','O') FROM DUAL;
SELECT INSTR('WELCOME TO ORACLE', 'O' , 6,2) FROM DUAL;

-------------
-- LPAD : LEFT PADDING - 왼쪽 여백(테두리 사이의 여백) 
SELECT LPAD('Oracle',20,'#') FROM DUAL;
SELECT RPAD('Oracle',20,'#') FROM DUAL;

-- 문자열 공백 제거
SELECT TRIM('                Oracle                ') trim FROM DUAL;
SELECT LTRIM('                Oracle                ') 왼쪽trim FROM DUAL;
SELECT RTRIM('                Oracle                ') 오른쪽trim FROM DUAL;


--------------

-- SYSDATE : SYSTEM DATE - 컴퓨터에 지정된 현재날짜 출력
SELECT SYSDATE FROM DUAL;
SELECT SYSDATE-1 어제날짜, SYSDATE 오늘날짜 , SYSDATE+1 내일날짜 FROM DUAL;

--6. 각 사원들의 현재까지의 근무 일수를 구하기
SELECT (SYSDATE - HIREDATE) 근무일수 FROM EMP;


-----------

SELECT HIREDATE "입사일", ROUND(HIREDATE, 'MONTH') "월 기준 입사일" FROM EMP;
-- ex) 월 단위 기준으로 퇴직금을 부여할 때 사용 


---------

-- TRUNC(날짜 , 포멧기준)
SELECT HIREDATE ,TRUNC(HIREDATE, 'MONTH') FROM EMP;

------


SELECT ENAME 이름, SYSDATE 오늘, HIREDATE 입사일, ROUND(MONTHS_BETWEEN(SYSDATE, HIREDATE)) 근무일수 FROM EMP;

SELECT ENAME 이름, SYSDATE 오늘, HIREDATE 입사일, ADD_MONTHS(HIREDATE, 6) 입사6개월후 FROM EMP;

SELECT SYSDATE 오늘, NEXT_DAY(SYSDATE,'수요일')"다음 수요일" FROM DUAL;

SELECT HIREDATE 입사일, LAST_DAY(HIREDATE) "입사한 달 마지막날" FROM EMP;

------------------

SELECT SYSDATE "현재 시스템 날짜형식", TO_CHAR(SYSDATE, 'YYYY-MM-DD')"날짜 형식 변형" FROM DUAL;

SELECT HIREDATE 오늘, TO_CHAR(HIREDATE, 'YYYY/MM/DD DAY') "입사일, 요일" FROM EMP;


SELECT TO_CHAR(SYSDATE, 'YYY/MM/DD, HH24:MI:SS') FROM DUAL;

SELECT ENAME 이름 , SAL 연봉, TO_CHAR(SAL, 'L999,999') FROM EMP;
-- 'L999,999' : L은 통화(원화) 999,999는 자리수 지정(빈자리는 비워서 출력)
-- '000,000'으로 자리수 지정하면 비어있는 자리수 0으로 채워서 출력함.
SELECT ENAME 이름 , SAL 연봉, TO_CHAR(SAL, 'L000,000') FROM EMP;


-----


SELECT ENAME , HIREDATE FROM EMP WHERE HIREDATE = TO_DATE(19810220, 'YYYYMMDD');

SELECT TRUNC(SYSDATE-TO_DATE('2008/01/01', 'YYYY/MM/DD'))FROM DUAL;


----------

SELECT TO_NUMBER('20,000','99,999')- TO_NUMBER('10,000', '99,999') FROM DUAL;

--------

SELECT ENAME "직원명", SAL "월급", COMM "성과급", SAL*12+COMM "NULL연봉", NVL(COMM , 0) , SAL*12+NVL(COMM, 0)"NVL연봉" FROM EMP ORDER BY JOB;
-- NVL(COMM , 0) : NULL값을 0으로 변환
-- 연산시  NULL 값이 문제가 됨.

--7. 상사(MANAGER)이 없는 사원만 출력하되 MGR 칼럼 값 NULL 대신 CEO로 출력
SELECT EMPNO ,ENAME , NVL(TO_CHAR(MGR, '9999'), 'C E O') MANAGER FROM EMP WHERE MGR IS NULL;
-- TO_CHAR(MGR, '999') 
-- MGR는 NUMBER 타입으로 선언됨.
-- CHAR 타입으로 형변환 후, CHAR 타입의 '9999' 비워둠.


-----------

SELECT ENAME, DEPTNO, DECODE(DEPTNO, 10, 'ACCONUNTING',
                                    20, 'RESERCH',
                                    30, 'SALES',
                                    40, 'OPERATIONS')
        AS DNAME
FROM EMP;

/*
8. 직급에 따라 급여를 인상하도록 하자. 직급이 'ANAlYST'인 사원은 5%,
'SALESMAN'인 사원은 10%, 'MANAGER'인 사원은 15%, 'CLERK'인 사원
은 20%인 인상한다.
*/
SELECT EMPNO, JOB, SAL, DECODE(JOB, 'ANALYST', ROUND(SAL*1.05),
                                    'SALESMAN', ROUND(SAL*1.1),
                                    'MANAGER', ROUND(SAL*1.15),
                                    'CLERK', ROUND(SAL*1.2),
                                    'PRESIDENT', SAL)AS UPSAL 
FROM EMP;


-------------------

SELECT ENAME , DEPTNO, CASE WHEN DEPTNO = 10 THEN 'ACCOUNTING'
                            WHEN DEPTNO = 20 THEN 'RESERCH'
                            WHEN DEPTNO = 30 THEN 'SALES'
                            WHEN DEPTNO = 40 THEN 'OPERATION'
                        END AS DNAME
FROM EMP;

----------------------JOIN
-----------CROSS JOIN

-- CROSS JOIN
SELECT * FROM EMP , DEPT;

-- EQUL JOIN
SELECT * FROM EMP , DEPT WHERE dept.deptno = emp.deptno;

SELECT ENAME , DNAME  FROM EMP, DEPT 
WHERE emp.deptno = dept.deptno AND ENAME='SCOTT';

-- 1. 뉴욕에서 근무하는 사원의 이름과 급여를 출력하시오.
SELECT ENAME, SAL FROM EMP, DEPT
WHERE emp.deptno = dept.deptno AND LOC = 'NEW YORK';
--2. ACCOUNTING 부서 소속 사원의 이름과 입사일을 출력하시오.
SELECT ENAME, HIREDATE FROM EMP, DEPT
WHERE emp.deptno = dept.deptno AND DNAME = 'ACCOUNTING';
--3. 직급이 MANAGER인 사원의 이름, 부서명을 출력하시오.
SELECT ENAME, DNAME FROM EMP, DEPT
WHERE emp.deptno = dept.deptno AND JOB = 'MANAGER';

-- NON-EQUL JOIN
SELECT * FROM SALGRADE;

SELECT ENAME, SAL, GRADE FROM EMP,SALGRADE
WHERE SAL BETWEEN LOSAL AND HISAL;

-- SELF JOIN

-- SMITH의 매니저 이름이 무엇인지 알아내려면 어떻게 구해야할까요?
SELECT * FROM EMP WHERE ENAME ='SMITH';
SELECT * FROM EMP WHERE EMPNO = 7902;
SELECT ENAME FROM EMP E1 
WHERE E1.EMPNO=(SELECT MGR FROM EMP WHERE ENAME ='SMITH');

-- 상관이 KING인 직원 찾기
SELECT EMPNO FROM EMP WHERE ENAME ='KING';
SELECT ENAME FROM EMP E1 
WHERE E1.MGR =(SELECT EMPNO FROM EMP WHERE ENAME ='KING');

SELECT LOC FROM EMP, DEPT WHERE emp.deptno = dept.deptno AND ENAME ='SCOTT';
SELECT SCOTT.ENAME, FRIEND.ENAME FROM EMP SCOTT, EMP FRIEND
WHERE SCOTT.deptno = friend.deptno 
        AND  SCOTT.ENAME <> FRIEND.ENAME;


-- OUTER JOIN
SELECT * FROM EMP;

SELECT employee.ename || '의 매니저는 '
        || manager.ename || '입니다.' 
FROM emp employee, emp manager
WHERE employee.mgr = manager.empno(+);

SELECT employee.ENAME "직원", manager.ENAME "상관"
--SELECT employee.ename || '의 매니저는 '
--        || NVL(manager.ENAME,  employee.ename) || '입니다.' 
FROM EMP employee LEFT OUTER JOIN EMP manager 
-- 상관이 없을 수 있음(->사장님)
-- 기준을 직원에게 맞춤 (LEFT OUTER JOIN)
ON manager.EMPNO = employee.MGR;


-- ANSI 표준 
-- 오라클에서 사용하는 LEFT OUTER JOIN
SELECT employee.ENAME "직원", manager.ENAME "상관"
FROM EMP employee, EMP manager 
WHERE manager.EMPNO(+) = employee.MGR;

-- 오라클에서 사용하는 RIGTH OUTER JOIN
SELECT employee.ENAME "직원", manager.ENAME "상관"
FROM EMP employee, EMP manager 
WHERE manager.EMPNO = employee.MGR(+);


------------------ ANSI JOIN
SELECT * FROM EMP ,DEPT;-- Oracle(cartesian product)
SELECT * FROM EMP CROSS JOIN DEPT; -- ANSI

-- INNER JOIN
SELECT ENAME , DNAME FROM EMP, DEPT-- (cartesian product)
WHERE emp.deptno = dept.deptno AND emp.ename = 'SCOTT';

SELECT ENAME , DNAME FROM EMP INNER JOIN DEPT
ON emp.deptno = dept.deptno
WHERE emp.ename = 'SCOTT';

SELECT ENAME , DNAME FROM EMP INNER JOIN DEPT
USING(deptno)
WHERE emp.ename = 'SCOTT';

-- NATUAL JOIN
-- : INNER JOIN이 기본으로 적용되고, 중복된 속성 제거함 
SELECT * FROM EMP NATURAL JOIN DEPT;


----------------------그룹 함수

SELECT MAX(HIREDATE) "뉴비 입사일", MIN(HIREDATE) "고인물 입사일" FROM EMP;
SELECT COUNT(COMM)"" FROM EMP; -- NULL 빼고 COUNT
SELECT COUNT(comm)"커미션 받은 사원" FROM EMP WHERE DEPTNO=10 ;
SELECT COUNT(DISTINCT JOB) "업무종류" FROM EMP;
SELECT DEPTNO FROM EMP GROUP BY DEPTNO;
SELECT DEPTNO, ROUND(AVG(SAL))"평균급여"  FROM EMP GROUP BY DEPTNO;
SELECT DEPTNO, COUNT(*)"부서인원", COUNT(COMM)"커미션받은사람"   FROM EMP GROUP BY DEPTNO;
SELECT DEPTNO, ROUND(AVG(SAL))"2000 이상인 평균급여" FROM EMP GROUP BY DEPTNO HAVING AVG(SAL) >=2000;
SELECT DEPTNO, MAX(SAL), MIN(SAL) FROM EMP GROUP BY DEPTNO HAVING MAX(SAL) > 2900;

SELECT * FROM EMP;