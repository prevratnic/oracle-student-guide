
-- *********************************************************************************************************************
-- * Oracle PL/SQL: Fundamentals level (Student Guide)
-- * Scheme: Human Resources
-- * Author: Ilya Varlamov
-- * Contact: degas.developer@gmail.com
-- *********************************************************************************************************************


-- *********************************************************************************************************************
-- * Lab 1
-- *********************************************************************************************************************

BEGIN
  DBMS_OUTPUT.PUT_LINE('Hello World');
END;

-- *********************************************************************************************************************
-- * Lab 2
-- *********************************************************************************************************************

SET SERVEROUTPUT ON
DECLARE
	fname VARCHAR(20);
	lname VARCHAR(15) DEFAULT 'fernandez';
BEGIN
	DBMS_OUTPUT.PUT_LINE(fname || ' ' || lname);
END;

------------------------------------------------------------------------------------------------------------------------

set serveroutput on

declare
	today DATE := sysdate;
	tomorrow today%TYPE;
BEGIN
	tomorrow:= today +1;
  	DBMS_OUTPUT.PUT_LINE('Hello World' || ' ' || today || ' and ' || tomorrow);
END;
/

------------------------------------------------------------------------------------------------------------------------

set serveroutput on
	variable basic_percent NUMBER
	variable pf_percent NUMBER  
BEGIN
  :basic_percent:=45;
  :pf_percent:=12;
END;
/

PRINT basic_percent
PRINT pf_percent


-- *********************************************************************************************************************
-- * Lab 3
-- *********************************************************************************************************************

set serveroutput on
DECLARE
  weight  NUMBER(3)     := 600;
  MESSAGE VARCHAR2(255) := 'Product 10012';
BEGIN
  DECLARE
    weight   NUMBER(3)     := 1;
    MESSAGE  VARCHAR2(255) := 'Product 11001';
    new_locn VARCHAR2(50)  := 'Europe';
  BEGIN
    weight   := weight + 1;   
    dbms_output.put_line( weight ); -- 2
    
    new_locn := 'Western ' || new_locn;
    /*(1)*/
  END;
  weight   := weight + 1;
  MESSAGE  := MESSAGE || ' is in stock';
 -- new_locn := 'Western ' || new_locn;
  /*(2)*/
  dbms_output.put_line( weight );
  dbms_output.put_line( MESSAGE );
END;
/

------------------------------------------------------------------------------------------------------------------------

set serveroutput on
DECLARE
  customer VARCHAR2(50) := 'Womansport';
  credit_rating VARCHAR2(50) := 'EXCELLENT';
BEGIN
  DECLARE
    customer NUMBER(7)    := 201;
    name     VARCHAR2(25) := 'Unisports';
  BEGIN
    credit_rating :='GOOD';
    dbms_output.put_line( customer );
    dbms_output.put_line( credit_rating );
  END;
    dbms_output.put_line( customer );
    dbms_output.put_line( credit_rating );    
END;
/

------------------------------------------------------------------------------------------------------------------------

set serveroutput on
--variable basic_percent NUMBER
--variable pf_percent NUMBER
DECLARE
  v_fname VARCHAR2(15);
  v_emp_sal NUMBER(10);
  v_nalog NUMBER(10);
  v_nalog_nichet NUMBER:=12;
  v_base_salary NUMBER:=45;
  
BEGIN
  --:basic_percent:=45;
  --:pf_percent:=12;
  SELECT first_name, salary INTO v_fname, v_emp_sal FROM employees
  WHERE employee_id = 110;
  
  v_nalog:= ((( v_emp_sal * v_base_salary / 100) * v_nalog_nichet ) / 100 );  
  
  dbms_output.put_line('Hello ' || v_fname);
  dbms_output.put_line('Зарплата до налогово вычета ' || v_emp_sal);
  dbms_output.put_line('Зарплата после налогово вычета ' || ( v_emp_sal - v_nalog ));  
  dbms_output.put_line('Налоговый вычет = ' ||  (( v_emp_sal * v_base_salary / 100) * v_nalog_nichet ) / 100 );  

END;
/

-- *********************************************************************************************************************
-- * Lab 4
-- *********************************************************************************************************************


SET serveroutput ON
DECLARE
  v_max_deptno NUMBER;
BEGIN
  SELECT MAX( department_id ) INTO v_max_deptno FROM employees;
  dbms_output.put_line( v_max_deptno );
END;
/

------------------------------------------------------------------------------------------------------------------------

SET serveroutput ON
DECLARE
  v_max_deptno NUMBER;
  v_dept_name departments.department_name%TYPE := 'Education';
  v_dept_id NUMBER;
BEGIN
  SELECT MAX( department_id ) INTO v_max_deptno FROM employees;
  v_dept_id:= ( v_max_deptno + 170 );

  dbms_output.put_line('Максимальный департамент ' || v_dept_id  );
  
  INSERT INTO departments ( department_id, department_name, location_id )
  VALUES( v_dept_id, v_dept_name, NULL );
  dbms_output.put_line( 'Количество строк ' || SQL%ROWCOUNT );
END;
/


-- *********************************************************************************************************************
-- * Lab 5
-- *********************************************************************************************************************

DROP TABLE messages;
CREATE TABLE messages( results VARCHAR2(80) );

BEGIN
  FOR v_count IN 1..10
  LOOP
    IF NOT( v_count = 6 OR v_count = 8 ) THEN
      INSERT INTO messages( results ) VALUES( v_count );
    END IF;
  END LOOP;
END;
/

COMMIT;
SELECT * FROM messages;

------------------------------------------------------------------------------------------------------------------------

set serveroutput on;
declare
  v_empno number := 176;
  v_asteriks emp_m.stars%type := NULL; 
  v_sal emp_m.salary%TYPE; 
begin
  select NVL(TRUNC(salary/1000, 0), 0) into v_sal from emp_m
  where employee_id = v_empno;
  
  for v_conunt in 1..v_sal loop
    v_asteriks:= v_asteriks || '*';
  end loop;
  update emp_m set stars = v_asteriks
  where employee_id = v_empno;
commit;
end;
/

select employee_id, salary, stars from emp_m 
where employee_id = 176;


-- *********************************************************************************************************************
-- * Lab 6
-- *********************************************************************************************************************

SET SERVEROUTPUT ON
--DEFINE v_countryid = "CA"
DECLARE
  v_countryid VARCHAR2(10) := 'CA'; -- DE, UK, US 
  v_country_record countries%ROWTYPE;
BEGIN
  SELECT * INTO v_country_record FROM countries WHERE country_id = v_countryid;
  DBMS_OUTPUT.PUT_LINE( 'Country_Id: ' || v_country_record.country_id 
                      ||' Country_Name: ' || v_country_record.country_name 
                      ||' Region_Id: ' || v_country_record.region_id );
END;
/

------------------------------------------------------------------------------------------------------------------------

SET SERVEROUTPUT ON;

DECLARE
  TYPE dept_table_type IS TABLE OF 
    departments.department_name%TYPE 
  INDEX BY PLS_INTEGER;
    
  my_dept_table dept_table_type;
  
  loop_count NUMBER( 10 ) DEFAULT 10;
  deptno     NUMBER( 10 ) DEFAULT 0;
  
BEGIN
  
  FOR i IN 1..loop_count
  LOOP
    deptno:= deptno + 10;

    SELECT DEPARTMENT_NAME INTO MY_DEPT_TABLE( I ) FROM DEPARTMENTS
    WHERE department_id = deptno;
  END LOOP;
  
  FOR i IN 1..loop_count
  LOOP
    dbms_output.put_line( my_dept_table( i ) );
  END LOOP;
END;
/

------------------------------------------------------------------------------------------------------------------------

set serveroutput on
declare
  type dept_table_type is table of 
    departments%rowtype
  INDEX BY PLS_INTEGER;
    
  my_dept_table dept_table_type;
  
  loop_count NUMBER( 10 ) DEFAULT 10;
  deptno     NUMBER( 10 ) DEFAULT 0;
  
BEGIN
  
  FOR i IN 1..loop_count
  LOOP
    deptno:= deptno + 10;

    SELECT * INTO my_dept_table( i ) FROM departments
    WHERE department_id = deptno;
  END LOOP;
  
  FOR i IN 1..loop_count
  loop
    dbms_output.put_line( 'Department_Id: ' || my_dept_table( i ).department_id
                        || ' Department_Name: ' || my_dept_table( i ).department_name
                        || ' Manager_Id: ' || my_dept_table( i ).manager_id 
                        || ' Location_Id: ' || my_dept_table( i ).location_id );
  END LOOP;
END;
/


-- *********************************************************************************************************************
-- * Lab 7
-- *********************************************************************************************************************

set serveroutput on

DECLARE 
  V_NUM NUMBER := 10; 
  SAL EMPLOYEES.SALARY%TYPE;
  
  CURSOR EMP_CURSOR IS
    SELECT DISTINCT SALARY FROM EMPLOYEES
    order by SALARY desc;

BEGIN
open EMP_CURSOR;
	loop
		FETCH EMP_CURSOR INTO SAL;
		insert into TOP_SALARIES ( SALARY ) values( sal );
		exit WHEN EMP_CURSOR%ROWCOUNT = V_NUM;
	END LOOP;
close EMP_CURSOR;
END;
/

