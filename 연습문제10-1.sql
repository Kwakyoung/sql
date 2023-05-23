[연습문제 10-1]
HANUL 계정으로 풀이

-- 1~3 다음 테이블을 생성하시오 (DDL : CREATE TABLE ~)

-- 1. 영화 정보 테이블 생성
CREATE TABLE star_wars(
    episode_id      NUMBER(5) PRIMARY KEY,
    episode_name    VARCHAR2(50),
    open_year       NUMBER(4)
);
-- 추가수정
ALTER TABLE star_wars
MODIFY episode_name NOT NULL;




-- 2. 등장인물 정보 테이블 생성
CREATE TABLE characters(
    character_id    NUMBER(5) PRIMARY KEY,  -- 컬럼 레벨에서 정의
    character_name  VARCHAR2(30) NOT NULL,
    master_id       NUMBER(5),
    role_id         NUMBER(5),
    email           VARCHAR2(40)
);

SELECT  *
FROM    user_constraints
WHERE   table_name='CHARACTERS';




-- 3. 등장인물과 실제 배역정보 테이블 생성
CREATE TABLE casting(
    episode_id NUMBER(5),
    character_id NUMBER(5),
    real_name   VARCHAR2(30) NOT NULL,
    CONSTRAINT casting_episode_id_pk PRIMARY KEY (episode_id, character_id) -- 복합키
);




-- 4. star_wars 테이블에 데이터 입력
INSERT INTO star_wars
VALUES (4, '새로운 희망(A New Hope)', 1977);
INSERT INTO star_wars
VALUES (5, '제국의 역습 (The Empire Strikes Back)', 1980);
INSERT INTO star_wars
VALUES (6, '제다이의 귀환(Return of Jedi)', 1983);
INSERT INTO star_wars
VALUES (1, '보이지 않는 위험(The Phantom Menace)', 1999);
INSERT INTO star_wars
VALUES (2, '클론의 습격(Attack of the Clones)' 2002);
INSERT INTO star_wars
VALUES (3, '시스의 복수(Revenge of the Sith)', 2005);

SELECT  *
FROM    star_wars;


-- 5. characters 테이블에 데이터 저장
INSERT INTO characters (character_id, character_name, email)
VALUES (1, '루크 스카이워커', 'luke@jedai.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (2, '한 솔로', 'solo@alliance.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (3, '레이아 공주', 'leia@alliance.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (4, '오비완 케노비', 'Obi-Wan@jedai.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (5, '다쓰 베이더', 'vader@sith.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (6, '다쓰 베이더(목소리)', 'vader_voice@sith.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (7, 'C-3PRO', 'c3po@alliance.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (8, 'R2-D2', 'r2d2@alliance.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (9, '츄바카', 'Chewbacca@alliance.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (10, '랜도 칼리시안', NULL);
INSERT INTO characters (character_id, character_name, email)
VALUES (11, '요다', 'yoda@jedai.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (12, '다스 시디어스', 'sidious@jedai.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (13, '아나킨 스카이워커', 'Anakin@jedai.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (14, '콰이곤 진', NULL);
INSERT INTO characters (character_id, character_name, email)
VALUES (15, '아미달라 여왕', NULL);
INSERT INTO characters (character_id, character_name, email)
VALUES (16, '아나킨 어머니', NULL);
INSERT INTO characters (character_id, character_name, email)
VALUES (17, '자자빙크스(목소리)', NULL);
INSERT INTO characters (character_id, character_name, email)
VALUES (18, '다쓰 몰', 'maul@sith.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (19, '장고 펫', NULL);
INSERT INTO characters (character_id, character_name, email)
VALUES (20, '마스터 윈두', 'windu@jedai.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (21, '두쿠 백작', 'dooku@jedai.com');


-- 6. roles 테이블 생성, 데이터 삽입
CREATE TABLE roles (
    role_id     NUMBER(4),
    role_name   VARCHAR2(30)
);

INSERT INTO roles
VALUES  (1001,'제다이');
INSERT INTO roles
VALUES  (1002,'시스');
INSERT INTO roles
VALUES  (1003,'반란군');



-- 7. characters 테이블의 role_id 컬럼의 데이터가 roles 테이블의 role_id 컬럼의 데이터를
-- 참조하도록 characters 테이블에 참조키를 생성하시오

-- 7.1 roles 테이블의 role_id를 기본키로 지정해야 밑에동작이 가능
ALTER TABLE roles
ADD CONSTRAINT roles_id_pk PRIMARY KEY (role_id);

-- 7.2 테이블 생성된 후 제약조건 지정
ALTER TABLE characters
ADD CONSTRAINT  characters_role_id_fk FOREIGN KEY (role_id) REFERENCES roles (role_id);

-- 7.3 확인
INSERT INTO characters (character_id, character_name, email, role_id)
VALUES (22, '완전악당', 'c3po@alliance.com', 1003);
ROLLBACK;

SELECT  *
FROM    characters;


-- 8. DML : UPDATE - 변경해서 데이터를 저장
UPDATE  characters
SET     role_id = 1002
WHERE   email LIKE '%sith%'; -- 3rows

UPDATE  characters
SET     role_id = 1003
WHERE   email LIKE '%alliance%'; -- 5rows

UPDATE  characters
SET     role_id = 1001
WHERE   character_name IN('루크 스카이워커','오비완 케노비', '요다', '아나킨 스카이워커',
                          '콰이곤 진', '마스터 윈두', '두쿠 백작');

SELECT  *
FROM    characters;

COMMIT;
