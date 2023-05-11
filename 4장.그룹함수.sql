-- 4장. 그룹 함수
-- 그룹지어서, 그룹별로 데이터를 조회
-- ??

-- 4.1 DISTINCT
-- 중복을 제거한 결과를 반환하는 함수 --> SYSDATE 처럼 파라미터가 없음.
-- DISTINCT 컬럼명1, 컬럼명2, ... : 모든 컬럼에게 (중복제거) 적용된다.

[예제4-1] 사원들이 소속된 부서를 조회한다.
-- DISTINCT : 중복을 제외한 결과를 보여주는 함수
SELECT  DISTINCT department_id   -- 중복제거 후 12 rows
FROM    employees;               -- 중복제거 전 107 rows 

-- ALL : 중복을 포함한 결과를 보여주는 함수 ==> 기본값이라 생략가능
SELECT  ALL department_id  
FROM    employees;    
--      ↑ ↓ 같음 (생략)
SELECT  department_id  
FROM    employees; 

-- DEPARTMENTS 테이블 : 27개 부서 (11개 부서에 사원이 소속, 나머지??)
/*
           부서(코드)
--------------------------------------
...
김길동     판매 [10]
홍길동     총무 [20]
이순신     판매 [10]
강감찬     판매 [10]
...
*/

[예제4-2] 사원들이 소속된 부서와 사번을 조회한다.
-- 컬럼끼리 조합해서 중복을 제거 ==> _ID : 식별자 (중복되지 않은 유일한 값, NULL 허용x)
SELECT  DISTINCT department_id, employee_id  
FROM    employees;               




-- 4.2 COUNT() : 데이터 행이 몇건 존재하는지 갯수를 세어서 반환하는 함수
-- 데이터가 NULL인 행은 제외된다.

예제[4-3]
-- * : 애스터리스크 / 모든 행
-- 검색속도의 차이가 있다고 알려져 있음.
-- 사원들은 10~110번 부서에 소속되어 있음.

SELECT  COUNT(*), COUNT(employee_id), COUNT(department_id),  -- 부서없는 사원 제외됨
        COUNT(DISTINCT department_id)
FROM    employees;





-- 4.3 SUM() : 숫자 데이터 컬럼의 전체 합계를 계산하여 그 결과를 반환하는 함수
-- 데이터는 미국 기준, salary는 $ 기준!
SELECT  TO_CHAR(SUM(salary),'999,999') AS 급여총합, 
        TO_CHAR(ROUND(SUM(salary) / COUNT(employee_id)),'9,999') AS 급여평균
FROM    employees;




-- 4.4 MAX() : 데이터 컬럼에서 가장 큰 값을 반환하는 함수 , 4.5 MIN() : 가장 작은 값을 반환하는 함수
-- 모든 데이터 유형을 사용! (숫자데이터 컬럼에만 사용하는게 아니다??)
-- (월)급
-- 연봉(12 * 월급)
SELECT  MAX(salary) AS 최고급여,  --24000 $
        MIN(salary) AS 최저급여   --2100 $
FROM    employees;

[예제 4-6]
SELECT  employee_id, first_name||' '||last_name AS name , job_id, salary
FROM    employees
WHERE   salary IN (24000, 2100);

SELECT *
FROM    job_history;  -- 사번/출근일/퇴사일/직무(업무)/부서코드

SELECT *
FROM    jobs;   -- 직무(업무)/업무제목/최저급여/최고급여

-------- 급여 : 직무와 연관성이 있다.
-- AD_PRES : President (대표자)
-- ST_CLERK : Stock Clerk (재고 담당자)
-- 최고금액 VS 최저금액 10배 차이의 이유?



-- MAX(), MIN() : 모든 데이터 컬럼에서 사용 가능
DESC employees;

