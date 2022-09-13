-- INSERT실습
INSERT INTO Book(bookid, bookname, publisher, price)
VALUES (11, '스포츠 의학', '한솔의학서적', 90000);

-- INSERT(생성)할 때, 모든 속성 값을 사용할 필요 없음.
-- 단, primary key와 not null , unique등 속성 값을 필수로 넣어야 하는 경우엔 속성 값을 지정해야함.
INSERT INTO Book(bookid, bookname, publisher)
VALUES (14, '스포츠 의학2', '한솔의학서적');

INSERT INTO Book
VALUES (16, '스포츠 의학3', '한솔의학서적' ,13000);

INSERT INTO Book(bookname, bookid, publisher, price)
VALUES ('스포츠 의학4', 17, '한솔의학서적', 90000);

SELECT * FROM book;

ROLLBACK;

-- UPDATE실습

-- UPDATE문 사용시  반드시 where조건문을 사용해야함
-- -> 사용하지 않으면 모든 행의 속성값을 변경함.

-- 질의 3-47 Customer 테이블에서 고객번호가 5인 고객의 주소를 ‘대한민국 부산’으로 변경하시오.
UPDATE  Customer
SET     address='대한민국 부산'
WHERE   custid=5;


-- 질의 3-48 Customer 테이블에서 박세리 고객의 주소를 김연아 고객의 주소로 변경하시오.
UPDATE  Customer
SET     address = (SELECT   address
                FROM    Customer
                WHERE   name='김연아')
WHERE   name LIKE '박세리';

SELECT * FROM customer;

ROLLBACK;

-- DELETE실습

-- 질의 3-49 Customer 테이블에서 고객번호가 5인 고객을 삭제하시오.
DELETE  FROM  Customer
WHERE   custid=5;

SELECT * FROM customer;

ROLLBACK;









