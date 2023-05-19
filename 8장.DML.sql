-- 8장. DML
-- Data Manipulation Language, 데이터를 조작하는 명령문

-- 8.1 SELECT   : 데이터 조회 ==> DQL(Data Query Language) : Query 질의 --> 요청
-- 8.2 INSERT   : 새 데이터를 저장하는 명령
-- 8.3 UAPDATE  : 기존 데이터 변경해서 저장하는 명령
-- 8.4 DELETE   : 기존 데이터 삭제하는 명령
-- ※ DML 은 TCL ( Transaction Control Language ) 와 함께 사용한다.
-- COMMIT : 데이터 조작 (메모리) ==> (물리적인 저장장치에) 반영
-- ROLLBACK : 데이터 조작        ==> 변경사항을 버림 ==> 조작 전 상태로!


-- 8.1 INSERT
-- 데이터 삽입 명령 ==> 테이블에 삽입!

[예제8-1] emp 테이블에 300번 사원 이름이 'Steven' , 성이 'jobs'인 사원의 정보를 오늘 날짜 기준으로
등록하시오
-- 1. emp 테이블 생성 (컬럼명, 컬럼의 자료형, 길이값 정의) ==> DDL (Data Definition Language, 데이터 정의어)
CREATE TABLE emp (
    emp_id  NUMBER,         -- emp_id 라는 컬럼을 NUMBER(숫자 자료형, 정수-실수)로 정의
    fname   VARCHAR2(30),   
    lname   VARCHAR2(20),
    hire_date   DATE DEFAULT SYSDATE,
    job_id  VARCHAR2(20),
    salary  NUMBER(9,2),   -- salary라는 컬럼은 숫자형(정수부7 소수부2) 길이로 정의
    comm_pct NUMBER(3,2),
    dept_id NUMBER(3)
);

-- 테이블 생성후 확인하는 방법 / 또는 새로고침
SELECT  *
FROM    user_tables
WHERE   table_name='EMP';


-- 테이블 삭제
DROP TABLE 테이블명; -- 자동으로 COMMIT되니까 주의!

-- 2. 데이터를 삽입
-- 2.1 테이블의 구조 조회 : desc
DESC emp;
ROLLBACK;


INSERT INTO EMP (emp_id,fname,lname,hire_date)
VALUES (300, 'Steven', 'jobs' , SYSDATE);

SELECT  *
FROM    emp;

[예제 8-2] 사번이 301이고 이름이 'Bill', 성이 'Gate'인 사원을 2013년 5월 26일자로 emp 테이블에 저장하시오.
INSERT INTO emp (emp_id,fname,lname,hire_date)
VALUES (301, 'Bill', 'Gates', TO_DATE('2013-05-26','YYYY-MM-DD'));

-- 트랜잭션 처리 : 커밋 or 롤백
COMMIT;

-- p.69 컬럼 목록 없이 테이블의 모든 컬럼에 대한 저장값 목록을 VALUES 절에 나열해야 한다.
-- 빈문자열 : NULL 또는 ''를 사용해서 수동으로 NULL 저장할 수 있다.
-- NULL ==> UPDATE로 변경해서 다시 저장할 수 있다.
-- ※ 업무에서는 NULL 입력하는게 좋다.

[예제8-3]
desc departments;
/*
이름              널?       유형           
--------------- -------- ------------ 
DEPARTMENT_ID   NOT NULL NUMBER(4)    
DEPARTMENT_NAME NOT NULL VARCHAR2(30) 
MANAGER_ID               NUMBER(6)    
LOCATION_ID              NUMBER(4)    

*/

INSERT INTO departments -- 컬럼의 수! 데이터 타입! 확인
VALUES (300,'Health Servces', NULL, NULL);

ROLLBACK;

[예제8-4]
INSERT INTO emp (emp_id, fname, lname, hire_date, job_id, salary)
VALUES (302,'Warrer', 'Buffett', SYSDATE, NULL, NULL);  -- 가독성 측면에서는 ''대신 NULL 로!

-- VALUES 절 없이 SELECT문을 사용해 서브쿼리로 테이블로부터 여러 데이터 행을 복사, 저장할 수 있다.
-- INSERT절의 저장할 컬럼 목록과 SELECT 절의 컬럼 목록의 갯수가 일치해야 한다.

