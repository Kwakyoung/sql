[��������3-4]

1. ����� ���, �̸�, �μ�, �Ŵ�����ȣ�� ��ȸ�ϴ� �������� �ۼ��Ѵ�
��, �Ŵ����� �ִ� ����� �Ŵ���, �Ŵ����� ���� ����� No Manager�� ǥ���ϵ��� �Ѵ�

-- �Ŵ���_���̵� NULL : BOSS (��ǥ�� Ȥ�� ȸ���) 
-- �Ϲ� ��� : �μ��� �Ҽ��� �Ǿ��ְ�, �����ϴ� ���(=�Ŵ���)�� �ִ�.
-- �� manager_id : ����� �ĺ��� ( ��� employee_id)

-- 1) NVL(exp1, exp2) : exp1�� NULL�̸� exp2 ��ȯ, �ƴϸ� exp1 ��ȯ
-- 2) NVL2(exp1, exp2, exp3) : exp1�� NULL�̸� exp3 ��ȯ, NULL �ƴϸ� exp2 ��ȯ
-- 3) COALESCE(exp1, exp2, ..) : ���ʷ� NULL �ƴ� exp ��ȯ
-- ��ȯ�Լ� : ����    ����    ��¥
--           number  char    date
SELECT  employee_id, first_name, department_id,NVL2(manager_id, TO_CHAR(manager_id), 'NO Manager') AS manager
FROM    employees;
  