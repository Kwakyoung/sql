-- 5��. JOIN (����)
-- ����Ŭ ������ �����ͺ��̽��̴� ==> ���� : ���̺�� ���̺��� �δ°�! 
-- (Relation, �����̼� - �����ͺ��̽� �����Ҷ� ���̺��� �����̼� �̶����)
-- JOIN ���� ���̺��� �����Ͽ� (HR : 7��, ���� : n) �����͸� ��ȸ�Ѵ�
-- EX> ��� ���̺� ~ �μ� ���̺� ���� : ��������� �μ� ����(�μ��̸�, �μ���ġ�ڵ�)�� ��ȸ�Ҷ�!


-- 5.1 Cartesian Product (Decart�� �ٸ� ��, Cartesian) 
-- JOIN ���� : �� �̻��� ���̺��� ���踦 ������, ������ �Ǵ� �÷��� ���� ==> ����, WHERE ���� ���...
-- JOIN ������ ������� ���� �� �߸��� ����� �߻��ϴµ�, �̰� ī�׽þ� ��(=�ռ���) �̶�� ��.
-- ������ �ȳ� ==> �����Ǵ� ������ ���� ���ٸ�, �ǽ�!!

/*
SELECT  �÷���1, �÷���2, ...
FROM    ���̺��1, ���̺��2, ...
WHERE   JOIN ����(=��)
*/

[����5-1] ��� ���̺�� �μ� ���̺��� �̿��� ����� ������ ��ȸ�ϰ��� �Ѵ�. ���, ��, �μ��̸���
��ȸ�϶�!

-- ���, �� : employees   ( ��� ���� ���̺� : ���, �̸�, ����޿�, �Ի��� ... )
-- �μ��̸� : departments ( �μ� ���� ���̺� : �μ��ڵ�, �μ��̸�, �μ��� ��ġ�� �����ڵ� )
-- �ٸ� ���̺��� ���� ����� �ۼ�!! (������)
-- �� ���̺��� ���� �÷� : department_id (manager_id : �μ����̺��� �ĺ���x)
-- ��ü ����� 107��, ��ȸ�� ��� 106��
SELECT  e.employee_id , e.last_name,    -- �ֵ� ������ ��ȸ�Ϸ��� ���̺��� �÷�
        d.department_name             -- �ΰ����� ����
FROM    employees e, departments d
WHERE   e.department_id = d.department_id;    
--      �������̺�.�����÷� = ������̺�.�����÷�

-- ������̺� ������/�� �� : 107
-- �μ����̺� ������/�� �� : 27
-- ī�׽þ� �� : 2889 rows ==> 107 * 27

DESC employees;
DESC departments;


-- 5.2 EQUI JOIN : ���� ������(=)�� ����� JOIN ���� : EQUI-JOIN
-- �� ���̺��� ���� �÷� : department_id (manager_id : �μ����̺��� �ĺ���x)
-- ��ü ����� 107��, ��ȸ�� ��� 106�� <--> �μ����� 1���� ����!!
-- ���̺��� �̿��� JOIN => ��� ���̺� � �÷������� ���!!
SELECT  e.employee_id , e.last_name,    -- �ֵ� ������ ��ȸ�Ϸ��� ���̺��� �÷�
        d.department_name             -- �ΰ����� ����
FROM    employees e, 
        departments d
WHERE   e.department_id = d.department_id;    

[���� 5-2]
SELECT  e.employee_id , e.last_name,    -- �ֵ� ������ ��ȸ�Ϸ��� ���̺��� �÷�
        d.department_name             -- �ΰ����� ����
FROM    employees e, 
        departments d
WHERE   e.department_id = d.department_id; 

[���� 5-3] ���̺��� Alias �� ����~
SELECT  e.employee_id , e.last_name,    -- �ֵ� ������ ��ȸ�Ϸ��� ���̺��� �÷�
        d.department_name             -- �ΰ����� ����
FROM    employees e, 
        departments d
WHERE   e.department_id = d.department_id; 

[���� 5-4] (��� ���̺�, �������̺��� �̿���) ���, �̸�, �����ڵ�, �������� ������ ��ȸ�Ѵ�.
DESC jobs;
/*
JOB_ID     NOT NULL VARCHAR2(10) 
JOB_TITLE  NOT NULL VARCHAR2(35) 
MIN_SALARY          NUMBER(6)    
MAX_SALARY          NUMBER(6)
*/
SELECT  e.employee_id, e.first_name||' '||e.last_name name, e.job_id, 
        j.job_title
FROM    employees e, jobs j   -- ī�׽þ� �� : 2,033 rows
WHERE   e.job_id = j.job_id;  -- �ߺ��Ǵ°� ��������


[���� 5-5] (��� ���̺�, �μ� ���̺�, ���� ���̺��� �̿���) ���, �̸�, �μ���, �������� ������ ��ȸ�Ѵ�.
-- employees , departments , jobs
-- �������  , �μ�����    , ��������
-- department_id

SELECT  e.employee_id AS ���, e.first_name||' '||e.last_name name,
        d.department_name,
        j.job_title
FROM    employees e , departments d , jobs j
WHERE   e.department_id = d.department_id  -- 1���� �μ��ڵ� x
AND     e.job_id = j.job_id
ORDER BY 1;




-- 5.3 NON-EQUI JOIN







-- 5.4 OUTER JOIN







-- 5.5 SELF JOIN



-- ========================== ������ ORACLE JOIN
-- ========================== �Ʒ��� ���� JOIN



-- 5.6 ANSI JOIN  /  ANSI ��ȸ���� ���� ǥ�� JOIN �� (ORACLE�ܿ��� MYSQL, CUBRID, ��Ÿ RDBMS ���� JOIN)







-- 5.7 OUTER JOIN

