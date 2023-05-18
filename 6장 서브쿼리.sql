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

/*
= ANY : 일치하는 것 하나라도 있으면 TRUE 결과 (서브쿼리 실행 결과가 다중행을 반환할때)
> ANY : (서브쿼리 실행에 따른 반환결과가 결과적으로) > 최소값(MIN함수) 과 같다.
< ANY : (서브쿼리 실행에 따른 반환결과가 결과적으로) < 최소값(MAX함수) 과 같다.
= ALL : (서브쿼리 실행에 따른 반환결과가 결과적으로) = 모든 결과와 비교해서 TRUE여야 하는 조건 ==> IN 연산자 (결과가 안나오는경우)
> ALL : (서브쿼리 실행에 따른 반환결과가 결과적으로) > 최대값(MAX함수) 과 같다.
< ALL : (서브쿼리 실행에 따른 반환결과가 결과적으로) > 최소값(MIN함수) 과 같다.

 NOT IN <>  ALL는 같은기능
*/
[예제6-10] 100번 부서원 모두의 급여보다 높은 급여를 받는 사원의 사번, 이름, 부서번호, 급여를 급여의 오름차순으로 조회한다.
-- 그룹함수 : COUNT(*) or COUNT(컬럼명) or COUNT(DISTINCT 컬럼명)
-- COUNT() :  NULL 제외
-- 100번 부서원 조회 ==> 그룹별 사원의 수 집계
SELECT   department_id, COUNT(*) AS cnt
FROM     employees
GROUP BY department_id
ORDER BY 1;

SELECT   employee_id, first_name, salary, department_id
FROM     employees
WHERE    department_id = 100 -- 6900, 7700, 7800, 8200, 9000, 12008
ORDER BY 3;

SELECT  employee_id, first_name, department_id, salary
FROM    employees
WHERE   salary > ALL ( SELECT   salary
                       FROM     employees
                       WHERE    department_id = 100 ); -- 서브쿼리, 다중 행 서브쿼리

-- 6.2.2 NOT 연산자
[예제6-16] 부서테이블에서 부서코드가 10,20,30,40에 해당하지 않는 부서코드를 조회한다.
SELECT  department_id, department_name
FROM    departments
WHERE   department_id NOT IN (10,20,30,40); -- 전체부서 : 27개 (10~270)  ==>  <> ALL 같은 기능

SELECT  department_id
FROM    departments
WHERE   department_id > ALL ( SELECT   department_id
                              FROM     departments
                              WHERE    department_id IN (10,20,30,40));

-- 6.2.3 ANY(=SOME) 연산자
-- 6.2.4 ALL 연산자
-- 6.2.5 (단일 행) 다중 컬럼 서브쿼리 (p.57)
-- 서브쿼리도 메인쿼리처럼 여러개의 컬럼을 (비교하는데) 사용할 수 있다.
-- WHERE 절에 (컬럼명1, 컬럼명2...) 처럼 작성
-- 컬럼의 갯수와 데이터 타입이 일치해야 함.
[예제6-18] 매니저가 없는 사원이 매니저로 있는 부서코드, 부서명을 조회한다.
-- 서브쿼리가 없어도 조회가 가능! ==> 서브쿼리를 사용할 줄 알면, 절차를 간단하게 줄일 수 있다.
SELECT  department_id, department_name
FROM    departments
--WHERE   (비교컬럼1, 비교컬럼2) 비교연산 (서브쿼리 결과행-다중컬럼);
WHERE   (department_id, manager_id) = ( SELECT  department_id , employee_id
                                        FROM    employees
                                        WHERE   manager_id IS NULL);
                                        
-- 다중컬럼 서브쿼리 ==> 한번에 두개 이상의 컬럼을 비교하는 서브쿼리
-- 분량 ==> 자주 사용하지 않을것 같다 ==> 비중 적다 vs 유용할수도 ?


-- ====== 단일 행 / 다중 행 / 다중 컬럼 서브쿼리 PART 1) ~ 3) ===========

-- 6.3 EXISTS 연산자(상호연관서브쿼리에서 사용)
-- 상호연관 서브쿼리(P.57)
-- 상호 : 서로 ~    /    연관 : 관련~ 연결 ==> JOIN 연산    vs     SET 연산
-- 서브쿼리인데, JOIN연산을 활용한 서브쿼리! ==> 메인쿼리의 테이블과 서브쿼리의 테이블간의 JOIN 조건이 사용
-- 메인쿼리의 컬럼이 서브쿼리의 조건절에 사용되어 메인 쿼리에 독립적이지 않은 형식
[예제6-19] 매니저가 있는 부서코드에 소속된 사원들의 수를 조회한다.
-- 수를 세어서 그 결과를 반환하는 함수 : COUNT(*) / 그룹함수
-- 매니저가 없는 부서코드 : 90번 vs 매니저가 있는 부서코드 10~80, 100~110
SELECT  COUNT(*) AS 사원수
FROM    employees e
WHERE   EXISTS ( SELECT   department_id
                           FROM     departments d
                           WHERE    manager_id IS NOT NULL 
                           AND      e.department_id = d.department_id );
