CREATE TABLE Publisher( publishername VARCHAR(20), city VARCHAR(20), country VARCHAR(20), telephonenumber VARCHAR(20), yearoffoundation INT);
CREATE TABLE Author( authornumber INT, authorname VARCHAR(20), dateofbirth DATE);
CREATE TABLE Book( booknumber INT, bookname VARCHAR(20), publishedyear INT, pages INT, cost1 INT, publishername VARCHAR(20));
CREATE TABLE Customer1( customernumber INT, customername VARCHAR(20), street VARCHAR(20), city VARCHAR(20), state VARCHAR(20), country VARCHAR(20));
CREATE TABLE Writing( booknumber INT, authornumber INT);
CREATE TABLE Sale( booknumber INT, customernumber INT, date1 DATE, price INT, quantity INT);

SELECT booknumber, bookname, pages FROM Book 
WHERE publishername='London Publishing';

SELECT COUNT(DISTINCT(booknumber)) FROM book, publisher
WHERE book.pages>=400 AND book.publishername= publisher.publishername AND publisher.city='Paris';

SELECT publisher.publishername FROM publisher, author, book, writing
WHERE (publisher.country='Belgium' OR publisher.country='Brazil' OR publisher.country='Singapore') AND publisher.publishername=book.publishername AND book.booknumber=writing.booknumber AND writing.authornumber=author.authornumber AND author.dateofbirth<'01-JAN-1920';

SELECT publisher.publishername, count(*) FROM publisher, book
WHERE publisher.publishername=book.publishername AND (publisher.country='India' OR publisher.country='Norway' OR (publisher.city='Nairobi' AND publisher.country='Kenya') OR (publisher.city='Auckland' AND publisher.country='New Zealand')) AND book.publishedyear=2001
GROUP BY publisher.publishername;

SELECT DISTINCT(publisher.publishername) FROM publisher, book
WHERE publisher.publishername=book.publishername AND book.publishedyear=(SELECT MIN(publishedyear) FROM book);

COMMIT;