------------------------------------------------------------------------------------------------------------------------

set serveroutput on

DECLARE 
  v_deptno number:= 30;
  
  CURSOR EMP_CURSOR IS
    SELECT E.LAST_NAME, E.SALARY, D.MANAGER_ID FROM DEPARTMENTS D, EMPLOYEES E
    WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID and D.DEPARTMENT_ID = V_DEPTNO;

BEGIN
  
  FOR I IN EMP_CURSOR LOOP
    IF I.SALARY < 5000 AND I.MANAGER_ID = 101 OR I.MANAGER_ID = 124 THEN
      DBMS_OUTPUT.PUT_LINE( I.LAST_NAME ||' Due for a raise.' );      
    ELSE 
      DBMS_OUTPUT.PUT_LINE( I.LAST_NAME ||' Not due for a raise.' );         
    end if;
  
  end loop;

END;
/

------------------------------------------------------------------------------------------------------------------------

set serveroutput on

DECLARE 
  
  CURSOR DEPT_CURSOR IS
    SELECT DEPARTMENT_ID, DEPARTMENT_NAME FROM DEPARTMENTS
    WHERE DEPARTMENT_ID < 100
    ORDER BY DEPARTMENT_ID ASC;
    
  CURSOR EMP_CURSOR( DEP_ID EMPLOYEES.DEPARTMENT_ID%TYPE ) IS
    SELECT LAST_NAME, JOB_ID, HIRE_DATE, SALARY FROM EMPLOYEES
    where EMPLOYEE_ID < 120 and DEPARTMENT_ID = DEP_ID;
  
  V_DEPARTMENT_ID DEPARTMENTS.DEPARTMENT_ID%TYPE;
  V_DEPARTMENT_NAME DEPARTMENTS.DEPARTMENT_NAME%TYPE;
  V_LAST_NAME EMPLOYEES.LAST_NAME%TYPE;
  V_JOB_ID EMPLOYEES.JOB_ID%TYPE;
  V_HIRE_DATE EMPLOYEES.HIRE_DATE%TYPE;
  V_SALARY EMPLOYEES.SALARY%TYPE;
  
BEGIN
  open DEPT_CURSOR;
  
  LOOP
    FETCH DEPT_CURSOR INTO V_DEPARTMENT_ID, V_DEPARTMENT_NAME;
    DBMS_OUTPUT.PUT_LINE('Номер отдела ' || V_DEPARTMENT_ID || ' Имя отдела ' || V_DEPARTMENT_NAME );
    
    OPEN EMP_CURSOR( V_DEPARTMENT_ID );
    
    LOOP
      FETCH EMP_CURSOR INTO V_LAST_NAME, V_JOB_ID, V_HIRE_DATE, V_SALARY;
      DBMS_OUTPUT.PUT_LINE( 'Имя ' || V_LAST_NAME || ' JOB ID ' || V_JOB_ID || ' HIRE DATE ' || V_HIRE_DATE
                            || ' SALARY ' || V_SALARY );
      EXIT WHEN EMP_CURSOR%NOTFOUND;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE( '----------------------------------------------------------------' );
    
    CLOSE EMP_CURSOR;
    
    EXIT WHEN DEPT_CURSOR%NOTFOUND;
    
  END LOOP;
  
  close DEPT_CURSOR;
  
END;
/


-- *********************************************************************************************************************
-- * Lab 8
-- *********************************************************************************************************************

DECLARE
  V_ENAME EMPLOYEES.LAST_NAME%TYPE;
  V_EMP_SAL EMPLOYEES.SALARY%TYPE:= 6000;
BEGIN
  SELECT LAST_NAME INTO V_ENAME FROM EMPLOYEES
  WHERE SALARY = V_EMP_SAL;
  
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    INSERT INTO MESSAGES ( RESULTS ) VALUES( 'No employees with a salary of ' || V_EMP_SAL );

  WHEN TOO_MANY_ROWS THEN
    INSERT INTO MESSAGES ( RESULTS ) VALUES( 'More than one employee with a salary of ' || V_EMP_SAL );
END;
/

SELECT * FROM MESSAGES;

------------------------------------------------------------------------------------------------------------------------

SET SERVEROUTPUT ON
DECLARE
  CHILDRECORD_EXISTS EXCEPTION;
  PRAGMA EXCEPTION_INIT( CHILDRECORD_EXISTS, -02292 );
BEGIN
  DBMS_OUTPUT.PUT_LINE( 'Deleting department 40.........' );
  DELETE FROM DEPARTMENTS WHERE DEPARTMENT_ID = 40;
  
  EXCEPTION
    WHEN CHILDRECORD_EXISTS THEN
      DBMS_OUTPUT.PUT_LINE('Cannot delete this department. There are employees in this department');
    
END;
/


-- *********************************************************************************************************************
-- * Lab 9
-- *********************************************************************************************************************

CREATE OR REPLACE PROCEDURE ADD_JOB ( 
  ID JOBS.JOB_ID%TYPE, 
  JOB_TITLE JOBS.JOB_TITLE%TYPE 
) AS
  BEGIN
    insert into jobs( JOB_ID, JOB_TITLE ) values( ID, JOB_TITLE );
  END;
  /

BEGIN
  ADD_JOB( 'IT_DBA', 'Database Administrator' ); -- добавится 
  ADD_JOB( 'ST_MAN', 'Stock Manager' ); --не добавится так как первый параметр является первичным клучом.
END;
/

------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE UPD_JOB  ( 
  ID JOBS.JOB_ID%TYPE, 
  JOB_TITLE JOBS.JOB_TITLE%TYPE 
) AS
  BEGIN
    UPDATE JOBS SET JOB_TITLE = JOB_TITLE
      WHERE JOB_ID = ID;
      
      IF SQL%NOTFOUND THEN
        dbms_output.put_line('Ничего не найдено');
      END IF;
  END;
  /

SET SERVEROUTPUT ON
BEGIN
  UPD_JOB( 'IT_DBA', 'Database Administrator' );
END;
/

------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE DEL_JOB( 
  ID JOBS.JOB_ID%TYPE
) AS
BEGIN
  DELETE FROM JOBS WHERE JOB_ID = ID;
  
  IF SQL%NOTFOUND THEN
    dbms_output.put_line( 'Ничего не удалено' );
  END IF;
END;
/

set serveroutput on
BEGIN
  DEL_JOB( 'IT_DBA' );
END;
/

------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE GET_EMPLOYEE(
  V_EMP IN EMPLOYEES.EMPLOYEE_ID%TYPE,
  V_JOB_ID OUT EMPLOYEES.JOB_ID%TYPE,
  V_SALARY OUT EMPLOYEES.SALARY%TYPE
) AS
BEGIN
  SELECT JOB_ID, SALARY INTO V_JOB_ID, V_SALARY FROM EMPLOYEES
  WHERE EMPLOYEE_ID = V_EMP;
END;
/

SET SERVEROUTPUT ON
DECLARE
  V_JOB_ID EMPLOYEES.JOB_ID%TYPE;
  V_SALARY EMPLOYEES.SALARY%TYPE;

BEGIN
  GET_EMPLOYEE( 120, V_JOB_ID, V_SALARY );
  DBMS_OUTPUT.PUT_LINE( 'JOB_ID ' || V_JOB_ID || ' ' || 'SALARY ' || V_SALARY );
END;
/


-- *********************************************************************************************************************
-- * Lab 10
-- *********************************************************************************************************************

CREATE OR REPLACE FUNCTION GET_JOB(
  jobs_id JOBS.JOB_ID%type
) RETURN VARCHAR2 AS
JOB_TIT JOBS.JOB_TITLE%type;
BEGIN
  SELECT JOB_TITLE into JOB_TIT FROM JOBS
    WHERE JOB_ID = JOBS_ID;

   return JOB_TIT;
END;
/

set serveroutput on
DECLARE
  b_title JOBS.JOB_TITLE%type;
BEGIN
  b_title:= GET_JOB( 'SA_REP' );
  
  dbms_output.put_line( B_TITLE );
END;
/

------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION GET_ANNUAL_COMP (
  COMMISSION_PCT IN OUT EMPLOYEES.COMMISSION_PCT%TYPE,
  SALARY IN OUT EMPLOYEES.SALARY%TYPE
) RETURN NUMBER AS
V_RESULT NUMBER;
BEGIN
  IF COMMISSION_PCT IS NULL THEN
    COMMISSION_PCT:= 0;
  END IF;  
  IF SALARY IS NULL THEN
    SALARY:= 0;
  END IF;
  
  V_RESULT:= ( ( SALARY * 12 ) + ( COMMISSION_PCT * SALARY * 12 ) ); 
  
  RETURN V_RESULT;
  
END GET_ANNUAL_COMP;
/

SET SERVEROUTPUT ON
DECLARE
  V_RESULT NUMBER;
  
  CURSOR MY_TEST IS
     SELECT COMMISSION_PCT, SALARY FROM EMPLOYEES
     WHERE DEPARTMENT_ID = 30; 
  
BEGIN
  
  FOR V_COUNT IN MY_TEST LOOP
   V_RESULT:= GET_ANNUAL_COMP( V_COUNT.COMMISSION_PCT, V_COUNT.SALARY );
    DBMS_OUTPUT.PUT_LINE( V_RESULT );
    
  END LOOP;
 END;
