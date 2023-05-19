-- 8��. DML
-- Data Manipulation Language, �����͸� �����ϴ� ��ɹ�

-- 8.1 SELECT   : ������ ��ȸ ==> DQL(Data Query Language) : Query ���� --> ��û
-- 8.2 INSERT   : �� �����͸� �����ϴ� ���
-- 8.3 UAPDATE  : ���� ������ �����ؼ� �����ϴ� ���
-- 8.4 DELETE   : ���� ������ �����ϴ� ���
-- �� DML �� TCL ( Transaction Control Language ) �� �Բ� ����Ѵ�.
-- COMMIT : ������ ���� (�޸�) ==> (�������� ������ġ��) �ݿ�
-- ROLLBACK : ������ ����        ==> ��������� ���� ==> ���� �� ���·�!


-- 8.1 INSERT
-- ������ ���� ��� ==> ���̺� ����!

[����8-1] emp ���̺� 300�� ��� �̸��� 'Steven' , ���� 'jobs'�� ����� ������ ���� ��¥ ��������
����Ͻÿ�
-- 1. emp ���̺� ���� (�÷���, �÷��� �ڷ���, ���̰� ����) ==> DDL (Data Definition Language, ������ ���Ǿ�)
CREATE TABLE emp (
    emp_id  NUMBER,         -- emp_id ��� �÷��� NUMBER(���� �ڷ���, ����-�Ǽ�)�� ����
    fname   VARCHAR2(30),   
    lname   VARCHAR2(20),
    hire_date   DATE DEFAULT SYSDATE,
    job_id  VARCHAR2(20),
    salary  NUMBER(9,2),   -- salary��� �÷��� ������(������7 �Ҽ���2) ���̷� ����
    comm_pct NUMBER(3,2),
    dept_id NUMBER(3)
);

-- ���̺� ������ Ȯ���ϴ� ��� / �Ǵ� ���ΰ�ħ
SELECT  *
FROM    user_tables
WHERE   table_name='EMP';


-- ���̺� ����
DROP TABLE ���̺��; -- �ڵ����� COMMIT�Ǵϱ� ����!

-- 2. �����͸� ����
-- 2.1 ���̺��� ���� ��ȸ : desc
DESC emp;
ROLLBACK;


INSERT INTO EMP (emp_id,fname,lname,hire_date)
VALUES (300, 'Steven', 'jobs' , SYSDATE);

SELECT  *
FROM    emp;

[���� 8-2] ����� 301�̰� �̸��� 'Bill', ���� 'Gate'�� ����� 2013�� 5�� 26���ڷ� emp ���̺� �����Ͻÿ�.
INSERT INTO emp (emp_id,fname,lname,hire_date)
VALUES (301, 'Bill', 'Gates', TO_DATE('2013-05-26','YYYY-MM-DD'));

-- Ʈ����� ó�� : Ŀ�� or �ѹ�
COMMIT;

-- p.69 �÷� ��� ���� ���̺��� ��� �÷��� ���� ���尪 ����� VALUES ���� �����ؾ� �Ѵ�.
-- ���ڿ� : NULL �Ǵ� ''�� ����ؼ� �������� NULL ������ �� �ִ�.
-- NULL ==> UPDATE�� �����ؼ� �ٽ� ������ �� �ִ�.
-- �� ���������� NULL �Է��ϴ°� ����.

[����8-3]
desc departments;
/*
�̸�              ��?       ����           
--------------- -------- ------------ 
DEPARTMENT_ID   NOT NULL NUMBER(4)    
DEPARTMENT_NAME NOT NULL VARCHAR2(30) 
MANAGER_ID               NUMBER(6)    
LOCATION_ID              NUMBER(4)    

*/

INSERT INTO departments -- �÷��� ��! ������ Ÿ��! Ȯ��
VALUES (300,'Health Servces', NULL, NULL);

ROLLBACK;

[����8-4]
INSERT INTO emp (emp_id, fname, lname, hire_date, job_id, salary)
VALUES (302,'Warrer', 'Buffett', SYSDATE, NULL, NULL);  -- ������ ���鿡���� ''��� NULL ��!

-- VALUES �� ���� SELECT���� ����� ���������� ���̺�κ��� ���� ������ ���� ����, ������ �� �ִ�.
-- INSERT���� ������ �÷� ��ϰ� SELECT ���� �÷� ����� ������ ��ġ�ؾ� �Ѵ�.

