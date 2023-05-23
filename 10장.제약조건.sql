-- 10장. 제약조건



-- 무결성 제약조건 : (Integrity Constraints) : 데이터의 정확성을 보장하기 위해 두는 제약/제한 조건
-- 1) 테이블 생성시 정의 : CREATE TABLE ~
-- 2) 테이블 생성 후 추가 : ALTER TABLE ~




-- 10.1 NOT NULL 제약조건 - NULL 허용하지 않음
-- 컬럼의 데이터 값에 있어 NULL 허용하지 않음 ==> 반드시 데이터를 입력해야 한다.
-- ★ 테이블 생성시 컬럼 레벨에서 정의한다
-- ex> 테이블 생성 구문
CREATE TABLE 테이블명(
    컬럼명1 데이터타입(길이) 제약조건, -- 컬럼 레벨
    컬럼명2 데이터타입(길이)
);

CREATE TABLE user(
    id VARCHAR2(20) NOT NULL, -- 컬럼 레벨
    nick VARCHAR2(20)
);

[예제10-1] null_test 라는 테이블을 생성하되 컬럼은 col1 문자타입 5바이트 길이,NULL 허용하지않고,
col2 문자타입 5바이트 길이로 정의하시오~

-- 1) 테이블 생성 : null_test + not null
CREATE TABLE NULL_TEST(
    col1 VARCHAR2(5) NOT NULL,
    col2 VARCHAR2(5)
);

INSERT INTO null_test (col1)
VALUES ('AA'); -- AA | (null)

-- 조회
SELECT  *
FROM NULL_TEST;

[예제10-3] BB를 col2에 삽입
INSERT INTO null_test (col2)
VALUES ('BB'); -- col1 NOT NULL 제약조건
-- ORA-01400: NULL을 ("HR"."NULL_TEST"."COL1") 안에 삽입할 수 없습니다

-- 2) 테이블 생성 후 NOT NULL 지정
-- 컬럼에 NULL 데이터가 없는 경우, NOT NULL을 추가할 수 있다.

UPDATE null_test
SET col2 = 'BB'; -- col2 컬럼의 데이터를 null에서 'BB'로 변경

-- null_test에 이미 BB가 col2 컬럼에 있는 상태
[예제10-4]
ALTER TABLE null_test
MODIFY  (col2 NOT NULL);

[예제10-5] col2를 NULL로 바꾸어보면 ==> 제약조건이 추가되었으니, 오류발생!
-- col2에 NOT NULL이 추가 ==> 데이터를 NULL
UPDATE null_test
SET col2 = NULL; -- 에러발생

-- 다시 col2 컬럼에 NULL 허용
ALTER TABLE null_test
MODIFY (col2 NULL); -- col1, col2 모두 데이터가 있다 <--> NULL이 아니므로

COMMIT;

-- ============ 사용자 계정으로 생성된 (테이블의) 제약조건이 모두 기록된 별도의 테이블 객체 ==============================
SELECT  constraint_name, constraint_type, owner
FROM    user_constraints
WHERE   table_name = 'NULL_TEST'; 






-- 10.2 CHECK 제약조건 - 값의 범위 (p.80)
-- 조건에 맞는 데이터만 저장할 수 있도록 하는 제약조건이다.
-- 컬럼 레벨, 테이블레벨에서 정의한다.

[예제 10-6] 
CREATE TABLE    check_test (
    name VARCHAR2(10) NOT NULL, -- 컬럼 레벨
    gender VARCHAR2(10) NOT NULL CHECK (gender IN ('남성', '여성' , 'male' , 'female' , 'man' , 'woman')),
    salary  NUMBER(8),
    dept_id NUMBER(4),
    CONSTRAINT  check_salary_ck CHECK (salary > 2000) -- 테이블 레벨
                         -- ck = check 
);

-- 테이블명_컬럼명_제약조건 약어 (NN:NOT NULL, CK:CHECK, PK:PRIMARY KEY, FK:FOREIGN, UK:UNIQUE KEY)

--생성 후 규칙 조회
SELECT  constraint_name, constraint_type, search_condition
FROM    user_constraints
WHERE   table_name = 'CHECK_TEST';

[예제 10-7] 데이터를 check_test 테이블에 삽입해보시오

INSERT INTO check_test 
VALUES('홍길동', '남성' , 3000 , 10); 

