[��������8-1]

1. EMP ���̺� (������) ������ ���� �����Ͻÿ�

DESC emp;

SELECT  *
FROM    emp;
-- DML : INSERT, UPDATE, DELETE
INSERT INTO emp (emp_id, fname, lname, hire_date, salary)
VALUES (400, 'Johns','Hopkins',TO_DATE('2008/10/15','YYYY/MM/DD'),5000);
INSERT INTO emp (emp_id, fname, lname, hire_date, salary)
VALUES (401, 'Abraham','Lincoln',TO_DATE('2010/03/03','YYYY/MM/DD'),12500);
INSERT INTO emp (emp_id, fname, lname, hire_date, salary)
VALUES (402, 'Tomas','Edison',TO_DATE('2013/06/21','YYYY/MM/DD'),6300);

-- �Ǵ� VALUES �����ϰ�,
-- SELECT ~ ���� : ITAS

--UPDATE ���̺��
--SET �÷���
--WHERE ����;

--DELETE FROM ���̺��
--WHERE ����;


2. EMP ���̺��� ��� 401�� ����� �μ��ڵ带 90����, �����ڵ带 SA_MAN���� �����ϰ� ������ ���� ������ Ȯ���Ѵ�.
UPDATE  emp
SET     dept_id = 90,
        job_id = 'SA_MAN'
WHERE   emp_id = 401;

-- ������ ������ Ȯ��
COMMIT;





3. EMP ���̺��� �޿��� 8000 �̸��� ��� ����� �μ��ڵ带 80������ �����ϰ�, �޿��� employees ���̺���
80�� �μ��� ��� �޿��� ������ �����Ѵ�.
(��, ��ձ޿��� �ݿø��� ������ ����Ѵ�.)

SELECT  *
FROM    emp
WHERE   salary < 8000;

-- EMPLOYEES ���̺��� 80�� �μ����� ��� �޿� ��ȸ
SELECT (ROUND(AVG(salary)))
FROM    employees
WHERE   department_id = 80;  -- 8956

SELECT department_id,(ROUND(AVG(salary)))
FROM    employees
WHERE   department_id = 80
GROUP BY department_id;

-- ������ ����
UPDATE  emp
SET     dept_id = 80,
        salary = (  SELECT ROUND(AVG(salary))
                    FROM    employees
                    WHERE   department_id = 80 )
WHERE   salary < 8000;

-- Ȯ��
SELECT   *
FROM    emp;



4. EMP ���̺��� 2010�� ���� �Ի��� ����� ������ �����Ѵ�.
-- TO_CHAR(hire_date, 'YYYY')
-- 2009�� 12�� 31�� ����(����), 2010�� 1�� 1�� �̸�

-- ��ȸ
SELECT  *
FROM    emp
--WHERE   hire_date <= '2009-12-31';
WHERE   TO_CHAR(hire_date, 'YYYY') <= TO_CHAR('2010');

-- ����
DELETE  FROM    emp
WHERE   hire_date < ('2009-12-31');

















