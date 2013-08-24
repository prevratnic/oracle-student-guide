
-- *********************************************************************************************************************
-- * Oracle SQL: Fundamentals level (Student Guide)
-- * Scheme: Human Resources
-- * Author: Ilya Varlamov
-- * Contact: degas.developer@gmail.com
-- *********************************************************************************************************************


-- *********************************************************************************************************************
-- * Lab 1
-- *********************************************************************************************************************

SELECT  last_name, job_id, salary As sal
FROM employees; 

------------------------------------------------------------------------------------------------------------------------

SELECT employee_id, last_name,
  SALARY * 12 as "ANNUAL SALARY"
FROM employees;

------------------------------------------------------------------------------------------------------------------------

DESC departments;

------------------------------------------------------------------------------------------------------------------------

select * from departments;

------------------------------------------------------------------------------------------------------------------------

SELECT employee_id, last_name, job_id, hire_date AS "StartDate" 
FROM employees;  

------------------------------------------------------------------------------------------------------------------------

SELECT DISTINCT job_id FROM employees;

------------------------------------------------------------------------------------------------------------------------

SELECT employee_id AS "Emp #", last_name AS "Employee", job_id AS "Job", hire_date AS "Hire Date"
FROM employees;

------------------------------------------------------------------------------------------------------------------------

SELECT last_name || ', ' || job_id AS "Employee and Title"
FROM employees;

------------------------------------------------------------------------------------------------------------------------

SELECT employee_id || ',' || first_name || ',' || last_name || ',' || email 
       || ',' || phone_number || ',' || hire_date || ',' || job_id || ',' || salary 
       || ',' || commission_pct || ',' || manager_id || ',' || department_id 
  AS "THE_OUTPUT"
FROM employees;


-- *********************************************************************************************************************
-- * Lab 2
-- *********************************************************************************************************************

SELECT last_name, salary FROM employees
  WHERE salary > 12000;

------------------------------------------------------------------------------------------------------------------------

SELECT LAST_NAME, DEPARTMENT_ID 
  FROM EMPLOYEES
WHERE EMPLOYEE_ID = 176;

------------------------------------------------------------------------------------------------------------------------

SELECT LAST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY NOT BETWEEN 5000 AND 12000;

------------------------------------------------------------------------------------------------------------------------

SELECT LAST_NAME, JOB_ID, HIRE_DATE
  FROM EMPLOYEES
WHERE HIRE_DATE BETWEEN '20-FEB-1998' AND '10-MAY-1998'
ORDER BY HIRE_DATE ASC;

------------------------------------------------------------------------------------------------------------------------

SELECT LAST_NAME, DEPARTMENT_ID
  FROM EMPLOYEES
WHERE DEPARTMENT_ID IN(20, 50) 
ORDER BY LAST_NAME ASC;

------------------------------------------------------------------------------------------------------------------------

SELECT LAST_NAME AS "Employee", SALARY AS "Mounthly Salary"
  FROM EMPLOYEES
WHERE DEPARTMENT_ID IN(20, 50) AND SALARY BETWEEN 5000 AND 12000
ORDER BY LAST_NAME ASC;

------------------------------------------------------------------------------------------------------------------------

SELECT LAST_NAME, HIRE_DATE
  FROM EMPLOYEES
WHERE HIRE_DATE LIKE '%94';

------------------------------------------------------------------------------------------------------------------------

SELECT LAST_NAME, JOB_ID
  FROM EMPLOYEES
WHERE MANAGER_ID IS NULL;

------------------------------------------------------------------------------------------------------------------------

SELECT LAST_NAME, SALARY, COMMISSION_PCT
  FROM EMPLOYEES
WHERE COMMISSION_PCT IS NOT NULL
ORDER BY SALARY, COMMISSION_PCT DESC;

------------------------------------------------------------------------------------------------------------------------

SELECT LAST_NAME, SALARY
  FROM EMPLOYEES
WHERE SALARY > &SAL; -- 15000

------------------------------------------------------------------------------------------------------------------------

SELECT EMPLOYEE_ID, LAST_NAME, SALARY, DEPARTMENT_ID
  FROM EMPLOYEES
WHERE MANAGER_ID = &NUM;   -- 205

------------------------------------------------------------------------------------------------------------------------

SELECT LAST_NAME
  FROM EMPLOYEES
WHERE LAST_NAME LIKE '__a%';

------------------------------------------------------------------------------------------------------------------------

SELECT LAST_NAME
  FROM EMPLOYEES
WHERE LAST_NAME LIKE '%a%' AND LAST_NAME LIKE '%e%';

------------------------------------------------------------------------------------------------------------------------

SELECT LAST_NAME, JOB_ID, SALARY
  FROM EMPLOYEES
WHERE ( JOB_ID = 'SA_REP' OR JOB_ID = 'ST_CLERK' ) AND SALARY NOT IN(2500, 3500, 7000);

------------------------------------------------------------------------------------------------------------------------

SELECT LAST_NAME, SALARY, COMMISSION_PCT
  FROM EMPLOYEES
WHERE COMMISSION_PCT = 0.2;


-- *********************************************************************************************************************
-- * Lab 3
-- *********************************************************************************************************************

SELECT SYSDATE AS "Date" FROM DUAL;

------------------------------------------------------------------------------------------------------------------------

SELECT EMPLOYEE_ID, LAST_NAME, SALARY, 
       ROUND((SALARY + (SALARY * 15.5) /100))  AS "New Salary" 
FROM EMPLOYEES;

------------------------------------------------------------------------------------------------------------------------

