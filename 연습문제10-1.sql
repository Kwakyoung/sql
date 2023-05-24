[�������� 10-1]
HANUL �������� Ǯ��

-- 1~3 ���� ���̺��� �����Ͻÿ� (DDL : CREATE TABLE ~)

-- 1. ��ȭ ���� ���̺� ����
CREATE TABLE star_wars(
    episode_id      NUMBER(5) PRIMARY KEY,
    episode_name    VARCHAR2(50),
    open_year       NUMBER(4)
);
-- �߰�����
ALTER TABLE star_wars
MODIFY episode_name NOT NULL;




-- 2. �����ι� ���� ���̺� ����
CREATE TABLE characters(
    character_id    NUMBER(5) PRIMARY KEY,  -- �÷� �������� ����
    character_name  VARCHAR2(30) NOT NULL,
    master_id       NUMBER(5),
    role_id         NUMBER(5),
    email           VARCHAR2(40)
);

SELECT  *
FROM    user_constraints
WHERE   table_name='CHARACTERS';




-- 3. �����ι��� ���� �迪���� ���̺� ����
CREATE TABLE casting(
    episode_id NUMBER(5),
    character_id NUMBER(5),
    real_name   VARCHAR2(30) NOT NULL,
    CONSTRAINT casting_episode_id_pk PRIMARY KEY (episode_id, character_id) -- ����Ű
);




-- 4. star_wars ���̺� ������ �Է�
INSERT INTO star_wars
VALUES (4, '���ο� ���(A New Hope)', 1977);
INSERT INTO star_wars
VALUES (5, '������ ���� (The Empire Strikes Back)', 1980);
INSERT INTO star_wars
VALUES (6, '�������� ��ȯ(Return of Jedi)', 1983);
INSERT INTO star_wars
VALUES (1, '������ �ʴ� ����(The Phantom Menace)', 1999);
INSERT INTO star_wars
VALUES (2, 'Ŭ���� ����(Attack of the Clones)' 2002);
INSERT INTO star_wars
VALUES (3, '�ý��� ����(Revenge of the Sith)', 2005);

SELECT  *
FROM    star_wars;


