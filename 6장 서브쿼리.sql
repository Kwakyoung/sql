-- 6장. 서브쿼리 (p.51)

-- ※ SQL문장 안에 존재하는 또다른 SQL 문장을 서브쿼리라고 한다.
-- 1) 서브쿼리는 괄호로( ) 로 묶어서 사용한다.
-- 2) 서브쿼리가 포함된 쿼리문을 메인 쿼리라고 한다.

-- ORACLE, MYSQL, MSSQL : RDBMS     VS     mongoDB(atlas), firebase(google), MS Azure, Amazon AWS
-- 관계형 데이터베이스                      <CLOUD 기반의 데이터 에비스> : NoSQL(관계형 데이터베이스가 아님)  
-- 오릌클 ==> 서브쿼리
-- MSSQL ==> T-SQL
-- 각종 DBMS 마다 약간 다른 이름


[예제6-1] 평균 급여보다 더 적은 급여를 받는 사원의 정보를 조회한다.

-- 1. 평균 급여를 구한다.
SELECT  ROUND(AVG(salary)) AS avg_sal   -- 평균급여 : 6462
FROM    employees;
  
-- 2. 평균 급여 미만을 받는 사원정보를 조회
SELECT  employee_id, first_name, salary, department_id
FROM    employees
WHERE   salary < 6462;

-- 1+2의 효과 : 서브쿼리
SELECT  employee_id, first_name, salary, department_id
FROM    employees
WHERE   salary < ( SELECT  ROUND(AVG(salary)) AS avg_sal   
                   FROM    employees );
-- ※ 실행 순서 : 서브쿼리가 먼저 실행되고 그 결과를 반환한 뒤 메인쿼리가 실행된다.


-- =========== 서브쿼리의 유형 =============
-- 6.1 단일 행 (단일 컬럼) 서브쿼리 : 하나의 결과 행을 반환하는 서브쿼리
-- ▶ 단일 행 연산자 (= , >= , > , < , <= , <> , != , ^=)
-- ▶ 그룹 함수를 사용하는 경우가 대다수. (AVG , SUM , COUNT , MAX , MIN)

[예제] 가장 큰 월급을 받는 사람.
-- 2. 서브쿼리작성
SELECT  employee_id, first_name, last_name
FROM    employees
WHERE   salary = ( SELECT MAX(salary) AS max_sal
                   FROM     employees);      -- salary : NUMBER (숫자 데이터 컬럼)




-- 6.2 다중 행 서브쿼리(p.53)
-- 다중 행 연산자 (IN, NOT, ANY(=SOME), ALL, EXISTS)
-- 6.2.1 IN 연산자
-- OR 연산자 대신 --> 간결
SELECT  employee_id, first_name, department_id
FROM    employees
WHERE   department_id IN (50, 80);

[예제6-5] 부서(위치코드, location_id)가 영국(UK)인 부서코드, 위치코드, 부서명 정보를 조회한다.
-- 1. 영국의 위치코드를 조회
SELECT  location_id
FROM    locations
WHERE   country_id = 'UK';  -- 2400, 2500, 2600 : 영국에 부서 여러개~

--2. 서브쿼리
SELECT  department_id, location_id, department_name
FROM    departments
WHERE   location_id = ANY (2400,2500,2600);
-- ANY ==> 하나라도 만족하면 나옴   (OR과 비슷)
-- ALL ==> 모두 만족하면 나옴   (AND와 비슷)








-- 6.3 다중 컬럼 서브쿼리

-- 연관성의 유무?
-- 6.4 상호연관 서브쿼리

-- 6.5 스칼라 서브쿼리
-- 6.6 인라인 뷰 서브쿼리
-- ========================================











[예제6-4] 월급여가 가장 많은 사원의 사번, 이름, 성, 업무제목 정보를 조회
-- employees : 사번, 이름, 성
-- jobs : 업무제목(job_title)

-- 1. 월급여 가장 큰 값 : 24000 VS 2100
SELECT  MAX(salary)
FROM    employees;

SELECT  MIN(salary)
FROM    employees;

-- 2. 사원의 사번, 이름, 성, 업무제목 정보
-- 2-1. 오라클 조인
-- 2-2. ANSI JOIN ==> MYSQL 사용 전제, T-SQL (MSSQL), ... 

SELECT  employee_id, first_name, last_name,
        job_title






