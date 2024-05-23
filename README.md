# Hopepital Datawarehouse

Data storage of invoice information of Children's Hospital

## Badges

![Static Badge](https://img.shields.io/badge/SSIS-1.3.2-yellow?link=https%3A%2F%2Fmarketplace.visualstudio.com%2Fitems%3FitemName%3DSSIS.MicrosoftDataToolsIntegrationServices)
![Static Badge](https://img.shields.io/badge/SSAS-3.0.15-blue?link=https%3A%2F%2Fmarketplace.visualstudio.com%2Fitems%3FitemName%3DProBITools.MicrosoftAnalysisServicesModelingProjects2022)

## Data decription

-   ERD Datawarehouse
    ![ERD](Database/DW-ERD.png)

Data is taken from data sources taken from hospitals. Hopefully, data is a collection of information about patients' medical examinations, transactions, services, accounts, clinics... compiled based on chemistry. hospital application in 2016.

To synthesize and store the above data for the purpose of analyzing operational situations, as well as supporting decision making. Therefore, the team conducted research and built a patient data warehouse to meet the hospital's needs.

## ETL from DBStore to DBStage

![ELT](Database/Load-from-DBStore-to-DBStage.png)

### 1. Clean data

Here is the general process for handling data cleansing:

-   Split tables from common data into separate tables
-   Delete duplicate lines
-   Remove the null value of the \_ID column to avoid errors in the primary key of the tables
-   Handle and replace null values for the remaining columns of each table
    ![cleandata](Database/Clean-data.png)

### 2. Load the temporary table that stores foreign key information

-   Select the invoice ID columns so that it can store information about each invoice detail, making it easy to create a fact table.
-   Do not delete duplicates here, because there will be service invoices used multiple times by the same patient and recorded at the same time.
-   For example: if a person uses hospital bed service for 4 nights, when recording the bill, it will be duplicated 4 times.
    ![stagefact](Database/Load-factbill-stage.png)

### 3. Load time stage

Load detailed date and time information in 2016 (year of invoice storage)
![timetable](Database/Load-time-stage.png)

## Load data to Data Warehouse

![dw](Database/Load-from-DBStage-to-DW.png)

1. First create the DW database from the dimension design excel file following link: [DimenstionDesign](Excel/Detailed-Dimensional-Modeling-Workbook-Hopepital.xlsm)
2. Remove foreign keys to avoid data binding errors
3. Truncate existing data in the DW beforehand to avoid adding duplicate data
4. Add data from DBStage to DW in order from outside to inside (dim -> fact)
5. Select the appropriate SCD Type for the dim panels
6. Add back the foreign key to ensure data binding

### 1. Design load data for Dim table type 1

![type1](Database/Load-from-DBStage-to-DW-Type1.png)

### 2. Design load data for Dim table type 2

![type2](Database/Load-from-DBStage-to-DW-Type2.png)

## Generate Cube

Create a cube to be able to observe the data warehouse in different dimensions of the data warehouse, easily for querying and analyzing with Excel or Power BI

### 1. Item Hierarchy

![ItemHierarchy](Database/ItemTypeHierarchy.png)

### 2. Date Hierarchy

![DateHierarchy](Database/DateHierarchy.png)

### 3. Patient Hierarchy

![PatientHierarchy](Database/PatientHierarchy.png)

### 4. Department Hierarchy

![DepartmentHierarchy](Database/DepartHierarchy.png)

### 5. Implement pivot table by loading Cube into excel

Excel file information according to the path [HopepitalSales.xlsx](Excel/HopepitalSales.xlsx)

## Power BI

Finally, perform data warehouse visualization using Power BI according to the path : [PowerBI](Hopepital_Report.pbix)

![SalesBI](Database/BI-Sales-report.png)
![PatientBI](Database/BI-Patient-report.png)
![DoctorBI](Database/BI-Doctor-report.png)

## Support

For support, email luongvudinhduy2003@gmail.com