/

------------------------------------------------------------------------------------------------------------------------

create or replace
FUNCTION VALID_DEPTID(
      DEP_ID NUMBER )
    RETURN BOOLEAN
  AS
    V_RESULT BOOLEAN;
    V_DEP_ID NUMBER:= 0;
    CURSOR TMP
    IS 
      SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE DEPARTMENT_ID = DEP_ID;
  BEGIN
    OPEN TMP;
      FETCH TMP INTO V_DEP_ID;
      IF TMP%NOTFOUND THEN
        v_result:= false;
      ELSE
        v_result:= true;
      END IF;
    CLOSE TMP;
    
    RETURN V_RESULT;
  END;


CREATE OR REPLACE
PROCEDURE ADD_EMPLOYEE(
    FIRST_NAME EMPLOYEES.FIRST_NAME%type,
    LAST_NAME EMPLOYEES.LAST_NAME%type,
    EMAIL EMPLOYEES.EMAIL%type,
    job EMPLOYEES.JOB_ID%type DEFAULT 'SA_REP',
    MGR EMPLOYEES.MANAGER_ID%type DEFAULT 145,
    SAL EMPLOYEES.SALARY%type DEFAULT 1000,
    COMM EMPLOYEES.COMMISSION_PCT%type DEFAULT 0,
    DEPTID EMPLOYEES.DEPARTMENT_ID%type DEFAULT 30 )
AS
  V_HIRE_DATE DATE;
BEGIN
  V_HIRE_DATE:= TRUNC(sysdate);
  IF VALID_DEPTID( DEPTID ) THEN
    INSERT INTO EMPLOYEES(EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID, SALARY,
                          COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID )
    VALUES(EMPLOYEES_SEQ.NEXTVAL, FIRST_NAME, LAST_NAME, EMAIL, V_HIRE_DATE, job, SAL, COMM, MGR, DEPTID);
  ELSE
    dbms_output.put_line( 'Такого отдела нет' );
  END IF;
END;


SET SERVEROUTPUT ON
BEGIN
  ADD_EMPLOYEE( 'SJF', 'SFSF', 'JKKJH', 'SA_REP', 145, 1000, 0, 0 );
END;
/


-- *********************************************************************************************************************
-- * Lab 11
-- *********************************************************************************************************************

CREATE OR REPLACE PACKAGE JOB_PKG IS
  
  PROCEDURE ADD_JOB( ID JOBS.JOB_ID%TYPE, JOB_TITLE JOBS.JOB_TITLE%TYPE ); 
  
  PROCEDURE UPD_JOB( ID JOBS.JOB_ID%TYPE, JOB_TITLE JOBS.JOB_TITLE%TYPE ); 
  
  PROCEDURE DEL_JOB( ID JOBS.JOB_ID%TYPE );

  FUNCTION GET_JOB( JOBS_ID JOBS.JOB_ID%TYPE ) RETURN VARCHAR2;
  
END;
/


CREATE OR REPLACE PACKAGE BODY JOB_PKG IS

  PROCEDURE ADD_JOB( ID JOBS.JOB_ID%TYPE, JOB_TITLE JOBS.JOB_TITLE%TYPE ) AS
  BEGIN
    insert into jobs( JOB_ID, JOB_TITLE ) values( ID, JOB_TITLE );
  END;
  
  PROCEDURE UPD_JOB( ID JOBS.JOB_ID%TYPE, JOB_TITLE JOBS.JOB_TITLE%TYPE ) AS
  BEGIN
    UPDATE JOBS SET JOB_TITLE = JOB_TITLE
      WHERE JOB_ID = ID;
      
      IF SQL%NOTFOUND THEN
        dbms_output.put_line('Ничего не найдено');
      END IF;
  END;
  
  PROCEDURE DEL_JOB( ID JOBS.JOB_ID%TYPE ) AS
  BEGIN
    DELETE FROM JOBS WHERE JOB_ID = ID;
    
    IF SQL%NOTFOUND THEN
      DBMS_OUTPUT.PUT_LINE( 'Ничего не удалено' );
    END IF;
  END;
  
  FUNCTION GET_JOB( JOBS_ID JOBS.JOB_ID%TYPE ) RETURN VARCHAR2 AS
    JOB_TIT JOBS.JOB_TITLE%TYPE;
  BEGIN
    SELECT JOB_TITLE into JOB_TIT FROM JOBS
      WHERE JOB_ID = JOBS_ID;

    RETURN JOB_TIT;
  END;

END;
/

------------------------------------------------------------------------------------------------------------------------

create or replace package EMP_PKG is

  PROCEDURE ADD_EMPLOYEE(
    FIRST_NAME EMPLOYEES.FIRST_NAME%type,
    LAST_NAME EMPLOYEES.LAST_NAME%type,
    EMAIL EMPLOYEES.EMAIL%type,
    DEPTID EMPLOYEES.DEPARTMENT_ID%type default 30,
    job EMPLOYEES.JOB_ID%type DEFAULT 'SA_REP',
    MGR EMPLOYEES.MANAGER_ID%type DEFAULT 145,
    SAL EMPLOYEES.SALARY%type DEFAULT 1000,
    COMM EMPLOYEES.COMMISSION_PCT%type default 0 );
      
  PROCEDURE GET_EMPLOYEE(
    V_EMP IN EMPLOYEES.EMPLOYEE_ID%TYPE,
    V_JOB_ID OUT EMPLOYEES.JOB_ID%TYPE,
    V_SALARY OUT EMPLOYEES.SALARY%type );

end EMP_PKG;
/

create or replace package body EMP_PKG is

  FUNCTION VALID_DEPTID( DEP_ID NUMBER ) RETURN BOOLEAN AS
      V_RESULT BOOLEAN;
      V_DEP_ID NUMBER:= 0;
      CURSOR TMP
      IS 
        SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE DEPARTMENT_ID = DEP_ID;
    BEGIN
      OPEN TMP;
        FETCH TMP INTO V_DEP_ID;
        IF TMP%NOTFOUND THEN
          v_result:= false;
        ELSE
          v_result:= true;
        END IF;
      CLOSE TMP;
      
      return V_RESULT;
      
    end VALID_DEPTID;

  PROCEDURE ADD_EMPLOYEE(
      FIRST_NAME EMPLOYEES.FIRST_NAME%type,
      LAST_NAME EMPLOYEES.LAST_NAME%type,
      EMAIL EMPLOYEES.EMAIL%type,
      DEPTID EMPLOYEES.DEPARTMENT_ID%type DEFAULT 30,
      job EMPLOYEES.JOB_ID%type DEFAULT 'SA_REP',
      MGR EMPLOYEES.MANAGER_ID%type DEFAULT 145,
      SAL EMPLOYEES.SALARY%type DEFAULT 1000,
      COMM EMPLOYEES.COMMISSION_PCT%type DEFAULT 0 )
  AS
    V_HIRE_DATE DATE;
  BEGIN
    V_HIRE_DATE:= TRUNC(sysdate);
    IF VALID_DEPTID( DEPTID ) THEN
      INSERT INTO EMPLOYEES(EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID, SALARY,
                            COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID )
      VALUES(EMPLOYEES_SEQ.NEXTVAL, FIRST_NAME, LAST_NAME, EMAIL, V_HIRE_DATE, job, SAL, COMM, MGR, DEPTID);
    ELSE
      dbms_output.put_line( 'Такого отдела нет' );
    end if;
  end ADD_EMPLOYEE;
  
  PROCEDURE GET_EMPLOYEE(
    V_EMP IN EMPLOYEES.EMPLOYEE_ID%TYPE,
    V_JOB_ID OUT EMPLOYEES.JOB_ID%TYPE,
    V_SALARY OUT EMPLOYEES.SALARY%TYPE
  ) AS
  BEGIN
    SELECT JOB_ID, SALARY INTO V_JOB_ID, V_SALARY FROM EMPLOYEES
    where EMPLOYEE_ID = V_EMP;
  END GET_EMPLOYEE;

end EMP_PKG;
/

set serveroutput on
begin
 -- EMP_PKG.ADD_EMPLOYEE('Jane', ' Harris', 'jaharris', 15);
     EMP_PKG.ADD_EMPLOYEE('David', 'Smith', 'dasmith', 80);
end;

select LAST_NAME, FIRST_NAME, EMAIL, COMMISSION_PCT from EMPLOYEES 
  where DEPARTMENT_ID = 80 and SALARY = 1000 ;

------------------------------------------------------------------------------------------------------------------------

PROCEDURE ADD_EMPLOYEE(
    FIRSTNAME EMPLOYEES.FIRST_NAME%type,
    LASTNAME EMPLOYEES.LAST_NAME%type,
    DEPARTMENT EMPLOYEES.DEPARTMENT_ID%type
);

PROCEDURE ADD_EMPLOYEE(
    FIRSTNAME EMPLOYEES.FIRST_NAME%type,
    LASTNAME EMPLOYEES.LAST_NAME%type,
    department EMPLOYEES.DEPARTMENT_ID%type )
  IS
    v_mail EMPLOYEES.EMAIL%type;
  BEGIN
    V_MAIL:= SUBSTR( FIRSTNAME, 1, 1 ) || SUBSTR( LASTNAME, 1, 7 );
    
    ADD_EMPLOYEE( FIRSTNAME, FIRSTNAME, V_MAIL, department );

  END ADD_EMPLOYEE;

