-- 1. 데이터가 담긴 테이블 구조를 조회 명령
-- DESC 테이블명;
-- DESCRIBE 테이블명;
-- describe 테이블명;
-- 대,소문자 구분하지 않음.
-- ※ 왼쪽 접속창 [+] 누르면 같은 기능! (구조를 확인)

DESC DEPARTMENTS;
-- 나머지 테이블을 모두 조회해보세요!
desc countries;


-- 2. 데이터를 조회하는 selet
-- select*from 테이블명;
SELECT * FROM employees;
SELECT * FROM countries;
SELECT * FROM departments;
Select * FROM job_history;
SELECT * FROM locations;
SELECT * FROM regions;

/*
   select *
   from    테이블명;
*/
-- ※ 왼쪽 접속에서 각 테이블을 더블클릭하고, [데이터] 컬럼을 클릭하면 같은 기능!

DESC countries;
select*
from countries;

desc departments;
select*
from departments;

desc employees;
select
*
from employees;





/* 
HR 스키마에 있는 테이블 (=오라클 데이터베이스 객체중 하나)
===================================================
이름                 정보
---------------------------------------------------
COUNTRIES           국가/나라 정보(국가ID/코드, 이름, 지역 코드)
DEPARTMENTS         부서 정보 (부서 코드, 부서 이름, 매니저 코드, 위치코드)
EMPLOYEES           사원 정보 (사원 코드, 이름, 성, 이메일, 전화번호, 입사일, 업무 코드, 급여, 커미션율, 담당자 코드, 부서 코드) 
JOB_HISTORY        
JOBS               
LOCATIONS           
REGIONS
*/


-- 2.1 테이블 구조
-- 오라클 (=데이터베이스 관리 시스템)이 데이터를 2차원 구조 (표, table의 행과 열로)로 기본적으로 저장
-- 테이블 : 어떤 정보가 있는데 <--> 데이터베이스 : 관계(Relation)
-- ex> (회사) 부서 정보 테이블, 사원 정보 테이블

-- ※ Document : 행,열 구조가 아님 vs RDBMS : 테이블(행,열)

/*
↓열(Column) : 가로 방향 [ 열 이름(=특성), 열의 자료형(문자,숫자,날짜..), 길이]
이름           널?       유형           <-- 행(ROW), 세로방향
------------ -------- ------------ 
COUNTRY_ID   NOT NULL CHAR(2)      
COUNTRY_NAME          VARCHAR2(40) 
REGION_ID             NUMBER  



*/


-- 대소문자 구별x
-- 띄어쓰기, TAB을 사용해서 가독성 있게!
-- 쿼리는 절(clause) 단위로 작성
-- 자동완성 지원함! 근데, 직접 쿼리작성 빠름!


-- 2.1 DESC / DESCRIBE : 테이블의 구조 ==> 열 이름, 자료형, (저장할 수 있는 데이터) 길이 확인
--     SELECT : 데이터를 조회 ==> 테이블의 레코드 (ROW 또는 Tuple/튜플)

SELECT *    -- SELECT 절
FROM    employees;  -- FROM 절
-- 계속 뭔가가 추가.. 

-- 2.2 조건절
-- 필요한 정보만 조회하기 위한 구문, 일종의 필터링!
SELECT 열이름1, 열이름2, 열이름3,...
FROM    테이블명;

-- * < 애스터리스크, all (모든 컬럼)
SELECT*
FROM countries; -- 25rows

SELECT *
FROM    departments; -- 27rows

[예제 2-3] 80번 부서의 사원 정보를 조회 ==> 80번 부서에 근무하는 사원들을 필터링!
-- CTRL+ENTER or 블럭씌우고 F5
SELECT *
FROM    employees  -- 107rows, 모든 사원의 정보를 조회
WHERE   department_id = 80;  -- 총 107명중 80번 부서에 근무하는 사원은 34명(rows)
-- 오라클 연산자 : = (같다)  대입x

-- 80번 부서의 부서이름을 조회하시오!
SELECT *
FROM    departments
WHERE   department_id = 80;  -- Sales 부서 : 판매 부서 --> 소속이 많이 필요한 부서

-- Sales 부서 (80번)가 위치한 위치 정보를 조회해보시오! (도로주소, 우편번호, 국가 코드)
SELECT  department_id, department_name, location_id
FROM    departments
--WHERE   department_id = 80;
--WHERE department_name = 'sales';  -- 문자는 '로 작성, 대/소문자를 구분[날짜 데이터도 '로]
WHERE department_name = 'Sales';  -- 부서이름으로 필터링