INSERT INTO 테이블 [(컬럼명1, 컬럼명2..)]    -- 2. 특정 테이블에 그대로 삽입(=복사)
--VALUES (값1, 값2, ...)
SELECT 컬럼명1, 컬럼명2, ...    -- 1. 기존 테이블의 특정 컬럼값 선택해서
FROM    테이블명
WHERE   조건절;

[예제8-5] 사원테이블의 부서코드 10또는 20에 소속된 사원의 정보중 사번, 이름, 성, 입사일, 업무코드, 부서코드를
emp 테이블에 삽입하시오!

INSERT INTO emp (emp_id, fname, lname, hire_date, job_id, dept_id)
SELECT  employee_id, first_name, last_name, hire_Date, job_id, department_id
FROM    employees
WHERE   department_id IN (10,20);

SELECT *
FROM    emp;

-- =========================================================================================================

-- ITAS : INSERT INTO ~ AS SELECT ~   // SELECT 결과를 다른 테이블에 삽입하는 명령[DML]
-- CTAS : CREATE TABLE ~ AS SELECT ~  // SELECT 결과로 다른 테이블을 생성하는 방법 (데이터 포함, 구조만)[DDL]

--=========================================================================================================

[예제8-6] 월별 급여 관리 테이블(month salary)에 부서테이블의 부서코드 행 데이터를 삽입하시오
-- 일반 테이블 생성 방법, 데이터를 직접 삽입
/*
CREATE TABLE 테이블명 (
    컬럼명 데이터타입 제약조건,
    ... 계속
)
*/
-- 4000바이트 기준
CREATE TABLE month_salary(
    dept_id NUMBER(3),
    emp_count NUMBER,
    sum_sal NUMBER,
    avg_sal NUMBER(9,2) -- 정수부는 7자, 소수부는 2자
);

INSERT INTO month_salary (dept_id)
SELECT  department_id
FROM    departments
WHERE   manager_id IS NOT NULL;

SELECT   *
FROM    month_salary;

INSERT INTO month_salary (dept_id, emp_count, sum_sal,avg_sal)
SELECT  department_id, COUNT(*), SUM(salary), ROUND(AVG(salary),2)
FROM    employees
WHERE   department_id IS NOT NULL
GROUP BY department_id
ORDER BY 1;

ROLLBACK;

-- CTAS로 테이블 생성 방법 ==> 데이터를 생성하면서 삽입하거나 또는 구조만 복제하고 데이터는 삽입x

[예제8-7] 사원테이블에서 부서코드가 30에서 60번에 해당하는 사원들의 사번,이름,성,입사일,업무코드,급여,
커미션율, 부서코드를 조회해서 emp 테이블에 삽입하시오

INSERT INTO emp 
SELECT  employee_id,first_name, last_name, hire_date, job_id, salary, commission_pct, department_id
FROM    employees
WHERE   department_id BETWEEN 30 AND 60;

SELECT  *
FROM    emp
ORDER BY 1;






-- 8.3 데이터 변경 UPDATE
-- INSERT : 새 데이터 삽입 (=저장)
-- UPDATE : 기존 데이터 변경해서 저장

/*
UPDATE 테이블명
SET 컬럼명 = 값
WHERE   조건;
*/ 

-- WHERE 생략 ==> 모든 데이터 행에 영향
-- ex> 급여를 특정 사원/부서를 제한하지 않으면 모든 사원의 급여가~ 커미션이~

[예제8-8] emp 테이블에서 사번이 300번 이상인 사원의 부서코드를 20으로 변경하시오
-- emp : 현재 300번 이상 6명 + employees 테이블 30~60번 부서원 57명 ==> 63명

UPDATE emp
SET dept_id = 20
WHERE   emp_id >= 300;

COMMIT;

[예제8-9] 사번이 300번인 사원의 급여, 커미션율, 업무코드를 변경한다.

UPDATE emp
SET salary = 2000,
    comm_pct = 0.1,
    job_id = 'IT_PROG'   -- 부서 : IT , 업무포지션 : PROGRAMMER