DEFINE SAL = (SALARY + (SALARY * 15.5) /100);

SELECT EMPLOYEE_ID, LAST_NAME, SALARY, 
       ROUND(&SAL)  AS "New Salary",
       (ROUND(&SAL) - SALARY) AS "Increase"
FROM EMPLOYEES;

------------------------------------------------------------------------------------------------------------------------

SELECT  INITCAP(LAST_NAME) AS "Name", LENGTH(LAST_NAME) AS "Length" 
FROM EMPLOYEES
WHERE LAST_NAME LIKE 'J%' OR LAST_NAME LIKE 'A%' OR LAST_NAME LIKE 'M%'
ORDER BY LAST_NAME ASC;

------------------------------------------------------------------------------------------------------------------------

SELECT CONCAT(UPPER(SUBSTR(LAST_NAME, 1, 1)), SUBSTR(LOWER(LAST_NAME), 2)) AS "Name",
CASE  
  WHEN LAST_NAME LIKE 'J%' THEN LENGTH(LAST_NAME)
  WHEN LAST_NAME LIKE 'A%' THEN LENGTH(LAST_NAME)
  WHEN LAST_NAME LIKE 'M%' THEN LENGTH(LAST_NAME)
  ELSE NULL
END "Lenght"
FROM EMPLOYEES
ORDER BY LAST_NAME ASC;

------------------------------------------------------------------------------------------------------------------------

SELECT INITCAP(LAST_NAME) AS "Name", LENGTH(LAST_NAME) AS "Length" 
FROM EMPLOYEES
WHERE LAST_NAME LIKE UPPER('&A%')
ORDER BY LAST_NAME ASC;

------------------------------------------------------------------------------------------------------------------------

SELECT LAST_NAME, ROUND(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) AS "MONTHS_WORKED" FROM EMPLOYEES
ORDER BY MONTHS_WORKED ASC; 

------------------------------------------------------------------------------------------------------------------------

SELECT LAST_NAME || ' earns' || TO_CHAR(SALARY, '$99,999.00') || ' monthly but wants '
  || TO_CHAR(SALARY * 3, '$99,999.00') AS "Dream Salaries"
FROM EMPLOYEES;

------------------------------------------------------------------------------------------------------------------------

SELECT LAST_NAME, LPAD(SALARY, 15 ,'$') AS "SALARY" 
  FROM EMPLOYEES;

------------------------------------------------------------------------------------------------------------------------

SELECT LAST_NAME, HIRE_DATE, 
TO_CHAR(
  NEXT_DAY(
    ADD_MONTHS(HIRE_DATE, 6), 'MON'), 'Day, "the" fmDdspth "of" Month, YYYY') AS "REVIEW" 
  FROM EMPLOYEES;

------------------------------------------------------------------------------------------------------------------------

SELECT LAST_NAME, HIRE_DATE, TO_CHAR(HIRE_DATE, 'DAY') AS "DAY" 
  FROM EMPLOYEES
ORDER BY TO_CHAR(HIRE_DATE, 'D');

------------------------------------------------------------------------------------------------------------------------

SELECT LAST_NAME, NVL(TO_CHAR(COMMISSION_PCT), 'No Commission') AS "COMM" 
  FROM EMPLOYEES;

------------------------------------------------------------------------------------------------------------------------

SELECT last_name || RPAD(' ', salary / 1000, '*') AS "EMPLOYEES AND THEIR SALARIES" 
FROM employees
ORDER BY salary DESC;

------------------------------------------------------------------------------------------------------------------------

SELECT JOB_ID, 
DECODE( JOB_ID, 'AD_PRES', 'A', 
                'ST_MAN', 'B',
                'IT_PROG', 'C',
                'SA_REP', 'D',
                'ST_CLERK', 'E', 
                0
) AS "G"
FROM EMPLOYEES;

------------------------------------------------------------------------------------------------------------------------

SELECT JOB_ID, 
(CASE JOB_ID WHEN 'AD_PRES'  THEN 'A' 
             WHEN 'ST_MAN'   THEN 'B'
             WHEN 'IT_PROG'  THEN 'C'
             WHEN 'SA_REP'   THEN 'D'
             WHEN 'ST_CLERK' THEN 'E' 
             ELSE '0' END) AS "G"
FROM EMPLOYEES;


-- *********************************************************************************************************************
-- * Lab 4
-- *********************************************************************************************************************

SELECT ROUND(MAX(SALARY)) AS "Maximum", 
       ROUND(MIN(SALARY))  AS "Minimum", 
       ROUND(AVG(SALARY)) AS "Average", 
       ROUND(SUM(SALARY)) AS "Sum" 
FROM EMPLOYEES;

------------------------------------------------------------------------------------------------------------------------

SELECT JOB_ID, 
       ROUND(MAX(SALARY)) AS "Maximum", 
       ROUND(MIN(SALARY)) AS "Minimum", 
       ROUND(AVG(SALARY)) AS "Average", 
       ROUND(SUM(SALARY)) AS "Sum" 
FROM EMPLOYEES
GROUP BY JOB_ID;

------------------------------------------------------------------------------------------------------------------------

SELECT JOB_ID, COUNT(*)       
FROM EMPLOYEES 
GROUP BY JOB_ID;

------------------------------------------------------------------------------------------------------------------------

SELECT COUNT(DISTINCT MANAGER_ID) AS "Number of Managers" 
FROM EMPLOYEES;

------------------------------------------------------------------------------------------------------------------------

SELECT (MAX(SALARY) - MIN(SALARY)) AS "DIFFERENCE" 
FROM EMPLOYEES; 

