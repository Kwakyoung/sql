-- 3장. 기본함수
-- 내장함수 + 사용자 정의 함수 == PL/SQL (SQL을 이용한 프로그래밍 문법)
-- 함수 : 대게는 Return 값이 있다
-- 프로시저 : Return 값이 없는 함수 형태
-- 프로그래밍 언어에서 사용하는 함수와 비슷하다
-- 자주 사용하는 기능을 함수로 정의하여 만들어둔 뒤, 필요할 때 마다 호출한다.
-- 예) 전체 사원의 급여 평균을 조회 ==> AVG()
-- 예) sal_avg() : 사용자 정의 함수 만들수 있는데.. 수학/삼각/재무/통계 함수는 대게 제공함.
-- 기본적으로 사용자 정의 함수는 기본함수에 없는 특별한 처리와 결과값 반환을 위해 만듦. (PL/SQL)

-- 기본함수 : 행 당 하나의 결과를 반환하는 "단일 행" 함수
-- 함수에서 사용하는 파라미터, 값의 유형에 따라 함수를 구분한다.
-- 함수의 종류 : 숫자/문자/날짜/변환/일반 함수


-- ※ 모든 함수를 교재에서 다룬것은 아님!!

-- 3.1 숫자함수

-- 3.1.1 ABS() : 절대값으로 반환하는 함수 
-- dual : 가짜 테이블
SELECT ABS(32), ABS(-32)
FROM    dual;
/*
   ABS(32)   ABS(-32)
---------- ----------
        32         32
*/




-- 3.1.2 SIGN() : 부호(음수,양수,0)
SELECT SIGN(32), SIGN(-32), SIGN(0)
FROM    dual;
/*  SIGN(32)  SIGN(-32)    SIGN(0)
   ---------- ---------- ----------
        1         -1          0
*/



-- 3.1.3 ROUND(n [,i]) : 반올림 함수 .. N을 소숫점 i번째 자리로 반올림한 결과를 반환하는 함수
[예제3-3]
SELECT ROUND(123.45678) avg1,
        ROUND(123.45678,1) avg2,
        ROUND(123.45678,0) avg3,
        ROUND(123.45678,-1) avg4
FROM    dual;
/*
      AVG1       AVG2       AVG3       AVG4
---------- ---------- ---------- ----------
       123      123.5        123        120
       
     i가 음수인 경우, 정수부 i번째 자리에서 반올림
*/


-- 3.1.3 TRUNC(n [,i]) : 버림 함수 .. 기본적으로 ROUND와 같다
[예제3-5]
SELECT  TRUNC(123.456787) T1,
        TRUNC(123.456787, 0) T2,
        TRUNC(123.456787, 2) T3,
        TRUNC(123.456787, -2) T4  -- 정수부 I번째 자리에서 버림
FROM    dual;


--3.1.4 CEIL(n) : N과 같거나 큰 가장 작은 정수 (단어 뜻 : 천정, 올림?)
[예제3-6]
SELECT  CEIL(0.12345) CEIL1,
        CEIL(123.45) CEIL2
FROM    dual;


-- 3.1.5 FLOOR(n) : n과 같거나 작은 가장 큰 정수 (단어 뜻 : 버림, 내림)
[예제3-6]
SELECT  FLOOR(0.12345) FLOOR1,
        FLOOR(123.45) FLOOR2
FROM    dual;


-- 3.1.6 MOD(m, 2) : m을 n으로 나눈 나머지 값을 반환하는 함수
-- % : LIKE 연산자와 함께 '여러 문자열' 찾는 패턴의 기호로 사용됨.
[예제3-8]
SELECT  MOD(17, 4) MOD1,
        MOD(17,-4) MOD2,
        MOD(-17,-4) MOD3,
        MOD(17, 0) MOD4
FROM    dual;

-- 0으로 나누는 쿼리 ==> Zero Divide 에러 발생가능!

[연습문제 3-1]
                                                                (급여+급여*0.15)
1. 사원 테이블 100번 부서와, 110번 부서의 사원에 대해 사번, 이름, 급여, 15% 인상된 급여를 조회한다
(단, 15% 인상된 급여는 정수로 표시하고, 컬럼명은 Increased Salary 라고 표시)

SELECT  employee_id , first_name , department_id, salary , 
        TRUNC(salary+salary*0.15) AS "Increased Salary ROUND"
--        ROUND(salary+salary*0.15) AS "Increased Salary TRUNC",
--        CEIL(salary+salary*0.15) AS "Increased Salary CEIL",
--        FLOOR(salary+salary*0.15) AS "Increased Salary FLOOR"   
FROM    employees
--WHERE   부서코드 = 100
--OR      부서코드 = 110
WHERE   department_id IN (100, 110); -- 8 rows


