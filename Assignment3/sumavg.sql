SET SERVEROUTPUT ON;
/*
DECLARE 
 x NUMBER;
 y NUMBER;
BEGIN
x:=&x;
y:=&y;
x:=x+y;
y:=x/2;
dbms_output.put_line('Sum is '|| x);
dbms_output.put_line('Average is '|| y);
END;
*/

/*
DECLARE
yr NUMBER;
BEGIN
yr:=&yr;
IF MOD(yr, 400)=0 THEN
dbms_output.put_line('Leap year');
ELSIF MOD(yr, 4)=0 AND MOD(yr, 100)<>0 THEN
dbms_output.put_line('Leap year');
ELSE
dbms_output.put_line('Not Leap Year');
END IF;
END;
*/
/*
DECLARE
sal NUMBER;
exp NUMBER;
BEGIN
sal:=&sal;
exp:=&exp;
IF exp>10 THEN
dbms_output.put_line('Bonus is: '||(sal/10 + 500));
ELSE 
dbms_output.put_line('Bonus is: '|| (sal/10));
END IF;
END;
*/
/*
DECLARE
basic NUMBER;
hra NUMBER;
da NUMBER;
BEGIN
basic:=&basic;
IF basic>15000 THEN
hra:=0.12*basic;
da:=0.08*basic;
ELSIF basic>12000 THEN
hra:=0.1*basic;
da:=0.06*basic;
ELSIF basic>9000 THEN
hra:=0.07*basic;
da:=0.04*basic;
ELSE
hra:=0.05*basic;
da:=200;
END IF;
dbms_output.put_line('hra is '||hra||' da is '||da||' net salary '||(basic-hra-da));
END;
*/
/*
DECLARE
pr NUMBER;
ti NUMBER;
i NUMBER;
amt NUMBER;
BEGIN
pr:=&pr;
ti:=&ti;
IF ti>10 THEN
i:=pr*0.08*ti;
amt:=pr+i;
ELSE
i:=pr*0.06*ti;
amt:=pr+i;
END IF;
dbms_output.put_line('interest is '||i||' amount is '||amt);
END;
*/
/*
DECLARE
nam employee.empname%type;
sal employee.salary%type;
num employee.empno%type;
BEGIN
num:=&num;
SELECT empname INTO nam FROM employee WHERE empno=num;
SELECT salary INTO sal FROM employee WHERE empno=num;
dbms_output.put_line('name is '||nam||' salary is '||sal);
END;
*/
/*
DECLARE
hig employee.salary%type;
lig employee.salary%type;
num employee.empno%type;
BEGIN
SELECT MAX(salary) INTO hig FROM employee;
SELECT MIN(salary) INTO lig FROM employee;
dbms_output.put_line('highest salary is '||hig||' lowest salary is '||lig);
END;
*/
/*
DECLARE
num employee.empno%type;
sal employee.salary%type;
BEGIN
num:=&num;
SELECT salary INTO sal FROM employee WHERE empno=num;
IF sal>5000 THEN
UPDATE employee
SET salary=salary+0.10*salary
WHERE empno=num;
ELSE
DELETE FROM employee WHERE empno=num;
END IF;
END;
*/
/*
DECLARE
dep employee.deptno%type;
BEGIN
dep:=&dep;
DELETE FROM employee WHERE deptno=dep;
END;
*/
/*
DECLARE
depn department.deptname%type;
buil department.building%type;
depc department.deptcode%type;
es department.estd%type;
BEGIN
INSERT INTO department(deptname, building, deptcode, estd) VALUES('&depn', '&buil', &depc, &es);
END;
*/
/*
DECLARE
empn employee.empname%type;
emp employee.empno%type;
sal employee.salary%type;
BEGIN
sal:=&sal;
SELECT empname,empno INTO empn,emp FROM employee WHERE salary=sal;
dbms_output.put_line('Emp name is '||empn||' Number is '||emp);
EXCEPTION
WHEN TOO_MANY_ROWS THEN
dbms_output.put_line('More than  one');
WHEN NO_DATA_FOUND THEN
dbms_output.put_line('No such employee');
END;
*/

DECLARE
x NUMBER;
y NUMBER;
e EXCEPTION;
BEGIN
x:=&x;
y:=&y;
IF y>x THEN
RAISE e;
END IF;
dbms_output.put_line('Output is '||x/y);
EXCEPTION
WHEN ZERO_DIVIDE THEN
dbms_output.put_line('Division by zero');
WHEN e THEN
dbms_output.put_line('y greater than x');
END;

COMMIT;