------------------------------------------------------------------------------------------------------------------------

  FUNCTION GET_EMPLOYEE(
    P_EMP_ID EMPLOYEES.EMPLOYEE_ID%TYPE 
  ) RETURN EMPLOYEES%ROWTYPE IS
  TMP EMPLOYEES%ROWTYPE;
  BEGIN
    SELECT * INTO TMP FROM EMPLOYEES
    WHERE EMPLOYEE_ID = P_EMP_ID;
    
    RETURN TMP;
    
  EXCEPTION  
    WHEN no_data_found THEN
    DBMS_OUTPUT.PUT_LINE( 'Ничего не найдено' );
    RETURN NULL;
    
  END GET_EMPLOYEE;


  FUNCTION GET_EMPLOYEE(
    P_FAMILY_NAME EMPLOYEES.LAST_NAME%TYPE 
  ) return employees%rowtype 
  IS
    
  TMP EMPLOYEES%ROWTYPE;
  
  BEGIN
    SELECT * INTO TMP FROM EMPLOYEES
      WHERE LAST_NAME = P_FAMILY_NAME;
    
    RETURN TMP;
    
  EXCEPTION  
    WHEN no_data_found THEN
      DBMS_OUTPUT.PUT_LINE( 'Ничего не найдено' );
    RETURN NULL;

  END GET_EMPLOYEE;



  PROCEDURE PRINT_EMPLOYEE( tmp employees%rowtype )IS
  BEGIN
    dbms_output.put_line( tmp.department_id || ' ' || tmp.employee_id || ' ' || tmp.first_name
    || ' ' || tmp.last_name || ' ' || tmp.job_id || ' ' || tmp.salary );
  END PRINT_EMPLOYEE;


SET SERVEROUTPUT ON
BEGIN
  EMP_PKG.PRINT_EMPLOYEE( EMP_PKG.GET_EMPLOYEE( 100 ) );
  EMP_PKG.PRINT_EMPLOYEE( EMP_PKG.GET_EMPLOYEE( 'Joplin' ) );
end;

------------------------------------------------------------------------------------------------------------------------

create or replace  package EMP_PKG is

  PROCEDURE ADD_EMPLOYEE(
    FIRST_NAME EMPLOYEES.FIRST_NAME%type,
    LAST_NAME EMPLOYEES.LAST_NAME%type,
    EMAIL EMPLOYEES.EMAIL%type,
    DEPTID EMPLOYEES.DEPARTMENT_ID%type default 30,
    job EMPLOYEES.JOB_ID%type DEFAULT 'SA_REP',
    MGR EMPLOYEES.MANAGER_ID%type DEFAULT 145,
    SAL EMPLOYEES.SALARY%type DEFAULT 1000,
    COMM EMPLOYEES.COMMISSION_PCT%type default 0 );

  PROCEDURE ADD_EMPLOYEE(
    FIRSTNAME EMPLOYEES.FIRST_NAME%type,
    LASTNAME EMPLOYEES.LAST_NAME%type,
    DEPARTMENT EMPLOYEES.DEPARTMENT_ID%type
  );

  PROCEDURE GET_EMPLOYEE(
    V_EMP IN EMPLOYEES.EMPLOYEE_ID%TYPE,
    V_JOB_ID OUT EMPLOYEES.JOB_ID%TYPE,
    V_SALARY OUT EMPLOYEES.SALARY%TYPE );
    
  FUNCTION GET_EMPLOYEE(
    P_EMP_ID EMPLOYEES.EMPLOYEE_ID%type 
  ) RETURN employees%ROWTYPE;
  
  FUNCTION GET_EMPLOYEE(
    p_family_name EMPLOYEES.LAST_NAME%type 
  ) RETURN EMPLOYEES%ROWTYPE;

  PROCEDURE PRINT_EMPLOYEE( tmp employees%rowtype );
  
  PROCEDURE INIT_DEPARTMENTS;

END EMP_PKG;

create or replace
package body EMP_PKG is

  TYPE BOOL_TYPE IS TABLE OF
    Boolean
  INDEX BY PLS_INTEGER;
  
  valid_departments BOOL_TYPE;
  
  PROCEDURE INIT_DEPARTMENTS AS
  CURSOR BOOL_CURSOR IS
    select DEPARTMENT_ID from DEPARTMENTS; 
  BEGIN
  
    FOR I IN BOOL_CURSOR LOOP
      VALID_DEPARTMENTS( I.DEPARTMENT_ID ):= TRUE;
    END LOOP;
    
  end INIT_DEPARTMENTS;
  
  FUNCTION VALID_DEPTID( DEP_ID NUMBER ) RETURN BOOLEAN AS
      V_RESULT BOOLEAN;
      V_DEP_ID NUMBER:= 0;
      CURSOR TMP
      IS 
        SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE DEPARTMENT_ID = DEP_ID;
    BEGIN
      OPEN TMP;
        FETCH TMP INTO V_DEP_ID;
        IF TMP%NOTFOUND THEN
          v_result:= false;
        ELSE
          v_result:= true;
        END IF;
      CLOSE TMP;
      
      return V_RESULT;
      
    END VALID_DEPTID;
    

  PROCEDURE ADD_EMPLOYEE(
      FIRST_NAME EMPLOYEES.FIRST_NAME%type,
      LAST_NAME EMPLOYEES.LAST_NAME%type,
      EMAIL EMPLOYEES.EMAIL%type,
      DEPTID EMPLOYEES.DEPARTMENT_ID%type DEFAULT 30,
      job EMPLOYEES.JOB_ID%type DEFAULT 'SA_REP',
      MGR EMPLOYEES.MANAGER_ID%type DEFAULT 145,
      SAL EMPLOYEES.SALARY%type DEFAULT 1000,
      COMM EMPLOYEES.COMMISSION_PCT%type DEFAULT 0 )
  AS
    V_HIRE_DATE DATE;
  BEGIN
    V_HIRE_DATE:= TRUNC(sysdate);
    IF VALID_DEPTID( DEPTID ) THEN
      INSERT INTO EMPLOYEES(EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID, SALARY,
                            COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID )
      VALUES(EMPLOYEES_SEQ.NEXTVAL, FIRST_NAME, LAST_NAME, EMAIL, V_HIRE_DATE, job, SAL, COMM, MGR, DEPTID);
    ELSE
      dbms_output.put_line( 'Такого отдела нет' );
    end if;
  end ADD_EMPLOYEE;
  
  
  PROCEDURE ADD_EMPLOYEE(
    FIRSTNAME EMPLOYEES.FIRST_NAME%type,
    LASTNAME EMPLOYEES.LAST_NAME%type,
    department EMPLOYEES.DEPARTMENT_ID%type )
  IS
    v_mail EMPLOYEES.EMAIL%type;
  BEGIN
    V_MAIL:= SUBSTR( FIRSTNAME, 1, 1 ) || SUBSTR( LASTNAME, 1, 7 );
    
    ADD_EMPLOYEE( FIRSTNAME, FIRSTNAME, V_MAIL, department );

  END ADD_EMPLOYEE;
  
  PROCEDURE GET_EMPLOYEE(
    V_EMP IN EMPLOYEES.EMPLOYEE_ID%TYPE,
    V_JOB_ID OUT EMPLOYEES.JOB_ID%TYPE,
    V_SALARY OUT EMPLOYEES.SALARY%TYPE
  ) AS
  BEGIN
    SELECT JOB_ID, SALARY INTO V_JOB_ID, V_SALARY FROM EMPLOYEES
    where EMPLOYEE_ID = V_EMP;

  END GET_EMPLOYEE;
  
  
  FUNCTION GET_EMPLOYEE(
    P_EMP_ID EMPLOYEES.EMPLOYEE_ID%TYPE 
  ) RETURN EMPLOYEES%ROWTYPE IS
  TMP EMPLOYEES%ROWTYPE;
  BEGIN
    SELECT * INTO TMP FROM EMPLOYEES
    WHERE EMPLOYEE_ID = P_EMP_ID;
    
    RETURN TMP;
    
  EXCEPTION  
    WHEN no_data_found THEN
    DBMS_OUTPUT.PUT_LINE( 'Ничего не найдено' );
    RETURN NULL;
    
  END GET_EMPLOYEE;


 FUNCTION GET_EMPLOYEE(
    P_FAMILY_NAME EMPLOYEES.LAST_NAME%TYPE 
  ) RETURN EMPLOYEES%ROWTYPE IS

  TMP EMPLOYEES%ROWTYPE;
  
  BEGIN
 
  SELECT * INTO TMP FROM EMPLOYEES
   WHERE LAST_NAME = P_FAMILY_NAME;

  RETURN TMP;

  EXCEPTION  
    WHEN no_data_found THEN
    DBMS_OUTPUT.PUT_LINE( 'Ничего не найдено' );
    RETURN NULL;

  END GET_EMPLOYEE;

  PROCEDURE PRINT_EMPLOYEE( tmp employees%rowtype )IS
  BEGIN
    dbms_output.put_line( tmp.department_id || ' ' || tmp.employee_id || ' ' || tmp.first_name
    || ' ' || tmp.last_name || ' ' || tmp.job_id || ' ' || tmp.salary );
  END PRINT_EMPLOYEE;
  