-- ORA-00920: 관계 연산자가 부적합합니다 : IN 대신 EXISTS를 사용할때는 WHERE절에 비교 컬럼이 없어야 함.
-- EXISTS 연산자는 서브쿼리의 결과행 존재 여부만 판단한다.
-- EXISTS 연산자를 사용할때, 서브쿼리의 SELECT 목록과는 무관한 메인 쿼리 칼럼과의 JOIN 조건이 핵심이다.
-- 다중컬럼 서브쿼리보다 분량은 좀 더 있다 --> 비중이 좀 더 있다 --> 더 자주 사용할 수 있다??
-- 상호연관 서브쿼리는 서브쿼리 실행과를 메인쿼리에 조인 ==> 속도차이가 발생 할 수 있다!


-- 연관성의 유무?
-- 6.4 상호연관 서브쿼리


-------------------------------------------------------------------------------------------------

-- 1) 서브쿼리 결과행에 따른 구분 : 단일 행, 다중행, 다중 컬럼
-- 2) 연관성에 따른 구분(=JOIN연산 사용) : 상호연관 서브쿼리
-- 3) 서브쿼리 사용위치에 따른 구분 : 스칼라 서브쿼리, 인라인 뷰 서브쿼리, (일반, WHERE절에)서브쿼리

-------------------------------------------------------------------------------------------------



-- 6.5 스칼라 서브쿼리
-- 스칼라 : (물리) 방향을 갖지 않고 크기만 갖는 개념(1차원) VS 벡터 : 크기와 방향을 무도 갖는 개념(2차원)
-- SELECT 절에 사용하는 서브쿼리 ==> SELECT 절은 컬럼(하나하나)을 작성하는 곳 (CLAUSE, 절)
-- 코드성 테이블에서 코드명을 조회하거나 그룹함수의 결과값을 조회할때 사용한다. / 최대값 최소값 합계 평균 숫자 ...
[예제6-22]  사원의 이름, 급여, 부서코드, 부서명을 조회한다.
-- JOIN 연산
-- employes : 이름 , 급여 , 부서코드
-- departments : 부서명

SELECT  first_name, salary , department_id, 
         ( SELECT department_name
           FROM   departments d
           WHERE  e.department_id = d.department_id) AS department_name -- 스칼라 서브쿼리 , 연관성 유무 따져봐야 - 상호연관 서브쿼리
FROM    employees e ;

-- 코드성 테이블?? 부서평균급여를 기록해둔 물리적인 테이블은 없지만, 있는것처럼 서브쿼리로 조회
[예제6-23] 사원의 사번, 이름, 급여, 부서코드, 부서평균급여
-- ROUND() : 소수부 / 정수부 자리에서 반올림 함수
-- AVG() : 평균값을 구하여 반환하는 (그룹)함수

SELECT  employee_id , first_name , TO_CHAR(salary, '999,999') , department_id, 
        ( SELECT ROUND(AVG(salary))
          FROM  employees e1
          WHERE e1.department_id = e2.department_id) AS debt_avg_sal  --  (부서평균급여)
FROM    employees e2;




-- 6.6 인라인 뷰 서브쿼리
-- FROM 절에 사용되는 서브쿼리 ==> FROM절은 테이블명 적는곳 ==> 인라인 뷰
-- 뷰 : 가상의 테이블(=메모리에만 존재, 쿼리 실행시 메모리에서 실행, 결과를 반환하고 사라지는...)
-- SELECT 절에 사용되는 서브쿼리 ==> 스칼라 서브쿼리
-- 메인 쿼리와 독립적이고 ==> 별도의 테이블이니까
-- WHERE 절에 메인 쿼리의 테이블과 JOIN을 통해 관계를 맺는다.

-- 보통은 WHERE절에 (일반) 서브쿼리 : 가장 많이 사용한다.

[예제 6-24] 급여가 회사 평균급여 이상이고, 최대급여 이하인 사원의 사번, 이름, 급여,
회사평균급여, 회사최대급여를 조회한다.
-- HR 계정 : 회사의 급여평균 집계 테이블은 없다 ==> 가상으로 있는것처럼 서브쿼리 조회

SELECT  employee_id, first_name, salary,
        avg_sal, max_sal
FROM    employees ,
        ( SELECT ROUND(AVG(salary)) AS avg_sal, MAX(salary) AS max_sal
          FROM employees ) 