INSERT INTO ���̺� [(�÷���1, �÷���2..)]    -- 2. Ư�� ���̺� �״�� ����(=����)
--VALUES (��1, ��2, ...)
SELECT �÷���1, �÷���2, ...    -- 1. ���� ���̺��� Ư�� �÷��� �����ؼ�
FROM    ���̺��
WHERE   ������;

[����8-5] ������̺��� �μ��ڵ� 10�Ǵ� 20�� �Ҽӵ� ����� ������ ���, �̸�, ��, �Ի���, �����ڵ�, �μ��ڵ带
emp ���̺� �����Ͻÿ�!

INSERT INTO emp (emp_id, fname, lname, hire_date, job_id, dept_id)
SELECT  employee_id, first_name, last_name, hire_Date, job_id, department_id
FROM    employees
WHERE   department_id IN (10,20);

SELECT *
FROM    emp;

-- =========================================================================================================

-- ITAS : INSERT INTO ~ AS SELECT ~   // SELECT ����� �ٸ� ���̺� �����ϴ� ���[DML]
-- CTAS : CREATE TABLE ~ AS SELECT ~  // SELECT ����� �ٸ� ���̺��� �����ϴ� ��� (������ ����, ������)[DDL]

--=========================================================================================================

[����8-6] ���� �޿� ���� ���̺�(month salary)�� �μ����̺��� �μ��ڵ� �� �����͸� �����Ͻÿ�
-- �Ϲ� ���̺� ���� ���, �����͸� ���� ����
/*
CREATE TABLE ���̺�� (
    �÷��� ������Ÿ�� ��������,
    ... ���
)
*/
-- 4000����Ʈ ����
CREATE TABLE month_salary(
    dept_id NUMBER(3),
    emp_count NUMBER,
    sum_sal NUMBER,
    avg_sal NUMBER(9,2) -- �����δ� 7��, �Ҽ��δ� 2��
);

INSERT INTO month_salary (dept_id)
SELECT  department_id
FROM    departments
WHERE   manager_id IS NOT NULL;

SELECT   *
FROM    month_salary;

INSERT INTO month_salary (dept_id, emp_count, sum_sal,avg_sal)
SELECT  department_id, COUNT(*), SUM(salary), ROUND(AVG(salary),2)
FROM    employees
WHERE   department_id IS NOT NULL
GROUP BY department_id
ORDER BY 1;

ROLLBACK;

-- CTAS�� ���̺� ���� ��� ==> �����͸� �����ϸ鼭 �����ϰų� �Ǵ� ������ �����ϰ� �����ʹ� ����x

[����8-7] ������̺��� �μ��ڵ尡 30���� 60���� �ش��ϴ� ������� ���,�̸�,��,�Ի���,�����ڵ�,�޿�,
Ŀ�̼���, �μ��ڵ带 ��ȸ�ؼ� emp ���̺� �����Ͻÿ�

INSERT INTO emp 
SELECT  employee_id,first_name, last_name, hire_date, job_id, salary, commission_pct, department_id
FROM    employees
WHERE   department_id BETWEEN 30 AND 60;

SELECT  *
FROM    emp
ORDER BY 1;






-- 8.3 ������ ���� UPDATE
-- INSERT : �� ������ ���� (=����)
-- UPDATE : ���� ������ �����ؼ� ����

/*
UPDATE ���̺��
SET �÷��� = ��
WHERE   ����;
*/ 

-- WHERE ���� ==> ��� ������ �࿡ ����
-- ex> �޿��� Ư�� ���/�μ��� �������� ������ ��� ����� �޿���~ Ŀ�̼���~

[����8-8] emp ���̺��� ����� 300�� �̻��� ����� �μ��ڵ带 20���� �����Ͻÿ�
-- emp : ���� 300�� �̻� 6�� + employees ���̺� 30~60�� �μ��� 57�� ==> 63��

UPDATE emp
SET dept_id = 20
WHERE   emp_id >= 300;

COMMIT;

[����8-9] ����� 300���� ����� �޿�, Ŀ�̼���, �����ڵ带 �����Ѵ�.

UPDATE emp
SET salary = 2000,
    comm_pct = 0.1,
    job_id = 'IT_PROG'   -- �μ� : IT , ���������� : PROGRAMMER
