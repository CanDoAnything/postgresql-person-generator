CREATE TABLE COMPANY(
   ID INT PRIMARY KEY NOT NULL,
   NAME TEXT NOT NULL,
   AGE INT NOT NULL,
   ADDRESS CHAR(50),
   SALARY REAL, 
   JOIN_DATE DATE
);

CREATE TABLE DEPARTMENT(
   ID INT PRIMARY KEY NOT NULL,
   DEPT CHAR(50) NOT NULL,
   EMP_ID INT NOT NULL
);

CREATE TABLE AUDIT( 
    EMP_ID INT NOT NULL, 
    ENTRY_DATE TEXT NOT NULL 
); 