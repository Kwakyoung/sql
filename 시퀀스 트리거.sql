-- 11��. ��� ������

/*
    �����ͺ��̽� �뵵, ���� ���� �ٸ�
    
    ������    vs    �����ͺ��̽� ������
      ��                     �� �͵�
    ���̺�          ���̺�, ��, �Լ�, ������, �ε���, Ŭ������, ���Ǿ� ...
    ������
    Ʈ����
*/





-- 11.1 �� (VIEW)
-- ��� �����Ͱ� �������� �ʴ� ���� ���̺� : �޸𸮿��� --> ������ �����ߴٰ� ������ ��� ��ȯ�� �Ҹ�
-- ���Ȱ� ����� ���Ǹ� ���� ����Ѵ�.
  
/*
    <�� ����>
    CREATE [OR REPLACE] VIEW ��� AS
    SELECT ����

    <�� ����>
    DOP VIEW ���;
*/


/* 
    ���̺� ������
    CREATE TABLE ���̺�� (
        ...
    );
    
    ���̺� ����
    DROP TABLE ���̺��;

*/

-- ���� emp_details_view �� SQL�� ����� �����_�� ������ü
SELECT  text
FROM    user_views;

[����11-1]  80�� �μ��� �ٹ��ϴ� ������� ������ ��� v_emp80�� �並 �����Ͻÿ�!
-- ITAS : SELECT�� �����͸� Ư�����̺� ����
-- CTAS : SELECT�� �����͸� �����ϴ� ���̺��� ����
CREATE OR REPLACE VIEW v_emp80 AS       -- v_emp80 �̹� ������ �⺻�� �����ϰ� ������ ���� �������ּ���~
SELECT  employee_id AS emp_id, first_name, last_name, email, hire_date
FROM    employees
WHERE   department_id=80
WITH READ ONLY;

-- Q. ��� ������ ���̺� ==> ������ ���� | ���� | ������ �Ҽ��ִ� ������ü�̴� �׷��ٸ� �䵵 �Ҽ��ֳ�? 
-- A. ����� ����! WITH READ ONLY ����ؼ� VIEW ������ �ʾұ� ������!!

-- 1. ���� ���̺� ������ ���� --> �信 ����?
DESC    employees;

-- 2. �信 ������ ���� --> ���� ���̺� ����?
INSERT INTO v_emp80 (emp_id, first_name, last_name, email, hire_date, job_id)
VALUES (208, 'SUNSHIN', 'LEE', 'SUNSHINLEE', SYSDATE, 'SA_REP');

-- ���� employees ���̺��� �ʼ��Է� �÷�(job_id)�� v_emp80�� �����ϱ�, Ȯ�ο� ��ü ��� �� �ٽø����
CREATE OR REPLACE VIEW v_emp_all AS      
SELECT  *
FROM    employees;

INSERT INTO v_emp_all (employee_id, first_name, last_name, email, hire_date, job_id,salary, department_id)
VALUES (208,'SUNSHIN','LEE' , 'SUNSHINLEE',SYSDATE,'SA_REP', 6600, 80);

ROLLBACK;

SELECT *
FROM    employees;

DELETE employees
WHERE   employee_id = 208;

[����11-2] v_dept �並 ���� - �μ��ڵ�, �μ���, �����޿�, �ִ�޿�, ��ձ޿� ������ ����ִ�.
CREATE OR REPLACE VIEW v_dept AS
SELECT  d.department_id, d.department_name,
        MIN(e.salary) AS min_sal, MAX(e.salary) AS max_sal, ROUND(AVG(e.salary) avg_sal)
FROM    employees e, departments d
WHERE   e.department_id = d.department_id
GROUP BY d.department_id, d.department_name
ORDER BY 1;


-- 11.2 ������ (SEQUENCE)
-- �������� ��ȣ�� ������ �ʿ��� ��� SEQUENCE�� ����Ͽ�, �ڵ����� ������ִ� ���
-- �ǻ��÷� CURRAVAL, NEXTVAL�� ���� ��ȸ�ϰ� ����� �� �ִ�.

SELECT  *
FROM    user_sequences; -- �ý��� ���� �� : ������ ����� �� �ְ�~

-- �� �������� �����? ������ �Է��Ҷ�����, Ư�� ������ ���� ����ص� �ʿ䰡 �������Ƿ� ..

/* ���̺� ����, �� ����, ������ ����.. �� ���ƿ�!
    CREATE SEQUENCE ��������
    START WITH   ���۰�
    MAXVALUE     �ִ밪
    INCREMENT BY ������
    NOCACHE | CACHE 
    NOCYCLE | CYCLE
    
    ���̺� ����, �� ����, ������ ����.. ����
    DROP SEQUENCE ��������;
    
    ���̺� ����, �� ����(=X), ������(=X)
    ALTER TABLE ���̺��
    MODIFY �÷��� ������Ÿ��(����Ʈ��);
*/


-- ���̺��� ã�� ���� ���?
SELECT  *
FROM    all_tables -- �ý��� �������� ������ ��
WHERE   OWNER = 'HANUL';

[����11-4] �������� ����
CREATE SEQUENCE emp_seq
START WITH 103
MAXVALUE    999999
MINVALUE    1
INCREMENT BY 1
NOCACHE;

