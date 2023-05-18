[��������6-2]

1. �μ���ġ�ڵ尡 1700�� �ش��ϴ� ��� ����� ���, �̸�, �μ��ڵ�, �����ڵ带 ��ȸ�ϴ� ��������
������ ���������� �ۼ��Ѵ�.
-- ����� ������ �� ==> IN, ANY(=SOME), ALL �̷���~

-- 1.1 �������� ���� ��ȸ
SELECT  employee_id, first_name, department_id, job_id
FROM    employees
WHERE   department_id IN (10,30,90,100,110); -- 10, 30, 90, 100, 110 / 120~270 ����

-- 1.2 ���������� ��ȸ
SELECT  employee_id, first_name, department_id, job_id
FROM    employees
WHERE   department_id IN ( SELECT department_id
                            FROM  departments
                            WHERE location_id = 1700); -- 18 rows
-- IN , =ANY �Ѵ� ����


-- ���� �޿��� ���̹޴� : MAX(salary) ==> ���� �� �Լ�!  ���� �� �������� Ư¡!
2. �μ����� ���� �޿��� ���� �޴� ����� ���, �̸�, �μ���ȣ, �޿�, �����ڵ带 ��ȸ�ϴ� ��������
���� �÷� ���������� ����Ͽ� �ۼ��Ѵ�.
SELECT  employee_id, first_name, department_id, salary, job_id
FROM    employees
WHERE   (department_id, salary) IN ( SELECT department_id, MAX(salary)    
                                    FROM   employees
                                    GROUP BY department_id);




[��������6-3]
1. �� �μ��� ���� �μ��ڵ�, �μ���, �μ��� ��ġ�� �����̸��� ��ȸ�ϴ� �������� 
��Į�� ���������� �ۼ��Ѵ�.
-- ��ȣ���� �������� ���� : �������� �÷��� ���������� ���� �������� ���Ǵ� --> ���������� ����?
SELECT department_id, department_name,
       ( SELECT city
         FROM   locations l
         WHERE  l.location_id = d.location_id ) AS city_name
FROM    departments d;




[�������� 6-4]
1. �޿��� ���� ���� 5�� ����� ����, ���, �̸�, �޿��� ��ȸ�ϴ� �������� �ζ��� �� ���������� �ۼ��Ѵ�.
SELECT  ROWNUM AS RANK, e.*
FROM    ( SELECT    employee_id, first_name, salary
          FROM      employees
          ORDER BY  salary ASC ) e
WHERE   ROWNUM <= 5;

-- �����Լ�
SELECT  ROWNUM as rank,
        RANK() OVER(ORDER BY e.salary) AS rank1,
        e.*
FROM    ( SELECT employee_id, first_name, salary
          FROM   employees
          ORDER BY salary )e
WHERE ROWNUM <= 5;



2. �μ����� ���� �޿��� ���� �޴� ����� ���, �̸�, �μ���ȣ, �޿�, �����ڵ带 ��ȸ�ϴ� ��������
�ζ��� �� ���������� ����Ͽ� �ۼ��Ѵ�.
SELECT department_id, MAX(salary)
FROM    employees
WHERE   department_id IS NOT NULL
GROUP BY department_id
ORDER BY 1;







