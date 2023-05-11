-- 5장. JOIN (연산)
-- 오라클 관계형 데이터베이스이다 ==> 관계 : 테이블과 테이블이 맺는것! 
-- (Relation, 릴레이션 - 데이터베이스 설계할때 테이블을 릴레이션 이라고함)
-- JOIN 여러 테이블을 연결하여 (HR : 7개, 업무 : n) 데이터를 조회한다
-- EX> 사원 테이블 ~ 부서 테이블 연결 : 사원정보에 부서 정보(부서이름, 부서위치코드)를 조회할때!


-- 5.1 Cartesian Product (Decart의 다른 말, Cartesian) 
-- JOIN 조건 : 둘 이상의 테이블의 관계를 맺을때, 기준이 되는 컬럼을 지정 ==> 보통, WHERE 절에 기술...
-- JOIN 조건을 기술하지 않을 때 잘못된 결과가 발생하는데, 이걸 카테시안 곱(=합성곱) 이라고 함.
-- 오류는 안남 ==> 예측되는 데이터 보다 많다면, 의심!!

/*
SELECT  컬럼명1, 컬럼명2, ...
FROM    테이블명1, 테이블명2, ...
WHERE   JOIN 조건(=비교)
*/

[예제5-1] 사원 테이블과 부서 테이블을 이용해 사원의 정보를 조회하고자 한다. 사번, 성, 부서이름을
조회하라!

-- 사번, 성 : employees   ( 사원 정보 테이블 : 사번, 이름, 사원급여, 입사일 ... )
-- 부서이름 : departments ( 부서 정보 테이블 : 부서코드, 부서이름, 부서가 위치한 지역코드 )
-- 다른 테이블은 행을 나누어서 작성!! (가독성)
-- 두 테이블의 공통 컬럼 : department_id (manager_id : 부서테이블의 식별자x)
-- 전체 사원은 107명, 조회된 결과 106건
SELECT  e.employee_id , e.last_name,    -- 주된 내용을 조회하려는 테이블의 컬럼
        d.department_name             -- 부가적인 정보
FROM    employees e, departments d
WHERE   e.department_id = d.department_id;    
--      기준테이블.공통컬럼 = 대상테이블.공통컬럼

-- 사원테이블 데이터/행 수 : 107
-- 부서테이블 데이터/행 수 : 27
-- 카테시안 곱 : 2889 rows ==> 107 * 27

DESC employees;
DESC departments;


-- 5.2 EQUI JOIN : 동등 연산자(=)를 사용해 JOIN 연산 : EQUI-JOIN
-- 두 테이블의 공통 컬럼 : department_id (manager_id : 부서테이블의 식별자x)
-- 전체 사원은 107명, 조회된 결과 106건 <--> 부서없는 1명의 누락!!
-- 테이블을 이용한 JOIN => 어는 테이블에 어떤 컬럼인지를 명시!!
SELECT  e.employee_id , e.last_name,    -- 주된 내용을 조회하려는 테이블의 컬럼
        d.department_name             -- 부가적인 정보
FROM    employees e, 
        departments d
WHERE   e.department_id = d.department_id;    

[예제 5-2]
SELECT  e.employee_id , e.last_name,    -- 주된 내용을 조회하려는 테이블의 컬럼
        d.department_name             -- 부가적인 정보
FROM    employees e, 
        departments d
WHERE   e.department_id = d.department_id; 

[예제 5-3] 테이블의 Alias 를 적용~
SELECT  e.employee_id , e.last_name,    -- 주된 내용을 조회하려는 테이블의 컬럼
        d.department_name             -- 부가적인 정보
FROM    employees e, 
        departments d
WHERE   e.department_id = d.department_id; 

[예제 5-4] (사원 테이블, 업무테이블을 이용해) 사번, 이름, 업무코드, 업무제목 정보를 조회한다.
DESC jobs;
/*
JOB_ID     NOT NULL VARCHAR2(10) 
JOB_TITLE  NOT NULL VARCHAR2(35) 
MIN_SALARY          NUMBER(6)    
MAX_SALARY          NUMBER(6)
*/
SELECT  e.employee_id, e.first_name||' '||e.last_name name, e.job_id, 
        j.job_title
FROM    employees e, jobs j   -- 카테시안 곱 : 2,033 rows
WHERE   e.job_id = j.job_id;  -- 중복되는걸 제어해줌


[예제 5-5] (사원 테이블, 부서 테이블, 업무 테이블을 이용해) 사번, 이름, 부서명, 업무제목 정보를 조회한다.
-- employees , departments , jobs
-- 사원정보  , 부서정보    , 업무정보
-- department_id

SELECT  e.employee_id AS 사번, e.first_name||' '||e.last_name name,
        d.department_name,
        j.job_title
FROM    employees e , departments d , jobs j
WHERE   e.department_id = d.department_id  -- 1명이 부서코드 x
AND     e.job_id = j.job_id
ORDER BY 1;




-- 5.3 NON-EQUI JOIN







-- 5.4 OUTER JOIN







-- 5.5 SELF JOIN



-- ========================== 위에는 ORACLE JOIN
-- ========================== 아래는 공용 JOIN



-- 5.6 ANSI JOIN  /  ANSI 협회에서 만든 표준 JOIN 식 (ORACLE외에도 MYSQL, CUBRID, 기타 RDBMS 공통 JOIN)







-- 5.7 OUTER JOIN

