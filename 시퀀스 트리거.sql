-- 11장. 뷰와 시퀀스

/*
    데이터베이스 용도, 권한 따라서 다름
    
    개발자    vs    데이터베이스 관리자
      ↓                     ↓ 것들
    테이블          테이블, 뷰, 함수, 시퀀스, 인덱스, 클러스터, 동의어 ...
    시퀀스
    트리거
*/





-- 11.1 뷰 (VIEW)
-- 뷰는 데이터가 존재하지 않는 가상 테이블 : 메모리에서 --> 쿼리를 저장했다가 실행한 결과 반환후 소멸
-- 보안과 사용자 편의를 위해 사용한다.
  
/*
    <뷰 생성>
    CREATE [OR REPLACE] VIEW 뷰명 AS
    SELECT 이하

    <뷰 삭제>
    DOP VIEW 뷰명;
*/


/* 
    테이블 생성문
    CREATE TABLE 테이블명 (
        ...
    );
    
    테이블 삭제
    DROP TABLE 테이블명;

*/

-- 실제 emp_details_view 의 SQL이 저장된 사용자_뷰 정보객체
SELECT  text
FROM    user_views;

[예제11-1]  80번 부서에 근무하는 사원들의 정보를 담는 v_emp80인 뷰를 생성하시오!
-- ITAS : SELECT한 데이터를 특정테이블에 삽입
-- CTAS : SELECT한 데이터를 저장하는 테이블을 생성
CREATE OR REPLACE VIEW v_emp80 AS       -- v_emp80 이미 있으면 기본껄 수정하고 없으면 새로 생성해주세요~
SELECT  employee_id AS emp_id, first_name, last_name, email, hire_date
FROM    employees
WHERE   department_id=80
WITH READ ONLY;

-- Q. 뷰는 가상의 테이블 ==> 데이터 삽입 | 수정 | 삭제를 할수있는 정보객체이다 그렇다면 뷰도 할수있나? 
-- A. 현재는 가능! WITH READ ONLY 사용해서 VIEW 만들지 않았기 때문에!!

-- 1. 원래 테이블에 데이터 삽입 --> 뷰에 영향?
DESC    employees;

-- 2. 뷰에 데이터 삽입 --> 원래 테이블에 영향?
INSERT INTO v_emp80 (emp_id, first_name, last_name, email, hire_date, job_id)
VALUES (208, 'SUNSHIN', 'LEE', 'SUNSHINLEE', SYSDATE, 'SA_REP');

-- 실제 employees 테이블의 필수입력 컬럼(job_id)이 v_emp80에 없으니까, 확인용 전체 사원 뷰 다시만들기
CREATE OR REPLACE VIEW v_emp_all AS      
SELECT  *
FROM    employees;

INSERT INTO v_emp_all (employee_id, first_name, last_name, email, hire_date, job_id,salary, department_id)
VALUES (208,'SUNSHIN','LEE' , 'SUNSHINLEE',SYSDATE,'SA_REP', 6600, 80);

ROLLBACK;

SELECT *
FROM    employees;

DELETE employees
WHERE   employee_id = 208;

[예제11-2] v_dept 뷰를 생성 - 부서코드, 부서명, 최저급여, 최대급여, 평균급여 정보를 담고있다.
CREATE OR REPLACE VIEW v_dept AS
SELECT  d.department_id, d.department_name,
        MIN(e.salary) AS min_sal, MAX(e.salary) AS max_sal, ROUND(AVG(e.salary) avg_sal)
FROM    employees e, departments d
WHERE   e.department_id = d.department_id
GROUP BY d.department_id, d.department_name
ORDER BY 1;


-- 11.2 시퀀스 (SEQUENCE)
-- 연속적인 번호의 생성이 필요한 경우 SEQUENCE를 사용하여, 자동으로 만들어주는 기능
-- 의사컬럼 CURRAVAL, NEXTVAL을 통해 조회하고 사용할 수 있다.

SELECT  *
FROM    user_sequences; -- 시스템 만든 뷰 : 누구나 사용할 수 있게~

-- 왜 시퀀스를 만들까? 데이터 입력할때마다, 특정 패턴의 값을 기억해둘 필요가 없어지므로 ..

/* 테이블 생성, 뷰 생성, 시퀀스 생성.. 다 같아요!
    CREATE SEQUENCE 시퀀스명
    START WITH   시작값
    MAXVALUE     최대값
    INCREMENT BY 증감값
    NOCACHE | CACHE 
    NOCYCLE | CYCLE
    
    테이블 삭제, 뷰 삭제, 시퀀스 삭제.. 같다
    DROP SEQUENCE 시퀀스명;
    
    테이블 수정, 뷰 수정(=X), 시퀀스(=X)
    ALTER TABLE 테이블명
    MODIFY 컬러명 데이터타입(바이트수);
*/


-- 테이블을 찾는 빠른 방법?
SELECT  *
FROM    all_tables -- 시스템 계정으로 생성한 뷰
WHERE   OWNER = 'HANUL';