[예제10-9]
UPDATE  check_test
SET salary = 2000   
WHERE   name = '홍길동';  --오류 보고 > ORA-02290: 체크 제약조건(HANUL.CHECK_SALARY_CK)이 위배되었습니다


-- II. 테이블 생성 후 제약조건 추가/지정
[예제10-10]
-- DDL : CREATE, ALTER, DROP
--        생성,  수정 , 삭제
-- check_test에 걸린 제약조건을 확인하고, 그런다음 삭제 했다가 다시 추가하는 SELECT  constraint_name, constraint_type, search_condition
SELECT  constraint_name, constraint_type, search_condition
FROM    user_constraints
WHERE   table_name = 'CHECK_TEST';
/*
SYS_C008365	C	"NAME" IS NOT NULL
SYS_C008366	C	"GENDER" IS NOT NULL
SYS_C008367	C	gender IN ('남성', '여성' , 'male' , 'female' , 'man' , 'woman')
CHECK_SALARY_CK	C	salary > 2000
*/

-- 제거
ALTER TABLE check_test
DROP CONSTRAINT check_test_salary_ck;  -- 제약조건 잘 확인

-- 다시추가
[예제10-11]
ALTER TABLE check_test
ADD CONSTRAINT check_salary_dept_ck CHECK (salary BETWEEN 2000 AND 10000 AND dept_id IN (10,20,30));

SELECT  *
FROM    check_test;

[예제10-12]
UPDATE check_test
SET salary = 12000
WHERE  name='홍길동';









-- 10.3 UNIQUE 제약조건 - 중복방지
-- 데이터가 중복되지 않도록 유일성을 보장하는 제약조건
-- 컬럼 레벨, 테이블 레벨에서 정의
-- ★ 복합키(Composite)를 생성할 수 있다 ★  예) 보통 사번 vs 사번+이름

-- 테이블 생성시 UNIQUE 지정
-- I. 컬럼레벨 정의
[예제10-13]
CREATE TABLE    unique_test (
    col1    VARCHAR2(5) UNIQUE NOT NULL,
    col2    VARCHAR2(5),
    col3    VARCHAR2(5) NOT NULL,
    col4    VARCHAR2(5) NOT NULL,
    CONSTRAINT uni_col2_uk UNIQUE (col2),
    CONSTRAINT uni_col34_uk UNIQUE (col3, col4) -- 복합 키 : 둘 이상의 컬럼을 조합
);

 

[예제10-14] 중복값을 제한하는지 입력 테스트
INSERT INTO unique_test 
VALUES  ('A1','B1','C1','D1');

SELECT  *
FROM    unique_test;

INSERT INTO unique_test
VALUES ('A','B2','C2','D2');

[예제10-10] 업데이트 테스트 --> 중복된 값으로 --> 제약조건에 따라 오류 발생!
UPDATE  unique_test
SET col1='A1'
WHERE   col1='A2';


[예제10-16] 데이터 입력 테스트 --> 중복값 확인
INSERT INTO unique_test
VALUES ('A3','','C3','D3'); -- col2, '' 대신 NULL 사용하는게 가독성측면에서는 낫다

INSERT INTO unique_test
VALUES ('A4','NULL','C4','D4');

INSERT INTO unique_test
VALUES ('A4','NULL','C5','D5'); -- A4는 있는 값 : ORA-00001: 무결성 제약 조건(HANUL.SYS_C008373)에 위배됩니다


-- II. 테이블 레벨 정의
-- 테이블 생성 후 UNIQUE 추가/지정 : 생성시 작성한 UNIQUE 제거 --> 추가

-- 데이터 사전 :
SELECT  *
FROM    dict;

SELECT  constraint_name, constraint_type
FROM    user_constraints
WHERE   table_name='UNIQUE_TEST';

[예제10-18] UNI_COL34_UK 제약조건을 삭제하고 col2,col3,col4를 UNIQUE 복합키로 지정하는!
ALTER TABLE unique_test
DROP    CONSTRAINT UNI_COL34_UK;

[예제 10-19] UNI_COL234_UK 제약조건 추가
ALTER TABLE  unique_test
ADD CONSTRAINT UNI_COL234_UK UNIQUE (col2,col3,col4);

SELECT  *
FROM    unique_test;


[예제10-20]
INSERT INTO unique_test
VALUES ('A7',NULL,'C4','D4');













