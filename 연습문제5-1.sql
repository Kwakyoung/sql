[��������5-1]

1. �̸��� �ҹ��� v�� ���Ե� ��� ����� ���, �̸�, �μ����� ��ȸ�ϴ� �������� �ۼ��Ѵ�.
SELECT  employee_id , first_name , department_id
FROM    employees
WHERE   first_name LIKE '%v%' ;



2. Ŀ�̼��� �޴� ����� ���, �̸�, �޿�, Ŀ�̼� �ݾ�, �μ����� ��ȸ�ϴ� �������� �ۼ��Ѵ�.
��, Ŀ�̼� �ݾ��� ���޿��� ���� Ŀ�̼� �ݾ��� ��Ÿ����
-- commission_pct : NULL ( �Ǹźμ��� �ƴ� ����� )
-- NULL ó�� : �񱳴��x ==> NVL(), NVL2()
-- Ŀ�̼� �ݾ� : salary * commission_pct
-- Ŀ�̼� �޴� ��� : 35�� ( 1���� �μ��� ������ )
SELECT  e.employee_id, e.first_name, e.salary, e.salary, e.salary * e.commission_pct AS comm_pct,
        d.department_name
FROM    employees e, departments d
WHERE   e.commission_pct IS NOT NULL        -- ���� ?
AND     e.department_id = d.department_id
ORDER BY 1;


3. �� �μ��� �μ��ڵ�, �μ���, ��ġ�ڵ�, ���ø�, �����ڵ�, �������� ��ȸ�ϴ� �������� �ۼ��Ѵ�.
-- ���� ���̺� : �μ����� ���̺�(�μ��ڵ�, �μ���, ��ġ�ڵ�)
-- ��� ���̺� : ��ġ ���̺�(���ø�, �����ڵ�) �������� ���̺�(������)

SELECT  d.department_id, d.department_name, d.location_id,
        l.city, l.country_id,
        c.country_name
FROM    departments d, locations l, countries c
WHERE   d.location_id = l.location_id
AND     l.country_id = c.country_id
ORDER BY 1; -- 27 rows



4. ����� ���, �̸�, �����ڵ�, �Ŵ����� ���, �Ŵ����� �̸�, �Ŵ����� �����ڵ带 ��ȸ�Ͽ�
����� ��� ������ �����ϴ� �������� �ۼ��Ѵ�.

SELECT 


5. ��� ����� ���, �̸�, �μ���, ���ø�, �����ּ� ������ ��ȸ�Ͽ� ��� ������ �����ϴ�
�������� �ۼ��Ѵ�.
