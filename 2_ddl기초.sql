
-- NewBook 테이블 삭제
DROP TABLE NewBook;

-- NewBook 테이블 생성
CREATE TABLE NewBook (
    bookid      NUMBER, -- 기본키는 not null 
    bookname    VARCHAR2(20), -- null가능함. 특별한 제약조건 없음.
    publisher   VARCHAR2(20),
    price       NUMBER,
    PRIMARY KEY (bookid) -- PRIMARY KEY를 bookid로 생성
);

CREATE TABLE NewBook (
    bookname    VARCHAR(20)     NOT NULL,
    publisher   VARCHAR(20)     UNIQUE,
    price       NUMBER          DEFAULT 10000 CHECK(price > 1000),
    PRIMARY KEY   (bookname, publisher)
);
     -- PRIMARY KEY에 들어가는 속성이 여러개면 반드시 별도의 PRIMARY KEY(키, 키, 키)를 선언해야함.


SELECT  *   FROM    NewBook;

