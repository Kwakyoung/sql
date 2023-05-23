-- 10��. ��������



-- ���Ἲ �������� : (Integrity Constraints) : �������� ��Ȯ���� �����ϱ� ���� �δ� ����/���� ����
-- 1) ���̺� ������ ���� : CREATE TABLE ~
-- 2) ���̺� ���� �� �߰� : ALTER TABLE ~




-- 10.1 NOT NULL �������� - NULL ������� ����
-- �÷��� ������ ���� �־� NULL ������� ���� ==> �ݵ�� �����͸� �Է��ؾ� �Ѵ�.
-- �� ���̺� ������ �÷� �������� �����Ѵ�
-- ex> ���̺� ���� ����
CREATE TABLE ���̺��(
    �÷���1 ������Ÿ��(����) ��������, -- �÷� ����
    �÷���2 ������Ÿ��(����)
);

CREATE TABLE user(
    id VARCHAR2(20) NOT NULL, -- �÷� ����
    nick VARCHAR2(20)
);

[����10-1] null_test ��� ���̺��� �����ϵ� �÷��� col1 ����Ÿ�� 5����Ʈ ����,NULL ��������ʰ�,
col2 ����Ÿ�� 5����Ʈ ���̷� �����Ͻÿ�~

-- 1) ���̺� ���� : null_test + not null
CREATE TABLE NULL_TEST(
    col1 VARCHAR2(5) NOT NULL,
    col2 VARCHAR2(5)
);

INSERT INTO null_test (col1)
VALUES ('AA'); -- AA | (null)

-- ��ȸ
SELECT  *
FROM NULL_TEST;

[����10-3] BB�� col2�� ����
INSERT INTO null_test (col2)
VALUES ('BB'); -- col1 NOT NULL ��������
-- ORA-01400: NULL�� ("HR"."NULL_TEST"."COL1") �ȿ� ������ �� �����ϴ�

-- 2) ���̺� ���� �� NOT NULL ����
-- �÷��� NULL �����Ͱ� ���� ���, NOT NULL�� �߰��� �� �ִ�.

UPDATE null_test
SET col2 = 'BB'; -- col2 �÷��� �����͸� null���� 'BB'�� ����

-- null_test�� �̹� BB�� col2 �÷��� �ִ� ����
[����10-4]
ALTER TABLE null_test
MODIFY  (col2 NOT NULL);

[����10-5] col2�� NULL�� �ٲپ�� ==> ���������� �߰��Ǿ�����, �����߻�!
-- col2�� NOT NULL�� �߰� ==> �����͸� NULL
UPDATE null_test
SET col2 = NULL; -- �����߻�

-- �ٽ� col2 �÷��� NULL ���
ALTER TABLE null_test
MODIFY (col2 NULL); -- col1, col2 ��� �����Ͱ� �ִ� <--> NULL�� �ƴϹǷ�

COMMIT;

-- ============ ����� �������� ������ (���̺���) ���������� ��� ��ϵ� ������ ���̺� ��ü ==============================
SELECT  constraint_name, constraint_type, owner
FROM    user_constraints
WHERE   table_name = 'NULL_TEST'; 






-- 10.2 CHECK �������� - ���� ���� (p.80)
-- ���ǿ� �´� �����͸� ������ �� �ֵ��� �ϴ� ���������̴�.
-- �÷� ����, ���̺������� �����Ѵ�.

[���� 10-6] 
CREATE TABLE    check_test (
    name VARCHAR2(10) NOT NULL, -- �÷� ����
    gender VARCHAR2(10) NOT NULL CHECK (gender IN ('����', '����' , 'male' , 'female' , 'man' , 'woman')),
    salary  NUMBER(8),
    dept_id NUMBER(4),
    CONSTRAINT  check_salary_ck CHECK (salary > 2000) -- ���̺� ����
                         -- ck = check 
);

-- ���̺��_�÷���_�������� ��� (NN:NOT NULL, CK:CHECK, PK:PRIMARY KEY, FK:FOREIGN, UK:UNIQUE KEY)

--���� �� ��Ģ ��ȸ
SELECT  constraint_name, constraint_type, search_condition
FROM    user_constraints
WHERE   table_name = 'CHECK_TEST';

[���� 10-7] �����͸� check_test ���̺� �����غ��ÿ�

INSERT INTO check_test 
VALUES('ȫ�浿', '����' , 3000 , 10); 

[����10-9]
UPDATE  check_test
SET salary = 2000   
WHERE   name = 'ȫ�浿';  --���� ���� > ORA-02290: üũ ��������(HANUL.CHECK_SALARY_CK)�� ����Ǿ����ϴ�


-- II. ���̺� ���� �� �������� �߰�/����
[����10-10]
-- DDL : CREATE, ALTER, DROP
--        ����,  ���� , ����
-- check_test�� �ɸ� ���������� Ȯ���ϰ�, �׷����� ���� �ߴٰ� �ٽ� �߰��ϴ� SELECT  constraint_name, constraint_type, search_condition
SELECT  constraint_name, constraint_type, search_condition
FROM    user_constraints
WHERE   table_name = 'CHECK_TEST';
/*
SYS_C008365	C	"NAME" IS NOT NULL
SYS_C008366	C	"GENDER" IS NOT NULL
SYS_C008367	C	gender IN ('����', '����' , 'male' , 'female' , 'man' , 'woman')
CHECK_SALARY_CK	C	salary > 2000
*/

-- ����
ALTER TABLE check_test
DROP CONSTRAINT check_test_salary_ck;  -- �������� �� Ȯ��

-- �ٽ��߰�
[����10-11]
ALTER TABLE check_test
ADD CONSTRAINT check_salary_dept_ck CHECK (salary BETWEEN 2000 AND 10000 AND dept_id IN (10,20,30));

SELECT  *
FROM    check_test;

[����10-12]
UPDATE check_test
SET salary = 12000
WHERE  name='ȫ�浿';









-- 10.3 UNIQUE �������� - �ߺ�����
-- �����Ͱ� �ߺ����� �ʵ��� ���ϼ��� �����ϴ� ��������
-- �÷� ����, ���̺� �������� ����
-- �� ����Ű(Composite)�� ������ �� �ִ� ��  ��) ���� ��� vs ���+�̸�

-- ���̺� ������ UNIQUE ����
-- I. �÷����� ����
[����10-13]
CREATE TABLE    unique_test (
    col1    VARCHAR2(5) UNIQUE NOT NULL,
    col2    VARCHAR2(5),
    col3    VARCHAR2(5) NOT NULL,
    col4    VARCHAR2(5) NOT NULL,
    CONSTRAINT uni_col2_uk UNIQUE (col2),
    CONSTRAINT uni_col34_uk UNIQUE (col3, col4) -- ���� Ű : �� �̻��� �÷��� ����
);

 

[����10-14] �ߺ����� �����ϴ��� �Է� �׽�Ʈ
INSERT INTO unique_test 
VALUES  ('A1','B1','C1','D1');

SELECT  *
FROM    unique_test;

INSERT INTO unique_test
VALUES ('A','B2','C2','D2');

[����10-10] ������Ʈ �׽�Ʈ --> �ߺ��� ������ --> �������ǿ� ���� ���� �߻�!
UPDATE  unique_test
SET col1='A1'
WHERE   col1='A2';


[����10-16] ������ �Է� �׽�Ʈ --> �ߺ��� Ȯ��
INSERT INTO unique_test
VALUES ('A3','','C3','D3'); -- col2, '' ��� NULL ����ϴ°� ���������鿡���� ����

INSERT INTO unique_test
VALUES ('A4','NULL','C4','D4');

INSERT INTO unique_test
VALUES ('A4','NULL','C5','D5'); -- A4�� �ִ� �� : ORA-00001: ���Ἲ ���� ����(HANUL.SYS_C008373)�� ����˴ϴ�


-- II. ���̺� ���� ����
-- ���̺� ���� �� UNIQUE �߰�/���� : ������ �ۼ��� UNIQUE ���� --> �߰�

-- ������ ���� :
SELECT  *
FROM    dict;

SELECT  constraint_name, constraint_type
FROM    user_constraints
WHERE   table_name='UNIQUE_TEST';

[����10-18] UNI_COL34_UK ���������� �����ϰ� col2,col3,col4�� UNIQUE ����Ű�� �����ϴ�!
ALTER TABLE unique_test
DROP    CONSTRAINT UNI_COL34_UK;

[���� 10-19] UNI_COL234_UK �������� �߰�
ALTER TABLE  unique_test
ADD CONSTRAINT UNI_COL234_UK UNIQUE (col2,col3,col4);

SELECT  *
FROM    unique_test;


[����10-20]
INSERT INTO unique_test
VALUES ('A7',NULL,'C4','D4');