BEGIN
  INIT_DEPARTMENTS;

END EMP_PKG;

------------------------------------------------------------------------------------------------------------------------

create or replace
package EMP_PKG is

  PROCEDURE ADD_EMPLOYEE(
    FIRST_NAME EMPLOYEES.FIRST_NAME%type,
    LAST_NAME EMPLOYEES.LAST_NAME%type,
    EMAIL EMPLOYEES.EMAIL%type,
    DEPTID EMPLOYEES.DEPARTMENT_ID%type default 30,
    job EMPLOYEES.JOB_ID%type DEFAULT 'SA_REP',
    MGR EMPLOYEES.MANAGER_ID%type DEFAULT 145,
    SAL EMPLOYEES.SALARY%type DEFAULT 1000,
    COMM EMPLOYEES.COMMISSION_PCT%type default 0 );
    

  PROCEDURE ADD_EMPLOYEE(
    FIRSTNAME EMPLOYEES.FIRST_NAME%type,
    LASTNAME EMPLOYEES.LAST_NAME%type,
    DEPARTMENT EMPLOYEES.DEPARTMENT_ID%type
  );
  

  PROCEDURE GET_EMPLOYEE(
    V_EMP IN EMPLOYEES.EMPLOYEE_ID%TYPE,
    V_JOB_ID OUT EMPLOYEES.JOB_ID%TYPE,
    V_SALARY OUT EMPLOYEES.SALARY%TYPE );
    
    
  FUNCTION GET_EMPLOYEE(
    P_EMP_ID EMPLOYEES.EMPLOYEE_ID%type 
  ) RETURN employees%ROWTYPE;
  
  FUNCTION GET_EMPLOYEE(
    p_family_name EMPLOYEES.LAST_NAME%type 
  ) RETURN EMPLOYEES%ROWTYPE;
  
  
  PROCEDURE INIT_DEPARTMENTS;

  PROCEDURE PRINT_EMPLOYEE( tmp employees%rowtype );

END EMP_PKG;


create or replace
package body EMP_PKG is

  TYPE BOOL_TYPE IS TABLE OF
    Boolean
  INDEX BY PLS_INTEGER;
  
  valid_departments BOOL_TYPE;
  
  FUNCTION VALID_DEPTID( DEP_ID NUMBER ) RETURN BOOLEAN;
  
  PROCEDURE ADD_EMPLOYEE(
      FIRST_NAME EMPLOYEES.FIRST_NAME%type,
      LAST_NAME EMPLOYEES.LAST_NAME%type,
      EMAIL EMPLOYEES.EMAIL%type,
      DEPTID EMPLOYEES.DEPARTMENT_ID%type DEFAULT 30,
      job EMPLOYEES.JOB_ID%type DEFAULT 'SA_REP',
      MGR EMPLOYEES.MANAGER_ID%type DEFAULT 145,
      SAL EMPLOYEES.SALARY%type DEFAULT 1000,
      COMM EMPLOYEES.COMMISSION_PCT%type DEFAULT 0 )
  AS
    V_HIRE_DATE DATE;
  BEGIN
    V_HIRE_DATE:= TRUNC(sysdate);
    IF VALID_DEPTID( DEPTID ) THEN
      INSERT INTO EMPLOYEES(EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID, SALARY,
                            COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID )
      VALUES(EMPLOYEES_SEQ.NEXTVAL, FIRST_NAME, LAST_NAME, EMAIL, V_HIRE_DATE, job, SAL, COMM, MGR, DEPTID);
    ELSE
      dbms_output.put_line( 'Такого отдела нет' );
    end if;
  end ADD_EMPLOYEE;
  
  
  PROCEDURE ADD_EMPLOYEE(
    FIRSTNAME EMPLOYEES.FIRST_NAME%type,
    LASTNAME EMPLOYEES.LAST_NAME%type,
    department EMPLOYEES.DEPARTMENT_ID%type )
  IS
    v_mail EMPLOYEES.EMAIL%type;
  BEGIN
    V_MAIL:= SUBSTR( FIRSTNAME, 1, 1 ) || SUBSTR( LASTNAME, 1, 7 );
    
    ADD_EMPLOYEE( FIRSTNAME, LASTNAME, V_MAIL, department );

  END ADD_EMPLOYEE;
  
  
  PROCEDURE GET_EMPLOYEE(
    V_EMP IN EMPLOYEES.EMPLOYEE_ID%TYPE,
    V_JOB_ID OUT EMPLOYEES.JOB_ID%TYPE,
    V_SALARY OUT EMPLOYEES.SALARY%TYPE
  ) AS
  BEGIN
    SELECT JOB_ID, SALARY INTO V_JOB_ID, V_SALARY FROM EMPLOYEES
    where EMPLOYEE_ID = V_EMP;

  END GET_EMPLOYEE;
  
  
  FUNCTION GET_EMPLOYEE(
    P_EMP_ID EMPLOYEES.EMPLOYEE_ID%TYPE 
  ) RETURN EMPLOYEES%ROWTYPE IS
  TMP EMPLOYEES%ROWTYPE;
  BEGIN
    SELECT * INTO TMP FROM EMPLOYEES
    WHERE EMPLOYEE_ID = P_EMP_ID;
    
    RETURN TMP;
    
  EXCEPTION  
    WHEN no_data_found THEN
    DBMS_OUTPUT.PUT_LINE( 'Ничего не найдено' );
    RETURN NULL;
    
  END GET_EMPLOYEE;


  FUNCTION GET_EMPLOYEE(
    P_FAMILY_NAME EMPLOYEES.LAST_NAME%TYPE 
  ) RETURN EMPLOYEES%ROWTYPE IS

  TMP EMPLOYEES%ROWTYPE;
  
  BEGIN
 
  SELECT * INTO TMP FROM EMPLOYEES
   WHERE LAST_NAME = P_FAMILY_NAME;

  RETURN TMP;

  EXCEPTION  
    WHEN no_data_found THEN
    DBMS_OUTPUT.PUT_LINE( 'Ничего не найдено' );
    RETURN NULL;

  END GET_EMPLOYEE;
  
  
  PROCEDURE INIT_DEPARTMENTS AS
  CURSOR BOOL_CURSOR IS
    select DEPARTMENT_ID from DEPARTMENTS; 
  BEGIN
  
    FOR I IN BOOL_CURSOR LOOP
      VALID_DEPARTMENTS( I.DEPARTMENT_ID ):= TRUE;
    END LOOP;
    
  END INIT_DEPARTMENTS;
  

  PROCEDURE PRINT_EMPLOYEE( tmp employees%rowtype )IS
  BEGIN
    dbms_output.put_line( tmp.department_id || ' ' || tmp.employee_id || ' ' || tmp.first_name
    || ' ' || tmp.last_name || ' ' || tmp.job_id || ' ' || tmp.salary );
  END PRINT_EMPLOYEE;
  
  
  FUNCTION VALID_DEPTID( DEP_ID NUMBER ) RETURN BOOLEAN AS
    BEGIN
    RETURN valid_departments.EXISTS( DEP_ID );
    
    EXCEPTION
      WHEN no_data_found THEN
        DBMS_OUTPUT.PUT_LINE( 'Ничего не найдено' );
        RETURN FALSE;
  
  END VALID_DEPTID;

  
BEGIN
  INIT_DEPARTMENTS;
  
END EMP_PKG;

------------------------------------------------------------------------------------------------------------------------

create or replace directory tmp as 'c:\tmp'; 
grant read, write on directory tmp to public;

create or replace procedure EMPLOYEE_REPORT(
  P_DIR varchar2,
  p_filename varchar2
) as

f_file utl_file.file_type;

cursor C_EMPLOYEES is
  select LAST_NAME, DEPARTMENT_ID, SALARY from EMPLOYEES E1
  where SALARY > ( select AVG( SALARY ) from EMPLOYEES E2 
                   group by E1.DEPARTMENT_ID )
  order by  E1.DEPARTMENT_ID;

begin

  F_FILE:= UTL_FILE.FOPEN( P_DIR, P_FILENAME, 'W' );

  UTL_FILE.PUT_LINE( F_FILE, 'Варламов 2.1 ' || TO_CHAR(sysdate, 'DD-MON-YYYY HH24:MI:SS') );
  UTL_FILE.new_LINE( F_FILE );
    for I in C_EMPLOYEES LOOP
      UTL_FILE.PUT_LINE( F_FILE, i.LAST_NAME || ' ' || i.DEPARTMENT_ID || ' ' || i.SALARY );  
    end LOOP;
  
  UTL_FILE.FCLOSE( F_FILE );

end;
/

begin
  EMPLOYEE_REPORT( 'TMP', 'test.txt' );
end;
/

------------------------------------------------------------------------------------------------------------------------

create or replace procedure EMPLOYEE_REPORT(
  P_DIR varchar2,
  p_filename varchar2
) as

f_file utl_file.file_type;

cursor C_EMPLOYEES is
  select LAST_NAME, DEPARTMENT_ID, SALARY from EMPLOYEES E1
  where SALARY > ( select AVG( SALARY ) from EMPLOYEES E2 
                   group by E1.DEPARTMENT_ID )
  order by  E1.DEPARTMENT_ID;
  
 