-- 100번, 110번 부서 : Finance(금융?) , Accounting(회계)
SELECT *
FROM    departments
WHERE   department_id = 110;





-- 3.2 문자함수

-- 3.2.1 CONCAT(char1, char2) : 두 문자열 char1, char2를 연결하여 반환하는 함수
-- || : 문자열 연결 연산자 (간결)

[예제3-9]
SELECT CONCAT('Hello', 'Oracle') CONCAT1,
       'Hello'||'Oracle' CONCAT2
FROM    dual;

-- 3.2.2 INITCAP(char) : 알파벳 단어 단위로 첫글자를 대문자화하여 반환하는 함수
-- 3.2.3 UPPER(char) : 알파벳을 모두 대문자화하여 반환하는 함수
-- 3.2.4 LOWER(char) : 알파벳을 모두 소문자화하여 반환하는 함수

[예제3-10]
SELECT  INITCAP('i am a boy') CAP1,
        UPPER('i am a boy') CAP2,
        LOWER('I AM A BOY') CAP3,
        LOWER('대한민국') CAP4
FROM    dual;

-- 3.2.5 LPAD(char1,n [,char2])
-- 3.2.6 RPAD(char1,n [,char2])
-- ※ n : 전체 문자열 길이 , (n 생략시, 기본값으로 공백문자 1개가 지정된다) 
-- ※ LPAD는 왼쪽에 공백/문자열(char2) 채우고, RPAD는 오른쪽에 공백/문자열(char2)을 채워 반환한다.
-- ※ 업무상 추가보다는 제거할 일이 훨씬~ 많다.!!

[예제3-11]
SELECT  LPAD('abc', 7) AS LPAD1,
        LPAD('abc', 7, '*') AS LPAD2,
        RPAD('abc', 7) AS RPAD1,
        RPAD('abc', 7, '#') AS RPAD2
FROM    dual;


-- p.23
-- 3.2.7 LTRIM(char1 [,char2]) : 문자열 char1에서 char2로 지정한 문자를 제거한 결과를 반환한다.
-- 3.2.8 RTRIM(char1 [,char2]) :                        " "
-- ※ 제거하고자 하는 문자열 생략 : 디폴트로 공백문자 한개가 사용된다.
-- 왼쪽에서 오른쪽으로 스캔하면서 일치하지 않는 문자가 나오기 
[예제3-12]
SELECT '[' || LTRIM('    ABCDEFG     ')||']' LTRIM1,
        LTRIM('ABCDEFG','AB') LTRIM2,
        LTRIM('ABCDEFG','BA') LTRIM3,  -- 순서상관없이 지움
        LTRIM('ABCDEFG','BC') LTRIM4   -- B,C가 아닌 A로 
FROM    dual;

[예제3-13]
SELECT '[' || RTRIM('    ABCDEFG     ')||']' RTRIM1,  -- 글짜바꾸기 > 블록씌우고 CTRL + R
        RTRIM('ABCDEFG','FG') RTRIM2,
        RTRIM('ABCDEFG','GEF') RTRIM3,  -- 순서상관없이 지움
        RTRIM('ABCDEFG','EGFD') RTRIM4    
FROM    dual;


-- 3.2.9 TRIM([LEADING, TRAILING, BOTH] [,trim_char] [FROM] char) : 문자열 char의 왼쪽(LEADING)이나
-- 오른쪽(TRAILING) 또는 양쪽 (BOTH)에서 지정된(=제거할) trim_char 문자를 제거한 결과를 반환하는 함수
-- 방향 : LEADING(=left), TRAILING(=right), BOTH(=left and right) (기본값은 생략시 BOTH 기본값 = 양쪽제거)
[예제3-14]
SELECT  '[' || TRIM('      ABCDEFG       ') || ']' TRIM1,  -- 공백제거
        '[' || LTRIM('      ABCDEFG       ') || ']' LTRIM,
        '[' || RTRIM('      ABCDEFG       ') || ']' RTRIM,
        '[' || TRIM(LEADING 'A' FROM 'ABCDEFG') || ']' TRIM2,
        '[' || TRIM(TRAILING 'G' FROM 'ABCDEFG') || ']' TRIM3,
        '[' || TRIM(BOTH '1' FROM '1ABCDEF1') || ']' TRIM4,
        '[' || TRIM('1' FROM '1ABCDEF1') || ']' TRIM5,
        '[' || TRIM(TRAILING 'C' FROM 'ABCDEF') || ']' TRIM6
FROM    dual;

-- 3.3.0 SUBSTAR(char, position [,length]) : 문자열의 일부를 추출/분리해서 반환하는 함수
-- char : 지정된 문자열
-- position : 지정된 위치, 값을 0으로 명시할 경우 1로 적용(=문자열의 첫번째 자리)
-- length : 길이, 갯수 --> length 생략시 문자열의 끝까지

