1. 급여가 가장 적은~ 사원의 사번, 이름, 부서(명), 급여를 조회한다.
SELECT  e.employee_id, e.first_name, e.last_name,
        d.department_name
FROM    employees e, departments d
WHERE   e.department_id = d. department_id
AND     salary = ( SELECT MIN(salary) AS max_sal
                   FROM employees );
                   
                   
                   
2. 부서명 Marketing인 부서에 속한 모든 사원의 사번, 이름, 부서코드, 업무코드를 조회하는 쿼리를 작성한다.
SELECT  department_id
FROM    departments
WHERE   department_name LIKE 'Marketing';


-- 메인쿼리
SELECT  employee_id, first_name, department_id, job_id
FROM    employees
WHERE   department_id = ( SELECT  department_id
                          FROM    departments
                          WHERE   department_name LIKE 'Marketing');
                          
                          
                          
3. 회사의 사장보다 더 먼저 입사한 사원들의 사번, 이름, 입사일을 조회하는 쿼리문을 작성
-- 사장은 그를 관리하는 매니저가 없는 사원이다.
-- 3.1 사자으이 입사일 조회
SELECT  hire_date
FROM    employees
WHERE   manager_id IS NULL; -- NULL 비교대상 x ==> IS NULL or IS NOT NULL 아니면 NULL 처리!!
-- 03/06/17

-- 3.2 입사일을 비교해서 더 먼저
SELECT  employee_id , first_name, hire_date
FROM    employees
WHERE   hire_date < (SELECT  hire_date
                     FROM    employees
                     WHERE   manager_id IS NULL) -- 10 rows
ORDER BY 3;
                  
                          
                          
                          
                          
                          
                          
                          
                          
                          
                          
                          
                          
                          
