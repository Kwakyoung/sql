-- [연습문제10-2]
-- hanul 계정으로 풀이


-- 1. 이메일 정보가 없는 배역들의 모든 정보(=모든 컬럼)를 조회
SELECT  *
FROM    characters
WHERE   email IS NULL;

-- 2. 역할이 시스에 해당하는 등장인물을 조회
-- 역할 정보 테이블 : roles
SELECT  *
FROM    roles; -- 시스 : 1002 (role_id)

-- 캐릭터 정보 테이블 : characters
SELECT  *
FROM    characters -- 시스, 제다이, 반란군 ==> 시스만 필터링!
WHERE   role_id = ( SELECT    role_id
                    FROM    roles
                    WHERE   role_name = '시스' );
                    
-- 3. 에피소드 4에 출연한 배우들의 실제 이름을 조회
-- star_wars : 영화정보 (에피소드 아이디, 에피소드명, 개봉연도)
-- characters : 등장인물정보 (아이디, 이름, 마스터id, 역할id, 이메일)
-- casting : 등자인물과 배우정보(에피소드 id, 캐릭터id, 실제이름)
SELECT  real_name
FROM    casting
WHERE   episode_id = 4;

INSERT INTO casting
VALUES (4, 1, '마크 해밀');
INSERT INTO casting
VALUES (4, 2, '해리슨 포드');
INSERT INTO casting
VALUES (4, 3, '캐리 피셔');

INSERT INTO casting
VALUES (5, 4, '앨릭 기니스');
INSERT INTO casting
VALUES (5, 5, '데이비드 프로스');
INSERT INTO casting
VALUES (5, 6, '제임스 얼 존스');

INSERT INTO casting
VALUES (6, 7, '앤서니 대니얼스');
INSERT INTO casting
VALUES (6, 8, '케니 베이커');
INSERT INTO casting
VALUES (6, 9, '피터 메이휴');

INSERT INTO casting
VALUES (1, 10, '빌리 디 윌리엄스');
INSERT INTO casting
VALUES (1, 11, '프랭크 오즈');
INSERT INTO casting
VALUES (1, 12, '이더 맥더미드');

INSERT INTO casting
VALUES (2, 13, '헤이든 크리스텐슨');
INSERT INTO casting
VALUES (2, 14, '리엄 니슨');
INSERT INTO casting
VALUES (2, 15, '나탈리 포트만');

INSERT INTO casting
VALUES (3, 16, '페르닐라 오거스트');
INSERT INTO casting
VALUES (3, 17, '아메드 베스트');
INSERT INTO casting
VALUES (3, 18, '레이 파크');

INSERT INTO casting
VALUES (3, 19, '테뮤라 모리슨');
INSERT INTO casting
VALUES (3, 20, '새뮤얼 L. 잭슨');
INSERT INTO casting
VALUES (3, 21, '크리스토퍼 리');


-- 4. 에피소드5 에 출연한 배우들의 배역이름과 실제이름
-- 배역이름 : character_name < characters 테이블
-- 실제이름 : real_name      < casting 테이블
-- 조인 연산 : 다른 테이블의 컬럼을 가져와 마치 하나의 테이블인것처럼 데이터를 조회 (수평)
-- SET 연산 : 컬럼의 갯수, 데이터 타입만 맞으면 마치 하나의 테이블에서 데이터 조회한 결과 (수직)

-- 4.1 오라클 조인
-- 4.2 ANSI 조인 : MYSQL 등 다른 RDBMS에서 각기 다른 조인 문법 => 표준 문법으로 만든 조인연산

SELECT  ch.character_name AS 배역이름, 
        ca.real_name AS 실제이름
FROM    characters ch , casting ca      
WHERE   ch.character_id = ca.character_id  -- 조인조건식 : 카테시안 곱 !
AND     ca.episode_id = 5;

-- 5. 국제표준 조인문으로 바꾸어 작성하시오
-- ANSI 조인 : INNER JOIN , OUTER JOIN
-- ON절 : WHERE 조건절 대신
-- USING : 컬럼의 별칭/약어 사용X

-- 테이블 여러개 일때 : 먼저 조인한 결과에 다시 추가로 조인하는 형식
-- (+) : 오라클 아우터 조인 <--> [LEFT|RIGHT|FULL] OUTER JOIN
SELECT  c.character_name, p.real_name, r.role_name
FROM    characters c LEFT OUTER JOIN casting p
ON      c.character_id = p.character_id
RIGHT OUTER JOIN roles r
ON      c.role_id = r.role_id
AND     p.episode_id = 2;

-- 에피소드 2편 출연자 3명의 배역명 | 실제 배우명 | 역할이름 이 나와야 함
-- characters 데이터와 casting 데이터간 불일치 : 교재 제공 vs 직접 데이터 수집/가공


-- 6. 문자 함수를 이용해 characters 테이블의 배역이름, 이메일, 이메일 아이디를 조회하시오
-- SUBSTR() : 문자열 추출
-- INSTR() : 특정 문자열의 시작위치를 반환
-- REPLACE() , TRANSLATE() : 치환 / 1:1 변환
-- TRIM, LTRIM(), RTRIN() : 문자열/기본값 공백 제거
-- LPAD(), RPAD() : 문자열 공백 추가
-- LENGTH() : 문자열 길이 반환

-- 단, 이메일이 아이디@도메인일때!

SELECT  character_name AS 배역이름,
        email AS 이메일,
        SUBSTR(email, 1, INSTR(email, '@')-1 ) AS 이메일_아이디
FROM    characters;



-- 7. 역할이 제다이에 해당하는 배역들의 배역이름과 그의 마스터이름을 조회하여 다음의 결과가 나오도록 작성한 쿼리문이다.
-- 서브쿼리
-- NULL 처리 함수 : NVL(), NVL2() 

SELECT  c.character_name,
        m.character_name
FROM    characters c, characters m
WHERE   c.master_id = m.character_id; -- 셀프조인


-- 스칼라 서브쿼리 : 단일 행 반환 (컬럼처럼) : x 
SELECT  c.character_name, NVL(m.character_name, '?') AS master_name
FROM    characters c , roles r , characters m
WHERE   c.role_id = r.role_id
AND     r.role_name = '제다이'
AND     NVL(c.master_id,0) = m.character_id(+)
ORDER BY 1;




-- 8. 역할이 제다이 ==> 기사의 이메일이 있으면 제다이의 이메일을 없으면 마스터의 이메일을 조회 (Emails)
SELECT  c.character_name, 
        NVL(c.email, NULL) AS JEDAI_EMAIL,
        NVL(m.email, NULL) AS MASTER_EAMIL
FROM    characters c , roles r , characters m
WHERE   c.role_id = r.role_id
AND     r.role_name = '제다이'
AND     NVL(c.master_id,0) = m.character_id(+)
ORDER BY 1;

-- 11. 위 쿼리문을 참고한 상위 3명의 배역명, 실명, 출연횟수
-- 인라인 뷰 서브쿼리 활용 하거나 - WEHRE ROWNUM <= 5;
-- 서브쿼리에서 ORDER BY 절은 아주 특별한 경우가 아니라면 사용하지 않는다.