[예제11-4] 시퀀스를 생성
CREATE SEQUENCE emp_seq
START WITH 103
MAXVALUE    999999
MINVALUE    1
INCREMENT BY 1
NOCACHE;

-- CURRVAL, NEXTVAL 통해 조회하고 사용
SELECT  emp_seq.CURRVAL,
        emp_seq.NEXTVAL
FROM    dual;

[예제11-5] emp_test에 데이터 삽입
SELECT  *
FROM    emp_test;

INSERT INTO emp_test
VALUES(emp_seq.CURRVAL - 1, 'Choi', 20, 'ST_CLERK');

-- 홍길동, 20번 부서, ''
INSERT INTO emp_test
VALUES(emp_seq.NEXTVAL, '홍길동', 20, 'ST_CLERK');

-- emp_dept_seq 생성 : 40번 부터 10씩 증가~ 최대 99999 까지~
CREATE SEQUENCE emp_test_dept_seq
START WITH 40
MINVALUE 10
MAXVALUE 9999999999999
INCREMENT BY 10
NOCACHE
NOCYCLE; 

-- 이순신
INSERT INTO emp_test
VALUES(emp_seq.NEXTVAL, '이순신', emp_test_dept_seq.NEXTVAL, '');

SELECT  *
FROM    user_constraints
WHERE   table_name = 'EMP_TEST';

SELECT  *
FROM    emp_test;

-- 연습|실습시 제약조건을 일시적으로 무력화 or 삭제
-- 구글 : oracle database disable constraint 검색
/*
ALTER TABLE table_name
[ENABLE or DISABLE] CONSTRAINT constraint_name;
*/
ALTER TABLE emp_test
DISABLE CONSTRAINT emp_test_dept_id_fk; -- emp_test

-- 이순신 삽입했으니 값 다시 변경 후 ENABLE로

UPDATE emp_test
SET dept_id=30
WHERE   emp_id = 106;

ALTER TABLE emp_test
ENABLE CONSTRAINT emp_test_dept_id_fk;

-- 제약조건 ENABLE / DISABLE : 테스트 할때 가끔 사용할 일이 있다.
-- 단, 다시 제약조건을 ENABLE 할때 테스트 하는 테이블에 제약조건과 일치하는 데이터가 있는지 확인!

COMMIT;



-- 12. 오라클 데이터베이스 객체
-- 12.1 데이터 사전/데이터 딕셔너리 : 데이터베이스의 중요한 정보, 객체등을 저장하고 있는 객체
-- 오라클이라는 시스템이 사용하는 데이터 + 사용자 데이터

-- 12.2 데이터 사전 조회
SELECT  *
FROM    dict;

-- 테이블, 뷰를 포함한 데이터베이스 객체 정보 : 제약조건, 인덱스, 클러스터, 시노님(=동의어), ...
-- 사실, 데이터베이스 관리자가 보는 정보
-- 사용자가 활용하는 정보가 담겨있다.

-- 조회해볼 수 있는 고유한 정보 테이블/뷰의 종류
-- 1) ALL_ 로 시작하는 뷰 : 권한 상관없이 누구든 조회할 수 있는 데이터
-- 2) DBA_ 로 시작하는 뷰 : DBA 권한이 있을때 조회
-- 3) USER_로 시작하는 뷰 : 접속한 계정에 포함된 데이터를 조회


-- 12.3 데이터베이스 객체 종류
-- 1) 테이블
-- 2) 뷰
-- 3) 시퀀스
-- 4) 함수 : 사용자 정의 함수 vs MAX()는 있지만~ MID()를 새로 만들겠다면!  == > 반환값이 있음
-- 5) 트리거 : 반환값이 없는 함수
---------------- 개발자 ↑    DBA ↓ --------------------
-- 6) 인덱스 : 검색 성능 향상때문에 
-- 7) 클러스터 :        " 
-- 8) 시노님 : 객체의 또 다른 이름 (=별명) 생성
-- 9) 패키지 : PL/SQL로 함수나 트리거등을 한데 묶기 위해

-- 12.4 생성/삭제/변경
--CREATE  구문
--ALTER   구문
--DROP    구문

-- 트리거 생성
CREATE OR REPLACE TRIGGER 트리거명
[BEFORE | AFTER]
    INSERT OR
    UPDATE OF salary, department_id OR  -- 2. 어떤 작업이 이뤄지면
    DELETE
    ON employees  -- 1. 어떤 테이블에서의
BEGIN
    -- 3. 아래에서 지정한 처리가 되는 PL/SQL
    -- PL/SQL 실행부 : 변수, 연산자, 조건문, 반복문 ...
    -- 에러처리부 : EXCEPTION 
END;



-- CASE | DECODE 
SELECT  *
FROM    employees;
-- 204 Shelley 급여 12008 을 12000 으로

-- DBMS_OUTPUT 패키지
-- SQL DEVELOPER 결과 확인 전 [보기 > DBMS 출력] 창을 선택해서
UPDATE  employees
SET salary = 12000
WHERE   employee_id = 205;

-- SQLPLUS 확인하려면?
ROLLBACK;