SELECT *
FROM    job_history; -- 10rows



/*
    WHERE 조건절을 구성하는 항목의 분류 (p.5)
    1) 컬럼명, 숫자, 문자/날짜
    2) 산술 ((+,-,*,/), 비교연산자 (= , <= , < , > , >= , !- , <> , ^=)  -- MOD(젯수, 피젯수) : % 대신 사용하는 함수
    3) AND, OR, NOT
    4) LIKE, IN, BETWEEN, EXISTS
    5) IS NULL, IS NOT NULL
    6) ANY, SOME, ALL
    7) 함수
*/

-- 2.3 연산자
-- 2.3.1 산술 연산자 : +,-,*,/
-- ※ MOD(젯수, 피젯수) : % 대신 사용하는 함수
-- 산술연산자는 SELECT 목록과  WHERE 조건절에 사용할 수 있습니다.


-- 1) SELECT
SELECT 2+2 "합"   -- Alias (별칭, 약어) 
FROM    dual; -- 4
-- 실제 존재하지 않는 테이블 dual, 단순히 산술연산이나 시스템 날짜 출력하거나 함수를 실행, 반환값 확인

SELECT 2-1 AS 차
FROM    dual;
-- 실제로 DB에서는 기본적을 오라클 객체를 (=테이블) 대문자로 작성하는데,
-- 소문자 테이블명으로 작성하려면 생성할 때 "소문자"로 명령을 처리!

SELECT 2 * 4 AS 곱
FROM    dual;

-- 약어 사용시 AS : 생략 가능하지만, SELECT 절이 복잡해지면 가독성 측면에서 AS를 추가하는 개발자가 많다.
-- 라는 통계가 있음 !!


SELECT 2 * 4 AS 곱, 2 - 1 AS 차, 2*3 AS 곱, 2/4 몫
FROM    dual;

-- 2) WHERE 조건절
SELECT  employee_id, last_name, salary, salary * 12 AS 연봉, department_id
FROM    employees
--WHERE   department_id = 80; -- 80번 부서에 근무하는 사원의 정보 조회, 34 rows
WHERE   salary * 12 >= 100000;

[예제2-4] 80번 부서 사원의 한 해 동안 받은 급여를 조회한다.
SELECT  employee_id AS 사번, last_name AS 성, salary * 12 AS 연봉
FROM    employees
WHERE   department_id = 80; -- Sales 부서, 34 rows 

[예제2-4] 한 해 동안 받은 급여가 120000 ($, USD) 인 사원의 정보(어떤걸?) 조회한다.
SELECT  employee_id, last_name, salary * 12 AS 연봉 , department_id
FROM    employees
WHERE   salary * 12 = 120000; -- 연봉 정보가 저장된 컬럼은 없지만, salary컬럼에 12를 곱해서 연봉정보를 조회, 비교

-- 문자열 연결 연산자 : || 
-- 문자 데이터, 숫자 데이터 : '로 묶음

[예제 2-6] 사번이 101번인 사원의 성명을 조회한다.
SELECT  employee_id, last_name ||' '||first_name AS 성명 , job_id, department_id
FROM    employees
WHERE   employee_id = 101;

-- 90번 부서 :
SELECT  department_name
FROM    departments
WHERE   department_id = 90; -- 경영진

-- 컬럼의 별칭 (Alias) : 컬럼에 별칭, 약어를 붙여 사용할 수 있다.
-- 1) 컬럼명 (공백) 별칭 : ' '
-- 2) 키워드 AS 또는 as 사용 -- 가독성 측면에서는 SELECT 절이 복잡해지면 AS를 추가하는 경우!
-- 3) 큰 따옴표를 사용할 수 있다 (보통 생략) 

[예제 2-8] 사번이 101번인 사원의 성과 한해 동안 받은 급여를 조회한다.
-- 성 : name 이라는 별칭
-- 한해 동안 받은 급여 : ANNUAL SALARY 라는 별칭

SELECT  employee_id AS 사번, last_name 성, salary * 12 "ANNUALSALARY"
FROM    employees
WHERE   employee_id = 101;


