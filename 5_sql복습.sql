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

------------------정렬 ORDER BY

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
-- (TRUNCATE)
-- TRUNC 는 반올림X, 그냥 잘라냄O.
SELECT TRUNC(34.56154, 2), TRUNC(34.345, -1), TRUNC(34.64145345) FROM DUAL;

----------

-- MOD 함수는 나누기 연산을 한 후에 구한 몫이 아닌 나머지를 결과로 되돌려주는 함수
SELECT MOD(27,2), MOD(27,5), MOD(27,7) FROM DUAL;


-- 1. 사번이 홀수인 사람들을 검색
SELECT * FROM EMP WHERE MOD(EMPNO,2) = 1;













