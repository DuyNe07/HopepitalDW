USE Hopepital_DW
;

/* Drop table dbo.DimTime */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.DimTime') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.DimTime 
;

/* Create table dbo.DimTime */
CREATE TABLE dbo.DimTime (
   [Time_key]  int IDENTITY  NOT NULL
,  [Time_ID]  int   NOT NULL
,  [Bill_year]  int   NULL
,  [Bill_quarter]  int   NULL
,  [Bill_month]  int   NULL
,  [Bill_day]  int   NULL
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
   [Doctor_key]  int   NOT NULL
,  [Doctor_ID]  int   NULL
,  [Doctor_name]  nvarchar(255)   NULL
,  [Department_key]  int   NULL
,  [RowIsCurrent]  nchar(1)   NOT NULL
,  [RowStartDate]  datetime   NOT NULL
,  [RowEndDate]  datetime   NOT NULL
, CONSTRAINT [PK_dbo.DimDoctor] PRIMARY KEY CLUSTERED 
( [Doctor_key] )
) ON [PRIMARY]
;

/* Drop table dbo.DimDepartment */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.DimDepartment') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.DimDepartment 
;

/* Create table dbo.DimDepartment */
CREATE TABLE dbo.DimDepartment (
   [Department_key]  int   NOT NULL
,  [Department_ID]  int   NOT NULL
,  [Department_name]  nvarchar(255)   NOT NULL
, CONSTRAINT [PK_dbo.DimDepartment] PRIMARY KEY CLUSTERED 
( [Department_key] )
) ON [PRIMARY]
;

/* Drop table dbo.DimPatient */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.DimPatient') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.DimPatient 
;

/* Create table dbo.DimPatient */
CREATE TABLE dbo.DimPatient (
   [Patient_key]  int IDENTITY  NOT NULL
,  [Patient_ID]  int   NULL
,  [Patient_name]  nvarchar(255)   NULL
,  [Patient_age]  float   NULL
,  [Patient_dob]  date   NULL
,  [Patient_sex]  nvarchar(255)   NULL
,  [Patient_address]  nvarchar(255)   NULL
,  [Patient_province]  nvarchar(255)   NULL
,  [Patient_creation_date]  date   NULL
,  [RowIsCurrent]  nchar(1)   NOT NULL
,  [RowStartDate]  datetime   NOT NULL
,  [RowEndDate]  datetime   NOT NULL
, CONSTRAINT [PK_dbo.DimPatient] PRIMARY KEY CLUSTERED 
( [Patient_key] )
) ON [PRIMARY]
;

/* Drop table dbo.DimItem */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.DimItem') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.DimItem 
;

/* Create table dbo.DimItem */
CREATE TABLE dbo.DimItem (
   [Item_key]  int IDENTITY  NOT NULL
,  [Item_ID]  nvarchar(10)   NOT NULL
,  [Item_name]  nvarchar(255)   NULL
,  [Item_price]  float   NULL
,  [Item_type]  nvarchar(255)   NULL
,  [RowIsCurrent]  nchar(1)   NOT NULL
,  [RowStartDate]  datetime   NOT NULL
,  [RowEndDate]  datetime   NOT NULL
, CONSTRAINT [PK_dbo.DimItem] PRIMARY KEY CLUSTERED 
( [Item_key] )
) ON [PRIMARY]
;

/* Drop table dbo.FactBill */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'dbo.FactBill') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE dbo.FactBill 
;

/* Create table dbo.FactBill */
CREATE TABLE dbo.FactBill (
   [Bill_key]  int  NOT NULL
,  [Bill_ID]  int   NULL
,  [Item_code]  nchar(20)   NULL
,  [Quantity]  float   NULL
,  [List_price]  float   NULL
,  [Vat_amount]  float   NULL
,  [Waiver_amount]  float   NULL
,  [Surcharge]  float   NULL
,  [Net_sale]  float   NULL
,  [Gross_sale]  float   NULL
,  [Time_key]  int   NULL
,  [Patient_key]  int   NULL
,  [Doctor_key]  int   NULL
,  [Item_key]  int   NULL
, CONSTRAINT [PK_dbo.FactBill] PRIMARY KEY NONCLUSTERED 
( [Bill_key] )
) ON [PRIMARY]
;


ALTER TABLE dbo.DimDoctor ADD CONSTRAINT
   FK_dbo_DimDoctor_Department_key FOREIGN KEY
   (
   Department_key
   ) REFERENCES DimDepartment
   ( Department_key )
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
   Patient_key
   ) REFERENCES DimPatient
   ( Patient_key )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactBill ADD CONSTRAINT
   FK_dbo_FactBill_Doctor_key FOREIGN KEY
   (
   Doctor_key
   ) REFERENCES DimDoctor
   ( Doctor_key )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE dbo.FactBill ADD CONSTRAINT
   FK_dbo_FactBill_Item_key FOREIGN KEY
   (
   Item_key
   ) REFERENCES DimItem
   ( Item_key )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