WHERE   emp_id = 300;

-- 서브쿼리를 사용해 데이터를 변경할 수 있다.
-- 업무코드, 급여, 커미션율 ==> 다중 컬럼  서브쿼리 ==> UPDATE 할때 사용한다.


[예제 8-11] emp 테이블 사번 103번 사원의 급여를 employees 테이블의 20번 부서의 최대 급여로 변경한다.
-- MAX() : 다중행 함수 (결과상 단일) ==> 집계함수

UPDATE  emp
SET     salary = ( SELECT   MAX(salary)
                   FROM     employees
                   WHERE    department_id = 20)  -- 서브쿼리
WHERE   emp_id = 103;

ROLLBACK;

[예제 8-12] emp 테이블 사번 180번 사원과 같은 해에 입사한 사원들의 급여를, employees 테이블 50번 부서의 
평균 급여로 변경하시오
SELECT  TO_CHAR(hire_date,'YYYY')
FROM    employees
WHERE   employee_id = 180;  -- 2006


UPDATE  emp
SET     salary = ( SELECT   ROUND(AVG(salary)) 
                   FROM     employees
                   WHERE    department_id = 50 )
WHERE   TO_CHAR(hire_date,'YYYY') = ( SELECT  TO_CHAR(hire_date,'YYYY')
                                        FROM    emp
                                        WHERE   emp_id = 180 );

COMMIT; 

[예제 8-13]

CREATE TABLE month_salary2(
    dept_id NUMBER(3),
    emp_count NUMBER,
    sum_sal NUMBER,
    avg_sal NUMBER(9,2) -- 정수부는 7자, 소수부는 2자
);

-- 사원테이블에서 사원들의 소속 부서코드만 삽입
INSERT INTO month_salary2 (dept_id)
SELECT department_id
FROM    employees
WHERE   department_id IS NOT NULL  -- 부서가 없는 사원 킴벌리
GROUP BY department_id;

SELECT *
FROM    month_salary2;

-- UPDATE 로 EMP_COUNT, SUM_SAL , AVG_SAL을 업데이트
UPDATE month_salary2 m
SET emp_count = ( SELECT    COUNT(*)
                  FROM    employees e
                  WHERE   e.department_id = m.dept_id
                  GROUP BY e.department_id ),
    sum_sal = ( SELECT    SUM(e.salary)
                FROM    employees e
                WHERE   e.department_id = m.dept_id
                GROUP BY e.department_id ),
    avg_sal = ( SELECT    ROUND(AVG(e.salary))
                FROM    employees e
                WHERE   e.department_id = m.dept_id
                GROUP BY e.department_id );
 
SELECT *
FROM    month_salary2;

COMMIT;

-- month_salary 처럼 month_salary2를 서브쿼리로 처리

[예제8-14] month_salary2의 emp_count, sum_sal, avg_sal 컬럼을 다중컬럼 서브쿼리를 활용해
employees의 부서별 집계된 데이터를 업데이트하시오!
(단, 급여평균은 정수로 표시하시오)

UPDATE  month_salary2 m
SET     ( emp_count, sum_sal, avg_sal ) = ( SELECT COUNT(*), SUM(salary), ROUND(AVG(salary))
                                            FROM    employees e
                                            WHERE   e.department_id = m.dept_id
                                            GROUP BY department_id
                                            );
SELECT  *
FROM    month_salary2;

COMMIT;




-- 8.3 데이터 삭제 DELETE
-- 테이블의 행 데이터를 삭제하는 기본 문법
-- WHERE 절의 조건에 일치하는 행 데이터를 삭제한다. (WHERE절 생략시 모든 행 데이터가 삭제됨)

/*
DELETE FROM 테이블명
WHERE 조건;
*/

[예제8-15] emp 테이블에서 60번 부서의 사원 정보를 삭제한다.
-- 조회
SELECT  *
FROM    emp
WHERE   dept_id = 60;

-- 삭제
DELETE FROM emp
WHERE   dept_id = 60;  -- 5rows deleted, 58rows remain

-- WHERE 절 생략시 모든 데이터가 삭제되므로 주의!!

COMMIT; -- 58rows remain



