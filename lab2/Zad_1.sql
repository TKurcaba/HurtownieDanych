-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2022-10-16 13:57:56.511

-- tables
-- Table: ClientDim
CREATE TABLE ClientDim (
    ID int  NOT NULL,
    phone_number int  NOT NULL,
    address varchar(50)  NOT NULL,
    name varchar(50)  NOT NULL,
    surname varchar(50)  NOT NULL,
    CONSTRAINT ClientDim_pk PRIMARY KEY  (ID)
);

-- Table: Courier_companyDim
CREATE TABLE Courier_companyDim (
    NIP int  NOT NULL,
    address varchar(50)  NOT NULL,
    name varchar(50)  NOT NULL,
    CONSTRAINT Courier_companyDim_pk PRIMARY KEY  (NIP)
);

-- Table: DateDim
CREATE TABLE DateDim (
    dateID int  NOT NULL,
    FullDate date  NOT NULL,
    day int  NOT NULL,
    month int  NOT NULL,
    year int  NOT NULL,
    CONSTRAINT DateDim_pk PRIMARY KEY  (dateID)
);

-- Table: Fact_sales
CREATE TABLE Fact_sales (
    ID int  NOT NULL,
    CourierCompanyID int  NOT NULL,
    ProductID bigint  NOT NULL,
    ClientID int  NOT NULL,
    dateID int  NOT NULL,
    CONSTRAINT Fact_sales_pk PRIMARY KEY  (ID)
);

-- Table: ProductDim
CREATE TABLE ProductDim (
    ISBN bigint  NOT NULL,
    publisher varchar(50)  NOT NULL,
    title varchar(50)  NOT NULL,
    author varchar(50)  NOT NULL,
    page_count int  NOT NULL,
    CONSTRAINT ProductDim_pk PRIMARY KEY  (ISBN)
);

-- foreign keys
-- Reference: Fact_sales_ClientDim (table: Fact_sales)
ALTER TABLE Fact_sales ADD CONSTRAINT Fact_sales_ClientDim
    FOREIGN KEY (ClientID)
    REFERENCES ClientDim (ID);

-- Reference: Fact_sales_Courier_companyDim (table: Fact_sales)
ALTER TABLE Fact_sales ADD CONSTRAINT Fact_sales_Courier_companyDim
    FOREIGN KEY (CourierCompanyID)
    REFERENCES Courier_companyDim (NIP);

-- Reference: Fact_sales_DateDim (table: Fact_sales)
ALTER TABLE Fact_sales ADD CONSTRAINT Fact_sales_DateDim
    FOREIGN KEY (dateID)
    REFERENCES DateDim (dateID);

-- Reference: Fact_sales_ProductDim (table: Fact_sales)
ALTER TABLE Fact_sales ADD CONSTRAINT Fact_sales_ProductDim
    FOREIGN KEY (ProductID)
    REFERENCES ProductDim (ISBN);

-- End of file.

