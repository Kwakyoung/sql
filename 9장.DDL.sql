-- 9��. DDL

-- Data Definition Language , ����Ʈ���̽� ���Ǿ�
-- [-----������------]  [---DBA(�����ͺ��̽� ������)---]
-- 1) ���̺� ���� 2)�� 3)�ε��� 4)�ó��(=ȣ) 5)Ŭ������ .... : �����ͺ��̽� ��ü

-- 9.1 ������ Ÿ�� ==> �����ͺ��̽��� ���̺� �÷� ���� �ڷ���, ����(Bytes)��
-- ���� ���� ����ϴ� �ڷ���
-- 1) ������ : �������� ������, �������� ������(=����ó�� �ð� �ִ� ����� �ƴ�!) VARCHAR2
-- 2) ������ : ����, �Ǽ�
-- 3) ��¥�� : ��¥
-- �� NLS ������ ���� �ٸ�
-- ���� > ȯ�漳�� > NLS �Ǵ�

SELECT  *
FROM    v$nls_parameters;

-- ���ڿ��� bytes�� �˷��ִ� �Լ� : LENGTHB()
SELECT  LENGTHB('a') AS ENG_CHAR,
        LENGTHB('��')
FROM    dual;

-- 9.1.1 ����(��)�� ������
-- �������� : char(����Ʈ ��) ==> char(5) : 5 bytes ���ڿ� �����ϴ� �÷��� ���̸� ����
-- �������� : varchar2(����Ʈ ��) ==> varchar2(5) :
-- �� 5byte �÷��� 3byte �Է��ϸ� ==> 2byte ��ȯ x, �����Ͱ� ����� ������ ����Ŭ�� �����ϴ� ��ȣ�� ����
-- varchar : 21c ������ varchar Ÿ�� ==> ����Ŭ�� ���߿� ����ϰų� �ٸ� �뵵�� �������� �����
-- ����Ŭ23c ���� ����Ǿ������� ���� Ȯ������ ���� (23.05.19 ������� 23c �ٿ�ε� ��ũ�� ���� �������� �ʾ���)

-- 9.1.2 ������ ������
-- NUMBER(n) : ���� N����Ʈ ���̷� ����
-- NUMBER(p, s) : ��ü���� p, ���� p-s ����, �Ҽ� s ���̷� ����
-- NUMBER(5,2) : ��ü���� 5, ���� 3, �Ҽ� 2

-- INT �÷����� ==> ����Ŭ�� ==> NUMBER�� �����ع���..
-- BIGINT ==> NUMBER
-- DOUBLE ==> NUMBER

-- 9.1.3 ��¥�� ������
-- DATE Ÿ�� , ��¥�� �ð� ������ ���´�.
SELECT  SYSDATE,
        TO_CHAR(SYSDATE, 'YYYY-MM-DD HH:MI:SS') AS DATE2
FROM    dual;


-- DDL : �����ͺ��̽� ��ü�� ����(����, ����)�ϴ� ��ɾ� : CREATE, ALTER, DROP, TRUNCATE
-- DDL�� �ڵ����� Ŀ������ �̷�� ���� : ������ (X) VS DBA (O)
-- TRUNC(number | date) : (�Ҽ��� ����) ������ �Լ�(����, ��¥)

/* ============ ���̺� ���� ��Ģ : �����ͺ��̽� ��ü ���� ��Ģ ===============
        1) �ݵ�� ���ڷ� �����Ѵ�
        2) ���� + ���� Ȱ��
        3) �ִ� 30����Ʈ
        4) ����Ŭ ���� ����� �� ���� ==> CREATE TABLE TABLE <- �������̸��̶� �ȉ�
*/

-- 9.2 ���̺� ���� CREATE
-- 9.3 ���̺� ���� ���� ALTER
-- 9.4 ���̺� ���� DROP
-- 9.5 ���̺� ������ ���� TRUNCATE (������ �����, �����ʹ� ����)





-- 9.2 ���̺���� CREATE
-- ex> ȸ���� ������ �����ϴ� ���̺� ���� 
--   ������ �𵨸� - ���伳�� :   ��� <----> �̸�    ,  ����ó  , �̸���, ...
--            "    - ������ : MEMBERS     name(20) , phone(30), email(50)
--                 - �������� : CREATE TABLE MEMBERS ( name varchar2(20), ...);

-- 1. SQL ���� : DDL
CREATE TABLE ���̺�� (
        �÷���1 ������Ÿ��,
        �÷���2 ������Ÿ��,
        ... ��� ...
);

[����9-1] 3 byte ���� id �÷�, 20byte ���� fname �÷����� �̷���� TMP ���̺� �����Ͻÿ�
CREATE TABLE tmp (
    id NUMBER(3),
    fname VARCHAR2(20)
    );

-- ����� ���̺� : �����ͺ��̽� ��ü ���� ==> ������ ����, ��ųʸ� ��ȸ
SELECT  *
FROM    dict; -- �Ǵ� dictionary


-- USER_ : ����� ���� / ����
-- ALL_ : ������~
-- DBA_ : ������ ���� / ����

[����9-2] tmp ���̺� ȫ�浿�� �̼����� �����͸� �����Ͻÿ�
INSERT INTO tmp (id, fname)
VALUES (1, 'ȫ�浿');
INSERT INTO tmp (fname, id)
VALUES ('�̼���', 2);

SELECT *
FROM tmp;

COMMIT;

