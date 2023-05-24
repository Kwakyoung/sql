-- 테이블 만드는 법, 키
-- 테이블 만들기 : 테이블명 => CUSTOMER
-- ID는 숫자형태로 데이터를 식별할수있는 유일한 키값
-- NAME 사람의 이름을 저장함 ( NULL 아님 )
-- GENDER는 성별을 저장하며 기본적으로 나의 성별이 들어가있음 NULL 아님
-- EAMIL
-- PHONE
DROP TABLE customer;
-- 다국어 처리나 데이터의 길이가 중요한경우 => NVARCHAR2 사용
CREATE TABLE customer (
    ID      NUMBER PRIMARY KEY,
    NAME    NVARCHAR2(20) NOT NULL,
    GENDER  NVARCHAR2(1) DEFAULT '남' CHECK ( GENDER IN ('남','여')) NOT NULL,
    EMAIL   VARCHAR2(50),
    PHONE   VARCHAR2(15)
);

SELECT *
FROM customer;

INSERT INTO customer
VALUES ('1' ,'곽영균','남','rhkrdudrbs13@naver.com','01034481720');
INSERT INTO customer
VALUES ('2' ,'김영균','여','rhkrdudrbs13@naver.com','01034481720');
INSERT INTO customer
VALUES ('3' ,'박영균','남','rhkrdudrbs13@naver.com','01034481720');
INSERT INTO customer
VALUES ('4' ,'최영균','여','rhkrdudrbs13@naver.com','01034481720');
INSERT INTO customer
VALUES ('5' ,'이영균','남','rhkrdudrbs13@naver.com','01034481720');

SELECT *
FROM    CUSTOMER
WHERE   ID = 1; --? <-

COMMIT;


SELECT * FROM customer
  		WHERE ID BETWEEN 2 AND 4;




