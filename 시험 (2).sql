-- ���̺� ����� ��, Ű
-- ���̺� ����� : ���̺�� => CUSTOMER
-- ID�� �������·� �����͸� �ĺ��Ҽ��ִ� ������ Ű��
-- NAME ����� �̸��� ������ ( NULL �ƴ� )
-- GENDER�� ������ �����ϸ� �⺻������ ���� ������ ������ NULL �ƴ�
-- EAMIL
-- PHONE
DROP TABLE customer;
-- �ٱ��� ó���� �������� ���̰� �߿��Ѱ�� => NVARCHAR2 ���
CREATE TABLE customer (
    ID      NUMBER PRIMARY KEY,
    NAME    NVARCHAR2(20) NOT NULL,
    GENDER  NVARCHAR2(1) DEFAULT '��' CHECK ( GENDER IN ('��','��')) NOT NULL,
    EMAIL   VARCHAR2(50),
    PHONE   VARCHAR2(15)
);

SELECT *
FROM customer;

INSERT INTO customer
VALUES ('1' ,'������','��','rhkrdudrbs13@naver.com','01034481720');
INSERT INTO customer
VALUES ('2' ,'�迵��','��','rhkrdudrbs13@naver.com','01034481720');
INSERT INTO customer
VALUES ('3' ,'�ڿ���','��','rhkrdudrbs13@naver.com','01034481720');
INSERT INTO customer
VALUES ('4' ,'�ֿ���','��','rhkrdudrbs13@naver.com','01034481720');
INSERT INTO customer
VALUES ('5' ,'�̿���','��','rhkrdudrbs13@naver.com','01034481720');

SELECT *
FROM    CUSTOMER
WHERE   ID = 1; --? <-

COMMIT;


SELECT * FROM customer
  		WHERE ID BETWEEN 2 AND 4;