SELECT  employee_id, first_name, MAX(hire_date), MIN(hire_date), MAX(commission_pct)
FROM    employees
WHERE   commission_pct IS NOT NULL;  -- 판매사원들의 입사일(최고,최저) , 커미션율(최고
-- ORA-00937 : 단일 그룹의 그룹 함수가 아닙니다.
-- 그룹함수를 사용하지 않고, 함께 나열한 일반 칼럼의 경우 GROUP BY 절에 명시를 해야함!

SELECT  MAX(hire_date), MIN(hire_date)
FROM    employees;  -- 08/04/21,            01/01/13
                    -- 가장 느린 입사자,    가장 빠른 입사자

SELECT  MAX(commission_pct), MIN(commission_pct)
FROM    employees
WHERE   commission_pct IS NOT NULL;

SELECT  employee_id, first_name, hire_date, commission_pct, department_id
FROM    employees
WHERE   commission_pct = 0.4;

SELECT  employee_id, first_name, hire_date, commission_pct, department_id
FROM    employees
WHERE   hire_date = '08/04/21';

-- 4.6 AVG()

-- 지금까지 등장했던 SQL 구문
SELECT
FROM
WHERE
ORDER BY  -- 가장 마지막에 작성한다(★)

-- 4.3 GROUP BY 절  ( 그룹함수 )
-- 1) 특정 조건을 사용하여 데이터 행을 하나의 그룹으로 나눌 수 있다.
-- 2) 그룹짓는 기준이 되는 컬럼을 지정한다.
-- 그룹함수를 사용한 컬럼과 일반 컬럼을 함께 SELECT 절에 작성할 경우,
-- GROUP BY 절을 추가해서 그룹짓는 기준 컬럼을 명시해야 '오류'가 발생하지 않음.
-- !!! SELECT 목록에 사용되는 그룹함수 이외의 컬럼은 반드시 GROUP BY 절에 명시해야 한다 !!!

[예제4-8] 부서별 <== (부서가 기준) 급여 총액, 사원 수, 평균 급여를 조회한다.
SELECT  department_id, SUM(salary) AS 급여총액, COUNT(*) AS 사원수, ROUND(AVG(salary)) AS 평균급여
FROM    employees
GROUP BY department_id
ORDER BY 1;

[예제4-9] 부서별, 업무별 <== (부서가 기준) 급여 총액, 평균 급여를 조회한다.
SELECT  department_id, job_id, SUM(salary) AS 급여총액, ROUND(AVG(salary)) AS 평균급여
FROM    employees
GROUP BY department_id , job_id
ORDER BY 1;

-- SELECT절에 일반컬럼, 그룹함수를 나열할때는 생략 가능 == > GROUP BY 절에는 기준되는 컬럼을 표시해야 함!
SELECT  SUM(salary) AS 급여총액, ROUND(AVG(salary)) AS 평균급여
FROM    employees
GROUP BY department_id , job_id
ORDER BY 1;

[예제4-10] 80번 부서의 급여 총액, 평균 급여를 조회한다.
SELECT  *
FROM    employees
WHERE   department_id = 80;  -- 34 orws / 판매부서

SELECT  department_id , department_name
FROM    departments
WHERE   department_id = 80;

-- SUM(), AVG()

SELECT  department_id AS 부서코드,
        TO_CHAR(SUM(salary),'999,999') AS 급여총액,
        TO_CHAR(ROUND(AVG(salary)),'999,999') AS 평균급여
FROM    employees
WHERE   department_id = 80
GROUP BY department_id;


-- ============== SQL 작성 순서 ===============

SELECT
FROM
WHERE    -- 일반 조건절
GROUP BY 
HAVING   -- 그룹함수 조건절
ORDER BY -- 항상, SQL 마지막에 위치!

-- ============== SQL 작성 순서 ===============


-- 4.4 HAVING 절
-- HAVING 절을 사용하여 그룹을 제한한다.
-- WHERE 절에서 사용하는 조건을 HAVING절에 사용할수도 있으나,  ==> 일반조건일때
-- 그룹함수가 포함된 조건은 HAVING절에서만 사용할 수 있다.    ==> ex> 사원수가 5인 이하인, 평균이 1000이상인

[예제4-11] 80번 부서의 평균 급여를 조회한다.
SELECT  department_id, ROUND(AVG(salary),0) AS avg_sal
FROM    employees
--WHERE   department_id = 80;  -- 8956$
GROUP BY department_id         -- 8956$
HAVING department_id = 80;


-- 부서별 사원 수 조회
SELECT  department_id, COUNT(*) AS cnt
FROM    employees
GROUP BY department_id
ORDER BY 1;

SELECT  department_id, COUNT(*) AS cnt
FROM    employees
GROUP BY department_id
HAVING COUNT(*) <= 5  -- 5이하 조건절
ORDER BY 1;



-- 4.5 ROLLUP, CUBE
-- 4.5.1 ROLLUP : GROUP BY 절에 ROLLUP 함수를 사용해 GROUP BY 구문에 의한 결과와 함께,
--                단계별 소계, 총계    

-- 4.5.2 CUBE : ROLLUP과 같고, **모든 경우의 조합에 대한** 소계, 총계 정보를 구할수 있다(??)
--              ==> 출력되는 내용이 좀더? 세분화/다르게

[예제 4-13] 부서별 사원수와 급여합계, (사원, 급여)총계를 조회한다.
SELECT  department_id, job_id, COUNT(*), SUM(salary)
FROM    employees
GROUP BY ROLLUP(department_id, job_id)  -- 12 rows
ORDER BY 1;










