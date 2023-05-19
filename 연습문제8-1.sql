[연습문제8-1]

1. EMP 테이블에 (교재의) 데이터 행을 저장하시오

DESC emp;

SELECT  *
FROM    emp;
-- DML : INSERT, UPDATE, DELETE
INSERT INTO emp (emp_id, fname, lname, hire_date, salary)
VALUES (400, 'Johns','Hopkins',TO_DATE('2008/10/15','YYYY/MM/DD'),5000);
INSERT INTO emp (emp_id, fname, lname, hire_date, salary)
VALUES (401, 'Abraham','Lincoln',TO_DATE('2010/03/03','YYYY/MM/DD'),12500);
INSERT INTO emp (emp_id, fname, lname, hire_date, salary)
VALUES (402, 'Tomas','Edison',TO_DATE('2013/06/21','YYYY/MM/DD'),6300);

-- 또는 VALUES 생략하고,
-- SELECT ~ 이하 : ITAS

--UPDATE 테이블명
--SET 컬럼명
--WHERE 조건;

--DELETE FROM 테이블명
--WHERE 조건;


2. EMP 테이블의 사번 401번 사원의 부서코드를 90으로, 업무코드를 SA_MAN으로 변경하고 데이터 행의 저장을 확정한다.
UPDATE  emp
SET     dept_id = 90,
        job_id = 'SA_MAN'
WHERE   emp_id = 401;

-- 데이터 저장을 확정
COMMIT;





3. EMP 테이블의 급여가 8000 미만인 모든 사원의 부서코드를 80번으로 변경하고, 급여는 employees 테이블의
80번 부서의 평균 급여를 가져와 변경한다.
(단, 평균급여는 반올림된 정수를 사용한다.)

SELECT  *
FROM    emp
WHERE   salary < 8000;

-- EMPLOYEES 테이블의 80번 부서원의 평균 급여 조회
SELECT (ROUND(AVG(salary)))
FROM    employees
WHERE   department_id = 80;  -- 8956

SELECT department_id,(ROUND(AVG(salary)))
FROM    employees
WHERE   department_id = 80
GROUP BY department_id;

-- 데이터 변경
UPDATE  emp
SET     dept_id = 80,
        salary = (  SELECT ROUND(AVG(salary))
                    FROM    employees
                    WHERE   department_id = 80 )
WHERE   salary < 8000;

-- 확인
SELECT   *
FROM    emp;



4. EMP 테이블의 2010년 이전 입사한 사원의 정보를 삭제한다.
-- TO_CHAR(hire_date, 'YYYY')
-- 2009년 12월 31일 까지(포함), 2010년 1월 1일 미만

-- 조회
SELECT  *
FROM    emp
--WHERE   hire_date <= '2009-12-31';
WHERE   TO_CHAR(hire_date, 'YYYY') <= TO_CHAR('2010');

-- 삭제
DELETE  FROM    emp
WHERE   hire_date < ('2009-12-31');

