------------------------------------------------------------------------------------------------------------------------

SELECT DEPARTMENTS.DEPARTMENT_NAME AS "Name", 
       DEPARTMENTS.LOCATION_ID AS "Location", 
       COUNT(EMPLOYEES.EMPLOYEE_ID) AS "Number of People", 
       ROUND(AVG(EMPLOYEES.SALARY)) AS "Salary"
FROM DEPARTMENTS, EMPLOYEES
WHERE
 DEPARTMENTS.DEPARTMENT_ID = EMPLOYEES.DEPARTMENT_ID 
GROUP BY DEPARTMENTS.DEPARTMENT_NAME, DEPARTMENTS.LOCATION_ID

------------------------------------------------------------------------------------------------------------------------

SELECT COUNT(EMPLOYEE_ID) AS "TOTAL",
  COUNT(DECODE(TO_CHAR(HIRE_DATE, 'YYYY'), '1995', HIRE_DATE ) ) AS "1995",
  COUNT(DECODE(TO_CHAR(HIRE_DATE, 'YYYY'), '1996', HIRE_DATE ) ) AS "1996",
  COUNT(DECODE(TO_CHAR(HIRE_DATE, 'YYYY'), '1997', HIRE_DATE ) ) AS "1997",
  COUNT(DECODE(TO_CHAR(HIRE_DATE, 'YYYY'), '1998', HIRE_DATE ) ) AS "1998"
FROM EMPLOYEES;

------------------------------------------------------------------------------------------------------------------------

SELECT JOB_ID AS "Job",
SUM(DECODE(DEPARTMENT_ID, '20', SALARY )) AS "Dept20",
SUM(DECODE(DEPARTMENT_ID, '50', SALARY )) AS "Dept50",
SUM(DECODE(DEPARTMENT_ID, '80', SALARY )) AS "Dept80",
SUM(DECODE(DEPARTMENT_ID, '90', SALARY )) AS "Dept90",
SUM(SALARY) "Total"
FROM EMPLOYEES
GROUP BY JOB_ID;


-- *********************************************************************************************************************
-- * Lab 5
-- *********************************************************************************************************************

SELECT emp.last_name, emp.department_id, dep.department_name 
  FROM employees emp INNER JOIN departments dep
ON( emp.department_id = dep.department_id )

------------------------------------------------------------------------------------------------------------------------

SELECT DISTINCT emp.job_id, dep.location_id
FROM employees emp INNER JOIN departments dep
ON( emp.department_id = dep.department_id )
WHERE dep.department_id = 80;

------------------------------------------------------------------------------------------------------------------------

SELECT DISTINCT emp.last_name, dep.department_name, dep.location_id, loc.city
FROM employees emp INNER JOIN departments dep
ON( emp.department_id = dep.department_id )
INNER JOIN locations loc
ON( loc.location_id = dep.location_id )
WHERE emp.commission_pct IS NOT NULL;

------------------------------------------------------------------------------------------------------------------------

SELECT emp.last_name, dep.department_name
FROM employees emp INNER JOIN departments dep
ON( dep.department_id = emp.department_id )
WHERE emp.last_name LIKE '%a%';
 
------------------------------------------------------------------------------------------------------------------------

SELECT emp.last_name, emp.job_id, dep.department_id, dep.department_name
FROM employees emp INNER JOIN departments dep 
  ON( dep.department_id = emp.department_id )
INNER JOIN locations loc
  ON( loc.location_id = dep.location_id )
WHERE loc.city = 'Toronto';

------------------------------------------------------------------------------------------------------------------------

SELECT emp1.last_name AS "Employee", emp1.employee_id AS "EMP#", emp2.last_name AS "Manager", emp2.manager_id AS "Mgr#"
FROM employees emp1 INNER JOIN employees emp2 
  ON( emp1.manager_id = emp2.employee_id )

------------------------------------------------------------------------------------------------------------------------

SELECT emp1.last_name AS "Employee", emp1.employee_id AS "EMP#", emp2.last_name AS "Manager", emp2.manager_id AS "Mgr#"
FROM employees emp1 LEFT OUTER JOIN employees emp2 
  ON( emp1.manager_id = emp2.employee_id )
ORDER BY emp1.employee_id ASC;

------------------------------------------------------------------------------------------------------------------------

SELECT emp1.department_id AS "DEPARTMENT", emp1.last_name AS "EMPLOYEE", emp2.last_name AS "COLLEAGUE"
FROM employees emp1 INNER JOIN employees emp2
ON( emp1.department_id = emp2.department_id ) 
WHERE emp1.employee_id <> emp2.employee_id

------------------------------------------------------------------------------------------------------------------------

SELECT emp.last_name, emp.job_id, dep.department_name, emp.salary, job.grade_level 
FROM employees emp INNER JOIN departments dep
ON( emp.department_id = dep.department_id )
INNER JOIN job_grades job
ON( emp.salary BETWEEN job.lowest_sal AND job.highest_sal );

------------------------------------------------------------------------------------------------------------------------

SELECT emp1.last_name, emp1.hire_date  
FROM employees emp1 INNER JOIN employees emp2
ON( emp1.hire_date > emp2.hire_date )
WHERE emp2.last_name = 'Davies';

------------------------------------------------------------------------------------------------------------------------

SELECT emp1.last_name AS "Employee", emp1.hire_date AS "Emp Hired",
  emp2.last_name AS "Manager", emp2.hire_date AS "Mgr hired"
FROM employees emp1 INNER JOIN employees emp2
ON( emp1.manager_id = emp2.employee_id )
WHERE emp1.hire_date < emp2.hire_date

