[연습문제6-2]

1. 부서위치코드가 1700에 해당하는 모든 사원의 사번, 이름, 부서코드, 업무코드를 조회하는 쿼리문을
다중행 서브쿼리로 작성한다.
-- 결과가 여러개 비교 ==> IN, ANY(=SOME), ALL 이런거~

-- 1.1 서브쿼리 없이 조회
SELECT  employee_id, first_name, department_id, job_id
FROM    employees
WHERE   department_id IN (10,30,90,100,110); -- 10, 30, 90, 100, 110 / 120~270 제외

-- 1.2 서브쿼리로 조회
SELECT  employee_id, first_name, department_id, job_id
FROM    employees
WHERE   department_id IN ( SELECT department_id
                            FROM  departments
                            WHERE location_id = 1700); -- 18 rows
-- IN , =ANY 둘다 같음


-- 가장 급여를 많이받는 : MAX(salary) ==> 단일 행 함수!  단일 행 서브쿼리 특징!
2. 부서별로 가장 급여를 많이 받는 사원의 사번, 이름, 부서번호, 급여, 업무코드를 조회하는 쿼리문을
다중 컬럼 서브쿼리를 사용하여 작성한다.
SELECT  employee_id, first_name, department_id, salary, job_id
FROM    employees
WHERE   (department_id, salary) IN ( SELECT department_id, MAX(salary)    
                                    FROM   employees
                                    GROUP BY department_id);




[연습문제6-3]
1. 각 부서에 대해 부서코드, 부서명, 부서가 위치한 도시이름을 조회하는 쿼리문을 
스칼라 서브쿼리로 작성한다.
-- 상호연관 서브쿼리 정의 : 메인쿼리 컬럼이 서브쿼리의 조인 조건절에 사용되는 --> 독립적이지 않은?
SELECT department_id, department_name,
       ( SELECT city
         FROM   locations l
         WHERE  l.location_id = d.location_id ) AS city_name
FROM    departments d;




[연습문제 6-4]
1. 급여가 적은 상위 5명 사원의 순위, 사번, 이름, 급여를 조회하는 쿼리문을 인라인 뷰 서브쿼리로 작성한다.
SELECT  ROWNUM AS RANK, e.*
FROM    ( SELECT    employee_id, first_name, salary
          FROM      employees
          ORDER BY  salary ASC ) e
WHERE   ROWNUM <= 5;

-- 순위함수
SELECT  ROWNUM as rank,
        RANK() OVER(ORDER BY e.salary) AS rank1,
        e.*
FROM    ( SELECT employee_id, first_name, salary
          FROM   employees
          ORDER BY salary )e
WHERE ROWNUM <= 5;



2. 부서별로 가장 급여를 많이 받는 사원의 사번, 이름, 부서번호, 급여, 업무코드를 조회하는 쿼리문을
인라인 뷰 서브쿼리를 사용하여 작성한다.
SELECT department_id, MAX(salary)
FROM    employees
WHERE   department_id IS NOT NULL
GROUP BY department_id
ORDER BY 1;







