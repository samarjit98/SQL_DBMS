SET SERVEROUTPUT ON;
/*
CREATE TABLE student3(s_id INT PRIMARY KEY, fname VARCHAR2(20), lname VARCHAR2(20), street VARCHAR2(20), city VARCHAR2(20), zip VARCHAR2(20));
CREATE TABLE instructor3(ino INT, no_of_sections INT);

CREATE OR REPLACE PACKAGE school_api AS
SUBTYPE msg IS VARCHAR2(200);
PROCEDURE get_name_address(p_id IN student3.s_id%type, p_fname OUT student3.fname%type, p_lname OUT student3.lname%type
, p_street OUT student3.street%type, p_city OUT student3.city%type, p_zip OUT student3.zip%type);

FUNCTION instructor_status(p_ino IN instructor3.ino%type) RETURN msg;

PROCEDURE remove_student(p_id IN student3.s_id%type);

END school_api;
*/
/*
CREATE OR REPLACE PACKAGE BODY school_api AS

PROCEDURE get_name_address(p_id IN student3.s_id%type, p_fname OUT student3.fname%type, p_lname OUT student3.lname%type
, p_street OUT student3.street%type, p_city OUT student3.city%type, p_zip OUT student3.zip%type)
IS 
BEGIN
SELECT fname, lname, street, city, zip INTO p_fname, p_lname, p_street, p_city, p_zip FROM student3 WHERE s_id=p_id;
END get_name_address;

FUNCTION instructor_status(p_ino IN instructor3.ino%type) RETURN msg
IS
cnt INT;
BEGIN
SELECT no_of_sections INTO cnt FROM instructor3 WHERE ino=p_ino;
IF cnt >= 3 THEN
RETURN 'Vacation reqd!';
ELSE 
RETURN cnt||' '||'sections taught.';
END IF;
END instructor_status;

PROCEDURE remove_student(p_id IN student3.s_id%type)
IS
delete_error EXCEPTION;
BEGIN
DELETE FROM student3
WHERE s_id=p_id;
IF SQL%rowcount=0 THEN 
  RAISE delete_error;
END IF;
EXCEPTION
WHEN delete_error THEN
dbms_output.put_line('No data found!');
END remove_student;

END school_api;
*/

DECLARE 
r_id INT;
p_fname student3.fname%type;
p_lname student3.lname%type;
p_street student3.street%type; 
p_city student3.city%type;
p_zip student3.zip%type;
iid INT;
rev_id student3.fname%type;
BEGIN
r_id:=&r_id;
school_api.get_name_address(r_id, p_fname, p_lname, p_street, p_city, p_zip);
dbms_output.put_line(p_fname||' '||p_lname||' '||p_street||' '||p_city||' '||p_zip);
iid:=&iid;
dbms_output.put_line(school_api.instructor_status(iid));
rev_id:=&rev_id;
school_api.remove_student(rev_id);
END;




