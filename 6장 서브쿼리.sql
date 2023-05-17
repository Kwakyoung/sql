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

/*
= ANY : ��ġ�ϴ� �� �ϳ��� ������ TRUE ��� (�������� ���� ����� �������� ��ȯ�Ҷ�)
> ANY : (�������� ���࿡ ���� ��ȯ����� ���������) > �ּҰ�(MIN�Լ�) �� ����.
< ANY : (�������� ���࿡ ���� ��ȯ����� ���������) < �ּҰ�(MAX�Լ�) �� ����.
= ALL : (�������� ���࿡ ���� ��ȯ����� ���������) = ��� ����� ���ؼ� TRUE���� �ϴ� ���� ==> IN ������ (����� �ȳ����°��)
> ALL : (�������� ���࿡ ���� ��ȯ����� ���������) > �ִ밪(MAX�Լ�) �� ����.
< ALL : (�������� ���࿡ ���� ��ȯ����� ���������) > �ּҰ�(MIN�Լ�) �� ����.

 NOT IN <>  ALL�� �������
*/
[����6-10] 100�� �μ��� ����� �޿����� ���� �޿��� �޴� ����� ���, �̸�, �μ���ȣ, �޿��� �޿��� ������������ ��ȸ�Ѵ�.
-- �׷��Լ� : COUNT(*) or COUNT(�÷���) or COUNT(DISTINCT �÷���)
-- COUNT() :  NULL ����
-- 100�� �μ��� ��ȸ ==> �׷캰 ����� �� ����
SELECT   department_id, COUNT(*) AS cnt
FROM     employees
GROUP BY department_id
ORDER BY 1;

SELECT   employee_id, first_name, salary, department_id
FROM     employees
WHERE    department_id = 100 -- 6900, 7700, 7800, 8200, 9000, 12008
ORDER BY 3;

SELECT  employee_id, first_name, department_id, salary
FROM    employees
WHERE   salary > ALL ( SELECT   salary
                       FROM     employees
                       WHERE    department_id = 100 ); -- ��������, ���� �� ��������

-- 6.2.2 NOT ������
[����6-16] �μ����̺��� �μ��ڵ尡 10,20,30,40�� �ش����� �ʴ� �μ��ڵ带 ��ȸ�Ѵ�.
SELECT  department_id, department_name
FROM    departments
WHERE   department_id NOT IN (10,20,30,40); -- ��ü�μ� : 27�� (10~270)  ==>  <> ALL ���� ���

SELECT  department_id
FROM    departments
WHERE   department_id > ALL ( SELECT   department_id
                              FROM     departments
                              WHERE    department_id IN (10,20,30,40));

-- 6.2.3 ANY(=SOME) ������
-- 6.2.4 ALL ������
-- 6.2.5 (���� ��) ���� �÷� �������� (p.57)
-- ���������� ��������ó�� �������� �÷��� (���ϴµ�) ����� �� �ִ�.
-- WHERE ���� (�÷���1, �÷���2...) ó�� �ۼ�
-- �÷��� ������ ������ Ÿ���� ��ġ�ؾ� ��.
[����6-18] �Ŵ����� ���� ����� �Ŵ����� �ִ� �μ��ڵ�, �μ����� ��ȸ�Ѵ�.
-- ���������� ��� ��ȸ�� ����! ==> ���������� ����� �� �˸�, ������ �����ϰ� ���� �� �ִ�.
SELECT  department_id, department_name
FROM    departments
--WHERE   (���÷�1, ���÷�2) �񱳿��� (�������� �����-�����÷�);
WHERE   (department_id, manager_id) = ( SELECT  department_id , employee_id
                                        FROM    employees
                                        WHERE   manager_id IS NULL);
                                        
-- �����÷� �������� ==> �ѹ��� �ΰ� �̻��� �÷��� ���ϴ� ��������
-- �з� ==> ���� ������� ������ ���� ==> ���� ���� vs �����Ҽ��� ?


-- ====== ���� �� / ���� �� / ���� �÷� �������� PART 1) ~ 3) ===========