------------------------------------------------------------------------------------------------------------------------

SELECT dep.department_id, dep.department_name, dep.location_id, COUNT(emp.employee_id)
FROM employees emp RIGHT OUTER JOIN departments dep
ON( emp.department_id = dep.department_id )
GROUP BY dep.department_id, dep.department_name, dep.location_id

------------------------------------------------------------------------------------------------------------------------

SELECT emp.job_id, COUNT(emp.employee_id) AS "FREQUENCY"
FROM employees emp INNER JOIN departments dep
ON( emp.department_id = dep.department_id )
WHERE dep.department_name = 'Administration' OR dep.department_name = 'Executive' 
GROUP BY emp.job_id
ORDER BY COUNT(emp.employee_id) DESC;

------------------------------------------------------------------------------------------------------------------------

SELECT emp1.last_name, emp2.last_name AS Manager, emp2.salary, job.grade_level AS "GRA"
FROM employees emp1 INNER JOIN employees emp2 
  ON( emp1.manager_id = emp2.employee_id )
INNER JOIN job_grades job
  ON( emp2.salary BETWEEN job.lowest_sal AND job.highest_sal)
WHERE emp2.salary > 15000


-- *********************************************************************************************************************
-- * Lab 6
-- *********************************************************************************************************************

SELECT last_name, hire_date FROM employees
WHERE department_id = ( 
  SELECT department_id FROM employees
  WHERE last_name = 'Zlotkey'
) AND last_name NOT IN('Zlotkey');

------------------------------------------------------------------------------------------------------------------------

SELECT employee_id, last_name, salary 
FROM employees
WHERE salary > (
  SELECT AVG(salary) FROM employees
)
ORDER BY salary ASC;

------------------------------------------------------------------------------------------------------------------------

SELECT employee_id, last_name
FROM employees
WHERE department_id IN (
  SELECT department_id FROM employees
    WHERE last_name LIKE '%u%'
)

------------------------------------------------------------------------------------------------------------------------

SELECT last_name, department_id, job_id
FROM employees
WHERE department_id IN (
  SELECT department_id FROM departments
    WHERE location_id = 1700
)

------------------------------------------------------------------------------------------------------------------------

SELECT last_name, salary
FROM employees
WHERE employee_id IN (
  SELECT emp1.employee_id
    FROM employees emp1 INNER JOIN employees emp2
    ON( emp1.manager_id = emp2.employee_id )
    WHERE emp2.last_name = 'King' 
)

------------------------------------------------------------------------------------------------------------------------

SELECT dep.department_id, emp.last_name, emp.job_id
FROM employees emp INNER JOIN departments dep
ON( emp.department_id = dep.department_id )
WHERE emp.employee_id IN (
  SELECT em.employee_id FROM departments de INNER JOIN employees em
    ON( em.department_id = de.department_id )
    WHERE department_name =  'Executive'
)

------------------------------------------------------------------------------------------------------------------------

SELECT employee_id, last_name, salary
FROM employees
WHERE department_id IN (
  SELECT e.department_id FROM employees e
    WHERE e.last_name LIKE '%u%'
  ) 
  AND salary > (
      SELECT AVG(salary) FROM employees
  ) 

------------------------------------------------------------------------------------------------------------------------

SELECT department_id, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID 
FROM departments 
WHERE DEPARTMENT_ID NOT IN (
  SELECT department_id FROM employees
  WHERE job_id = 'SA_REP’'
)


-- *********************************************************************************************************************
-- * Lab 7
-- *********************************************************************************************************************

SELECT department_id FROM departments
  MINUS
SELECT department_id FROM employees
WHERE job_id = 'ST_CLERK'

------------------------------------------------------------------------------------------------------------------------

SELECT
  COUNTRY_ID AS CO,
  COUNTRY_NAME
FROM
  COUNTRIES
WHERE
  COUNTRY_ID IN (SELECT
                COUNTRY_ID
              FROM
                COUNTRIES
              MINUS
              SELECT DISTINCT
                  LOCATIONS.COUNTRY_ID
              FROM
                  DEPARTMENTS JOIN LOCATIONS
                  ON DEPARTMENTS.LOCATION_ID=LOCATIONS.LOCATION_ID)

------------------------------------------------------------------------------------------------------------------------

select job_id, department_id from ( 
SELECT job_id, department_id, 1 dummy FROM employees 
  WHERE department_id = 10
UNION  
SELECT job_id, department_id, 2 dummy FROM employees 
  WHERE department_id = 50
UNION
SELECT job_id, department_id, 3 dummy FROM employees 
  WHERE department_id = 20
ORDER BY dummy
);

------------------------------------------------------------------------------------------------------------------------

SELECT employee_id, job_id FROM employees
  INTERSECT
SELECT employee_id, job_id FROM job_history

------------------------------------------------------------------------------------------------------------------------

SELECT employee_id, department_id, TO_CHAR(null)  AS department_name FROM employees
  UNION
SELECT TO_NUMBER(null), department_id, department_name FROM departments;


-- *********************************************************************************************************************
-- * Lab 8
-- *********************************************************************************************************************

CREATE TABLE MY_EMPLOYEE(
 ID         NUMBER(4) CONSTRAINT MY_EMPLOYEE_ID_NN   NOT NULL,
 LAST_NAME  VARCHAR2(25),
 FIRST_NAME VARCHAR2(25),
 USERID     VARCHAR2(8),
 SALARY     NUMBER(9,2)
);

------------------------------------------------------------------------------------------------------------------------

