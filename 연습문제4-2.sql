[�������� 4-2]

1. ��� ���̺��� Ŀ�̼��� �޴� ����� ��� ������� �� ���� ��ȸ�ϴ� �������� �ۼ��Ѵ�.
-- NULL�� ���� ����
SELECT  COUNT(commission_pct) AS "Ŀ�̼� �޴� ��� ��"
FROM    employees;  -- 35 rows

/*
SELECT  *
FROM    employees
WHERE   commission_pct IS NOT NULL;  Ŀ�̼����� NULL �ƴѻ�� ==> �Ǹźμ����� Ŀ�̼� ����!
*/

2. ���� �ֱٿ� ���� ������ �Ի��Ų ��¥�� �������� �ֱ� �Ի����ڸ� ��ȸ�ϴ� �������� �ۼ��Ѵ�.

SELECT  MAX(hire_date)
FROM    employees;

/*
SELECT  employee_id, first_name, hire_date
FROM    employees
ORDER BY 3 DESC;
*/

3. 90�� �μ��� ��ձ޿����� ��ȸ�ϴ� �������� �ۼ��Ѵ�.
��, ��� �޿����� �Ҽ� ��°�ڸ����� ǥ��ǵ��� �Ѵ�
-- SUM(), AVG() : ���� ������ �÷��� ��/����� ����Ͽ� ��ȯ�ϴ� �Լ�
-- MAX(), MIN() : ��� ������ �÷��� ���밡��
-- ROUND(n [,i]) : �Ҽ��� ���� i��° �ڸ��� �ݿø��� ����� ��ȯ�ϴ� �Լ�
-- ��¥�����Ϳ��� ROUND(date,[,fmt]) �������� �ݿø��� ����� ��ȯ
SELECT  TO_CHAR(ROUND(AVG(salary),2),'999,999') AS "90�� �μ��� ��� �޿���1",
        ROUND(AVG(salary),2) AS "90�� �μ��� ��� �޿���2"
FROM    employees
WHERE   department_id = 90;