-- 10.4 PRIMARY KEY ��������
-- ������ ��(ROW)�� ��ǥ�ϵ��� �����ϰ� �ĺ��ϱ� ���� ��������
-- UNIQUE + NOT NULL�� ����
-- �⺻Ű, �ĺ���, �� Ű, PK�� �Ѵ�.
-- �÷�����, ���̺������� ���� �ں���Ű�ٸ� ������ �� �ִ�.
-- ��) ��� - �ֹι�ȣ (= ����Ű), ȸ��� - �����ȣ

-- I. �÷����� ����
�÷��� ������ Ÿ�� PRIMARY KEY : ��� --> SYS_C008XXX
�÷��� ������ Ÿ�� CONSTRAINT �������Ǹ� PRIMARY KEY --> ���̺��_�÷���_�������Ǿ�

-- II. ���̺��� ����
CONSTRAINT ���̺��_�÷���_�������Ǿ�� PRIMARY KEY (�÷���)
            member_id_pk                            (id)

CREATE TABLE member (
    id  VARCHAR(10) PRIMARY KEY,  -- �÷� ����
    name,
    email,
    phone
    CONSTRAINT member_id_pk PRIMARY KEY (id) -- ���̺� ����
);

[����10-21] dept_test ���̺��� �����ϰ� dept_id,dept_name �÷� ���� ���� 4����Ʈ ,�������� 30����Ʈ��
������ �����ϵ� dept_name�� null�� ������� �ʰ�, dept_id�� �⺻Ű�� �����ϴ� ������ �ۼ��Ͻÿ�

CREATE TABLE   dept_test (
    dept_id NUMBER(4) PRIMARY KEY,
    dept_name VARCHAR2(30) NOT NULL
--  CONSTRAINT dept_test_dept_id_pk PRIMARY KEY (dept_id) 
);

SELECT  constraint_name, constraint_type
FROM    user_constraints
WHERE   table_name = 'DEPT_TEST';

[����10-22] 10�� �μ�, �μ����� ������ �����͸� �Է��Ͻÿ�
INSERT INTO dept_test
VALUES  (10, '������'); -- �Ϸ�

INSERT INTO dept_test
VALUES  (10, '���ߺ�'); -- PK��(dept_id) �ߺ��Ǿ� ���� ����

-- ���̺� ���� �� PK (�߰�) ����
-- �ϴ� ���� ����
ALTER TABLE dept_test
DROP  CONSTRAINT dept_test_id_pk;


INSERT INTO dept_test
VALUES (20,'���ߺ�');

UPDATE  dept_test
SET dept_id = 10
WHERE   dept_name='���ߺ�'; --ORA-00001: ���Ἲ ���� ����(HANUL.SYS_C008378)�� ����˴ϴ�








-- 10.5 FOREIGN KEY �������� - �ܷ�Ű
-- �θ� ���̺��� �÷��� �����ϴ� �ڽ� ���̺긣�� �÷���, �������� ���Ἲ�� �����ϱ� ���� �����ϴ� ��������
-- NULL ��� <--> UNIQUE : �ߺ�����, NULL ���
-- ����Ű, �ܷ�Ű, FK
-- �÷�����  �� ����Ű �ڸ� ������ �� �ִ�.

-- �÷��� ������ Ÿ�� REFERENCES �θ����̺� (�����Ǵ� �÷���)
-- �÷��� ������ Ÿ�� CONSTRAINT �������Ǹ� REFERENCES �θ����̺� (�����Ǵ� �÷���)