-- 6.3 EXISTS ������(��ȣ���������������� ���)
-- ��ȣ���� ��������(P.57)
-- ��ȣ : ���� ~    /    ���� : ����~ ���� ==> JOIN ����    vs     SET ����
-- ���������ε�, JOIN������ Ȱ���� ��������! ==> ���������� ���̺�� ���������� ���̺��� JOIN ������ ���
-- ���������� �÷��� ���������� �������� ���Ǿ� ���� ������ ���������� ���� ����
[����6-19] �Ŵ����� �ִ� �μ��ڵ忡 �Ҽӵ� ������� ���� ��ȸ�Ѵ�.
-- ���� ��� �� ����� ��ȯ�ϴ� �Լ� : COUNT(*) / �׷��Լ�
-- �Ŵ����� ���� �μ��ڵ� : 90�� vs �Ŵ����� �ִ� �μ��ڵ� 10~80, 100~110
SELECT  COUNT(*) AS �����
FROM    employees e
WHERE   EXISTS ( SELECT   department_id
                           FROM     departments d
                           WHERE    manager_id IS NOT NULL 
                           AND      e.department_id = d.department_id );
-- ORA-00920: ���� �����ڰ� �������մϴ� : IN ��� EXISTS�� ����Ҷ��� WHERE���� �� �÷��� ����� ��.
-- EXISTS �����ڴ� ���������� ����� ���� ���θ� �Ǵ��Ѵ�.
-- EXISTS �����ڸ� ����Ҷ�, ���������� SELECT ��ϰ��� ������ ���� ���� Į������ JOIN ������ �ٽ��̴�.
-- �����÷� ������������ �з��� �� �� �ִ� --> ������ �� �� �ִ� --> �� ���� ����� �� �ִ�??
-- ��ȣ���� ���������� �������� ������� ���������� ���� ==> �ӵ����̰� �߻� �� �� �ִ�!


-- �������� ����?
-- 6.4 ��ȣ���� ��������


-------------------------------------------------------------------------------------------------

-- 1) �������� ����࿡ ���� ���� : ���� ��, ������, ���� �÷�
-- 2) �������� ���� ����(=JOIN���� ���) : ��ȣ���� ��������
-- 3) �������� �����ġ�� ���� ���� : ��Į�� ��������, �ζ��� �� ��������, (�Ϲ�, WHERE����)��������

-------------------------------------------------------------------------------------------------



-- 6.5 ��Į�� ��������
-- ��Į�� : (����) ������ ���� �ʰ� ũ�⸸ ���� ����(1����) VS ���� : ũ��� ������ ���� ���� ����(2����)
-- SELECT ���� ����ϴ� �������� ==> SELECT ���� �÷�(�ϳ��ϳ�)�� �ۼ��ϴ� �� (CLAUSE, ��)
-- �ڵ强 ���̺��� �ڵ���� ��ȸ�ϰų� �׷��Լ��� ������� ��ȸ�Ҷ� ����Ѵ�. / �ִ밪 �ּҰ� �հ� ��� ���� ...
[����6-22]  ����� �̸�, �޿�, �μ��ڵ�, �μ����� ��ȸ�Ѵ�.
-- JOIN ����
-- employes : �̸� , �޿� , �μ��ڵ�
-- departments : �μ���

SELECT  first_name, salary , department_id, 
         ( SELECT department_name
           FROM   departments d
           WHERE  e.department_id = d.department_id) AS department_name -- ��Į�� �������� , ������ ���� �������� - ��ȣ���� ��������
FROM    employees e ;

-- �ڵ强 ���̺�?? �μ���ձ޿��� ����ص� �������� ���̺��� ������, �ִ°�ó�� ���������� ��ȸ
[����6-23] ����� ���, �̸�, �޿�, �μ��ڵ�, �μ���ձ޿�
-- ROUND() : �Ҽ��� / ������ �ڸ����� �ݿø� �Լ�
-- AVG() : ��հ��� ���Ͽ� ��ȯ�ϴ� (�׷�)�Լ�

SELECT  employee_id , first_name , TO_CHAR(salary, '999,999') , department_id, 
        ( SELECT ROUND(AVG(salary))
          FROM  employees e1
          WHERE e1.department_id = e2.department_id) AS debt_avg_sal  --  (�μ���ձ޿�)
FROM    employees e2;




-- 6.6 �ζ��� �� ��������
-- FROM ���� ���Ǵ� �������� ==> FROM���� ���̺�� ���°� ==> �ζ��� ��
-- �� : ������ ���̺�(=�޸𸮿��� ����, ���� ����� �޸𸮿��� ����, ����� ��ȯ�ϰ� �������...)
-- SELECT ���� ���Ǵ� �������� ==> ��Į�� ��������
-- ���� ������ �������̰� ==> ������ ���̺��̴ϱ�
-- WHERE ���� ���� ������ ���̺�� JOIN�� ���� ���踦 �δ´�.

