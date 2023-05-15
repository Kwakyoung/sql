-- 7��. SET ������(p.63)
-- ������� ���̺��� �����͸� �ϳ��� ��ȸ�Ҷ� ��� ==> ���ֻ������ ������..

-- 5�� JOIN����. ���̺�(�� �÷�)�� ���η� �����ϴ� ����
-- 7�� SET������. ���̺�(�� ������/��)�� ���η� �����ϴ� ����

-- �� SET �����ڷ� ���̴� �� SELECT���� (1)�÷��� ��  (2)������ Ÿ���� ��ġ�ؾ��Ѵ�.
-- ��ȸ�Ǵ� �÷����� ù���� �������� �÷����� ���ȴ�.
-- ORDER BY ��� �������� ���� �������� ����Ѵ�.


-- 7.1 UNION     : ������
-- 7.2 UNION ALL : ������
-- 7.3 INTERSECT : ������
-- 7.4 MINUS     : ������



-- 7.1 UNION : ������
-- ���տ��� �����տ� �ش��ϴ� ������, �ߺ��� ������ ���� ����� ��ȯ�Ѵ�.
[���� 7-1]
SELECT  1,3,4,5,7,8,'A'  AS first -- ��ȸ�Ǵ� �÷Ÿ��� ù��° �������� �÷����� ���ȴ�.
FROM    dual
UNION
SELECT  2,4,5,6,8,NULL,'B'  AS second
FROM    dual
UNION
SELECT  1,3,4,5,7,8,'A' AS third
FROM    dual;

[���� 7-2] �����ǰ� �ִ� �μ�, �����ǰ� �ִ� ���� ������ ��ȸ�Ѵ�.
SELECT  department_id AS code, department_name AS name
FROM    departments
UNION
SELECT  location_id, city
FROM    locations;





-- 7.2 UNION ALL
-- UNION A
[���� 7-4]
SELECT  1,3,4,5,7,8,'A'  AS first -- ��ȸ�Ǵ� �÷Ÿ��� ù��° �������� �÷����� ���ȴ�.
FROM    dual
UNION ALL  -- ������ SET ������
SELECT  2,4,5,6,8,NULL,'B'  AS second
FROM    dual
UNION ALL
SELECT  1,3,4,5,7,8,'A' AS third
FROM    dual;

[����7-7] 80�� �μ��� 50�� �μ��� �������� �ִ� ����� �̸��� ��ȸ�Ѵ�.
SELECT  first_name
FROM    employees
WHERE   department_id = 80  -- 34rows / �Ǹ� or ��� �μ�
INTERSECT    -- ������
SELECT  first_name
FROM    employees
WHERE   department_id = 50; -- 45rows / �Ǹ� or ��� �μ�




-- 7.4 MINUS : ������
-- ���տ��� �����տ� �ش��ϴ� ������.
[���� 7-9] 80�� �μ����� �̸����� 50�� �μ����� �̸��� �����Ѵ�.
SELECT  first_name
FROM    employees
WHERE   department_id =80;
MINUS
SELECT  first_name
FROM    employees
WHERE   d                                                                                                                                                               