begin

  F_FILE:= UTL_FILE.FOPEN(P_DIR, P_FILENAME ||'_'|| to_char( user ) ||'_'|| to_char( sysdate, 'HH24MISS')||'.txt', 'W');

  UTL_FILE.PUT_LINE( F_FILE, 'Варламов 2.1 ' || TO_CHAR(sysdate, 'DD-MON-YYYY HH24:MI:SS') );
  UTL_FILE.new_LINE( F_FILE );
    for I in C_EMPLOYEES LOOP
      UTL_FILE.PUT_LINE( F_FILE, i.LAST_NAME || ' ' || i.DEPARTMENT_ID || ' ' || i.SALARY );  
    end LOOP;
  
  UTL_FILE.FCLOSE( F_FILE );

end;
/

set serveroutput on

begin
  EMPLOYEE_REPORT( 'TMP', 'test' ); 
end;
/

------------------------------------------------------------------------------------------------------------------------

create or replace package TABLE_PKG is

  /* DDL create table */
  PROCEDURE make( table_name VARCHAR2, col_specs VARCHAR2 );

  /* DML insert into in table */
  PROCEDURE add_row( table_name VARCHAR2, col_values VARCHAR2, cols VARCHAR2 := NULL );
  
  /* DML update set in table */
  PROCEDURE upd_row( table_name VARCHAR2, set_values VARCHAR2, conditions VARCHAR2 := NULL );
  
  /* DML delete from in table */
  PROCEDURE del_row( table_name VARCHAR2, conditions VARCHAR2 := NULL );
  
  /* DDL drop table */
  PROCEDURE remove( table_name VARCHAR2 );

END TABLE_PKG;
/

create or replace package body TABLE_PKG is

  PROCEDURE MAKE( TABLE_NAME varchar2, COL_SPECS varchar2 ) is  
  BEGIN 
    execute immediate 'CREATE TABLE ' || TABLE_NAME || ' ( ' || COL_SPECS || ' ) ';
  END MAKE;
  

  PROCEDURE ADD_ROW( TABLE_NAME VARCHAR2, COL_VALUES VARCHAR2, COLS VARCHAR2 := NULL ) IS
    v_result varchar2(200);   
  BEGIN
    v_result:= 'insert into ' || TABLE_NAME;
    
    IF COLS IS NOT NULL THEN
      v_result:= v_result || ' ( ' || COLS || ' ) ';
    end if;
    
    v_result:= v_result || ' values( '|| COL_VALUES ||' ) ';
    
    EXECUTE IMMEDIATE v_result;
    
  end ADD_ROW;
  
  
  
   PROCEDURE upd_row( table_name VARCHAR2, set_values VARCHAR2, conditions VARCHAR2 := NULL ) IS
   
    v_result VARCHAR2(200);
    
   BEGIN
   
    v_result:= 'UPDATE ' || table_name || ' set ' || set_values;
    
    IF conditions IS NOT NULL THEN
      v_result:= v_result || ' where ' || conditions;
    end if;
     
    EXECUTE IMMEDIATE v_result;
    
   END upd_row;
   
   
   
   PROCEDURE del_row( table_name VARCHAR2, conditions VARCHAR2 := NULL ) IS
    v_result varchar2(200);
   BEGIN
    v_result:= 'delete from ' || table_name;
    
    IF conditions IS NOT NULL THEN
      v_result:= v_result || ' where ' || conditions;
    end if;
    
    execute IMMEDIATE v_result;
   
   end del_row;
   
  /* 
   PROCEDURE remove( table_name VARCHAR2 ) IS   
   BEGIN
    execute IMMEDIATE 'drop table ' || table_name; 
   end remove;
  */
  
   PROCEDURE remove( table_name VARCHAR2 ) IS   
    v_cursor pls_integer;
    v_result varchar2(200);
   BEGIN
    v_cursor:= dbms_sql.open_cursor;
    v_result:= 'drop table ' || table_name;
    dbms_sql.parse( v_cursor, v_result, dbms_sql.NATIVE );
    dbms_sql.close_cursor( v_cursor );
   end remove;

END TABLE_PKG;
/

BEGIN
  TABLE_PKG.MAKE( 'my_contacts', 'id number(4), name varchar2(40)' );
  
  table_pkg.add_row( 'my_contacts', '1, ''Lauran Serhal''');
  table_pkg.add_row( 'my_contacts', '2, ''Nancy''');
  table_pkg.add_row( 'my_contacts', '3, ''Sunitha Patel''');
  table_pkg.add_row( 'my_contacts', '4, ''Valli Pataballa''');

  table_pkg.upd_row( 'my_contacts', 'id = 2', 'name = ''Nancy Greenderg''' );
  table_pkg.del_row( 'my_contacts', 'id = 3' );
  
  table_pkg.remove( 'my_contacts' );
END;
/

------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE package COMPILE_PKG IS

  procedure MAKE( p_name varchar2 );

END;
/

CREATE OR REPLACE package body COMPILE_PKG IS

  FUNCTION GET_TYPE( p_type VARCHAR2 ) RETURN VARCHAR2 IS
    v_result varchar2(100) default NULL; 
  BEGIN
  
  SELECT object_type INTO v_result FROM user_objects
    where object_name = p_type and rownum = 1;
  
  RETURN v_result;
  
  exception
    WHEN no_data_found THEN
      return v_result;
  
  END GET_TYPE;
 

  PROCEDURE MAKE( p_name VARCHAR2 ) IS
    v_result VARCHAR2(200);
    v_test VARCHAR2(50):= GET_TYPE( p_name );
  BEGIN
  
    IF v_test IS NOT NULL THEN
       v_result:= 'ALTER ' || v_test || ' ' || P_NAME || ' COMPILE';
       EXECUTE IMMEDIATE v_result;
    ELSE
      RAISE_APPLICATION_ERROR(-20000, 'ERROR' );
    end if;   
    
  end MAKE;

END COMPILE_PKG;
/

------------------------------------------------------------------------------------------------------------------------

set serveroutput on
BEGIN
  EMP_PKG.GET_EMPLOYEES( 60 );
  EMP_PKG.SHOW_EMPLOYEES;
END;
/

package body EMP_PKG
  PROCEDURE GET_EMPLOYEES( P_DEPT_ID EMPLOYEES.DEPARTMENT_ID%TYPE );
  
  PROCEDURE show_employees; 

package body EMP_PKG 
TYPE EMP_TABLE TYPE IS TABLE OF EMPLOYEES%ROWTYPE;
  
  emp_table EMP_TABLETYPE;
  
  PROCEDURE GET_EMPLOYEES( P_DEPT_ID EMPLOYEES.DEPARTMENT_ID%TYPE ) IS
  BEGIN
    SELECT * BULK COLLECT INTO EMP_TABLE FROM EMPLOYEES
    where DEPARTMENT_ID = P_DEPT_ID;
  end GET_EMPLOYEES;

  PROCEDURE SHOW_EMPLOYEES IS
  BEGIN
    FOR I IN 1 .. EMP_TABLE.COUNT LOOP
      PRINT_EMPLOYEE( EMP_TABLE( i ) );
    end loop;
  END SHOW_EMPLOYEES;

------------------------------------------------------------------------------------------------------------------------

create or replace
PACKAGE emp_pkg IS

  PROCEDURE GET_EMPLOYEES( P_DEPT_ID EMPLOYEES.DEPARTMENT_ID%TYPE );
  
  PROCEDURE show_employees; 

  PROCEDURE ADD_EMPLOYEE(
      FIRST_NAME EMPLOYEES.FIRST_NAME%type,
      LAST_NAME EMPLOYEES.LAST_NAME%type,
      EMAIL EMPLOYEES.EMAIL%type,
      DEPTID EMPLOYEES.DEPARTMENT_ID%type DEFAULT 30,
      job EMPLOYEES.JOB_ID%type DEFAULT 'SA_REP',
      MGR EMPLOYEES.MANAGER_ID%type DEFAULT 145,
      SAL EMPLOYEES.SALARY%type DEFAULT 1000,
      comm employees.commission_pct%type default 0 ); 
      
      
  PROCEDURE ADD_EMPLOYEE(
      FIRSTNAME EMPLOYEES.FIRST_NAME%type,
      LASTNAME EMPLOYEES.LAST_NAME%type,
      DEPARTMENT EMPLOYEES.DEPARTMENT_ID%type );
      
      
  PROCEDURE GET_EMPLOYEE(
      V_EMP IN EMPLOYEES.EMPLOYEE_ID%TYPE,
      V_JOB_ID OUT EMPLOYEES.JOB_ID%TYPE,
      V_SALARY OUT EMPLOYEES.SALARY%TYPE );
    
 
  FUNCTION GET_EMPLOYEE(
      P_EMP_ID EMPLOYEES.EMPLOYEE_ID%type )
    RETURN EMPLOYEES%ROWTYPE;
  
    
  FUNCTION GET_EMPLOYEE(
      p_family_name EMPLOYEES.LAST_NAME%type )
    RETURN EMPLOYEES%ROWTYPE;
    
    
  PROCEDURE PRINT_EMPLOYEE( tmp employees%rowtype );
      
  END EMP_PKG;


