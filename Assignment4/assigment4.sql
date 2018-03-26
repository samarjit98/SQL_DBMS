/*
CREATE TABLE employee2(emp_id INT PRIMARY KEY, emp_name VARCHAR(20), emp_job VARCHAR(20), salary INT, dep_no INT);
*/

SET SERVEROUTPUT ON;
/*
DECLARE
CURSOR c1 IS SELECT * FROM employee2;
v_emp_id INT;
v_emp_name VARCHAR(20);
v_emp_job VARCHAR(20);
v_salary INT;
v_dep_no INT;
BEGIN 
OPEN c1;
LOOP 
   FETCH c1 INTO v_emp_id, v_emp_name, v_emp_job, v_salary, v_dep_no; 
      EXIT WHEN c1%notfound; 
      dbms_output.put_line(v_emp_id || ' ' || v_emp_name || ' ' || v_emp_job || ' ' || v_salary || ' ' || v_dep_no);
END LOOP; 
CLOSE c1; 
END;
*/
/*
BEGIN
UPDATE employee2
SET salary= salary+0.08*salary
WHERE salary<1200;
UPDATE employee2
SET salary= salary+0.12*salary
WHERE salary>=1200 AND salary<2500;
UPDATE employee2
SET salary= salary+0.15*salary
WHERE salary>=2500 AND salary<4500;
UPDATE employee2
SET salary= salary+0.20*salary
WHERE salary>=4500;
END;
*/
/*
DECLARE 
v_inp INT;
v_emp_id INT;
v_emp_name VARCHAR(20);
v_emp_job VARCHAR(20);
v_salary INT;
v_dep_no INT;
CURSOR c2 IS SELECT * FROM employee2;
BEGIN
OPEN c2;
v_inp:=&v_inp;
LOOP 
   FETCH c2 INTO v_emp_id, v_emp_name, v_emp_job, v_salary, v_dep_no; 
      EXIT WHEN c2%notfound; 
      IF v_dep_no=v_inp THEN
      dbms_output.put_line(v_emp_id || ' ' || v_emp_name || ' ' || v_emp_job || ' ' || v_salary || ' ' || v_dep_no);
      END IF;
END LOOP; 
CLOSE c2;
END;
*/

/*
DECLARE 
v_emp_id INT;
v_emp_name VARCHAR(20);
v_emp_job VARCHAR(20);
v_salary INT;
v_dep_no INT;
bonus INT;
CURSOR c3 IS SELECT * FROM employee2;
BEGIN
OPEN c3;
LOOP 
   FETCH c3 INTO v_emp_id, v_emp_name, v_emp_job, v_salary, v_dep_no; 
      EXIT WHEN c3%notfound; 
      bonus:=v_salary*0.12;
      dbms_output.put_line(v_emp_name || ' ' || v_salary || ' ' || bonus);
END LOOP; 
CLOSE c3;
END;
*/
/*
CREATE OR REPLACE PROCEDURE Multi_table(x IN INT, y IN INT) IS 
cnt INT;
prod INT;
BEGIN 
  cnt:=1;
  WHILE cnt<=y
  LOOP
    prod:=x*cnt;
    dbms_output.put_line( x || '*' || cnt || '=' || prod);
    cnt:=cnt+1;
  END LOOP;
END Multi_table;
*/
/*
DECLARE 
x INT;
y INT;
BEGIN
x:=&x;
y:=&y;
Multi_table(x, y);
END;
*/
/*
CREATE OR REPLACE PROCEDURE proc1(p_dep_no IN INT, p_sum OUT INT) IS 
CURSOR c4 IS SELECT emp_name, salary, dep_no FROM employee2;
v_sum INT;
v_emp_name VARCHAR(20);
v_salary INT;
v_dep_no INT;
BEGIN 
  OPEN c4; 
  v_sum:=0;
  LOOP
  FETCH c4 INTO v_emp_name, v_salary, v_dep_no;
  EXIT WHEN c4%notfound;
  IF v_dep_no=p_dep_no THEN
  dbms_output.put_line(v_emp_name || ' ' || v_salary);
  v_sum:=v_sum+v_salary;
  END IF;
  END LOOP;
  p_sum:=v_sum;
  CLOSE c4;
END proc1;
*/
/*
DECLARE
v_dep INT;
v_sum INT;
BEGIN
v_dep:=&v_dep;
proc1(v_dep, v_sum);
dbms_output.put_line(v_sum);
END;
*/
/*
CREATE OR REPLACE PROCEDURE incr(x IN INT, y IN INT) IS
BEGIN
UPDATE employee2
SET salary=salary+y
WHERE emp_id=x;
END incr;
*/

/*
DECLARE
x INT;
y INT;
BEGIN
x:=&x;
y:=&y;
incr(x, y);
END;
*/
/*
CREATE OR REPLACE FUNCTION powr(x IN INT, y IN INT)
RETURN INT
IS
cnt INT;
ret INT;
BEGIN
cnt:=1;
ret:=1;
WHILE cnt<=y
LOOP
ret:=ret*x;
cnt:=cnt+1;
END LOOP;
RETURN ret;
END powr;
*/
/*
DECLARE
x INT;
y INT;
BEGIN
x:=&x;
y:=&y;
dbms_output.put_line(powr(x, y));
END;
*/
/*
CREATE TABLE employee3(emp_id INT, emp_name VARCHAR(20), join_date DATE, salary INT);
*/
/*
CREATE OR REPLACE TRIGGER CHECK_DATE BEFORE INSERT ON employee3
FOR EACH ROW 
WHEN (NEW.join_date<sysdate)
BEGIN
:NEW.join_date:=sysdate;
dbms_output.put_line('Wrong date');
END;
*/
/*
INSERT INTO employee3 VALUES(1, 'Sammy', '12-MAR-2017', 1500);
INSERT INTO employee3 VALUES(2, 'Vipin', '27-MAR-2018', 10000);
*/
/*
CREATE OR REPLACE TRIGGER FIRING_IS_AWESOME BEFORE INSERT ON employee3
BEGIN
dbms_output.put_line('AK 47');
END;
*/
/*
INSERT INTO employee3 VALUES(3, 'Amit', '12-MAR-2017', 15000);
*/
/*
CREATE TABLE emp_dept(emp_name VARCHAR(20), dep_n0 INT);
*/
/*
CREATE OR REPLACE TRIGGER REDUN_KARO BEFORE INSERT ON employee2
FOR EACH ROW
BEGIN
INSERT INTO emp_dept VALUES( :NEW.emp_name, :NEW.dep_no);
END;
*/

INSERT INTO employee2 VALUES(2, 'Vipin', 'SE2', 15000, 3);