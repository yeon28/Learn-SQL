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



