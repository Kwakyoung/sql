
-- 13번 문제
CREATE TABLE DEPT (
    DEPTNO NUMBER PRIMARY KEY,
    DNAME VARCHAR2(20),
    CITY VARCHAR2(30)
);

INSERT INTO DEPT
VALUES (10,'Accounting','NEW YORK');
INSERT INTO DEPT
VALUES (20,'Research','Dallas');
INSERT INTO DEPT
VALUES (30,'Sales','Chicago');



-- 14번 문제
CREATE TABLE EMP1 (
    EMPNO   NUMBER NOT NULL PRIMARY KEY,
    NAME    VARCHAR2 (30) NOT NULL,
    JOB     VARCHAR2 (30),
    HIREDATE DATE,
    SALARY NUMBER,
    DEPTNO  NUMBER
);

INSERT INTO EMP1
VALUES (200103,'Jones','Manager','2001-04-02',2975,20);
INSERT INTO EMP1
VALUES (200104,'Blake','Manager','2001-05-01',2850,30);
INSERT INTO EMP1
VALUES (200105,'Clark','Manager','2001-06-09',2450,10);
INSERT INTO EMP1
VALUES (200106,'King','President','2001-11-17',5000,10);
INSERT INTO EMP1
VALUES (200201,'Miller','Clerk','2002-01-23',1300,10);
INSERT INTO EMP1
VALUES (200202,'Allen','Salesman','2002-02-20',1600,30);
INSERT INTO EMP1
VALUES (200203,'Ford','Analyst','2002-12-03',3000,20);
INSERT INTO EMP1
VALUES (200701,'Adams','Clerk','2007-02-23',1100,20);
INSERT INTO EMP1
VALUES (200702,'Ward','Salesman','2007-05-22',1250,30);
INSERT INTO EMP1
VALUES (200703,'James','Clerk','2007-12-03',950,30);

SELECT  name, salary, deptno, TO_CHAR(hiredate,'YYYY-MM-DD')
FROM    emp1
WHERE   TO_CHAR(hiredate,'YYYY') = '2001'
ORDER BY HIREDATE DESC;




-- 15번 문제
SELECT  empno, name, deptno, salary
FROM    emp1
WHERE   deptno IN (10,20)
ORDER BY deptno, SALARY DESC;



-- 16번 문제
SELECT  e.name, e.salary, 
        d.dname
FROM    emp1 e , dept d
WHERE   e.deptno = d.deptno;



-- 17번 문제
SELECT  deptno, ROUND(avg(salary),2)
FROM    emp1
GROUP BY deptno;


-- 18번 문제
INSERT INTO emp1 (empno, name, job, hiredate, salary, deptno)
VALUES(201701,'Bill','Clerk','2017-10-02',1000,20);


-- 19번 문제
UPDATE emp1
SET salary = 1400
WHERE job = 'Clerk';


-- 20번 문제
SELECT  salary
FROM    emp1
ORDER BY 1 DESC; -- MAX salary = 5000

DELETE FROM emp1
WHERE   salary = 5000;
commit;

