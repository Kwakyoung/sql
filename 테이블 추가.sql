-- ���� , ���� , ����
-- DML ( DATA MANIPULATION LANGUAGE ) - INSERT , UPDATE , DELETE ( SELECT )
-- CRUD ( WEB���� �⺻ 4���� ������ ��� CRUD��� ǥ���� �Ѵ� )
-- DDL ( Data Definition Language ) - CREATE , ALTER , DROP ( ���̺��� �����ϰ� , �����ϰ� , ���� )

-- JAVA (JDBC) -> (SQL)DBMS : �������ִ� -> DB(Exceló�� ���常 �ϴ� â��)

SELECT 1 FROM dual;
-- KEY �����ͺ��̽��� ����ȭ ������ ��ġ�µ� �� �� �����͸� �ϳ��� ���� �Ǵ� �����ϰ� �Ҽ��ְ� ���ִ�
-- �ĺ��� ( ������� ġ�� �� �ĺ��� : �ֹε�Ϲ�ȣ , �� �ĺ��� : �θ���� �ֹε�Ϲ�ȣ �� ���� )

-- NUMBER(int), VARCHAR2(String), NVARCHAR2(String)
CREATE TABLE KYG (  -- String col1 , col4; int col2;
    COL1 VARCHAR2(1000),
    COL2 NUMBER,
    COL3 VARCHAR2(1000),
    COL4 VARCHAR2(1000),
    COL5 VARCHAR2(1000)
);              -- ���̺� ����

--DROP TABLE KYG; -- ���̺� ����

INSERT INTO KYG (COL1, COL2, COL3, COL4, COL5) VALUES ('��ȣ��1', '1', '1000', 'D', 'E');
INSERT INTO KYG (COL1, COL2, COL3, COL4, COL5) VALUES ('��ȣ��2', '1', '10000', 'D', 'E');
INSERT INTO KYG (COL1, COL2, COL3, COL4, COL5) VALUES ('��ȣ��A', '1', 'C', '10000', 'E');
COMMIT;
-- ��� �۾��� ��� �͵��� �ǵ�����. ( ROLLBACK ) ; ROLLBACK �Ǵ� COMMIT�� �Ҷ��� �����ϰ� �Ѵ�.
-- ��� �۾��� ���� Ȯ�� ( COMMIT ) ;
-- Ʈ����� : ��� �۾��� �ּ��� ���� : DBMS�� �۾��� �س��� Ȯ���Ҳ����� ��ٸ��� ����.
SELECT * FROM KYG;

ROLLBACK;

UPDATE KYG SET COL1 = '��ȣ��ٲ�' WHERE COL3='10000';
COMMIT;

DELETE FROM KYG;

-- DATA TYPE : NUMBER (int) , VACHAR2 (String)
-- CREATE TABLE ���̺��̸� (
-- �÷��̸� ������Ÿ��(ũ��)  , <- �÷��� ��������� �޸��� �������� �÷� �̸� ������Ÿ�Ժκ��� �ݺ�
-- );
ROLLBACK;
DROP TABLE KOREA_PEOPLE;
CREATE TABLE KOREA_PEOPLE (
    JUMIN_NUM NUMBER PRIMARY KEY, -- PRIMARY KEY << �ߺ��Ǹ� �ȵǴ� ������ (key,�ĺ���)�� �ǹ���. 
    NAME VARCHAR2(20),
    GENDER NUMBER
);
INSERT INTO KOREA_PEOPLE (JUMIN_NUM, NAME, GENDER) VALUES ('2', '�̸�', '2');

SELECT * FROM korea_people;

COMMIT;
-- ��ȣ�� : �ҳ���, �ָ޴� : ��� , �ּ� : ~~~ 
-- ���� ���������� ���п��� ������ �����͸� ���� DB�� ������ �ϰ�ʹٸ� ��� �ؾ��ұ�?
-- �ش� ������ ������ ���̺��� �����, INSERT���� �̿��ؼ� �����͸� �־�� (2��)

CREATE TABLE GWANGJU_MATZIP (
    TITLE VARCHAR2(100) ,
    Main_Menu VARCHAR2(100),
    Phone_Num NUMBER,
    Business_Num NUMBER PRIMARY KEY
);
INSERT INTO GWANGJU_MATZIP (TITLE, MAIN_MENU, PHONE_NUM, BUSINESS_NUM) VALUES ('����', '��¥��', '01034481720', '123456781');
INSERT INTO GWANGJU_MATZIP (TITLE, MAIN_MENU, PHONE_NUM, BUSINESS_NUM) VALUES ('��ī��ī��', 'ũ��ī��', '01034481720', '411129590');

SELECT * FROM GWANGJU_MATZIP;
COMMIT;

DROP TABLE KYG;
COMMIT;