-- 2.3.3 비교연산자 (p.6)
-- 값의 크기를 비교 : =, >=, >, <, <=
[예제2-9] 급여가 3000 이하인 사원의 정보를 조회한다.
SELECT  employee_id, last_name, salary, department_id
FROM    employees
WHERE   salary <= 3000;  -- 26rows , 30번 50번 부서에 소속

-- 30 : Purchase 구매
-- 50 : Shipping 배송
-- 80 : Sales 판매
-- 90 : Executive 경영진

[예제2-10] 부서코드가 80번 초과인 사원의 정보를 조회한다.
-- 부서코드 : department_id
-- 사원코드 : employee_id
-- 업무코드 : job_id
-- 부서장코드 : manager_id

SELECT  *
FROM    employees
WHERE   department_id > 80; -- 90번 부터 나머지 부서들~ 11rows

-- departments 데이터를 확인!
SELECT  *
FROM    departments; -- 27rows, 10 ~ 270

-- 문자데이터, 날짜데이터는 작은 따옴표(')로 묶어서 표현해야 합니다.
-- 문자데이터는 대,소문자를 구분합니다.

SELECT  *
FROM    employees   
WHERE   last_name = 'Chen';  -- wrong

SELECT  'hanul' AS company_name, employee_id, last_name, hire_date
FROM    employees
WHERE   hire_date < '05/09/28'; --년/월/일 : 먼저, 나중에 입사한 사람들 정보

DESC employees;

[예제2-11] 성이 King인 사원의 정보를 조회한다.
SELECT  employee_id, last_name, email, phone_number, hire_date
FROM    employees
WHERE   last_name = 'King';

[예제2-12] 입사일이 2004년 1월 1일 이전인 사원의 정보를 조회한다.
SELECT  employee_id , last_name, hire_date
FROM    employees
WHERE   hire_date < '04/01/01'; -- 14rows 


-- 2.3.4 논리조건 연산자 (p.8)
-- 조건의 갯수는 여러개가 올 수 있다.
-- AND 연산자는 조건이 모두 TRUE일때
-- 여러 조건이 있을 경우 각각의 조건들을 AND, OR 연산자를 이용해 연결한다.

-- NOT + BETWEEN 연산자, IN 연산자, LIKE 연산자

[예제 2-13] 30번 부서 사원 중 급여가 10000 이하인 사원의 정보를 조회한다.
-- 사원의 정보는 : EMPLOYEES 테이블
-- EMPLOYEE_ID ~ DEPARTMENT_ID : 각종 사원의들의 정보중 어떤 특정 컬럼들이 존재
-- 부서정보는 departments에 있으나, 사원들은 부서 10~110번까지 소속되어 있음

SELECT  employee_id, first_name||''|| last_name AS name, salary, department_id
FROM    employees
WHERE   department_id=30
AND     salary <= 10000;


[예제2-14] 30번 부서 사원 중 급여가 10000 이하이면서 입사일자가 2005년 이전에 입사한 사원의 정보를 조회한다.
SELECT  employee_id, first_name||''|| last_name AS name, salary, department_id
FROM    employees
WHERE   department_id=30
AND     salary <= 10000
AND     hire_date <'05-01-01'; -- '01-JAN-05' : 1일-1월-05년

-- NLS : National Language Support  (동아시아 - 한국/중국/일본) RR/MM/DD
-- DATE : 날짜, 표현할때 YY(Year) vs RR(50이상은 1900년대, 50미만은 2000년대 표기법)


[예제 2-15] 30번 부서나 60번 부서에 속한 사원의 정보를 조회하시오.
SELECT  employee_id,first_name||''||last_name name, salary, phone_number,email,department_id, hire_date
FROM    employees
WHERE   department_id = 30
OR      department_id = 60
AND     hire_date<'05-01-01';  -- 오류
-- IS (30,60) 

-- AND, OR 조건이 혼합되어 사용되는 경우 가독성을 위해 괄호를 붙여주는 것이 좋다.


-- 2.3.5 논리조건 연산자 (p.9)
-- 범위 조건 연산자  BETWEEN 초기값(이상) AND 마지막값(이하);
[예제2-18] 사번이 110번 부터 120번까지의 사원 정보를 조회하시오
-- 100번부터 206번까지 총 107명 근무하는 회사의 사원정보 테이블
SELECT  *
FROM    employees
WHERE   employee_id >= 110
AND     employee_id <= 120;
-- ↑↓ 같은 값 11rows
SELECT  *
FROM    employees
WHERE   employee_id BETWEEN 110 AND 120;


-- (p.10 하단) NOT 연산자와 BETWWN 연산자를 사용하여 BETWEEN초기값 AND 마지막값 과 반대되는 조건을 만든다

-- NOT을 이용해 그외 값 산출 (110~120 제외한 수)
SELECT  *
FROM    employees
WHERE   NOT employee_id BETWEEN 110 AND 120;  -- NOT + 컬럼명

SELECT  *
FROM    employees
WHERE   employee_id NOT BETWEEN 110 AND 120;  -- NOT + BETWEEN ~ 

-- 두 경우 모두 같은 결과가 조회된다.
-- BETWEEN이나 관계연산자로 비교할 수 있는 값은 1)숫자데이터 2)문자데이터 3)날짜데이터 이다.
-- 11g 버전에서는 NLS 설정이 없어서 문제가 안되지만, 21c 에서는 RR/MM/DD 형식을 따라서 조회하여야 오류가 발생되지 않는다.
-- ORA-01858: 숫자가 있어야 하는 위치에서 숫자가 아닌 문자가 발견되었습니다. 라는 오류는 무조건 날짜형식!
-- 맞지않아서 ==> 1) 대게는 변환함수 사용해서 처리하거나 2)NLS 세팅을 확인하고 RR/MM/DD로 조회하거나
-- 도구 > 환경설정 > 데이터베이스 > NLS 확인

