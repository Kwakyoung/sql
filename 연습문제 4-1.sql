[연습문제 4-1]

1. 사원 테이블에서 이 회사의 매니저들을 조회하시오
-- manager_id : 사원중 매니저에 해당하는 사원의 사번(=employee_id)
-- employee_id
DESC employees;

SELECT DISTINCT manager_id
FROM    employees
WHERE   manager_id IS NOT NULL; -- 18명