-- CURRVAL, NEXTVAL ���� ��ȸ�ϰ� ���
SELECT  emp_seq.CURRVAL,
        emp_seq.NEXTVAL
FROM    dual;

[����11-5] emp_test�� ������ ����
SELECT  *
FROM    emp_test;

INSERT INTO emp_test
VALUES(emp_seq.CURRVAL - 1, 'Choi', 20, 'ST_CLERK');

-- ȫ�浿, 20�� �μ�, ''
INSERT INTO emp_test
VALUES(emp_seq.NEXTVAL, 'ȫ�浿', 20, 'ST_CLERK');

-- emp_dept_seq ���� : 40�� ���� 10�� ����~ �ִ� 99999 ����~
CREATE SEQUENCE emp_test_dept_seq
START WITH 40
MINVALUE 10
MAXVALUE 9999999999999
INCREMENT BY 10
NOCACHE
NOCYCLE; 

-- �̼���
INSERT INTO emp_test
VALUES(emp_seq.NEXTVAL, '�̼���', emp_test_dept_seq.NEXTVAL, '');

SELECT  *
FROM    user_constraints
WHERE   table_name = 'EMP_TEST';

SELECT  *
FROM    emp_test;

-- ����|�ǽ��� ���������� �Ͻ������� ����ȭ or ����
-- ���� : oracle database disable constraint �˻�
/*
ALTER TABLE table_name
[ENABLE or DISABLE] CONSTRAINT constraint_name;
*/
ALTER TABLE emp_test
DISABLE CONSTRAINT emp_test_dept_id_fk; -- emp_test

-- �̼��� ���������� �� �ٽ� ���� �� ENABLE��

UPDATE emp_test
SET dept_id=30
WHERE   emp_id = 106;

ALTER TABLE emp_test
ENABLE CONSTRAINT emp_test_dept_id_fk;

-- �������� ENABLE / DISABLE : �׽�Ʈ �Ҷ� ���� ����� ���� �ִ�.
-- ��, �ٽ� ���������� ENABLE �Ҷ� �׽�Ʈ �ϴ� ���̺� �������ǰ� ��ġ�ϴ� �����Ͱ� �ִ��� Ȯ��!

COMMIT;



-- 12. ����Ŭ �����ͺ��̽� ��ü
-- 12.1 ������ ����/������ ��ųʸ� : �����ͺ��̽��� �߿��� ����, ��ü���� �����ϰ� �ִ� ��ü
-- ����Ŭ�̶�� �ý����� ����ϴ� ������ + ����� ������

-- 12.2 ������ ���� ��ȸ
SELECT  *
FROM    dict;

-- ���̺�, �並 ������ �����ͺ��̽� ��ü ���� : ��������, �ε���, Ŭ������, �ó��(=���Ǿ�), ...
-- ���, �����ͺ��̽� �����ڰ� ���� ����
-- ����ڰ� Ȱ���ϴ� ������ ����ִ�.

-- ��ȸ�غ� �� �ִ� ������ ���� ���̺�/���� ����
-- 1) ALL_ �� �����ϴ� �� : ���� ������� ������ ��ȸ�� �� �ִ� ������
-- 2) DBA_ �� �����ϴ� �� : DBA ������ ������ ��ȸ
-- 3) USER_�� �����ϴ� �� : ������ ������ ���Ե� �����͸� ��ȸ


-- 12.3 �����ͺ��̽� ��ü ����
-- 1) ���̺�
-- 2) ��
-- 3) ������
-- 4) �Լ� : ����� ���� �Լ� vs MAX()�� ������~ MID()�� ���� ����ڴٸ�!  == > ��ȯ���� ����
-- 5) Ʈ���� : ��ȯ���� ���� �Լ�
---------------- ������ ��    DBA �� --------------------
-- 6) �ε��� : �˻� ���� ��󶧹��� 
-- 7) Ŭ������ :        " 
-- 8) �ó�� : ��ü�� �� �ٸ� �̸� (=����) ����
-- 9) ��Ű�� : PL/SQL�� �Լ��� Ʈ���ŵ��� �ѵ� ���� ����

-- 12.4 ����/����/����
--CREATE  ����
--ALTER   ����
--DROP    ����

-- Ʈ���� ����
CREATE OR REPLACE TRIGGER Ʈ���Ÿ�
[BEFORE | AFTER]
    INSERT OR
    UPDATE OF salary, department_id OR  -- 2. � �۾��� �̷�����
    DELETE
    ON employees  -- 1. � ���̺�����
BEGIN
    -- 3. �Ʒ����� ������ ó���� �Ǵ� PL/SQL
    -- PL/SQL ����� : ����, ������, ���ǹ�, �ݺ��� ...
    -- ����ó���� : EXCEPTION 
END;



-- CASE | DECODE 
SELECT  *
FROM    employees;
-- 204 Shelley �޿� 12008 �� 12000 ����

-- DBMS_OUTPUT ��Ű��
-- SQL DEVELOPER ��� Ȯ�� �� [���� > DBMS ���] â�� �����ؼ�
UPDATE  employees
SET salary = 12000
WHERE   employee_id = 205;

-- SQLPLUS Ȯ���Ϸ���?
ROLLBACK;








