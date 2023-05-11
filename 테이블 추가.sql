-- 정의 , 조작 , 제어
-- DML ( DATA MANIPULATION LANGUAGE ) - INSERT , UPDATE , DELETE ( SELECT )
-- CRUD ( WEB에서 기본 4가지 로직을 묶어서 CRUD라고 표현을 한다 )
-- DDL ( Data Definition Language ) - CREATE , ALTER , DROP ( 테이블을 생성하고 , 삭제하고 , 수정 )

-- JAVA (JDBC) -> (SQL)DBMS : 번역해주는 -> DB(Excel처럼 저장만 하는 창고)

SELECT 1 FROM dual;
-- KEY 데이터베이스가 정규화 과정을 거치는데 그 때 데이터를 하나로 묶고 또는 구분하고 할수있게 해주는
-- 식별자 ( 사람으로 치면 주 식별자 : 주민등록번호 , 부 식별자 : 부모님의 주민등록번호 와 같은 )

-- NUMBER(int), VARCHAR2(String), NVARCHAR2(String)
CREATE TABLE KYG (  -- String col1 , col4; int col2;
    COL1 VARCHAR2(1000),
    COL2 NUMBER,
    COL3 VARCHAR2(1000),
    COL4 VARCHAR2(1000),
    COL5 VARCHAR2(1000)
);              -- 테이블 생성

--DROP TABLE KYG; -- 테이블 삭제

INSERT INTO KYG (COL1, COL2, COL3, COL4, COL5) VALUES ('상호명1', '1', '1000', 'D', 'E');
INSERT INTO KYG (COL1, COL2, COL3, COL4, COL5) VALUES ('상호명2', '1', '10000', 'D', 'E');
INSERT INTO KYG (COL1, COL2, COL3, COL4, COL5) VALUES ('상호명A', '1', 'C', '10000', 'E');
COMMIT;
-- 방금 작업한 모든 것들을 되돌리다. ( ROLLBACK ) ; ROLLBACK 또는 COMMIT을 할때는 신중하게 한다.
-- 방금 작업한 모든것 확정 ( COMMIT ) ;
-- 트랜잭션 : 디비 작업에 최소의 단위 : DBMS가 작업을 해놓고 확정할껀지를 기다리는 상태.
SELECT * FROM KYG;

ROLLBACK;

UPDATE KYG SET COL1 = '상호명바꿈' WHERE COL3='10000';
COMMIT;

DELETE FROM KYG;

-- DATA TYPE : NUMBER (int) , VACHAR2 (String)
-- CREATE TABLE 테이블이름 (
-- 컬럼이름 데이터타입(크기)  , <- 컬럼이 여러개라면 콤마를 기준으로 컬럼 이름 데이터타입부분이 반복
-- );
ROLLBACK;
DROP TABLE KOREA_PEOPLE;
CREATE TABLE KOREA_PEOPLE (
    JUMIN_NUM NUMBER PRIMARY KEY, -- PRIMARY KEY << 중복되면 안되는 데이터 (key,식별자)를 의미함. 
    NAME VARCHAR2(20),
    GENDER NUMBER
);
INSERT INTO KOREA_PEOPLE (JUMIN_NUM, NAME, GENDER) VALUES ('2', '이름', '2');

SELECT * FROM korea_people;

COMMIT;
-- 상호명 : 소나무, 주메뉴 : 고기 , 주소 : ~~~ 
-- 내가 공공데이터 포털에서 가져온 데이터를 나의 DB에 저장을 하고싶다면 어떻게 해야할까?
-- 해당 내용을 가지고 테이블을 만들고, INSERT문을 이용해서 데이터를 넣어보기 (2건)

CREATE TABLE GWANGJU_MATZIP (
    TITLE VARCHAR2(100) ,
    Main_Menu VARCHAR2(100),
    Phone_Num NUMBER,
    Business_Num NUMBER PRIMARY KEY
);
INSERT INTO GWANGJU_MATZIP (TITLE, MAIN_MENU, PHONE_NUM, BUSINESS_NUM) VALUES ('연경', '간짜장', '01034481720', '123456781');
INSERT INTO GWANGJU_MATZIP (TITLE, MAIN_MENU, PHONE_NUM, BUSINESS_NUM) VALUES ('유카이카레', '크림카레', '01034481720', '411129590');

SELECT * FROM GWANGJU_MATZIP;
COMMIT;

DROP TABLE KYG;
COMMIT;