-- 5. characters ���̺� ������ ����
INSERT INTO characters (character_id, character_name, email)
VALUES (1, '��ũ ��ī�̿�Ŀ', 'luke@jedai.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (2, '�� �ַ�', 'solo@alliance.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (3, '���̾� ����', 'leia@alliance.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (4, '����� �ɳ��', 'Obi-Wan@jedai.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (5, '�پ� ���̴�', 'vader@sith.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (6, '�پ� ���̴�(��Ҹ�)', 'vader_voice@sith.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (7, 'C-3PRO', 'c3po@alliance.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (8, 'R2-D2', 'r2d2@alliance.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (9, '���ī', 'Chewbacca@alliance.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (10, '���� Į���þ�', NULL);
INSERT INTO characters (character_id, character_name, email)
VALUES (11, '���', 'yoda@jedai.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (12, '�ٽ� �õ�', 'sidious@jedai.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (13, '�Ƴ�Ų ��ī�̿�Ŀ', 'Anakin@jedai.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (14, '���̰� ��', NULL);
INSERT INTO characters (character_id, character_name, email)
VALUES (15, '�ƹ̴޶� ����', NULL);
INSERT INTO characters (character_id, character_name, email)
VALUES (16, '�Ƴ�Ų ��Ӵ�', NULL);
INSERT INTO characters (character_id, character_name, email)
VALUES (17, '���ں�ũ��(��Ҹ�)', NULL);
INSERT INTO characters (character_id, character_name, email)
VALUES (18, '�پ� ��', 'maul@sith.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (19, '��� ��', NULL);
INSERT INTO characters (character_id, character_name, email)
VALUES (20, '������ ����', 'windu@jedai.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (21, '���� ����', 'dooku@jedai.com');


-- 6. roles ���̺� ����, ������ ����
CREATE TABLE roles (
    role_id     NUMBER(4),
    role_name   VARCHAR2(30)
);

INSERT INTO roles
VALUES  (1001,'������');
INSERT INTO roles
VALUES  (1002,'�ý�');
INSERT INTO roles
VALUES  (1003,'�ݶ���');



-- 7. characters ���̺��� role_id �÷��� �����Ͱ� roles ���̺��� role_id �÷��� �����͸�
-- �����ϵ��� characters ���̺� ����Ű�� �����Ͻÿ�

-- 7.1 roles ���̺��� role_id�� �⺻Ű�� �����ؾ� �ؿ������� ����
ALTER TABLE roles
ADD CONSTRAINT roles_id_pk PRIMARY KEY (role_id);

-- 7.2 ���̺� ������ �� �������� ����
ALTER TABLE characters
ADD CONSTRAINT  characters_role_id_fk FOREIGN KEY (role_id) REFERENCES roles (role_id);

-- 7.3 Ȯ��
INSERT INTO characters (character_id, character_name, email, role_id)
VALUES (22, '�����Ǵ�', 'c3po@alliance.com', 1003);
ROLLBACK;

SELECT  *
FROM    characters;


-- 8. DML : UPDATE - �����ؼ� �����͸� ����
UPDATE  characters
SET     role_id = 1002
WHERE   email LIKE '%sith%'; -- 3rows

UPDATE  characters
SET     role_id = 1003
WHERE   email LIKE '%alliance%'; -- 5rows

UPDATE  characters
SET     role_id = 1001
WHERE   character_name IN('��ũ ��ī�̿�Ŀ','����� �ɳ��', '���', '�Ƴ�Ų ��ī�̿�Ŀ',
                          '���̰� ��', '������ ����', '���� ����');

SELECT  *
FROM    characters;

COMMIT;



-- 9. characters ���̺��� master_id�÷��� employees ���̺��� manager_id�� ���� ������ �Ѵ�.
-- �Ŵ��� ����� ��� : manager_id
-- master_id : ĳ������ �������� ĳ���� id 
SELECT *
FROM   characters; -- master_id�� NULL �ε�, �����Ϳ� �ش��ϴ� ĳ������ id�� �˸°� ����

SELECT  character_id
FROM    characters
WHERE   character_name = '����� �ɳ��';


UPDATE characters
SET master_id = ( SELECT  character_id
                    FROM    characters
                    WHERE   character_name = '����� �ɳ��' )
WHERE  character_name IN ('�Ƴ�Ų ��ī�̿�Ŀ' , '��ũ ��ī�̿�Ŀ');

UPDATE characters
SET master_id = ( SELECT  character_id
                    FROM    characters
                    WHERE   character_name = '�ٽ� �õ�' )
WHERE  character_name IN ('�پ� ���̴�' , '�پ� ��');

UPDATE characters
SET master_id = ( SELECT  character_id
                    FROM    characters
                    WHERE   character_name = '���̰� ��' )
WHERE  character_name = '����� �ɳ��';

SELECT  *
FROM    characters;


-- 10. casting ( �����ι��� ���� ��� ���� ���̺� )�� �⺻Ű�� episode_id, character_id
-- �� �÷��� ���� star_wars�� characters ���̺��� �⺻Ű�� �����ϰ� �ִ�.
-- ����Ű�� �����϶�

-- �������� : NOT NULL, CHECK , UNIQUE , PRIMARY KEY , FOREIGN KEY
--             �÷�   , �÷�/���̺� ~
--                              <- ����Ű                       ->

-- ���̺� ������ �������� ���� : �÷�/���̺� ����

-- �̹� ���̺��� ������ �� �������� �߰�
-- star_wras ���̺��� episode_id �÷��� �����ϴ� casting ���̺��� episode_id �÷��� FK �������� ����
ALTER TABLE casting
ADD CONSTRAINT star_wars_episode_id_fk FOREIGN KEY (episode_id) REFERENCES star_wars (episode_id);

-- characters ���̺��� character_id �÷��� �����ϴ� casting ���̺��� character_id �÷��� FK �������� ����
ALTER TABLE casting
ADD CONSTRAINT characters_character_id_episode_id_fk FOREIGN KEY (character_id) REFERENCES characters (character_id);