--WHERE   salary >= a.avg_sal
--AND     salary <= a.max_sal;
WHERE     salary BETWEEN avg_sal AND max_sal; 
-- JOIN 연산중 NON-EQUI JOIN 형식 : = 이외의 연산자사용하는 JOIN형식 (번위비교연산자 , BETWEEN, IN)
-- 거의 사용하지 않는 형식
-- NON-EQUI JOIN형태의 인라인 뷰 서브쿼리 ==> 테이블의 별칭, 컬럼에 붙이는 경우 에러발생!


[예제6-25, 26] 월별 입사 현황 테이블은 없지만, 인라인 뷰 서브쿼리 형식으로, 월별 입사자 현황을 조회하시오
-- 요구되는 테이블의 구조
-- 1월 ... 6월 ... 12월
-- 14(명) .. 11(명) .. 7(명)
-- 1) 결과행이 하나이다.
-- 2) 컬럼의 수는 1월~12월까지 12개
-- 3) 데이터는 사원수의 합계이다.
-- DECODE / 함수       vs         CASE ~ END / 표현식    <-----> 오라클 IF~ELSE문!
-- 동등비교만!                            동등비교, 범위비교~
-- DECODE (exp, serch1, result1,            CASE (exp WHEN search1 THEN result     or   CASE WHEN conditio
--              search2, result2,                     WHEN search1 THEN result
--               ...계속...                           ELSE 기본값
--              0 ) AS 별칭                 END AS 별칭

--      TO_CHAR()   TO_DATE()
-- 숫자 -----> 문자 ------> 날짜
-- 숫자 <----- 문자 <------ 날짜
--      TO_NUMBER()    TO_CHAR()
-- 숫자 --> 날짜 변환 안되므로, 변환함수가 활용!

SELECT  TO_CHAR(hire_date,'YYYY-MM-DD-DAY') 날짜
FROM    employees;


SELECT  DECODE(TO_CHAR(hire_date,'MM'),'01',COUNT(*),0) AS "1월",
        DECODE(TO_CHAR(hire_date,'MM'),'02',COUNT(*),0) AS "2월",
        DECODE(TO_CHAR(hire_date,'MM'),'03',COUNT(*),0) AS "3월",
        DECODE(TO_CHAR(hire_date,'MM'),'04',COUNT(*),0) AS "4월",
        DECODE(TO_CHAR(hire_date,'MM'),'05',COUNT(*),0) AS "5월",
        DECODE(TO_CHAR(hire_date,'MM'),'06',COUNT(*),0) AS "6월",
        DECODE(TO_CHAR(hire_date,'MM'),'07',COUNT(*),0) AS "7월",
        DECODE(TO_CHAR(hire_date,'MM'),'08',COUNT(*),0) AS "8월",
        DECODE(TO_CHAR(hire_date,'MM'),'09',COUNT(*),0) AS "9월",
        DECODE(TO_CHAR(hire_date,'MM'),'10',COUNT(*),0) AS "10월",
        DECODE(TO_CHAR(hire_date,'MM'),'11',COUNT(*),0) AS "11월",
        DECODE(TO_CHAR(hire_date,'MM'),'12',COUNT(*),0) AS "12월"
FROM    employees
GROUP BY TO_CHAR(hire_date,'MM')
ORDER BY TO_CHAR(hire_date,'MM');
    
-- 그룹함수는 여러 행으로부터 하나의 결과 값을 반환한다. 


-- 수업에서는 인라인 뷰 실습용이지만
-- 업무에서는 집계성테이블 실제 DB에 반영하고, 기업 경영하는데 피룡한 데이터로 누적해서 관리해야함!
-- 테이블의 데이터가 엄청나게 많을때, 조인등으로 연산하면 처리속도/지연시간 ==> 테이블의 일부만 추출할때 사용

-- ROWNUM() : 일반 순위 함수 ( 동순위를 표시, 다음순위+1 표시 = 1,2,3,3,5... )
-- WHERE 절에 사용한다.



SELECT ROWNUM AS rank, employee_id,first_name, salary
FROM    employees
WHERE   ROWNUM <= 5    
ORDER BY salary DESC;             -- salay 높은순으로 5명 조회


[예제 6-27] 사번, 이름을 10건 조회한다.
SELECT employee_id, first_name
FROM    employees
WHERE   ROWNUM <= 10;

[예제 6-28]
SELECT  ROWNUM * AS rank
FROM    ( SELECT  employee_id, last_name, salary,
                  
          FROM    employees );

-- 순위함수를 사용할때
SELECT  employee_id, last_name, salary,
        ROWNUM,
        RANK() OVER(ORDER BY salary DESC) AS salary_rank,
        DENSE_RANK() OVER(ORDER BY salary DESC) AS salary_rank
FROM    employees;













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