create or replace
package body EMP_PKG is

  TYPE EMP_TABLETYPE IS TABLE OF EMPLOYEES%ROWTYPE;
  
  emp_table EMP_TABLETYPE;
  
  PROCEDURE GET_EMPLOYEES( P_DEPT_ID EMPLOYEES.DEPARTMENT_ID%TYPE ) IS
  BEGIN
    SELECT * BULK COLLECT INTO EMP_TABLE FROM EMPLOYEES
    where DEPARTMENT_ID = P_DEPT_ID;
  end GET_EMPLOYEES;

  PROCEDURE SHOW_EMPLOYEES IS
  BEGIN
    FOR I IN 1 .. EMP_TABLE.COUNT LOOP
      PRINT_EMPLOYEE( EMP_TABLE( i ) );
    end loop;
  END SHOW_EMPLOYEES;
  
  PROCEDURE AUDIT_NEWEMP( P_FIRST_NAME varchar2, P_LAST_NAME varchar2 ) IS
    pragma autonomous_transaction;
  BEGIN
    INSERT INTO LOG_NEWEMP ( ENTRY_ID, USER_ID, LOG_TIME, NAME )
    VALUES( LOG_NEWEMP_SEQ.NEXTVAL, USER, SYSDATE, P_FIRST_NAME || ' ' || P_LAST_NAME );
    commit;
  end AUDIT_NEWEMP;

  FUNCTION VALID_DEPTID( DEP_ID NUMBER ) RETURN BOOLEAN AS
      V_RESULT BOOLEAN;
      V_DEP_ID NUMBER:= 0;
      CURSOR TMP
      IS 
        SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE DEPARTMENT_ID = DEP_ID;
    BEGIN
      OPEN TMP;
        FETCH TMP INTO V_DEP_ID;
        IF TMP%NOTFOUND THEN
          v_result:= false;
        ELSE
          v_result:= true;
        END IF;
      CLOSE TMP;
      
      return V_RESULT;
      
    END VALID_DEPTID;
    

  PROCEDURE ADD_EMPLOYEE(
      FIRST_NAME EMPLOYEES.FIRST_NAME%type,
      LAST_NAME EMPLOYEES.LAST_NAME%type,
      EMAIL EMPLOYEES.EMAIL%type,
      DEPTID EMPLOYEES.DEPARTMENT_ID%type DEFAULT 30,
      job EMPLOYEES.JOB_ID%type DEFAULT 'SA_REP',
      MGR EMPLOYEES.MANAGER_ID%type DEFAULT 145,
      SAL EMPLOYEES.SALARY%type DEFAULT 1000,
      COMM EMPLOYEES.COMMISSION_PCT%type DEFAULT 0 )
  AS
    V_HIRE_DATE DATE;
  BEGIN
    V_HIRE_DATE:= TRUNC(sysdate);
    IF VALID_DEPTID( DEPTID ) THEN
      AUDIT_NEWEMP( FIRST_NAME, LAST_NAME );
      INSERT INTO EMPLOYEES(EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID,
                            SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID )
      VALUES(EMPLOYEES_SEQ.NEXTVAL, FIRST_NAME, LAST_NAME, EMAIL, V_HIRE_DATE, job, SAL, COMM, MGR, DEPTID);
    ELSE
      dbms_output.put_line( 'Такого отдела нет' );
    end if;
  end ADD_EMPLOYEE;
  
  
  PROCEDURE ADD_EMPLOYEE(
    FIRSTNAME EMPLOYEES.FIRST_NAME%type,
    LASTNAME EMPLOYEES.LAST_NAME%type,
    department EMPLOYEES.DEPARTMENT_ID%type )
  IS
    v_mail EMPLOYEES.EMAIL%type;
  BEGIN
    V_MAIL:= SUBSTR( FIRSTNAME, 1, 1 ) || SUBSTR( LASTNAME, 1, 7 );
    
    ADD_EMPLOYEE( FIRSTNAME, FIRSTNAME, V_MAIL, department );

  END ADD_EMPLOYEE;
  
  
  PROCEDURE GET_EMPLOYEE(
    V_EMP IN EMPLOYEES.EMPLOYEE_ID%TYPE,
    V_JOB_ID OUT EMPLOYEES.JOB_ID%TYPE,
    V_SALARY OUT EMPLOYEES.SALARY%TYPE
  ) AS
  BEGIN
    SELECT JOB_ID, SALARY INTO V_JOB_ID, V_SALARY FROM EMPLOYEES
    where EMPLOYEE_ID = V_EMP;

  END GET_EMPLOYEE;
  
 
  FUNCTION GET_EMPLOYEE(
    P_EMP_ID EMPLOYEES.EMPLOYEE_ID%TYPE 
  ) RETURN EMPLOYEES%ROWTYPE IS
  TMP EMPLOYEES%ROWTYPE;
  BEGIN
    SELECT * INTO TMP FROM EMPLOYEES
    WHERE EMPLOYEE_ID = P_EMP_ID;
    
    RETURN TMP;
    
  EXCEPTION  
    WHEN no_data_found THEN
    DBMS_OUTPUT.PUT_LINE( 'Ничего не найдено' );
    RETURN NULL;
    
  END GET_EMPLOYEE;


  FUNCTION GET_EMPLOYEE(
    P_FAMILY_NAME EMPLOYEES.LAST_NAME%TYPE 
  ) return employees%rowtype 
  IS
    
  TMP EMPLOYEES%ROWTYPE;
  
  BEGIN
    SELECT * INTO TMP FROM EMPLOYEES
      WHERE LAST_NAME = P_FAMILY_NAME;
    
    RETURN TMP;
    
  EXCEPTION  
    WHEN no_data_found THEN
      DBMS_OUTPUT.PUT_LINE( 'Ничего не найдено' );
    RETURN NULL;

  END GET_EMPLOYEE;
  

  PROCEDURE PRINT_EMPLOYEE( tmp employees%rowtype )IS
  BEGIN
    dbms_output.put_line( tmp.department_id || ' ' || tmp.employee_id || ' ' || tmp.first_name || ' '
    || tmp.last_name || ' ' || tmp.job_id || ' ' || tmp.salary );
  END PRINT_EMPLOYEE;

END EMP_PKG;


set serveroutput on
  
BEGIN
  compile_pkg.make('EMPLOYEE_REPORT');
END;
/

ROLLBACK;

select * from LOG_NEWEMP;


-- *********************************************************************************************************************
-- * Lab 12
-- *********************************************************************************************************************

CREATE OR REPLACE PROCEDURE CHECK_SALARY(
  P_JOB_ID JOBS.JOB_ID%TYPE, 
  p_SALARY EMPLOYEES.SALARY%type
) IS

  V_MIN_SALARY JOBS.MIN_SALARY%TYPE;
  V_MAX_SALARY jobs.MAX_SALARY%TYPE;

BEGIN
  
  SELECT MIN_SALARY, MAX_SALARY INTO V_MIN_SALARY, V_MAX_SALARY FROM JOBS
    WHERE JOB_ID = P_JOB_ID;
    
  IF P_SALARY NOT BETWEEN V_MIN_SALARY AND V_MAX_SALARY THEN
    RAISE_application_error( -20022, 'Invalid salary ' || P_SALARY || ' for this job. Salaries must be between '
    || V_MIN_SALARY || ' and ' || V_MAX_SALARY || '.');
  end if;
  
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      dbms_output.put_line( ' NOT FIND JOB_ID ' );
  
END;
/

CREATE OR REPLACE TRIGGER CHECK_SALARY_TRG
AFTER INSERT OR UPDATE ON EMPLOYEES
FOR EACH ROW
BEGIN
  CHECK_SALARY( :new.JOB_ID, :new.SALARY );
END;
/

------------------------------------------------------------------------------------------------------------------------

set serveroutput on
BEGIN
  EMP_PKG.ADD_EMPLOYEE( 'Eleanor', 'Berh', 30 ); /* ошибка так как зарплата по умолчанию
                                                    1000 отдел по умолчанию SA_REP min 6000 max 12000 */
END;
/

UPDATE employees SET salary = 2000 -- between 2500 and 5500.
where employee_id = 115;

UPDATE employees SET job_id  = 'HR_REP' -- HR_REP selary другая.
where employee_id = 115;

UPDATE employees SET salary = 2800 -- between 2500 and 5500.
WHERE employee_id = 115;

------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER CHECK_SALARY_TRG BEFORE
  INSERT OR UPDATE OF JOB_ID, SALARY ON EMPLOYEES 
  FOR EACH ROW WHEN ( 
    old.SALARY <> new.SALARY
    OR OLD.JOB_ID <> NEW.JOB_ID 
  )
  BEGIN
    CHECK_SALARY( :new.JOB_ID, :new.SALARY );
  END;
  /
  
set serveroutput on
BEGIN
  EMP_PKG.ADD_EMPLOYEE( 'Eleanor', 'Berh', 'EBEH', job=>'IT_PROG', SAL=>5000 );
END;
/

UPDATE employees SET salary = salary + 2000
where job_id = 'IT_PROG';

UPDATE employees SET salary  = 9000
where first_name = 'Eleanor' and last_name = 'Berh';

UPDATE employees SET job_id = 'ST_MAN' -- провалится
WHERE first_name = 'Eleanor' and last_name = 'Berh';