INSERT INTO MY_EMPLOYEE (id, last_name, first_name, userid, salary) 
VALUES(2, 'Dancs', 'Betty', 'bdancs', 860);

------------------------------------------------------------------------------------------------------------------------

SET ECHO OFF
SET VERIFY OFF
INSERT INTO my_employee 
VALUES( &id, '&&l_name', '&&f_name', lower(substr('&f_name', 1, 1) || substr('&l_name', 1, 7)), &sal );
UNDEFINE f_name;
UNDEFINE l_name;

------------------------------------------------------------------------------------------------------------------------

UPDATE my_employee SET last_name = 'Drexler' 
WHERE id = 3;

------------------------------------------------------------------------------------------------------------------------

UPDATE my_employee SET salary = 1000 
WHERE salary < 900

------------------------------------------------------------------------------------------------------------------------

DELETE FROM my_employee
WHERE first_name = 'Betty' AND last_name = 'Dancs'

------------------------------------------------------------------------------------------------------------------------

INSERT INTO my_employee VALUES ( 5, 'Ropeburn', 'Andrey', 'Aropebur', 1550 );

------------------------------------------------------------------------------------------------------------------------

DELETE FROM my_employee;

------------------------------------------------------------------------------------------------------------------------

SELECT dep1.department_id, dep1.location_id, loc.city
FROM departments DEP1 
INNER JOIN departments DEP2
ON( dep1.location_id = dep2.location_id AND dep1.department_id <> dep2.department_id )
INNER JOIN LOCATIONS LOC
ON(loc.location_id = dep2.location_id ) INNER JOIN EMPLOYEES EMP
ON(emp.department_id = dep1.department_id) 
HAVING SUM(emp.salary) > (
  SELECT AVG(SUM(emp.salary))
  FROM departments DEP1 
  INNER JOIN departments DEP2
  ON( dep1.location_id = dep2.location_id AND dep1.department_id <> dep2.department_id )
  INNER JOIN LOCATIONS LOC
  ON(loc.location_id = dep2.location_id ) INNER JOIN EMPLOYEES EMP
  ON(emp.department_id = dep1.department_id) 
  GROUP BY dep1.department_id
)
GROUP BY dep1.department_id, dep1.location_id, loc.city


-- *********************************************************************************************************************
-- * Lab 9
-- *********************************************************************************************************************

CREATE TABLE DEPT (
  id NUMBER(7),
  name VARCHAR2(25)
);

DESC dept;

------------------------------------------------------------------------------------------------------------------------

CREATE TABLE emp (
  id NUMBER(7),
  last_name VARCHAR2(25),
  first_name VARCHAR2(25),
  dept_id NUMBER(7)
);
DESC EMP;

------------------------------------------------------------------------------------------------------------------------

CREATE TABLE emloyees2 AS(
  SELECT EMPLOYEE_ID AS "ID", FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID AS "DEPT_ID" 
  FROM employees
);

------------------------------------------------------------------------------------------------------------------------

DROP TABLE emp;


-- *********************************************************************************************************************
-- * Lab 10
-- *********************************************************************************************************************

CREATE VIEW employees_vu AS
  SELECT employee_id, last_name AS employee, department_id FROM employees;

------------------------------------------------------------------------------------------------------------------------

CREATE VIEW dept50 (empno, employee, deptno) AS
  SELECT employee_id, last_name, department_id FROM employees
  WHERE department_id = 50
  WITH READ ONLY;

------------------------------------------------------------------------------------------------------------------------

UPDATE dept50 SET deptno = 80
WHERE employee = 'Matos'

------------------------------------------------------------------------------------------------------------------------

CREATE VIEW salary_vu ("Employee", "Department", "Salary", "Grade" ) AS 
  SELECT emp.last_name, dep.department_name, emp.salary, job.grade_level
    FROM employees emp INNER JOIN departments dep
    ON( emp.department_id = dep.department_id  )
  INNER JOIN job_grades JOB
ON( emp.salary BETWEEN job.lowest_sal AND job.highest_sal );

------------------------------------------------------------------------------------------------------------------------

CREATE SEQUENCE  dept_id_seq 
MINVALUE 1 
MAXVALUE 1000 
INCREMENT BY 10 
START WITH 200 
CACHE 20
NOORDER
NOCYCLE ;

------------------------------------------------------------------------------------------------------------------------

CREATE INDEX dept_index_name ON dept ( name );

------------------------------------------------------------------------------------------------------------------------

CREATE SYNONYM emp FOR employees;


-- *********************************************************************************************************************
-- * Lab 11
-- *********************************************************************************************************************

SELECT column_name, data_type, data_length, data_precision precision, data_scale scale, nullable
FROM user_tab_columns
WHERE table_name = UPPER('&table');

------------------------------------------------------------------------------------------------------------------------

SELECT user_col.column_name, user_con.constraint_name, user_con.constraint_type, 
user_con.search_condition, user_con.status
FROM user_constraints user_con INNER JOIN user_cons_columns user_col
ON(user_con.table_name = user_col.table_name) 
WHERE user_col.table_name = UPPER('&table');

------------------------------------------------------------------------------------------------------------------------

COMMENT ON TABLE DEPARTMENTS IS 'Hello World !!!';

SELECT * FROM user_tab_comments
WHERE table_name = 'DEPARTMENTS';


-- *********************************************************************************************************************
-- * Lab 12
-- *********************************************************************************************************************

ALTER USER user IDENTIFIED BY password.

------------------------------------------------------------------------------------------------------------------------

REVOKE SELECT 
ON emp
FROM user2;


