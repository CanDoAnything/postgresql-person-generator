CREATE TABLE person(
   ssn CHAR(9) NOT NULL PRIMARY KEY,
  sex_code CHAR(1),
  first_name VARCHAR(128),
  last_name VARCHAR(128),
  birthdate date,
  street_address VARCHAR(50),
  city_name VARCHAR(128),
  state_code CHAR(2),
  zip CHAR(5),
  net_worth_amount bigint
);
CREATE TABLE address (
  ID INT PRIMARY KEY NOT NULL,
  DEPT CHAR(50) NOT NULL,
  EMP_ID INT NOT NULL
);