-- ���̺������� ����
-- CONSTRAINT ���̺��_�������Ǹ�_�������Ǿ�� FOREIGN KEY (�����ϴ� �÷���) REFERENCES �θ����̺� (�����Ǵ� �÷���)
-- ���̺�� ���̺��� ���迡 ����...
-- ��� ���� ���̺� <--> �μ� ���� �Ĥ��̺�
-- ����� �μ��� �Ҽӵȴ� (=����) N : 1     [1:��] ���� : RDBMS���� �� ���� �⺻����!
-- �μ��� ����� �����Ѵ� (=����  1 : N     [��:��], [M:N] ���� : ����ȭ -> ���� �ؼ� -> 1,2,3
-- HR ��Ű�� ==> ���� �Ը��� �����ͺ��̽� ==> ���ʿ� ����� ���̺� ����

-- ������� ==> employees (���̺�)
-- �̸�, ���(PK), �޿�, �̸���, �μ��ڵ�(FK) ==> first_name, employee_id, salary (�÷�) 
-- �μ����� ==> departments (���̺�)
-- �μ��ڵ�(PK), �μ���, ��ġ�ڵ� ==> �÷�

-- ������ �𵨸� : �𵨷� ==> ���̺� ����, �÷�, �������� ����

-- ���θ� ���� : ���θ� ���� �ľ� (��-��ǰ �ֹ�, ����   ȸ��-��ǰ ����, �߼�..)
-- ���伳�� : ���� ���� �߿� Ű���带 ���� ==> ����Ƽ(=��ü), �÷�(=Ư��) ..... 
-- ������ : Entity Relational Diagram (ERD) ==> �׸����� ��ü, Ư��, ���踦 ǥ���ϴ� ����
-- �������� : CREATE TABLE~ ALTER TABLE~ INSERT INTO~

 
-- < I. ���伳�� >
-- �� ������ ��� ���̺� : CUSTOMERS (�� ID, ����, ����ó..)
-- ��ǰ ������ ��� ���̺� : ITEMS (��ǰ ID, ��ǰ��, ����..) 

-- < II. ������ >
-- ������
-----------------------------------
��ID    ����     ����ó
  PK        NN         
NUMBER    VARCHAR2    VARCHAR2(11)
-----------------------------------
001       ȫ�浿       010-123
002       �̱浿       062-213
003       �ڱ浿

-- ��ǰ����
-----------------------------------
��ǰID    �з�      ������   ������/������
-----------------------------------
001     ��ȭ(D)     �ѱ�        H��
002     ��ǰ(F)     �±�        Y��


-- < III. �������� : SQL >

CREATE TABLE   customers(
    id      NUMBER(4),
    name    VARCHAR2(20) NOT NULL,
    phone   VARCHAR2(11),
    CONSTRAINT customers_id_pk PRIMARY KEY(id)
);

CREATE TABLE    items(
    p_id    NUMBER(4),
    p_type  CHAR(10) NOT NULL,
    p_born  CHAR(10) NOT NULL,
    p_manufactor VARCHAR2(50),
    regdate DATE,
    CONSTRAINT items_p_id_pk PRIMARY KEY (p_id)
);

-- DBA, ������ �𵨷� : ���忡 ���� ���� ==> ���� ���� ==> �ΰ����� Ȱ��ȭ

[���� 10-26] emp_test : employees ���̺��� �����ϰ� , �������� �Žÿ�

CREATE TABLE emp_test (
    emp_id  NUMBER(4) PRIMARY KEY, -- �ߺ�X NULL ���! : ���ϼ� ����
    ename   VARCHAR2(30) NOT NULL,
    dept_id NUMBER(4),
    job_id VARCHAR2(10),
    CONSTRAINT emp_test_dept_id_fk FOREIGN KEY (dept_id) REFERENCES dept_test (dept_id)  
);

-- dept_test [dept_id, dept_name] 

SELECT *
FROM    dept_test; -- 10, 20�� �μ��� ���� <--> ��� ��Ͻ� �μ��ڵ�� 10�̳� 20�̾�� ����� ��.

[����10-27]
INSERT INTO emp_test
VALUES  ('1000','King', 10 ,'ST_MAN' ); -- OK

INSERT INTO emp_test
VALUES  ('1001','Kong', 30 ,'AC_MG' ); -- �μ����̺� 30�� �μ��� �������� �ʴµ�, �Է½õ�
-- ORA-02291: ���Ἲ ��������(HANUL.EMP_TEST_DEPT_ID_FK)�� ����Ǿ����ϴ�- �θ� Ű�� �����ϴ�

-- 30�� �μ������� dept_test�� �Է� �� ��������� ���Է� ==> ����
INSERT INTO dept_test (dept_id, dept_name)
VALUES  (30,'�Ǹź�');
-- dept_test ���̺� 30�� �Է������� �ٽ� �߰��ϸ� ������

SELECT  *
FROM    EMP_TEST;

-- UPDATE �غ��ô�.
UPDATE emp_test
SET dept_id = 30
WHERE   emp_id = 1001;

COMMIT;

-- DEFAULT
-- �÷� ������ �����Ǵ� �Ӽ�, �����͸� �Է����� �ʾƵ� ������ ���� �⺻ �Էµǵ��� �Ѵ�.
-- ���������� �ƴ�����, �÷� �������� �ۼ��Ѵ�.

[����10-30]
CREATE TABLE default_test (
    name VARCHAR2(10) NOT NULL,
    hire_date DATE DEFAULT SYSDATE NOT NULL,
    salary NUMBER(8) DEFAULT 2500
); -- default �Է½� �⺻������ �����

INSERT INTO default_test
VALUES ('ȫ�浿', TO_DATE('2023-05-22','YYYY-MM-DD'), 3000); 

INSERT INTO default_test (name)
VALUES ('ȫ�浿');

SELECT  *
FROM    default_test;        