-- ↓ NLS 설정 확인 명령~
SELECT  *
FROM    v$nls_parameters;

 -- 날짜 형식으로 변환하는 함수 : TO_DATE('날짜데이터');
 -- RR/MM/DD 또는 TO_DATE('날짜데이터', '지정형식 YY-MM-DD HH:MI:SS')
 -- 3장. 함수 - 변환함수 파트(P.28)
 
 -- 2.3.7 IN 조건연산자
 -- OR연산자 대신 IN 연산자 ==> 가독성, 간결성
 [예제2-25] 30번 부서원 또는 60번 부서원 또는 90번 부서원의 정보를 조회한다.
 SELECT employee_id AS emp_id, first_name||''||last_name AS name , salary, department_id AS dept_id
 FROM   employees
 WHERE  department_id = 30
 OR     department_id = 60
 OR     department_id = 90;          -- 14rows
 -- ↑ 를 IN 연산자로 간결하게 표시 ↓
 SELECT employee_id AS emp_id, first_name||''||last_name AS name , salary, department_id AS dept_id
 FROM   employees
 WHERE  department_id IN (30,60,90);  -- 14rows

 SELECT employee_id AS emp_id, first_name||''||last_name AS name , salary, department_id AS dept_id
 FROM   employees
 WHERE  department_id NOT IN (30,60,90);  -- 92rows 
 
 -- 전체 사원수는 107명
 SELECT *
 FROM   employees;  -- 107rows... 14(30,60,90 부서) + 92(나머지 부서) = 106 ... 1명은?
 -- 178 Kimberely Grant (부서코드 NULL) : 부서배정이 안된? 
 
 
 -- 2.3.8 LIKE 연산자 (p.11) 
 -- 컬럼값중 특정 패턴에 속하는 값을 조회할때 사용하는 문자열 패턴 연산자
 -- 1) % : 여러 개의 문자열을 나타낸다.
 -- 2) _ : 하나의 문자열을 나타낸다.
 [예제 2-28] 이름이 K로 시작되는 사원정보를 조회한다.
 -- 문자 데이터는 대,소문자를 구분   vs SQL은 대,소문자를 구분 안함
 -- 예) 'k' 와 'K'는 다른..
 -- last_name : 성
 -- first_name : 이름
 SELECT *
 FROM   employees
 WHERE  first_name LIKE 'K%'; -- 7rows
 
 [예제 2-29] 성이 s로 끝나는 사원 정보를 조회한다.
 SELECT *
 FROM   employees
 WHERE  last_name LIKE '%s';  -- 18rows

[예제 2-30] 이름에 b가 들어있는 사원 정보를 조회한다.
SELECT  *
FROM    employees
WHERE   first_name LIKE '%b%'; -- 3rows