WHERE   emp_id = 300;

-- ���������� ����� �����͸� ������ �� �ִ�.
-- �����ڵ�, �޿�, Ŀ�̼��� ==> ���� �÷�  �������� ==> UPDATE �Ҷ� ����Ѵ�.


[���� 8-11] emp ���̺� ��� 103�� ����� �޿��� employees ���̺��� 20�� �μ��� �ִ� �޿��� �����Ѵ�.
-- MAX() : ������ �Լ� (����� ����) ==> �����Լ�

UPDATE  emp
SET     salary = ( SELECT   MAX(salary)
                   FROM     employees
                   WHERE    department_id = 20)  -- ��������
WHERE   emp_id = 103;

ROLLBACK;

[���� 8-12] emp ���̺� ��� 180�� ����� ���� �ؿ� �Ի��� ������� �޿���, employees ���̺� 50�� �μ��� 
��� �޿��� �����Ͻÿ�
SELECT  TO_CHAR(hire_date,'YYYY')
FROM    employees
WHERE   employee_id = 180;  -- 2006


UPDATE  emp
SET     salary = ( SELECT   ROUND(AVG(salary)) 
                   FROM     employees
                   WHERE    department_id = 50 )
WHERE   TO_CHAR(hire_date,'YYYY') = ( SELECT  TO_CHAR(hire_date,'YYYY')
                                        FROM    emp
                                        WHERE   emp_id = 180 );

COMMIT; 

[���� 8-13]

CREATE TABLE month_salary2(
    dept_id NUMBER(3),
    emp_count NUMBER,
    sum_sal NUMBER,
    avg_sal NUMBER(9,2) -- �����δ� 7��, �Ҽ��δ� 2��
);

-- ������̺��� ������� �Ҽ� �μ��ڵ常 ����
INSERT INTO month_salary2 (dept_id)
SELECT department_id
FROM    employees
WHERE   department_id IS NOT NULL  -- �μ��� ���� ��� Ŵ����
GROUP BY department_id;

SELECT *
FROM    month_salary2;

-- UPDATE �� EMP_COUNT, SUM_SAL , AVG_SAL�� ������Ʈ
UPDATE month_salary2 m
SET emp_count = ( SELECT    COUNT(*)
                  FROM    employees e
                  WHERE   e.department_id = m.dept_id
                  GROUP BY e.department_id ),
    sum_sal = ( SELECT    SUM(e.salary)
                FROM    employees e
                WHERE   e.department_id = m.dept_id
                GROUP BY e.department_id ),
    avg_sal = ( SELECT    ROUND(AVG(e.salary))
                FROM    employees e
                WHERE   e.department_id = m.dept_id
                GROUP BY e.department_id );
 
SELECT *
FROM    month_salary2;

COMMIT;

-- month_salary ó�� month_salary2�� ���������� ó��

[����8-14] month_salary2�� emp_count, sum_sal, avg_sal �÷��� �����÷� ���������� Ȱ����
employees�� �μ��� ����� �����͸� ������Ʈ�Ͻÿ�!
(��, �޿������ ������ ǥ���Ͻÿ�)

UPDATE  month_salary2 m
SET     ( emp_count, sum_sal, avg_sal ) = ( SELECT COUNT(*), SUM(salary), ROUND(AVG(salary))
                                            FROM    employees e
                                            WHERE   e.department_id = m.dept_id
                                            GROUP BY department_id
                                            );
SELECT  *
FROM    month_salary2;

COMMIT;




-- 8.3 ������ ���� DELETE
-- ���̺��� �� �����͸� �����ϴ� �⺻ ����
-- WHERE ���� ���ǿ� ��ġ�ϴ� �� �����͸� �����Ѵ�. (WHERE�� ������ ��� �� �����Ͱ� ������)

/*
DELETE FROM ���̺��
WHERE ����;
*/

[����8-15] emp ���̺��� 60�� �μ��� ��� ������ �����Ѵ�.
-- ��ȸ
SELECT  *
FROM    emp
WHERE   dept_id = 60;

-- ����
DELETE FROM emp
WHERE   dept_id = 60;  -- 5rows deleted, 58rows remain

-- WHERE �� ������ ��� �����Ͱ� �����ǹǷ� ����!!

COMMIT; -- 58rows remain



