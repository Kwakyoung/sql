-- 10��. ��������



-- ���Ἲ �������� : (Integrity Constraints) : �������� ��Ȯ���� �����ϱ� ���� �δ� ����/���� ����
-- 1) ���̺� ������ ���� : CREATE TABLE ~
-- 2) ���̺� ���� �� �߰� : ALTER TABLE ~




-- 10.1 NOT NULL �������� - NULL ������� ����
-- �÷��� ������ ���� �־� NULL ������� ���� ==> �ݵ�� �����͸� �Է��ؾ� �Ѵ�.
-- �� ���̺� ������ �÷� �������� �����Ѵ�
-- ex> ���̺� ���� ����
CREATE TABLE ���̺��(
    �÷���1 ������Ÿ��(����) ��������, -- �÷� ����
    �÷���2 ������Ÿ��(����)
);

CREATE TABLE user(
    id VARCHAR2(20) NOT NULL, -- �÷� ����
    nick VARCHAR2(20)
);

[����10-1] null_test ��� ���̺��� �����ϵ� �÷��� col1 ����Ÿ�� 5����Ʈ ����,NULL ��������ʰ�,
col2 ����Ÿ�� 5����Ʈ ���̷� �����Ͻÿ�~

-- 1) ���̺� ���� : null_test + not null
CREATE TABLE NULL_TEST(
    col1 VARCHAR2(5) NOT NULL,
    col2 VARCHAR2(5)
);

INSERT INTO null_test (col1)
VALUES ('AA'); -- AA | (null)

-- ��ȸ
SELECT  *
FROM NULL_TEST;

[����10-3] BB�� col2�� ����
INSERT INTO null_test (col2)
VALUES ('BB'); -- col1 NOT NULL ��������
-- ORA-01400: NULL�� ("HR"."NULL_TEST"."COL1") �ȿ� ������ �� �����ϴ�

-- 2) ���̺� ���� �� NOT NULL ����
-- �÷��� NULL �����Ͱ� ���� ���, NOT NULL�� �߰��� �� �ִ�.

UPDATE null_test
SET col2 = 'BB'; -- col2 �÷��� �����͸� null���� 'BB'�� ����

-- null_test�� �̹� BB�� col2 �÷��� �ִ� ����
[����10-4]
ALTER TABLE null_test
MODIFY  (col2 NOT NULL);

[����10-5] col2�� NULL�� �ٲپ�� ==> ���������� �߰��Ǿ�����, �����߻�!
-- col2�� NOT NULL�� �߰� ==> �����͸� NULL
UPDATE null_test
SET col2 = NULL; -- �����߻�

-- �ٽ� col2 �÷��� NULL ���
ALTER TABLE null_test
MODIFY (col2 NULL); -- col1, col2 ��� �����Ͱ� �ִ� <--> NULL�� �ƴϹǷ�

COMMIT;

-- ============ ����� �������� ������ (���̺���) ���������� ��� ��ϵ� ������ ���̺� ��ü ==============================
SELECT  constraint_name, constraint_type, owner
FROM    user_constraints
WHERE   table_name = 'NULL_TEST'; 






-- 10.2 CHECK �������� - ���� ����
-- 10.3 UNIQUE �������� - �ߺ�����
-- 10.4 PRIMARY KEY �������� - UNIQUE + NOT NULL
-- 10.5 FOREIGN KEY �������� - �ܷ�Ű

