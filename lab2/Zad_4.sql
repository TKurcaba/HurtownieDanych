-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2022-10-16 13:09:08.028

-- tables
-- Table: CategoryDim
CREATE TABLE CategoryDim (
    categoryID int  NOT NULL,
    name varchar(25)  NOT NULL,
    CONSTRAINT CategoryDim_pk PRIMARY KEY (categoryID)
);

-- Table: ClientDim
CREATE TABLE ClientDim (
    NIP int  NOT NULL,
    name varchar(50)  NOT NULL,
    address varchar(50)  NOT NULL,
    CONSTRAINT ClientDim_pk PRIMARY KEY (NIP)
);

-- Table: Details
CREATE TABLE Details (
    DetailsID int  NOT NULL,
    OrderPlace varchar(50)  NOT NULL,
    SalesPlace varchar(50)  NOT NULL,
    price real  NOT NULL,
    CONSTRAINT Details_pk PRIMARY KEY (DetailsID)
);

-- Table: Fact_Sales
CREATE TABLE Fact_Sales (
    SalesID int  NOT NULL,
    FruitID int  NOT NULL,
    ClienID int  NOT NULL,
    SaleDateID int  NOT NULL,
    DetailsID int  NOT NULL,
    CONSTRAINT Fact_Sales_pk PRIMARY KEY (SalesID)
);

-- Table: FruitDim
CREATE TABLE FruitDim (
    FruitID int  NOT NULL,
    name varchar(50)  NOT NULL,
    price float  NOT NULL,
    quantity int  NOT NULL,
    categoryID int  NOT NULL,
    CONSTRAINT FruitDim_pk PRIMARY KEY (FruitID)
);

-- Table: MonthDim
CREATE TABLE MonthDim (
    MonthID int  NOT NULL,
    name varchar(15)  NOT NULL,
    CONSTRAINT MonthDim_pk PRIMARY KEY (MonthID)
);

-- Table: SaleDateDim
CREATE TABLE SaleDateDim (
    SaleDateID int  NOT NULL,
    FullDate date  NOT NULL,
    day int  NOT NULL,
    hour int  NOT NULL,
    monthID int  NOT NULL,
    CONSTRAINT SaleDateDim_pk PRIMARY KEY (SaleDateID)
);

-- foreign keys
-- Reference: Fact_Sales_ClientDim (table: Fact_Sales)
ALTER TABLE Fact_Sales ADD CONSTRAINT Fact_Sales_ClientDim
    FOREIGN KEY (ClienID)
    REFERENCES ClientDim (NIP)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Fact_Sales_Details (table: Fact_Sales)
ALTER TABLE Fact_Sales ADD CONSTRAINT Fact_Sales_Details
    FOREIGN KEY (DetailsID)
    REFERENCES Details (DetailsID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Fact_Sales_FruitDim (table: Fact_Sales)
ALTER TABLE Fact_Sales ADD CONSTRAINT Fact_Sales_FruitDim
    FOREIGN KEY (FruitID)
    REFERENCES FruitDim (FruitID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Fact_Sales_SaleDateDim (table: Fact_Sales)
ALTER TABLE Fact_Sales ADD CONSTRAINT Fact_Sales_SaleDateDim
    FOREIGN KEY (SaleDateID)
    REFERENCES SaleDateDim (SaleDateID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FruitDim_Category (table: FruitDim)
ALTER TABLE FruitDim ADD CONSTRAINT FruitDim_Category
    FOREIGN KEY (categoryID)
    REFERENCES CategoryDim (categoryID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: SaleDateDim_MonthDim (table: SaleDateDim)
ALTER TABLE SaleDateDim ADD CONSTRAINT SaleDateDim_MonthDim
    FOREIGN KEY (monthID)
    REFERENCES MonthDim (MonthID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- End of file.

