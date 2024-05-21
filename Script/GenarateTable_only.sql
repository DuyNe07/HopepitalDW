USE Hopepital_DW
;

/* Drop table dbo.DimTime */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.DimTime') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.DimTime 
;

/* Create table dbo.DimTime */
CREATE TABLE dbo.DimTime (
   [Time_key]  int  NOT NULL
,  [Bill_year]  int   NULL
,  [Bill_quarter]  int   NULL
,  [Bill_month]  int   NULL
,  [Bill_day]  int   NULL
,  [Bill_dayname] nvarchar(50) NULL
, CONSTRAINT [PK_dbo.DimTime] PRIMARY KEY CLUSTERED 
( [Time_key] )
) ON [PRIMARY]
;

/* Drop table dbo.DimDoctor */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.DimDoctor') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.DimDoctor 
;

/* Create table dbo.DimDoctor */
CREATE TABLE dbo.DimDoctor (
   [Doctor_ID]  int NOT NULL
,  [Doctor_name]  nvarchar(255)   NULL
,  [Department_ID]  int   NULL
,  [RowIsCurrent]  nchar(1) NULL
,  [RowStartDate]  datetime NULL
,  [RowEndDate]  datetime NULL
, CONSTRAINT [PK_dbo.DimDoctor] PRIMARY KEY CLUSTERED 
( [Doctor_ID] )
) ON [PRIMARY]
;

/* Drop table dbo.DimDepartment */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.DimDepartment') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.DimDepartment 
;

/* Create table dbo.DimDepartment */
CREATE TABLE dbo.DimDepartment (
   [Department_ID]  int NOT NULL
,  [Department_name]  nvarchar(255)   NOT NULL
, CONSTRAINT [PK_dbo.DimDepartment] PRIMARY KEY CLUSTERED 
( [Department_ID] )
) ON [PRIMARY]
;

/* Drop table dbo.DimPatient */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.DimPatient') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.DimPatient 
;

/* Create table dbo.DimPatient */
CREATE TABLE dbo.DimPatient (
   [Patient_ID]  int NOT NULL
,  [Patient_name]  nvarchar(255)   NULL
,  [Patient_age]  float   NULL
,  [Patient_dob]  datetime   NULL
,  [Patient_sex]  nvarchar(255)   NULL
,  [Patient_address]  nvarchar(255)   NULL
,  [Patient_province]  nvarchar(255)   NULL
,  [Patient_creation_date]  datetime   NULL
,  [RowIsCurrent]  nchar(1) NULL
,  [RowStartDate]  datetime NULL
,  [RowEndDate]  datetime NULL
, CONSTRAINT [PK_dbo.DimPatient] PRIMARY KEY CLUSTERED 
( [Patient_ID] )
) ON [PRIMARY]
;

/* Drop table dbo.DimItem */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.DimItem') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.DimItem 
;

/* Create table dbo.DimItem */
CREATE TABLE dbo.DimItem (
   [Item_Code]  nvarchar(255)   NOT NULL
,  [Item_name]  nvarchar(255)   NULL
,  [Item_price]  float   NULL
,  [Item_type]  nvarchar(255)   NULL
,  [RowIsCurrent]  nchar(1) NULL
,  [RowStartDate]  datetime NULL
,  [RowEndDate]  datetime NULL
, CONSTRAINT [PK_dbo.DimItem] PRIMARY KEY CLUSTERED 
( [Item_Code] )
) ON [PRIMARY]
;

/* Drop table dbo.FactBill */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.FactBill') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.FactBill 
;

/* Create table dbo.FactBill */
CREATE TABLE dbo.FactBill (
   [Bill_key]  int IDENTITY NOT NULL
,  [Bill_ID]  int  NULL
,  [Quantity]  float   NULL
,  [List_price]  float   NULL
,  [Vat_amount]  float   NULL
,  [Waiver_amount]  float   NULL
,  [Surcharge]  float   NULL
,  [Net_sale]  float   NULL
,  [Gross_sale]  float   NULL
,  [Time_key]  int   NULL
,  [Patient_ID]  int   NULL
,  [Doctor_ID]  int   NULL
,  [Item_Code]  nvarchar(255) NULL
, CONSTRAINT [PK_dbo.FactBill] PRIMARY KEY NONCLUSTERED 
( [Bill_key] )
) ON [PRIMARY]
;


ALTER TABLE dbo.DimDoctor ADD CONSTRAINT
   FK_dbo_DimDoctor_Department_key FOREIGN KEY
   (
   Department_ID
   ) REFERENCES DimDepartment
   ( Department_ID )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactBill ADD CONSTRAINT
   FK_dbo_FactBill_Time_key FOREIGN KEY
   (
   Time_key
   ) REFERENCES DimTime
   ( Time_key )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactBill ADD CONSTRAINT
   FK_dbo_FactBill_Patient_key FOREIGN KEY
   (
   Patient_ID
   ) REFERENCES DimPatient
   ( Patient_ID )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactBill ADD CONSTRAINT
   FK_dbo_FactBill_Doctor_key FOREIGN KEY
   (
   Doctor_ID
   ) REFERENCES DimDoctor
   ( Doctor_ID )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactBill ADD CONSTRAINT
   FK_dbo_FactBill_Item_key FOREIGN KEY
   (
   Item_Code
   ) REFERENCES DimItem
   ( Item_Code )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
-- Xóa các ràng buộc khóa ngoại từ bảng FactBill
ALTER TABLE FactBill 
DROP CONSTRAINT FK_dbo_FactBill_Item_key;

ALTER TABLE FactBill 
DROP CONSTRAINT FK_dbo_FactBill_Doctor_key;

ALTER TABLE FactBill 
DROP CONSTRAINT FK_dbo_FactBill_Patient_key;

ALTER TABLE FactBill 
DROP CONSTRAINT FK_dbo_FactBill_Time_key;

ALTER TABLE DimDoctor 
DROP CONSTRAINT FK_dbo_DimDoctor_Department_key;

TRUNCATE TABLE DimTime;
TRUNCATE TABLE DimDoctor;
TRUNCATE TABLE DimDepartment;
TRUNCATE TABLE DimPatient;
TRUNCATE TABLE DimItem;
TRUNCATE TABLE FactBill;