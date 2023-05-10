[��������3-3]

1. ��� ���̺��� 30�� �μ����� ���, ����, �޿�, �ٹ� ���� ���� ��ȸ�ϴ� �������� �ۼ��Ѵ�.
(��, �ٹ� ���� ���� ���� ��¥�� �������� ��¥ �Լ��� ����Ͽ� ����Ѵ�)
-- ��¥ �Լ�
-- 1. ������ n ���� ��¥ ��ȯ : ADD_MONTHS(date, n)
-- 2. �� ��¥ ������ �������� ���, ��ȯ : MONTHS_BETWEEN(date1, date2) / date1 : ���ĳ�¥

-- 3. ���ϴ� �÷� ��ȸ
-- ����, �ݿø� �Լ� ==> �Ҽ��� ù° �ڸ� or ����
SELECT  employee_id, first_name, salary, 
        ROUND(MONTHS_BETWEEN(SYSDATE, hire_date),0) AS "�ٹ� ���� ��1 �ݿø�", 
        TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date),0) AS "�ٹ� ���� ��2"
FROM    employees  -- 1. ���̺��� ���� ã�´�.
WHERE   department_id = 30;  -- 2. ���͸�  - 6 rows



2. �޿��� 12000 �޷� �̻��� ����� ���, ����, �޿��� ��ȸ�Ͽ� �޿� ������ ����� �����Ѵ�.
(��, �޿��� õ���� ���� ��ȣ�� ����Ͽ� ǥ���ϵ��� �Ѵ�)

-- p.31 TO_CHAR(number [,fmt])
-- , : õ ���� ǥ��
-- 9 : ���� �ϳ� ǥ��
-- $ : �޷�ǥ��
-- L : ����(=����) ��ȭ��ȣ ǥ��(WON, YEN, ...)
SELECT  employee_id, first_name||' '||last_name name, TO_CHAR(salary,'99,999') AS �޿�
FROM    employees
WHERE   salary>=12000
ORDER BY salary DESC;




3. 2005�� ������ �Ի��� ������� ���, ����, �Ի���, ���� ���� ������ ��ȸ�ϴ� �������� �ۼ��Ѵ�.
(��, ���� ���� �����̶� �Ի��Ͽ� �ش��ϴ� ������ �����Ѵ�)
-- TO_CHAR(date, 'YYYY') : �⵵ 4�ڸ����� ���ڷ� ��ȯ�Ͽ� ��ȯ�ϴ� �Լ�
-- 2004�� 12�� 31�� ����
-- 2005�� 1�� 1�� �̸�
-- NEXT_DAT(date, '��������') : ���ƿ��� ����
-- LAST_DAY(date) : date�� �޿� ������ ���ڸ� ��ȯ�ϴ� �Լ�

SELECT  employee_id, first_name||' '||last_name name, hire_date, TO_CHAR(hire_date, 'day')  AS "���� ���� ����"
FROM    employees
-- WHERE   hire_date<2005-01-01;
WHERE TO_CHAR(hire_date, 'YYYY')<2005
ORDER BY 3 DESC;

ALTER SESSION SET NLS_DATE_FORMAT = 'RR/MM/DD';