-- ������ WHERE���� (�Ϲ�) �������� : ���� ���� ����Ѵ�.

[���� 6-24] �޿��� ȸ�� ��ձ޿� �̻��̰�, �ִ�޿� ������ ����� ���, �̸�, �޿�,
ȸ����ձ޿�, ȸ���ִ�޿��� ��ȸ�Ѵ�.
-- HR ���� : ȸ���� �޿���� ���� ���̺��� ���� ==> �������� �ִ°�ó�� �������� ��ȸ

SELECT  employee_id, first_name, salary,
        avg_sal, max_sal
FROM    employees ,
        ( SELECT ROUND(AVG(salary)) AS avg_sal, MAX(salary) AS max_sal
          FROM employees ) 
--WHERE   salary >= a.avg_sal
--AND     salary <= a.max_sal;
WHERE     salary BETWEEN avg_sal AND max_sal; 
-- JOIN ������ NON-EQUI JOIN ���� : = �̿��� �����ڻ���ϴ� JOIN���� (�����񱳿����� , BETWEEN, IN)
-- ���� ������� �ʴ� ����
-- NON-EQUI JOIN������ �ζ��� �� �������� ==> ���̺��� ��Ī, �÷��� ���̴� ��� �����߻�!


[����6-25, 26] ���� �Ի� ��Ȳ ���̺��� ������, �ζ��� �� �������� ��������, ���� �Ի��� ��Ȳ�� ��ȸ�Ͻÿ�
-- �䱸�Ǵ� ���̺��� ����
-- 1�� ... 6�� ... 12��
-- 14(��) .. 11(��) .. 7(��)
-- 1) ������� �ϳ��̴�.
-- 2) �÷��� ���� 1��~12������ 12��
-- 3) �����ʹ� ������� �հ��̴�.
-- DECODE / �Լ�       vs         CASE ~ END / ǥ����    <-----> ����Ŭ IF~ELSE��!
-- ����񱳸�!                            �����, ������~
-- DECODE (exp, serch1, result1,            CASE (exp WHEN search1 THEN result     or   CASE WHEN conditio
--              search2, result2,                     WHEN search1 THEN result
--               ...���...                           ELSE �⺻��
--              0 ) AS ��Ī                 END AS ��Ī

--      TO_CHAR()   TO_DATE()
-- ���� -----> ���� ------> ��¥
-- ���� <----- ���� <------ ��¥
--      TO_NUMBER()    TO_CHAR()
-- ���� --> ��¥ ��ȯ �ȵǹǷ�, ��ȯ�Լ��� Ȱ��!

SELECT  TO_CHAR(hire_date,'YYYY-MM-DD-DAY') ��¥
FROM    employees;


SELECT  DECODE(TO_CHAR(hire_date,'MM'),'01',COUNT(*),0) AS "1��",
        DECODE(TO_CHAR(hire_date,'MM'),'02',COUNT(*),0) AS "2��",
        DECODE(TO_CHAR(hire_date,'MM'),'03',COUNT(*),0) AS "3��",
        DECODE(TO_CHAR(hire_date,'MM'),'04',COUNT(*),0) AS "4��",
        DECODE(TO_CHAR(hire_date,'MM'),'05',COUNT(*),0) AS "5��",
        DECODE(TO_CHAR(hire_date,'MM'),'06',COUNT(*),0) AS "6��",
        DECODE(TO_CHAR(hire_date,'MM'),'07',COUNT(*),0) AS "7��",
        DECODE(TO_CHAR(hire_date,'MM'),'08',COUNT(*),0) AS "8��",
        DECODE(TO_CHAR(hire_date,'MM'),'09',COUNT(*),0) AS "9��",
        DECODE(TO_CHAR(hire_date,'MM'),'10',COUNT(*),0) AS "10��",
        DECODE(TO_CHAR(hire_date,'MM'),'11',COUNT(*),0) AS "11��",
        DECODE(TO_CHAR(hire_date,'MM'),'12',COUNT(*),0) AS "12��"
FROM    employees
GROUP BY TO_CHAR(hire_date,'MM')
ORDER BY TO_CHAR(hire_date,'MM');
    
-- �׷��Լ��� ���� �����κ��� �ϳ��� ��� ���� ��ȯ�Ѵ�. 


-- ���������� �ζ��� �� �ǽ���������
-- ���������� ���輺���̺� ���� DB�� �ݿ��ϰ�, ��� �濵�ϴµ� �Ƿ��� �����ͷ� �����ؼ� �����ؾ���





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