desc employees;
-- NVARCHAR2(길이) : National + VARCHAR2(10)   vs  VARCHAR2(10)   : (한국)30byte   vs (미국) 10byte 
-- VARCHAR2(길이) : 문자 데이터
-- VARCHAR(길이) : 일반적인 목적으로 사용하지 않고, 오라클에서 사용할 예정인 타입 ==> 우리는 사용X
-- NUMBER(길이) : 정수 데이터
-- NUMBER(총길이, 소숫점이하길이) : 실수 데이터
-- DATE : 날짜 데이터
-- ※ INT 자료형으로 컬럼을 정의하면 ==> 오라클 내부적으로 NUMBER로 변경해버림..
-- STRING 자료형으로 컬럼을 정의하면 ==>          "      VARCHAR2로 변경해버림
-- 빅데이터, 바이너리(=이미지,오디어,영상) ==> BLOB, CLOB, BFILE 타입 ==> 쓰는걸 본적이없음


[예제 2-31] 이메일의 세번째 문자가 B인 사원정보를 조회한다.
-- % : 여러문자
-- _ : 하나의 문자
SELECT *
FROM    employees
WHERE   email LIKE '__B%';  -- 1rows

[예제 2-32] 이메일이 뒤에서부터 세번째 문자가 B인 사원정보를 조회한다.
SELECT *
FROM    employees
WHERE   email LIKE '%B__';  -- 1rows

-- LIKE 역시 IN, BETWEEN 처음값 AND 마지막값 과 같이 NOT 연산자와 함께 사용할 수 있다. (p.14)


[예제2-33] 전화번호가 6으로 시작되지 않는 사원의 정보를 조회한다.
-- phone_number 컬럼 :
-- phone_number LIKE '6%' + NOT

SELECT employee_id, first_name, phone_number, job_id
FROM    employees
--WHERE   phone_number LIKE '6%'; -- 46rows (6으로 시작하는) 
WHERE   NOT phone_number LIKE '6%'; -- 61rows (6으로 시작하지 않는)


--===============================================
--   Q. %나 _ 자체를 문자열로 조회하고자 한다면?
--===============================================

[예제 2-34] JOB_ID에 _A가 들어간 사원 정보를 조회한다.
SELECT  *
FROM    employees
WHERE   job_id LIKE '%_A%'; -- 49 rows

-- ESCAPE 식별자를 사용해 %나 _ 자체를 하나의 문자로 검색하게 한다.
-- WHERE 컬럼명 '%\_A%' ESCAPE '\';

SELECT  *
FROM    employees
WHERE   job_id LIKE '%\_A%' ESCAPE'\'; -- 49 rows


-- 2.3.9 NULL조건처리
-- NULL : 빈 값 ---> ''   / 데이터가 입력되지 않음.
SELECT  *
FROM    locations; -- 23 rows


-- IS NULL : NULL 인 데이터를 조회
-- IS NOT NULL : NULL 이 아닌 데이터를 조회
SELECT  *
FROM    locations
WHERE   state_province IS NULL; -- 6rows

SELECT  *
FROM    locations
WHERE    state_province IS NOT NULL; -- 17rows

--====== LOCATIONS (부서 위치 정보 테이블) ======
-- POSTAL_CODE : 우편번호
-- STATE_PROVINCE : 행정구역 (~주)



SELECT  *
FROM    employees
WHERE   commission_pct IS NULL;  -- 거래 수수료를 받지 않는사람 ?? 72 rows 총 107명 중 35명은 받는 사람!

SELECT  employee_id, last_name, salary, department_id, job_id, hire_date
FROM    employees
WHERE   commission_pct IS NOT NULL;

SELECT  *
FROM    departments
WHERE   department_id = 80;

SELECT  *
FROM    jobs
WHERE   job_id IN ('SA_MAN', 'SA_REP');

-- ====== EMPLOYEES (사원 정보 테이블) ======
-- commission_pct : (거래에 따른) 수수료율,
-- manager_id (매니저, 관리자),
-- department_id (부서코드)

-- 80번 부서 Sale 파트 ==> 판매부서니까 거래 수수료 (=많이 팔면, 많이 남기는 구조)
-- commission_pct가 NOT NULL 인 이유!  기본급 낮되, 수수료를 책정해서 지급하는 구조?
--          "       NULL 인 이유? 판매부서가 아님, 기본 급여가 높거나..
-- 근데, 1명이 부서는 없으나 commission_pct가 NOT NULL인 사람 (178 Kiberle