-- *********************************************************************************************************************
-- * Lab 13
-- *********************************************************************************************************************

ALTER TABLE emp2 
MODIFY (last_name  VARCHAR(50));

------------------------------------------------------------------------------------------------------------------------

CREATE TABLE employees2 (
employee_ID NUMBER(6) NOT NULL,
first_name VARCHAR2(20),
last_name VARCHAR2(25),
salary NUMBER(8,2),
department_id NUMBER(4)
);

ALTER TABLE employees2 RENAME COLUMN employee_id TO id;
ALTER TABLE employees2 RENAME COLUMN department_id TO dept_id;

------------------------------------------------------------------------------------------------------------------------

SELECT * FROM user_recyclebin;
FLASHBACK TABLE emp2 TO BEFORE DROP;

------------------------------------------------------------------------------------------------------------------------

ALTER TABLE employees2 DROP (first_name);
DESC employees2;

------------------------------------------------------------------------------------------------------------------------

ALTER TABLE employees2
SET UNUSED COLUMN dept_id;

------------------------------------------------------------------------------------------------------------------------

ALTER TABLE employees2 
DROP UNUSED COLUMNS;

------------------------------------------------------------------------------------------------------------------------

ALTER TABLE emp2 
ADD CONSTRAINT my_emp_id_pk
PRIMARY KEY ( id );

------------------------------------------------------------------------------------------------------------------------

ALTER TABLE dept2 
ADD CONSTRAINT my_dept_id_pk
PRIMARY KEY ( id );

------------------------------------------------------------------------------------------------------------------------

ALTER TABLE emp2 
ADD CONSTRAINT my_emp_dept_id_fk
FOREIGN KEY (dept_id) REFERENCES dept2(id);

------------------------------------------------------------------------------------------------------------------------

ALTER TABLE emp2 
ADD ( commission NUMBER(2, 2) ) 
ADD CONSTRAINT commission_not_null CHECK(commission > 0);

------------------------------------------------------------------------------------------------------------------------

DROP TABLE emp2 PURGE;

------------------------------------------------------------------------------------------------------------------------

CREATE TABLE DEPT_NAMED_INDEX (
  DEPTNO NUMBER(4) PRIMARY KEY 
  USING INDEX (
  CREATE INDEX DEPT_PK_IDX ON DEPT_NAMED_INDEX (DEPTNO)),
  DNAME VARCHAR2(30)
);

SELECT * FROM user_indexes;


-- *********************************************************************************************************************
-- * Lab 14
-- *********************************************************************************************************************

INSERT ALL
  WHEN SAL > 20000 THEN
    INTO SPECIAL_SAL VALUES (EMP, SAL)
  ELSE
    INTO SAL_HISTORY VALUES (EMP, H_DATE, SAL)
    INTO MGR_HISTORY VALUES (EMP, MANAGER, SAL)   
SELECT HIRE_DATE AS H_DATE, EMPLOYEE_ID AS EMP, SALARY AS SAL, MANAGER_ID AS MANAGER FROM EMPLOYEES
WHERE EMPLOYEE_ID < 125;

------------------------------------------------------------------------------------------------------------------------

INSERT ALL
  INTO SALES_INFO VALUES(EMP, WEEK, MON )
  INTO SALES_INFO VALUES(EMP, WEEK, TUE )
  INTO SALES_INFO VALUES(EMP, WEEK, THUR)
  INTO SALES_INFO VALUES(EMP, WEEK, WED )
  INTO SALES_INFO VALUES(EMP, WEEK, FRI )
SELECT EMPLOYEE_ID AS EMP, WEEK_ID AS WEEK, SALES_MON AS MON, SALES_TUE AS TUE, SALES_THUR AS THUR,
       SALES_WED AS WED, SALES_FRI AS FRI
FROM SALES_SOURCE_DATA;

------------------------------------------------------------------------------------------------------------------------

CREATE TABLE EMP_DATA
  (
    FIRST_NAME VARCHAR2(25),
    LAST_NAME  VARCHAR2(25),
    EMAIL      VARCHAR2(25)
  )ORGANIZATION EXTERNAL (
    TYPE ORACLE_LOADER
    DEFAULT DIRECTORY EMP_DIR
    ACCESS PARAMETERS (
      RECORDS DELIMITED BY NEWLINE
      NOBADFILE
      NOLOGFILE
      FIELDS TERMINATED BY ',' (
      FIRST_NAME POSITION (1:20) CHAR,
      LAST_NAME POSITION (22:41) CHAR,
      EMAIL POSITION (40:90) CHAR
      )
    ) LOCATION ('emp.dat')
  );

------------------------------------------------------------------------------------------------------------------------

MERGE INTO EMP_HIST EMP_H USING EMP_DATA EMP_D
  ON( EMP_H.FIRST_NAME = EMP_D.FIRST_NAME 
  AND EMP_H.LAST_NAME = EMP_D.LAST_NAME)
WHEN MATCHED THEN
  UPDATE SET EMP_H.EMAIL = EMP_D.EMAIL
WHEN NOT MATCHED THEN
  INSERT (
    EMP_H.FIRST_NAME,
    EMP_H.LAST_NAME,
    EMP_H.EMAIL
  )VALUES (
    EMP_D.FIRST_NAME,
    EMP_D.LAST_NAME,
    EMP_D.EMAIL
  ); 


-- *********************************************************************************************************************
-- * Lab 15
-- *********************************************************************************************************************