--SA_MAN
--SA_REP
-- 0505.040.
-- EMAIL ID : manager@hr.com

[예제3-15]
SELECT  SUBSTR('You are not alone',9,3) SUBSTR1,    -- 9번째 위치부터 3자를 분리해서 반환
        SUBSTR('You are not alone',5) SUBSTR2,      -- (length 생략시) 5번째 위치에서 끝까지 분리해서
        SUBSTR('You are not alone',0,3) SUBSTR3,    -- position을 0으로 명시하면 1로 기본값
        SUBSTR('You are not alone',-9,3) SUBSTR4,   -- position 음수면, 문자열 뒤에서 부터..
        SUBSTR('You are not alone',-5) SUBSTR5      -- position을 음수이고 length 생략시 뒤에서 끝까지
FROM    dual;

-- ======================================================
-- position 값이 음수일 경우 그 위치가, 오른쪽부터 시작된다
-- ======================================================
SELECT  INSTR('admin@hanuledu.co.kr', '@') at_ps  -- @의 위치 = 6 고로 앞에는 5자리 (admin)
FROM    dual;

SELECT  SUBSTR('admin@hanuledu.co.kr', 1, 5) email_id -- 1부터 5까지가 id
FROM    dual;

-- 3.3.1 REPLACE(char, serch_string [,replace_string]) : 문자열중 일부를 다른 문자열로 변경하여 반환
-- char : 문자열
-- search_string : 찾을 문자열
-- replace_string : 변경할 문자열, 생략할 경우 또는 NULL이 오면 search_string 문자열을 제외한 결과를 반환

[예제 3-17]
SELECT  REPLACE('You are not alone', 'You', 'We') REP1,
        REPLACE('You are not alone', 'not') REP2,  -- replace_str 생략, search_str 제외한 char 반환
        REPLACE('You are not alone', 'not', null) REP3
FROM    dual;

-- 3.3.2 TRANSLATE(char, from_string, to_string) : from_string에서 해당하는 문자를 찾아 to_string 해당하는 문자로 1:1 변환하여 반환
-- 1대 1로 문자 변환 :
[예제 3-18]
SELECT  TRANSLATE('u! You are not alone','You','We') TRANS1, -- 글자가 1:1 you : we 한자씩 변환됨
        REPLACE('u! You are not alone','You','We') REPLACE2
FROM    dual;


-- ============ Quiz ============
-- 너는 나를 모르는데 나는 너를 알겠느냐 , 이 문자열을 REPLACE() 와 TRANSLATE() 로 아래와 같이 변경
-- 나는 나를 모르는데 나는 나를 알겠느냐   <-- REPLACE 함수 사용해서,
-- 나는 너를 모르는데 너는 나를 알겠느냐   <-- TRANSLATE 함수 사용해서

SELECT  REPLACE('너는 나를 모르는데 나는 너를 알겠느냐','너','나') REPLACE1,
        TRANSLATE('너는 나를 모르는데 나는 너를 알겠느냐','너나','나너') TRANSLATE2
FROM    dual;


--3.3.3 INSTR(char, search_string [,position][,th]) : 문자열에서 특정 문자열의 시작 위치를 반환하는 함수
-- char : 문자열
-- search_string : 찾을 문자
-- position : 문자를 찾는 시작 위치
-- _th : 몇번째 문자열인지
-- ※ 문자열의 position 위치에서부터 특정 문자를 찾기시작해 -th번째에 해당하는 시작위치를 반환하는 함수
-- 찾을 문자열이 발견되지 않으면 0을 반환
-- 찾을 문자열이 발견되면 해당 위치값을 반환

[예제 3-19]
SELECT  INSTR('Every Sha-la-la-la','la') INSTR1,        -- 1의 위치, 첫번째 la의 시작하는 위치 반환
        INSTR('Every Sha-la-la-la','la', 7) INSTR2,     -- 7번째 위치에서 찾기시작해서 첫번째 la의 위치
        INSTR('Every Sha-la-la-la','la', 1, 2) INSTR3,  -- 두번째 la의 위치
        INSTR('Every Sha-la-la-la','la', 12, 2) INSTR4, -- 12번째 위치에서 찾기시작, 두번째 la의 위치
        INSTR('Every Sha-la-la-la','la', 15, 2) INSTR5  -- 15번째 위치에서 찾기시작, 두번째 la의 위치
FROM    dual;


-- 3.3.4 LENGTH(char) : 문자열의 길이를 반환한다.
-- 3.3.5 LENGTHB(char) : 문자열의 바이트값을 반환한다.
[예제3-20]
SELECT  LENGTH('Every Sha-la-la-la') LEN1,
        LENGTH('무궁화 꽃이 피었습니다') LEN2,
        LENGTHB('Every Sha-la-la-la') || ' Bytes' LEN3,
        LENGTHB('무궁화 꽃이 피었습니다') || ' Bytes' LEN4  -- 한글은 3Bytes, NLS 설정 => 오라클 설치시 자동 적용!
