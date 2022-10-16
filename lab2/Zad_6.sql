-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2022-10-16 13:55:48.203

-- tables
-- Table: BrandDim
CREATE TABLE BrandDim (
    branID int  NOT NULL,
    name varchar(50)  NOT NULL,
    CONSTRAINT BrandDim_pk PRIMARY KEY  (branID)
);

-- Table: DateDim
CREATE TABLE DateDim (
    DateID int  NOT NULL,
    FullDate date  NOT NULL,
    day int  NOT NULL,
    month int  NOT NULL,
    year int  NOT NULL,
    CONSTRAINT DateDim_pk PRIMARY KEY  (DateID)
);

-- Table: ProductDim
CREATE TABLE ProductDim (
    productID int  NOT NULL,
    name varchar(50)  NOT NULL,
    BrandID int  NOT NULL,
    previousID int  NOT NULL,
    CONSTRAINT ProductDim_pk PRIMARY KEY  (productID)
);

-- Table: StateFact
CREATE TABLE StateFact (
    ID int  NOT NULL,
    warehouseID int  NOT NULL,
    effectiveDateID int  NOT NULL,
    productID int  NOT NULL,
    CONSTRAINT StateFact_pk PRIMARY KEY  (ID)
);

-- Table: WarehouseDim
CREATE TABLE WarehouseDim (
    warehouseID int  NOT NULL,
    address varchar(50)  NOT NULL,
    country varchar(30)  NOT NULL,
    CONSTRAINT WarehouseDim_pk PRIMARY KEY  (warehouseID)
);

-- foreign keys
-- Reference: ProductDim_BrandDim (table: ProductDim)
ALTER TABLE ProductDim ADD CONSTRAINT ProductDim_BrandDim
    FOREIGN KEY (BrandID)
    REFERENCES BrandDim (branID);

-- Reference: ProductDim_ProductDim (table: ProductDim)
ALTER TABLE ProductDim ADD CONSTRAINT ProductDim_ProductDim
    FOREIGN KEY (previousID)
    REFERENCES ProductDim (productID);

-- Reference: StateFact_DateDim (table: StateFact)
ALTER TABLE StateFact ADD CONSTRAINT StateFact_DateDim
    FOREIGN KEY (effectiveDateID)
    REFERENCES DateDim (DateID);

-- Reference: StateFact_ProductDim (table: StateFact)
ALTER TABLE StateFact ADD CONSTRAINT StateFact_ProductDim
    FOREIGN KEY (productID)
    REFERENCES ProductDim (productID);

-- Reference: StateFact_WarehouseDim (table: StateFact)
ALTER TABLE StateFact ADD CONSTRAINT StateFact_WarehouseDim
    FOREIGN KEY (warehouseID)
    REFERENCES WarehouseDim (warehouseID);

-- End of file.

