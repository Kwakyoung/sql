[연습문제 4-3]

1. 사원테이블에서 똑같은 이름이 둘 이상 있는 이름과 그 이름이 모두 몇명인지를 조회한다

SELECT  first_name, COUNT(*) AS cnt
FROM    employees
--WHERE 
GROUP BY    first_name
HAVING   COUNT(*) >= 2
ORDER BY 2 DESC;




2. 부서번호, 각 부서별 급여총액과 평균급여를 조회하는 쿼리문을 작성한다
단, 부서 평균급여가 8000 이상인 부서만 조회

SELECT  department_id, SUM(salary) AS sum_sal, ROUND(AVG(salary)) AS avg_sal
FROM    employees
--WHERE
GROUP BY department_id
HAVING ROUND(AVG(salary)) >= 8000
ORDER BY 3 ;  -- 6 rows




3. 년도, 년도별로 입사한 사원수를 조회하는 쿼리문을 작성한다.
단, 년도는 2014의 형태로 표기되도록 한다 --YYYY

SELECT  TO_CHAR(hire_date,'YYYY') AS YEAR ,COUNT(*) AS "입사한 인원"
FROM    employees
GROUP BY TO_CHAR(hire_date,'YYYY')
ORDER BY 1;

