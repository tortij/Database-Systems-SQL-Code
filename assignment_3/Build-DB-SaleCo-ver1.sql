BEGIN TRANSACTION;

--======== CREATING TABLE STRUCTURES

CREATE TABLE VENDOR ( 
 V_CODE     INTEGER     NOT NULL UNIQUE, 
 V_NAME     VARCHAR(35) NOT NULL, 
 V_CONTACT  VARCHAR(15) NOT NULL, 
 V_AREACODE CHAR(3)     NOT NULL, 
 V_PHONE    CHAR(8)     NOT NULL, 
 V_STATE    CHAR(2)     NOT NULL, 
 V_ORDER    CHAR(1)     NOT NULL, 
 PRIMARY KEY (V_CODE));


CREATE TABLE PRODUCT ( 
 P_CODE     VARCHAR(10)  NOT NULL UNIQUE, 
 P_DESCRIPT VARCHAR(35)  NOT NULL, 
 P_INDATE   DATETIME     NOT NULL, 
 P_QOH      SMALLINT     NOT NULL,  
 P_MIN      SMALLINT     NOT NULL, 
 P_PRICE    NUMERIC(8,2) NOT NULL, 
 P_DISCOUNT NUMERIC(4,2) NOT NULL, 
 V_CODE     INTEGER, 
 PRIMARY KEY (P_CODE),
 FOREIGN KEY (V_CODE) REFERENCES VENDOR (V_CODE));

--======== CONSTRAINTS, CHECKS and DEFAULTS

CREATE TABLE CUSTOMER(
CUS_CODE       	INTEGER PRIMARY KEY,
CUS_LNAME       VARCHAR(15) NOT NULL,
CUS_FNAME       VARCHAR(15) NOT NULL,
CUS_INITIAL     CHAR(1),
CUS_AREACODE 	CHAR(3) DEFAULT '615' NOT NULL,
CUS_PHONE       CHAR(8) NOT NULL,
CUS_BALANCE     NUMERIC(9,2) DEFAULT 0.00,
CONSTRAINT CUS_UI1 UNIQUE(CUS_LNAME,CUS_FNAME));


CREATE TABLE INVOICE (
INV_NUMBER     	INTEGER PRIMARY KEY,
CUS_CODE        INTEGER NOT NULL,
INV_DATE        DATETIME NOT NULL,
FOREIGN KEY (CUS_CODE ) REFERENCES CUSTOMER(CUS_CODE));


CREATE TABLE LINE (
INV_NUMBER      INTEGER NOT NULL,
LINE_NUMBER     NUMERIC(2,0) NOT NULL,
P_CODE	        VARCHAR(10) NOT NULL,
LINE_UNITS      NUMERIC(9,2) DEFAULT 0.00 NOT NULL,
LINE_PRICE      NUMERIC(9,2) DEFAULT 0.00 NOT NULL,
PRIMARY KEY (INV_NUMBER,LINE_NUMBER),
FOREIGN KEY (INV_NUMBER) REFERENCES INVOICE (INV_NUMBER) ON DELETE CASCADE,
FOREIGN KEY (P_CODE) REFERENCES PRODUCT(P_CODE),
CONSTRAINT LINE_UI1 UNIQUE(INV_NUMBER, P_CODE));


--======== INDEXES

-- Q: Create index on P_INDATE
CREATE INDEX P_INDATEX ON PRODUCT(P_INDATE);

-- Q: Create composite index on V_CODE and P_CODE
CREATE INDEX VENPRODX ON PRODUCT(V_CODE,P_CODE);


--======== DATA ENTRY

COMMIT;

.read LoadRowsIntoDBver1.sql

--==== LOOK AT TABLES CREATED

.print "\nBelow are the tables that were created:"
.print "\n=============================================="
.tables
.print "\n"