-- 10.4 PRIMARY KEY 제약조건
-- 데이터 행(ROW)을 대표하도록 유일하게 식별하기 위한 제약조건
-- UNIQUE + NOT NULL의 형태
-- 기본키, 식별자, 주 키, PK라 한다.
-- 컬럼레벨, 테이블레벨에서 정의 ★복합키☆를 생성할 수 있다.
-- 예) 사람 - 주민번호 (= 인조키), 회사원 - 사원번호

-- I. 컬럼레벨 정의
컬럼명 데이터 타입 PRIMARY KEY : 약식 --> SYS_C008XXX
컬럼명 데이터 타입 CONSTRAINT 제약조건명 PRIMARY KEY --> 테이블명_컬럼명_제약조건어

-- II. 테이블레벨 정의
CONSTRAINT 테이블명_컬럼명_제약조건약어 PRIMARY KEY (컬럼명)
            member_id_pk                            (id)

CREATE TABLE member (
    id  VARCHAR(10) PRIMARY KEY,  -- 컬럼 레벨
    name,
    email,
    phone
    CONSTRAINT member_id_pk PRIMARY KEY (id) -- 테이블 레벨
);

[예제10-21] dept_test 테이블을 생성하고 dept_id,dept_name 컬럼 각각 숫자 4바이트 ,가변문자 30바이트의
구조를 갖게하되 dept_name은 null은 허용하지 않고, dept_id를 기본키로 지정하는 쿼리를 작성하시오

CREATE TABLE   dept_test (
    dept_id NUMBER(4) PRIMARY KEY,
    dept_name VARCHAR2(30) NOT NULL
--  CONSTRAINT dept_test_dept_id_pk PRIMARY KEY (dept_id) 
);

SELECT  constraint_name, constraint_type
FROM    user_constraints
WHERE   table_name = 'DEPT_TEST';

[예제10-22] 10번 부서, 부서명은 영업부 데이터를 입력하시오
INSERT INTO dept_test
VALUES  (10, '영업부'); -- 완료

INSERT INTO dept_test
VALUES  (10, '개발부'); -- PK값(dept_id) 중복되어 삽입 실패

-- 테이블 생성 후 PK (추가) 지정
-- 일단 먼저 제거
ALTER TABLE dept_test
DROP  CONSTRAINT dept_test_id_pk;


INSERT INTO dept_test
VALUES (20,'개발부');

UPDATE  dept_test
SET dept_id = 10
WHERE   dept_name='개발부'; --ORA-00001: 무결성 제약 조건(HANUL.SYS_C008378)에 위배됩니다








-- 10.5 FOREIGN KEY 제약조건 - 외래키
-- 부모 테이블의 컬럼을 참조하는 자식 테이브르이 컬럼에, 데이터의 무결성을 보장하기 위해 지정하는 제약조건
-- NULL 허용 <--> UNIQUE : 중복방지, NULL 허용
-- 참조키, 외래키, FK
-- 컬럼레벨  ★ 복합키 ★를 생성할 수 있다.

-- 컬럼명 데이터 타입 REFERENCES 부모테이블 (참조되는 컬럼명)
-- 컬럼명 데이터 타입 CONSTRAINT 제약조건명 REFERENCES 부모테이블 (참조되는 컬럼명)

