-- 6��. �������� (p.51)

-- �� SQL���� �ȿ� �����ϴ� �Ǵٸ� SQL ������ ����������� �Ѵ�.
-- 1) ���������� ��ȣ��( ) �� ��� ����Ѵ�.
-- 2) ���������� ���Ե� �������� ���� ������� �Ѵ�.

-- ORACLE, MYSQL, MSSQL : RDBMS     VS     mongoDB(atlas), firebase(google), MS Azure, Amazon AWS
-- ������ �����ͺ��̽�                      <CLOUD ����� ������ ����> : NoSQL(������ �����ͺ��̽��� �ƴ�)  
-- ���jŬ ==> ��������
-- MSSQL ==> T-SQL
-- ���� DBMS ���� �ణ �ٸ� �̸�


[����6-1] ��� �޿����� �� ���� �޿��� �޴� ����� ������ ��ȸ�Ѵ�.

-- 1. ��� �޿��� ���Ѵ�.
SELECT  ROUND(AVG(salary)) AS avg_sal   -- ��ձ޿� : 6462
FROM    employees;
  
-- 2. ��� �޿� �̸��� �޴� ��������� ��ȸ
SELECT  employee_id, first_name, salary, department_id
FROM    employees
WHERE   salary < 6462;

-- 1+2�� ȿ�� : ��������
SELECT  employee_id, first_name, salary, department_id
FROM    employees
WHERE   salary < ( SELECT  ROUND(AVG(salary)) AS avg_sal   
                   FROM    employees );
-- �� ���� ���� : ���������� ���� ����ǰ� �� ����� ��ȯ�� �� ���������� ����ȴ�.


-- =========== ���������� ���� =============
-- 6.1 ���� �� (���� �÷�) �������� : �ϳ��� ��� ���� ��ȯ�ϴ� ��������
-- �� ���� �� ������ (= , >= , > , < , <= , <> , != , ^=)
-- �� �׷� �Լ��� ����ϴ� ��찡 ��ټ�. (AVG , SUM , COUNT , MAX , MIN)

[����] ���� ū ������ �޴� ���.
-- 2. ���������ۼ�
SELECT  employee_id, first_name, last_name
FROM    employees
WHERE   salary = ( SELECT MAX(salary) AS max_sal
                   FROM     employees);      -- salary : NUMBER (���� ������ �÷�)




-- 6.2 ���� �� ��������(p.53)
-- ���� �� ������ (IN, NOT, ANY(=SOME), ALL, EXISTS)
-- 6.2.1 IN ������
-- OR ������ ��� --> ����
SELECT  employee_id, first_name, department_id
FROM    employees
WHERE   department_id IN (50, 80);

[����6-5] �μ�(��ġ�ڵ�, location_id)�� ����(UK)�� �μ��ڵ�, ��ġ�ڵ�, �μ��� ������ ��ȸ�Ѵ�.
-- 1. ������ ��ġ�ڵ带 ��ȸ
SELECT  location_id
FROM    locations
WHERE   country_id = 'UK';  -- 2400, 2500, 2600 : ������ �μ� ������~

--2. ��������
SELECT  department_id, location_id, department_name
FROM    departments
WHERE   location_id = ANY (2400,2500,2600);
-- ANY ==> �ϳ��� �����ϸ� ����   (OR�� ���)
-- ALL ==> ��� �����ϸ� ����   (AND�� ���)








-- 6.3 ���� �÷� ��������

-- �������� ����?
-- 6.4 ��ȣ���� ��������

-- 6.5 ��Į�� ��������
-- 6.6 �ζ��� �� ��������
-- ========================================











[����6-4] ���޿��� ���� ���� ����� ���, �̸�, ��, �������� ������ ��ȸ
-- employees : ���, �̸�, ��
-- jobs : ��������(job_title)

-- 1. ���޿� ���� ū �� : 24000 VS 2100
SELECT  MAX(salary)
FROM    employees;

SELECT  MIN(salary)
FROM    employees;

-- 2. ����� ���, �̸�, ��, �������� ����
-- 2-1. ����Ŭ ����
-- 2-2. ANSI JOIN ==> MYSQL ��� ����, T-SQL (MSSQL), ... 

SELECT  employee_id, first_name, last_name,
        job_title