SELECT MANAGER_ID, JOB_ID, SUM(SALARY)
FROM EMPLOYEES 
WHERE MANAGER_ID < 120
GROUP BY ROLLUP( MANAGER_ID, JOB_ID);

------------------------------------------------------------------------------------------------------------------------

SELECT MANAGER_ID, JOB_ID, SUM(SALARY), GROUPING(MANAGER_ID), GROUPING(JOB_ID)
FROM EMPLOYEES 
WHERE MANAGER_ID < 120
GROUP BY ROLLUP (MANAGER_ID, JOB_ID)

------------------------------------------------------------------------------------------------------------------------

SELECT MANAGER_ID, JOB_ID, SUM(SALARY)
FROM EMPLOYEES 
GROUP BY CUBE(MANAGER_ID, JOB_ID);

------------------------------------------------------------------------------------------------------------------------

SELECT MANAGER_ID, JOB_ID, SUM(SALARY), GROUPING(MANAGER_ID), GROUPING(JOB_ID)
FROM EMPLOYEES 
GROUP BY CUBE (MANAGER_ID, JOB_ID);

------------------------------------------------------------------------------------------------------------------------

SELECT department_id, manager_id, job_id, SUM(salary)
FROM employees 
GROUP BY GROUPING SETS (department_id, manager_id, job_id), (department_id, job_id), (manager_id, job_id);


-- *********************************************************************************************************************
-- * Lab 16
-- *********************************************************************************************************************

ALTER SESSION 
SET NLS_DATE_FORMAT = 'DD-MON-YYYY HH24:MI:SS';

------------------------------------------------------------------------------------------------------------------------

SELECT TZ_OFFSET('US/Pacific-New'), TZ_OFFSET('Singapore'), TZ_OFFSET('Egypt') FROM dual;

------------------------------------------------------------------------------------------------------------------------

ALTER SESSION 
SET TIME_ZONE = '-08:00';

SELECT CURRENT_DATE, CURRENT_TIMESTAMP, LOCALTIMESTAMP FROM dual;

------------------------------------------------------------------------------------------------------------------------

ALTER SESSION 
SET TIME_ZONE = '+08:00';

SELECT CURRENT_DATE, CURRENT_TIMESTAMP, LOCALTIMESTAMP FROM dual;

------------------------------------------------------------------------------------------------------------------------

SELECT DBTIMEZONE, SESSIONTIMEZONE  FROM dual;

------------------------------------------------------------------------------------------------------------------------

SELECT EXTRACT (YEAR FROM HIRE_DATE) FROM EMPLOYEES
WHERE DEPARTMENT_ID = 80;

------------------------------------------------------------------------------------------------------------------------

ALTER SESSION 
SET NLS_DATE_FORMAT = 'DD-MON-YYYY';

------------------------------------------------------------------------------------------------------------------------

SELECT LAST_NAME, EXTRACT(MONTH FROM HIRE_DATE) AS "MONTH", HIRE_DATE FROM EMPLOYEES
WHERE EXTRACT(MONTH FROM HIRE_DATE) = 1;


-- *********************************************************************************************************************
-- * Lab 17
-- *********************************************************************************************************************

SELECT LAST_NAME, DEPARTMENT_ID, SALARY 
FROM EMPLOYEES
WHERE (SALARY, DEPARTMENT_ID) IN (
  SELECT SALARY, DEPARTMENT_ID 
  FROM EMPLOYEES
  WHERE COMMISSION_PCT IS NOT NULL
);

------------------------------------------------------------------------------------------------------------------------

SELECT EMP.LAST_NAME, DEP.DEPARTMENT_NAME, EMP.SALARY  
FROM EMPLOYEES EMP INNER JOIN DEPARTMENTS DEP
ON( EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID )
WHERE (EMP.SALARY, NVL(EMP.COMMISSION_PCT, 0)) IN(
  SELECT E.SALARY, NVL(E.COMMISSION_PCT, 0)
  FROM EMPLOYEES E INNER JOIN DEPARTMENTS D
  ON(E.DEPARTMENT_ID = D.DEPARTMENT_ID)
  WHERE D.LOCATION_ID = 1700
);

------------------------------------------------------------------------------------------------------------------------

SELECT LAST_NAME, HIRE_DATE, SALARY 
FROM EMPLOYEES
WHERE (SALARY, NVL(COMMISSION_PCT, 0)) IN(
  SELECT SALARY, NVL(COMMISSION_PCT, 0) 
  FROM EMPLOYEES
  WHERE LAST_NAME = 'Kochhar'
) AND LAST_NAME <> 'Kochhar';

------------------------------------------------------------------------------------------------------------------------

SELECT LAST_NAME, JOB_ID, SALARY 
FROM EMPLOYEES
WHERE SALARY > ALL (
  SELECT SALARY 
  FROM EMPLOYEES
  WHERE JOB_ID = 'SA_MAN' 
)
ORDER BY SALARY DESC;

------------------------------------------------------------------------------------------------------------------------

SELECT EMPLOYEE_ID, LAST_NAME, DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN(
  SELECT DEPARTMENT_ID
  FROM DEPARTMENTS
  WHERE LOCATION_ID IN( 
    SELECT LOCATION_ID 
    FROM LOCATIONS 
    WHERE CITY LIKE 'T%'
  )
);

------------------------------------------------------------------------------------------------------------------------

SELECT EMP1.LAST_NAME AS ENAME, EMP1.SALARY AS SALARY, EMP1.DEPARTMENT_ID AS DEPTNO, ROUND(AVG(EMP2.SALARY), 4)
  AS DEPT_AVG
