--DROP TABLE CARES_FOR;
--DROP TABLE CONCESSION;
--DROP TABLE EMPLOYEE;
--DROP TABLE ANIMAL;
--DROP TABLE ENCLOSURE;
--DROP TABLE HOURLY_RATE;
--DROP TABLE PARTICIPATES_IN;
--DROP TABLE REVENUE_EVENTS;
--DROP TABLE SPECIES;
--DROP TABLE ZOO_ADMISSION;
--DROP TABLE ANIMAL_SHOW;
--DROP TABLE REVENUE_TYPES;
--DROP TABLE BUILDING;

CREATE TABLE BUILDING(
Building_ID VARCHAR(10) NOT NULL,
Build_Name VARCHAR(30) NOT NULL,
Buid_Type VARCHAR(50) NOT NULL,
PRIMARY KEY (Building_ID)
) ;

CREATE TABLE REVENUE_TYPES(
RevenueTypes_ID VARCHAR(10) NOT NULL,
Rev_Name VARCHAR(30) NOT NULL,
Rev_Type VARCHAR(30) NOT NULL,
Building_ID VARCHAR(10) NOT NULL,
PRIMARY KEY (RevenueTypes_ID),
CONSTRAINT revt_fk_bui FOREIGN KEY (Building_ID) REFERENCES BUILDING(Building_ID)
) ;

CREATE TABLE HOURLY_RATE(
Hr_ID VARCHAR(10) NOT NULL,
Rate INT NOT NULL,
PRIMARY KEY (Hr_ID)
) ;

CREATE TABLE EMPLOYEE(
Emp_ID CHAR(9) NOT NULL,
Start_Date DATE NOT NULL,
JobType VARCHAR(15) NOT NULL,
Fname VARCHAR(15) NOT NULL,
Minit CHAR NOT NULL,
Lname VARCHAR(15) NOT NULL,
Street VARCHAR(30) NOT NULL,
City VARCHAR(15) NOT NULL,
State_Name VARCHAR(15) NOT NULL,
PinCode CHAR(5) NOT NULL,
Hr_ID VARCHAR(10) NOT NULL,
Super_ID CHAR(9),
RevenueTypes_ID VARCHAR(10),
PRIMARY KEY (Emp_ID),
CONSTRAINT emp_fk_hou FOREIGN KEY (Hr_ID) REFERENCES HOURLY_RATE(Hr_ID),
CONSTRAINT emp_fk_rty FOREIGN KEY (RevenueTypes_ID) REFERENCES REVENUE_TYPES(RevenueTypes_ID)
) ;

CREATE TABLE SPECIES(
Spc_ID VARCHAR(10) NOT NULL,
Spc_Name VARCHAR(30) NOT NULL,
Food_Cost INT,
PRIMARY KEY (Spc_ID),
UNIQUE (Spc_Name)
) ;

CREATE TABLE ENCLOSURE(
Enc_ID VARCHAR(10) NOT NULL,
Sq_ft INT NOT NULL,
Building_ID VARCHAR(10) NOT NULL,
PRIMARY KEY (Enc_ID,Building_ID),
CONSTRAINT enc_fk_bui FOREIGN KEY (Building_ID) REFERENCES BUILDING(Building_ID)
) ;

CREATE TABLE ANIMAL(
Ani_ID VARCHAR(10) NOT NULL,
Status VARCHAR(10) NOT NULL,
Birth_Year CHAR(4) NOT NULL,
Spc_ID VARCHAR(10) NOT NULL,
Enc_ID VARCHAR(10) NOT NULL,
Building_ID VARCHAR(10) NOT NULL,
PRIMARY KEY (Ani_ID),
CONSTRAINT ani_fk_spc FOREIGN KEY (Spc_ID) REFERENCES SPECIES(Spc_ID),
CONSTRAINT ani_fk_enc FOREIGN KEY (Enc_ID,Building_ID) REFERENCES ENCLOSURE(Enc_ID,Building_ID)
--CONSTRAINT ani_fk_encb FOREIGN KEY (Building_ID) REFERENCES ENCLOSURE(Building_ID)
) ;

CREATE TABLE REVENUE_EVENTS(
Date_Time DATE NOT NULL,
Revenue INT NOT NULL,
Tickets_Sold INT NOT NULL,
RevenueTypes_ID VARCHAR(10) NOT NULL,
PRIMARY KEY (Date_Time,RevenueTypes_ID),
CONSTRAINT reve_fk_revt FOREIGN KEY (RevenueTypes_ID) REFERENCES REVENUE_TYPES(RevenueTypes_ID)
) ;

CREATE TABLE ZOO_ADMISSION(
Child_Price INT NOT NULL,
Adult_Price INT NOT NULL,
Senior_Price INT NOT NULL,
RevenueTypes_ID VARCHAR(10) NOT NULL,
PRIMARY KEY (RevenueTypes_ID),
CONSTRAINT zoo_fk_revt FOREIGN KEY (RevenueTypes_ID) REFERENCES REVENUE_TYPES(RevenueTypes_ID)
) ;

CREATE TABLE CONCESSION(
Product VARCHAR(10) NOT NULL,
RevenueTypes_ID VARCHAR(10) NOT NULL,
PRIMARY KEY (RevenueTypes_ID),
CONSTRAINT con_fk_revt FOREIGN KEY (RevenueTypes_ID) REFERENCES REVENUE_TYPES(RevenueTypes_ID)
) ;

CREATE TABLE CARES_FOR(
Emp_ID CHAR(9) NOT NULL,
Spc_ID VARCHAR(10) NOT NULL,
PRIMARY KEY (Emp_ID,Spc_ID),
CONSTRAINT cf_fk_emp FOREIGN KEY (Emp_ID) REFERENCES EMPLOYEE(Emp_ID),
CONSTRAINT cf_fk_spc FOREIGN KEY (Spc_ID) REFERENCES SPECIES(Spc_ID)
) ;

CREATE TABLE ANIMAL_SHOW(
Child_Price INT NOT NULL,
Adult_Price INT NOT NULL,
Senior_Price INT NOT NULL,
Shows_Per_Day INT NOT NULL,
RevenueTypes_ID VARCHAR(10) NOT NULL,
PRIMARY KEY (RevenueTypes_ID),
CONSTRAINT anis_fk_revt FOREIGN KEY (RevenueTypes_ID) REFERENCES REVENUE_TYPES(RevenueTypes_ID)
) ;

CREATE TABLE PARTICIPATES_IN(
Spc_ID VARCHAR(10) NOT NULL,
RevenueTypes_ID VARCHAR(10) NOT NULL,
Num_spc_req INT NOT NULL,
PRIMARY KEY (Spc_ID,RevenueTypes_ID),
CONSTRAINT pi_fk_spc FOREIGN KEY (Spc_ID) REFERENCES SPECIES(Spc_ID),
CONSTRAINT pi_fk_anis FOREIGN KEY (RevenueTypes_ID) REFERENCES ANIMAL_SHOW(RevenueTypes_ID)
) ;