[����9-3] id�� 1���� ����� name �÷��� �����͸� ȫ�浿 ==> ȫ���� �����Ͻÿ�
UPDATE  tmp
SET fname = 'ȫ��'
WHERE   id = 1;


-- 2. �׷��� : ���� > ������(HR) > ���̺� - ���콺 ��Ŭ�� > ���̺� > ����..
-- Ű���� AS�� ���������� �����, �̹� �ִ� ���̺��� �����Ͽ� �����ϴ� ���·� ���̺� ���� : CTAS

--                       "                    "                             ���̺� ������ ���� : ITAS


[����9-4] �μ� ���̺� �����͸� �����Ͽ� dept1 ���̺�� ����(=����)�Ѵ�.
CREATE TABLE dept1 AS
SELECT  *
FROM    departments; -- �÷�, �ڷ���, �����ͱ��� �����ϵ���!! [����/������=> ����]

-- ��ȸ
SELECT  *
FROM    dept1;

-- ���̺� ����, �÷��� | �ڷ���
DESC dept1;

[����9-5] ��� ���̺��� 20�� �μ��� �Ҽӵ� ����� ���, �̸�, �Ի��� �÷��� �����͸� �����Ͽ� emp20 ���̺��� �����Ѵ�.

CREATE TABLE    emp20 AS
SELECT employee_id, first_name, hire_date
FROM    employees
WHERE   department_id = 20;

-- ��ȸ
SELECT  *
FROM    emp20;

[����9-6] �μ� ���̺��� ������ ���� dept2 ���̺��� �����Ͽ� �����Ͻÿ�
-- ��ġ�ϴ� ������ �����Ͱ� ���� ��� ==> dept2 ���̺� ����:OK , ������:NO
-- CTAS�� WHERE ������ �������� �ָ� �÷���, ������Ÿ���� ���������� �����ʹ� ����
CREATE TABLE dept2 AS
SELECT  *
FROM    departments
WHERE   1 = 2;

-- ��ȸ
SELECT  *
FROM    dept2;





-- 9.3 ���̺� ���� ���� ALTER
-- �� ���̺� ���� �����Ͱ� ������ ==> �����Ұ�! , ���� ���� ������ �����ҷ��� �Ҷ�~
-- 9.3.1 �÷� �߰� : ������?�� NULL ä����
-- ���� ���̺� ���ο� �÷��� �߰��ϴ� ����
ALTER TABLE ���̺��
ADD (�÷���1 �ڷ���, �÷���2 �ڷ���(����)...)

[����9-7] emp20 ���̺� ����Ÿ�� �޿� �÷�(salary), ����Ÿ�� �����ڵ�(job_id) �÷��� �߰��Ѵ�.
DESC emp20;

ALTER TABLE emp20
ADD (salary NUMBER, job_id VARCHAR2(30));

SELECT *
FROM    emp20;

-- 9.3.2 �÷� ���� ( �̸�, ����, �ڷ���, �������� ), ������ ���ǰ��ɼ�
-- �÷���, ������ Ÿ��, ũ�⸦ �����ϴ� ����
ALTER TABLE ���̺��
MODIFY (�÷���1 ������Ÿ��, �÷���2 ������Ÿ��, ... )

-- ���̺��� �̸��� ����
ALTER TABLE ���̺��
RENAME COLUMN ������ ���̺�� TO ����� ���̺��

ALTER TABLE EMP
RENAME  COLUMN  fname TO first_name;

[����9-8] emp20 ���̺��� salary �÷��� job_id �÷��� ������ ũ�⸦ ���� �����Ѵ�.
-- ���� : salary NUMBER --> NUMBER(8,2), job_id VARCHAR2(5) --> 10 byte
ALTER TABLE emp20
MODIFY  (salary NUMBER(5,3) , job_id VARCHAR2(10)); 
-- ORA-01440: ���� �Ǵ� �ڸ����� ����� ���� ��� �־�� �մϴ�.

INSERT INTO emp20
VALUES (203,'Steve',SYSDATE,10000,'SA_MAN');


-- 9.3.3 �÷� ����
ALTER TABLE ���̺��
DROP COLUMN �÷���;

[����9-9] emp20 ���̺��� �����ڵ� �÷� job_id�� �����Ͻÿ�
ALTER TABLE emp20
DROP COLUMN job_id;

ROLLBACK; -- DDL : CREATE, ALTER, DROP, TRUNCATE --> �ڵ� COMMIT; 







-- 9.4 ���̺� ���� DROP ==> ������ �ϴ� �Ű�����, �ʿ�� ����(=FLASH BACK)
-- ���̺��� �� �����Ϳ� ������ �����ϴ� ���� : DROP TABLE
-- ���̺��� �� �����͸� �����ϰ� ������ ����� ���� : TRUNCATE TABLE ���̺��;
DROP TABLE ���̺��;

DROP TABLE emp20;

-- ���� �ȵǰ� ���̺� ����
DROP TABLE ���̺�� PURGE 







-- 9.5 ���̺� ������ ���� TRUNCATE (������ �����, �����ʹ� ����)
TRUNCATE TABLE tmp2;  -- �����ʹ� ��������, ���̺�� �÷�, �ڷ����� ���Ǵ� ����

SELECT  *  
FROM    tmp2;

truncate table tmp2; -- �����ʹ� ��������, ���̺�� �÷�, �ڷ����� ���Ǵ� ����

DESC tmp2;