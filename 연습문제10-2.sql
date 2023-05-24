-- [��������10-2]
-- hanul �������� Ǯ��


-- 1. �̸��� ������ ���� �迪���� ��� ����(=��� �÷�)�� ��ȸ
SELECT  *
FROM    characters
WHERE   email IS NULL;

-- 2. ������ �ý��� �ش��ϴ� �����ι��� ��ȸ
-- ���� ���� ���̺� : roles
SELECT  *
FROM    roles; -- �ý� : 1002 (role_id)

-- ĳ���� ���� ���̺� : characters
SELECT  *
FROM    characters -- �ý�, ������, �ݶ��� ==> �ý��� ���͸�!
WHERE   role_id = ( SELECT    role_id
                    FROM    roles
                    WHERE   role_name = '�ý�' );
                    
-- 3. ���Ǽҵ� 4�� �⿬�� ������ ���� �̸��� ��ȸ
-- star_wars : ��ȭ���� (���Ǽҵ� ���̵�, ���Ǽҵ��, ��������)
-- characters : �����ι����� (���̵�, �̸�, ������id, ����id, �̸���)
-- casting : �����ι��� �������(���Ǽҵ� id, ĳ����id, �����̸�)
SELECT  real_name
FROM    casting
WHERE   episode_id = 4;

INSERT INTO casting
VALUES (4, 1, '��ũ �ع�');
INSERT INTO casting
VALUES (4, 2, '�ظ��� ����');
INSERT INTO casting
VALUES (4, 3, 'ĳ�� �Ǽ�');

INSERT INTO casting
VALUES (5, 4, '�ٸ� ��Ͻ�');
INSERT INTO casting
VALUES (5, 5, '���̺�� ���ν�');
INSERT INTO casting
VALUES (5, 6, '���ӽ� �� ����');

INSERT INTO casting
VALUES (6, 7, '�ؼ��� ��Ͼ�');
INSERT INTO casting
VALUES (6, 8, '�ɴ� ����Ŀ');
INSERT INTO casting
VALUES (6, 9, '���� ������');

INSERT INTO casting
VALUES (1, 10, '���� �� ��������');
INSERT INTO casting
VALUES (1, 11, '����ũ ����');
INSERT INTO casting
VALUES (1, 12, '�̴� �ƴ��̵�');

INSERT INTO casting
VALUES (2, 13, '���̵� ũ�����ٽ�');
INSERT INTO casting
VALUES (2, 14, '���� �Ͻ�');
INSERT INTO casting
VALUES (2, 15, '��Ż�� ��Ʈ��');

INSERT INTO casting
VALUES (3, 16, '�丣�Ҷ� ���Ž�Ʈ');
INSERT INTO casting
VALUES (3, 17, '�Ƹ޵� ����Ʈ');
INSERT INTO casting
VALUES (3, 18, '���� ��ũ');

INSERT INTO casting
VALUES (3, 19, '�׹¶� �𸮽�');
INSERT INTO casting
VALUES (3, 20, '���¾� L. �轼');
INSERT INTO casting
VALUES (3, 21, 'ũ�������� ��');


-- 4. ���Ǽҵ�5 �� �⿬�� ������ �迪�̸��� �����̸�
-- �迪�̸� : character_name < characters ���̺�
-- �����̸� : real_name      < casting ���̺�
-- ���� ���� : �ٸ� ���̺��� �÷��� ������ ��ġ �ϳ��� ���̺��ΰ�ó�� �����͸� ��ȸ (����)
-- SET ���� : �÷��� ����, ������ Ÿ�Ը� ������ ��ġ �ϳ��� ���̺��� ������ ��ȸ�� ��� (����)

-- 4.1 ����Ŭ ����
-- 4.2 ANSI ���� : MYSQL �� �ٸ� RDBMS���� ���� �ٸ� ���� ���� => ǥ�� �������� ���� ���ο���

SELECT  ch.character_name AS �迪�̸�, 
        ca.real_name AS �����̸�
FROM    characters ch , casting ca      
WHERE   ch.character_id = ca.character_id  -- �������ǽ� : ī�׽þ� �� !
AND     ca.episode_id = 5;

-- 5. ����ǥ�� ���ι����� �ٲپ� �ۼ��Ͻÿ�
-- ANSI ���� : INNER JOIN , OUTER JOIN
-- ON�� : WHERE ������ ���
-- USING : �÷��� ��Ī/��� ���X

-- ���̺� ������ �϶� : ���� ������ ����� �ٽ� �߰��� �����ϴ� ����
-- (+) : ����Ŭ �ƿ��� ���� <--> [LEFT|RIGHT|FULL] OUTER JOIN
SELECT  c.character_name, p.real_name, r.role_name
FROM    characters c LEFT OUTER JOIN casting p
ON      c.character_id = p.character_id
RIGHT OUTER JOIN roles r
ON      c.role_id = r.role_id
AND     p.episode_id = 2;

-- ���Ǽҵ� 2�� �⿬�� 3���� �迪�� | ���� ���� | �����̸� �� ���;� ��
-- characters �����Ϳ� casting �����Ͱ� ����ġ : ���� ���� vs ���� ������ ����/����


-- 6. ���� �Լ��� �̿��� characters ���̺��� �迪�̸�, �̸���, �̸��� ���̵� ��ȸ�Ͻÿ�
-- SUBSTR() : ���ڿ� ����
-- INSTR() : Ư�� ���ڿ��� ������ġ�� ��ȯ
-- REPLACE() , TRANSLATE() : ġȯ / 1:1 ��ȯ
-- TRIM, LTRIM(), RTRIN() : ���ڿ�/�⺻�� ���� ����
-- LPAD(), RPAD() : ���ڿ� ���� �߰�
-- LENGTH() : ���ڿ� ���� ��ȯ

-- ��, �̸����� ���̵�@�������϶�!

SELECT  character_name AS �迪�̸�,
        email AS �̸���,
        SUBSTR(email, 1, INSTR(email, '@')-1 ) AS �̸���_���̵�
FROM    characters;



-- 7. ������ �����̿� �ش��ϴ� �迪���� �迪�̸��� ���� �������̸��� ��ȸ�Ͽ� ������ ����� �������� �ۼ��� �������̴�.
-- ��������
-- NULL ó�� �Լ� : NVL(), NVL2() 

SELECT  c.character_name,
        m.character_name
FROM    characters c, characters m
WHERE   c.master_id = m.character_id; -- ��������


-- ��Į�� �������� : ���� �� ��ȯ (�÷�ó��) : x 
SELECT  c.character_name, NVL(m.character_name, '?') AS master_name
FROM    characters c , roles r , characters m
WHERE   c.role_id = r.role_id
AND     r.role_name = '������'
AND     c.master_id = m.character_id(+)
ORDER BY 1;