-- 테이블레벨에서 정의
-- CONSTRAINT 테이블명_제약조건명_제약조건약어 FOREIGN KEY (참조하는 컬럼명) REFERENCES 부모테이블 (참조되는 컬럼명)
-- 테이블과 테이블의 관계에 따라서...
-- 사원 정보 테이블 <--> 부서 정보 ㅔㅌ이블
-- 사원은 부서에 소속된다 (=관계) N : 1     [1:다] 관계 : RDBMS에서 ★ 가장 기본적인!
-- 부서는 사원을 포함한다 (=관계  1 : N     [다:다], [M:N] 관계 : 정규화 -> 관계 해소 -> 1,2,3
-- HR 스키마 ==> 작은 규모의 데이터베이스 ==> 기초에 충실한 테이블 설계

-- 사원정보 ==> employees (테이블)
-- 이름, 사번(PK), 급여, 이메일, 부서코드(FK) ==> first_name, employee_id, salary (컬럼) 
-- 부서정보 ==> departments (테이블)
-- 부서코드(PK), 부서명, 위치코드 ==> 컬럼

-- 데이터 모델링 : 모델러 ==> 테이블 설계, 컬럼, 제약조건 설정

-- 쇼핑몰 구축 : 쇼핑몰 업무 파악 (고객-상품 주문, 결제   회사-상품 포장, 발송..)
-- 개념설계 : 업무 관련 중요 키워드를 도출 ==> 엔터티(=개체), 컬럼(=특성) ..... 
-- 논리설계 : Entity Relational Diagram (ERD) ==> 그림으로 개체, 특성, 관계를 표시하는 과정
-- 물리설계 : CREATE TABLE~ ALTER TABLE~ INSERT INTO~

 
-- < I. 개념설계 >
-- 고객 정보를 담는 테이블 : CUSTOMERS (고객 ID, 고객명, 연락처..)
-- 상품 정보를 담는 테이블 : ITEMS (상품 ID, 상품명, 가격..) 

-- < II. 논리설계 >
-- 고객정보
-----------------------------------
고객ID    고객명     연락처
  PK        NN         
NUMBER    VARCHAR2    VARCHAR2(11)
-----------------------------------
001       홍길동       010-123
002       이길동       062-213
003       박길동

-- 상품정보
-----------------------------------
상품ID    분류      원산지   제조사/생산자
-----------------------------------
001     잡화(D)     한국        H사
002     식품(F)     태국        Y사


-- < III. 물리설계 : SQL >

CREATE TABLE   customers(
    id      NUMBER(4),
    name    VARCHAR2(20) NOT NULL,
    phone   VARCHAR2(11),
    CONSTRAINT customers_id_pk PRIMARY KEY(id)
);

CREATE TABLE    items(
    p_id    NUMBER(4),
    p_type  CHAR(10) NOT NULL,
    p_born  CHAR(10) NOT NULL,
    p_manufactor VARCHAR2(50),
    regdate DATE,
    CONSTRAINT items_p_id_pk PRIMARY KEY (p_id)
);

-- DBA, 데이터 모델러 : 현장에 거의 없다 ==> 몸값 높다 ==> 인공지능 활성화

[예제 10-26] emp_test : employees 테이블을 생성하고 , 제약조건 거시오

CREATE TABLE emp_test (
    emp_id  NUMBER(4) PRIMARY KEY, -- 중복X NULL 허용! : 유일성 보장
    ename   VARCHAR2(30) NOT NULL,
    dept_id NUMBER(4),
    job_id VARCHAR2(10),
    CONSTRAINT emp_test_dept_id_fk FOREIGN KEY (dept_id) REFERENCES dept_test (dept_id)  
);

-- dept_test [dept_id, dept_name] 

SELECT *
FROM    dept_test; -- 10, 20번 부서가 존재 <--> 사원 등록시 부서코드는 10이나 20이어야 등록이 됨.

[예제10-27]
INSERT INTO emp_test
VALUES  ('1000','King', 10 ,'ST_MAN' ); -- OK

INSERT INTO emp_test
VALUES  ('1001','Kong', 30 ,'AC_MG' ); -- 부서테이블 30번 부서는 존재하지 않는데, 입력시도
-- ORA-02291: 무결성 제약조건(HANUL.EMP_TEST_DEPT_ID_FK)이 위배되었습니다- 부모 키가 없습니다

-- 30번 부서정보를 dept_test에 입력 후 사원정보를 재입력 ==> 성공
INSERT INTO dept_test (dept_id, dept_name)
VALUES  (30,'판매부');
-- dept_test 테이블에 30을 입력해준후 다시 추가하면 성공함

SELECT  *
FROM    EMP_TEST;

-- UPDATE 해봅시다.
UPDATE emp_test
SET dept_id = 30
WHERE   emp_id = 1001;

COMMIT;

-- DEFAULT
-- 컬럼 단위로 지정되는 속성, 데이터를 입력하지 않아도 지정된 값이 기본 입력되도록 한다.
-- 제약조건은 아니지만, 컬럼 레벨에서 작성한다.

[예제10-30]
CREATE TABLE default_test (
    name VARCHAR2(10) NOT NULL,
    hire_date DATE DEFAULT SYSDATE NOT NULL,
    salary NUMBER(8) DEFAULT 2500
); -- default 입력시 기본값으로 적용됨

INSERT INTO default_test
VALUES ('홍길동', TO_DATE('2023-05-22','YYYY-MM-DD'), 3000); 

INSERT INTO default_test (name)
VALUES ('홍길동');

SELECT  *
FROM    default_test;        

