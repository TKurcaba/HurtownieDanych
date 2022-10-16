-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2022-10-16 13:25:11.952

-- tables
-- Table: EmployeeFact
CREATE TABLE EmployeeFact (
    employeeID int  NOT NULL,
    PESEL int  NOT NULL,
    address varchar(50)  NOT NULL,
    salary bigint  NOT NULL,
    CONSTRAINT EmployeeFact_pk PRIMARY KEY (employeeID)
);

-- Table: MarkDim
CREATE TABLE MarkDim (
    mark_sid int  NOT NULL,
    mark int  NOT NULL,
    Effective_date date  NOT NULL,
    current boolean  NOT NULL,
    employeeID intEmployeeFact_employeeID  NOT NULL,
    CONSTRAINT MarkDim_pk PRIMARY KEY (mark_sid)
);

-- foreign keys
-- Reference: MarkDim_EmployeeFact (table: MarkDim)
ALTER TABLE MarkDim ADD CONSTRAINT MarkDim_EmployeeFact
    FOREIGN KEY (employeeID)
    REFERENCES EmployeeFact (employeeID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- End of file.