FROM    dual;




-- 3.3 날짜 함수 (p.27)
-- 날짜와 더불어 시간을 연산 대상으로 한다.

-- 3.3.1 SYSDATE
-- 시스템의 현재 날짜를 가져와 반환하는 함수
-- 이 날짜는 시각을 포함하고 있다.
-- SYSDATE 함수는 다른 함수와 다르게 파라미터가 없다. () 를 사용하지 않는다.
-- SYSDATE() : 엄청 자주, 일반적으로 쓰는 함수 --> SYSDATE로 표기

SELECT  SYSDATE
FROM    dual;       -- 23/05/09 <==> 시스템 날짜 형식 : RR/MM/DD
-- YY vs RR 표기법 : 50 이상이면 1900년대, 50 미만이면 2000년대 표기
-- 99/05/09 ==> 1999/05/09
-- 03/05/09 ==> 2003/05/09

-- 날짜 형식(Format)을 확인하는 SQL
SELECT  *
FROM    v$nls_parameters; -- : 공용뷰 (누구나 쓸수) VS 권한마다 다름..
-- NLS_DATE_FORMAT : RR/MM//DD --> YY/MM/DD, YYYY/MM/DD, YY/MM/DD HH:MI:SS.. [날짜/시간 형식 지정]                     

-- 일시적으로 날짜 포맷을 기존 : 날짜 --> 변경 : 날짜+시간 형식으로 변경
-- 영구적인 설정X , 현재 로그인된 HR 세션에서만 유효!
-- 도구 > 환경설정 > 데이터베이스 > NLS : 날짜 포맷
ALTER SESSION SET nls_date_format = 'RR/MM/DD HH24:MI:SS';  -- 24시간제 표시, HH만하면 12시간제
ALTER SESSION SET nls_date_format = 'RR/MM/DD';

SELECT  SYSDATE, SYSTIMESTAMP
FROM    dual;

-- =================================================================
-- 설정을 매번 바꾸어서 날짜, 시간을 출력하는 것은 불편하므로,
-- 변환 함수를 사용하여, 그때 그때 원하는 형식으로 출력하는 편이 낫다
-- =================================================================
SELECT SYSDATE,
        TO_DATE('2023-05-09 17:32:20', 'RR/MM/DD HH24:MI:SS') SYSDATE_TIME
FROM    dual;


-- table (객체) : 데이터를 저장
-- view (객체) : 테이블의 일부만 추출해서 마치 테이블처럼 사용 (조회|저장 ..)

-- HR 계정, EMP_DETAILS_VIEW  ( 사원,세부정보 담은 뷰)

SELECT *
FROM EMP_DETAILS_VIEW;  -- 뷰를 조회! (임시 뷰 - 메모리에서 존재)

-- 3.3.1 ADD_MONTHS(date, n) : date에 개월수 n을 더해서 그 결과(날짜)를 반환하는 함수
-- n : integer
[예제3-21]
SELECT  ADD_MONTHS(SYSDATE, 1) MONTH1,
        ADD_MONTHS(SYSDATE, 2.5) MONTH2,
        ADD_MONTHS(SYSDATE, -3) MONTH3
FROM    dual;

-- 3.3.2 MONTHS_BETWEEN(date1, date2) : 두 날짜 사이의 개월수를 구하여 반환하는 함수
-- date1 : 이후 날짜
-- date2 : 이전 날짜
-- ※ date1 - date2 형식으로 계산

[예제3-22]
-- ROUND(n, 0)
-- TRUNC(n, 0)
-- CEIL(n)
-- FLOOR(n) 
-- ABS(n)

SELECT  ROUND(MONTHS_BETWEEN('2013-03-20', SYSDATE)) AS REMAINED,
        ABS(TRUNC(MONTHS_BETWEEN(SYSDATE, '2013-08-28'))) AS PASS
FROM    dual;


-- 3.3.3 LAST_DAY(date) : date에 해당하는 달의 마지막 날짜를 반환한다.
-- 3월이면 31 반환, 4월이면 30 반환
-- 오늘 날짜 5월은 31
-- 매월 말 보고서를 자동으로 생성하거나, 관련 데이터(비용 지출 내역?) 등을 월말 보고로 자동생성하는
-- 서비스를 생성하거나 하는 기능에서 필요할 수 있는 함수

SELECT  LAST_DAY(SYSDATE) AS LAST1,
        LAST_DAY('2013-03-20') AS LAST2
FROM    dual;

SELECT  employee_id, first_name, hire_date
FROM    employees;


-- 3.4 변환함수
-- 3.5 일반함수

-- 고급함수 : 데이터 사이언티스트(DS), 데이터 분석가(DA) 들이 사용하는 함수