FROM EMPLOYEES EMP1 INNER JOIN EMPLOYEES EMP2 
ON( EMP1.DEPARTMENT_ID = EMP2.DEPARTMENT_ID)  AND
EMP1.SALARY > (
  SELECT AVG(SALARY)
  FROM EMPLOYEES
  WHERE DEPARTMENT_ID = EMP1.DEPARTMENT_ID
  )
GROUP BY EMP1.LAST_NAME, EMP1.SALARY, EMP1.DEPARTMENT_ID  
ORDER BY AVG(EMP2.SALARY);

------------------------------------------------------------------------------------------------------------------------

SELECT EMP.LAST_NAME
FROM EMPLOYEES EMP
WHERE NOT EXISTS (
  SELECT * 
  FROM EMPLOYEES E
  WHERE E.MANAGER_ID = EMP.EMPLOYEE_ID
)

------------------------------------------------------------------------------------------------------------------------

SELECT EMP.LAST_NAME
FROM EMPLOYEES EMP
WHERE EMP.EMPLOYEE_ID NOT IN(
  SELECT E.MANAGER_ID FROM EMPLOYEES E
)

------------------------------------------------------------------------------------------------------------------------

SELECT EMP1.LAST_NAME 
FROM EMPLOYEES EMP1
WHERE SALARY < (
  SELECT AVG(SALARY) 
  FROM EMPLOYEES EMP2
  WHERE EMP2.DEPARTMENT_ID = EMP1.DEPARTMENT_ID
)


-- *********************************************************************************************************************
-- * Lab 18
-- *********************************************************************************************************************

SELECT * FROM employees
WHERE REGEXP_LIKE (first_name, '^Na|Ne');

------------------------------------------------------------------------------------------------------------------------

SELECT REGEXP_REPLACE( STREET_ADDRESS, ' ', '')  AS “ALL”
FROM LOCATIONS;

------------------------------------------------------------------------------------------------------------------------

SELECT REGEXP_REPLACE(STREET_ADDRESS, 'St$', 'Street') AS ALL
FROM LOCATIONS
WHERE REGEXP_LIKE( STREET_ADDRESS, 'St$' );


-- *********************************************************************************************************************
-- * Lab 19
-- *********************************************************************************************************************

SELECT REGEXP_replace('C:\Talk to Me NV\Fonts \ emp.dat', '(^\D+\\\s+)|(\d\D)$') 
FROM dual;

------------------------------------------------------------------------------------------------------------------------

SELECT REGEXP_REPLACE('http://127.0.0.1:8080', ':[0-9]+$', '') AS "Adress" 
FROM DUAL;

------------------------------------------------------------------------------------------------------------------------

SELECT REGEXP_REPLACE(
  REGEXP_REPLACE(
    REGEXP_REPLACE('hello hello world ffgalff jfb y  ilya ilya', '([^ ]{2,})\s\1', '###\1### ###\1###'), 
                   '([^\#]{3})[^ ]([^\#]{3})', ''), 
                   '\#', '')
FROM Dual;

------------------------------------------------------------------------------------------------------------------------

SELECT REGEXP_SUBSTR('555-55-55', '^\([0-9]{3}\).([0-9]{3}-[0-9]{2}-[0-9]{2})|^([0-9]{3}-[0-9]{2}-[0-9]{2})') 
FROM dual;

------------------------------------------------------------------------------------------------------------------------

SELECT 
    REGEXP_REPLACE('akfklaj "ajsgkjsgksh" aagjajgoiagj "kopskgopsgk"', '[a-z]+[^\"a-z\n]', '')
FROM Dual;

------------------------------------------------------------------------------------------------------------------------

SELECT 
    REGEXP_SUBSTR('ilya@mail.ru', '^[a-z]+@[a-z]+.[a-z]{2,10}$')
FROM Dual;

------------------------------------------------------------------------------------------------------------------------

SELECT    '&&regex',
          CASE
          WHEN  LENGTH(REGEXP_REPLACE('&regex', '\(', '')) !=
                LENGTH(REGEXP_REPLACE('&regex', '\)', ''))
                THEN 'Different count of close and open brackets'
          WHEN  0 > ANY(SELECT
                        LENGTH(REGEXP_REPLACE('&regex', '\(', '', level))-
                        LENGTH(REGEXP_REPLACE('&regex', '\)', '', level))
                        FROM dual
                        CONNECT BY LEVEL <= LENGTH('&regex'))
                THEN 'Bracket misplacing'
          ELSE '&regex'
          END 
FROM dual;
UNDEFINE regex;

------------------------------------------------------------------------------------------------------------------------

SELECT REGEXP_REPLACE('2*9-6*5 (34+555)-9*4)', '[0-9]+(\+)', '')  
FROM dual;

------------------------------------------------------------------------------------------------------------------------

SELECT 
REGEXP_REPLACE('ilya@mail.ru prevratnic@gmail.com', '@[a-z]+.[a-z]+', '')
FROM dual;

------------------------------------------------------------------------------------------------------------------------

--REGEXP_LIKE(‘123.56 4654.3 45642 5465 44 5 474445’, ‘[0-9]+(\.[0-9]+)’)

select REGEXP_SUBSTR(STR, '[0-9]+\\s[0-9]+[.]{1}[0-9]+|[0-9]+[.]{1}[0-9]+|[0-9]+.[0-9]+[.]{1}[0-9]+', 1, level) STR
from ( SELECT '10 5646.45, 45 sd eds,.sd 9 882,566.11 ' str FROM dual) table_1
connect by
regexp_substr(str,'([0-9][.]{1}[0-9])+',1, level)  is not null;