------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER DELETE_EMP_TRG AFTER
  DELETE ON EMPLOYEES
  BEGIN
    IF TO_CHAR(SYSDATE, 'HH24') BETWEEN 09 AND 18 THEN
      raise_application_error(-20020, 'My ERROR') ;    
    end if;
  END;
  /


-- *********************************************************************************************************************
-- * Lab 13
-- *********************************************************************************************************************

PROCEDURE SET_SALARY( 
    p_id_jobs employees.JOB_ID%TYPE, 
    p_min_SALARY employees.SALARY%TYPE 
  ) IS
    CURSOR cur_emp IS
      SELECT EMPLOYEE_ID FROM EMPLOYEES
        WHERE job_id = p_id_jobs AND salary < p_min_SALARY;
  BEGIN
    FOR i IN cur_emp loop
      UPDATE employees SET salary = p_min_salary
        where employee_id = i.employee_id; 
    end loop;
    
  end SET_SALARY;

CREATE OR REPLACE TRIGGER UPD_MINSALARY_TRG
AFTER UPDATE OF MIN_SALARY ON jobs
FOR EACH ROW
BEGIN
  emp_pkg.set_salary( :new.JOB_ID, :new.MIN_SALARY );
END;
/
UPDATE JOBS SET MIN_SALARY = MIN_SALARY + 3200
where JOB_ID = 'IT_PROG'; -- мутация таблиц

------------------------------------------------------------------------------------------------------------------------

create or replace
PACKAGE JOBS_PKG AS 

  PROCEDURE initialize;
	FUNCTION get_minsalary(jobid VARCHAR2) RETURN NUMBER;
	FUNCTION get_maxsalary(jobid VARCHAR2) RETURN NUMBER;
	PROCEDURE set_minsalary(jobid VARCHAR2, min_salary NUMBER);
	PROCEDURE SET_MAXSALARY(JOBID VARCHAR2, MAX_SALARY NUMBER);

END JOBS_PKG;


create or replace
PACKAGE BODY JOBS_PKG AS

  TYPE JOBS_TAB_TYPE IS TABLE OF 
    JOBS%ROWTYPE
  INDEX BY JOBS.JOB_ID%TYPE;
  
  jobstab JOBS_TAB_TYPE;

  PROCEDURE INITIALIZE AS
    CURSOR CUR_JOBS IS
      select * from jobs;
  BEGIN
    FOR I IN CUR_JOBS LOOP
      jobstab( i.JOB_ID ):= i;
    end loop;
    
  END initialize;

  FUNCTION get_minsalary(jobid VARCHAR2) RETURN NUMBER AS
  BEGIN
    RETURN jobstab( JOBID ).MIN_SALARY;
  END get_minsalary;

  FUNCTION get_maxsalary(jobid VARCHAR2) RETURN NUMBER AS
  BEGIN
    RETURN jobstab( JOBID ).MAX_SALARY;
  END get_maxsalary;

  PROCEDURE set_minsalary(jobid VARCHAR2, min_salary NUMBER) AS
  BEGIN
    jobstab( JOBID ).MAX_SALARY := min_salary;
  END set_minsalary;

  PROCEDURE SET_MAXSALARY(JOBID VARCHAR2, MAX_SALARY NUMBER) AS
  BEGIN
    JOBSTAB( JOBID ).MAX_SALARY := MAX_SALARY;  
  END SET_MAXSALARY;
  
  END JOBS_PKG;


create or replace
PROCEDURE CHECK_SALARY(
  P_JOB_ID JOBS.JOB_ID%TYPE, 
  p_SALARY EMPLOYEES.SALARY%type
) IS

  V_MIN_SALARY JOBS.MIN_SALARY%TYPE;
  V_MAX_SALARY jobs.MAX_SALARY%TYPE;

BEGIN
/*  
  SELECT MIN_SALARY, MAX_SALARY INTO V_MIN_SALARY, V_MAX_SALARY FROM JOBS
    WHERE JOB_ID = P_JOB_ID;
*/

  V_MIN_SALARY := JOBS_PKG.GET_MINSALARY( P_JOB_ID );
  V_MAX_SALARY := JOBS_PKG.GET_MAXSALARY( P_JOB_ID );
  
  IF P_SALARY NOT BETWEEN V_MIN_SALARY AND V_MAX_SALARY THEN
    RAISE_application_error( -20022, 'Invalid salary ' || P_SALARY || ' for this job. Salaries must be between '
    || V_MIN_SALARY || ' and ' || V_MAX_SALARY || '.');
  end if;
  
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_application_error( -20023, ' NOT FIND JOB_ID ' );
  
END;


CREATE OR REPLACE TRIGGER INIT_JOBPKG_TRG 
BEFORE INSERT OR UPDATE ON JOBS
BEGIN
   JOBS_PKG.INITIALIZE;
END;
/


SELECT * FROM JOBS
where JOB_ID = 'IT_PROG';

SELECT * FROM employees
WHERE JOB_ID = 'IT_PROG';

UPDATE JOBS SET MIN_SALARY = MIN_SALARY + 100
where JOB_ID = 'IT_PROG';

------------------------------------------------------------------------------------------------------------------------

set serveroutput on
BEGIN
  EMP_PKG.ADD_EMPLOYEE('Steven', 'Morse', 'SMORSE', sal=>6500); 
end;        -- ok так как salary 6000


-- *********************************************************************************************************************
-- * Lab 14
-- *********************************************************************************************************************

ALTER SESSION SET PLSQL_CODE_TYPE = 'native';
ALTER PROCEDURE ADD_JOB_HISTORY COMPILE;

ALTER PROCEDURE UNREACHABLE_CODE COMPILE;

BEGIN
  dbms_output.put_line( DBMS_WARNING.GET_CATEGORY(&eee) );
end;


-- *********************************************************************************************************************
-- * Lab 15
-- *********************************************************************************************************************

set serveroutput on
BEGIN
  DBMS_PREPROCESSOR.PRINT_POST_PROCESSED_SOURCE('PACKAGE', 'HR', 'MY_PKG');
end;

------------------------------------------------------------------------------------------------------------------------

set serveroutput on
BEGIN
  $IF DBMS_DB_VERSION.VER_LE_10_1 $THEN
    DBMS_OUTPUT.PUT_LINE('Unsupported database release.');
  $ELSE
    dbms_output.put_line('Release 11.1 is supported.');
  $end
END;
/

------------------------------------------------------------------------------------------------------------------------

  PACKAGE_TEXT varchar2(32767);
  
  function GENERATE_SPEC(PKGNAME varchar2) return varchar2 as
  begin
     return 'CREATE PACKAGE ' || PKGNAME || ' AS
       PROCEDURE raise_salary (emp_id NUMBER, amount NUMBER);
       PROCEDURE fire_employee (emp_id NUMBER);
       END ' || PKGNAME || ';';
  end GENERATE_SPEC;
  
function GENERATE_BODY(PKGNAME varchar2) return varchar2 as
  begin
     return 'CREATE PACKAGE BODY ' || PKGNAME || ' AS

     PROCEDURE raise_salary (emp_id NUMBER, amount NUMBER) IS
       BEGIN
         UPDATE employees SET salary = salary + amount WHERE employee_id = emp_id;
       END raise_salary;
     PROCEDURE fire_employee (emp_id NUMBER) IS
       BEGIN
         DELETE FROM employees WHERE employee_id = emp_id;
       END fire_employee;
     END ' || PKGNAME || ';';
  end GENERATE_BODY;
  
  begin
  
    PACKAGE_TEXT := GENERATE_SPEC('EMP_ACTIONS');
    
    
    DBMS_DDL.CREATE_WRAPPED(PACKAGE_TEXT);
    
    
    PACKAGE_TEXT := GENERATE_BODY('EMP_ACTIONS');
    
    
    DBMS_DDL.CREATE_WRAPPED(PACKAGE_TEXT);
    
    
  end;
/

begin
  EMP_ACTIONS.RAISE_SALARY(120,100);    //exception;
end;
/


-- *********************************************************************************************************************
-- * Lab 16
-- *********************************************************************************************************************

begin
  DEPTREE_FILL('PROCEDURE', user, 'add_job'); // зависимостей нет
end;
begin
  DEPTREE_FILL('FUNCTION', user, 'valid_deptid'); // зависимость от add_employees;
end;
select * from IDEPTREE;

------------------------------------------------------------------------------------------------------------------------

create table EMPS as 
  select * from EMPLOYEES;

alter table employees add (totsal number(9,2))

select OBJECT_NAME, OBJECT_TYPE, STATUS from USER_OBJECTS
where status = 'INVALID'


  PROCEDURE RECOMPILE IS
    V_RESULT VARCHAR2(200); 
  BEGIN
  
    FOR I IN ( SELECT OBJECT_NAME, OBJECT_TYPE FROM USER_OBJECTS
               WHERE STATUS = 'INVALID' AND OBJECT_TYPE <> 'PACKAGE BODY' ) LOOP
      v_result:= 'ALTER '|| I.OBJECT_TYPE || ' ' || I.OBJECT_NAME || ' COMPILE';
    END LOOP;
    EXECUTE IMMEDIATE V_RESULT;
  END RECOMPILE;


BEGIN
  COMPILE_PKG.RECOMPILE;
END;
/
