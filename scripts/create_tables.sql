USE BikeRental
GO

Create Table City
(
C_ID int Not Null Identity(1,1) Constraint PK_City_ID Primary Key(C_ID),
C_NAME nvarchar(30) Not Null,
C_COEFF decimal(3,2) NOT NULL Constraint DF_City_Coeff Default 1.0,
Constraint CK_City_Coeff Check (C_COEFF > 0),
Constraint UQ_City_Name Unique (C_NAME),
Constraint CK_City_Name Check (LEN(TRIM(C_NAME)) > 0)
);

Create Table Model
(
M_ID int Not Null Identity(1,1) Constraint PK_Model_ID Primary Key(M_ID),
M_BRAND varchar(50) Not Null Constraint CK_Model_Brand Check (M_BRAND IN ('Stels', 'Aist', 'Racer')),
M_NAME varchar(100) Not Null,
M_PRICE decimal(6,2) Not Null,
M_TYPE nvarchar(20) Not Null,
Constraint CK_Model_Price Check (M_PRICE > 0),
Constraint CK_Model_Type Check (M_TYPE IN (N'детский', N'электро', N'городской')),
Constraint CK_Model_Name Check (LEN(TRIM(M_NAME)) > 0)
);

Create Table Station
(
S_ID int Not Null Identity(1,1) Constraint PK_Station_ID Primary Key(S_ID),
CityID int Not Null Constraint FK_Station_City Foreign Key references City(C_ID) ON DELETE NO ACTION,
S_ADDRESS nvarchar(100) Not Null,
S_PLACES int Not Null,
Constraint UQ_Station_Address Unique (S_ADDRESS),
Constraint CK_Station_Places Check (S_PLACES >= 100 AND S_PLACES <= 999),
Constraint CK_Station_Address Check (LEN(TRIM(S_ADDRESS)) > 0)
);

Create Table Bike
(
B_NUMBER int Not Null Constraint PK_Bike_Number Primary Key(B_NUMBER),
ModelID int Not Null Constraint FK_Bike_Model Foreign Key references Model(M_ID),
StationID int Not Null Constraint FK_Bike_Station Foreign Key references Station(S_ID),
B_MILEAGE int Not Null,
B_DATE date Not Null,
B_STATUS nvarchar(10) Not Null,
Constraint CK_Bike_Number Check (B_NUMBER > 0),
Constraint CK_Bike_Mileage Check (B_MILEAGE >= 0),
Constraint CK_Bike_Date Check (B_DATE > '2024-01-01' AND B_DATE <= GETDATE()),
Constraint CK_Bike_Status Check (LEN(TRIM(B_STATUS)) > 0)
);

Create Table Client
(
CL_ID int Not Null Identity(1,1) Constraint PK_Client_ID Primary Key(CL_ID),
CL_NAME nvarchar(100) Not Null,
CL_PHONE nvarchar(20) Not Null,
CL_DATE date Not Null,
CL_SUBTYPE nvarchar(10) Not Null Constraint DF_Client_Subtype Default N'Нет',
CL_PAYTYPE nvarchar(10) Null Constraint CK_Client_Paytype Check (CL_PAYTYPE Is Null OR CL_PAYTYPE IN (N'Карта', N'Кошелёк')),
CL_4LAST char(4) Null Constraint CK_Client_4Last Check (CL_4LAST Is Null OR CL_4LAST LIKE '[0-9][0-9][0-9][0-9]'),
CL_TOKEN nvarchar(100) Null,
CL_SUBEND date Null,
Constraint CK_Client_Date Check (CL_DATE > '2024-01-01' AND CL_DATE <= GETDATE()),
Constraint UQ_Client_Phone Unique (CL_PHONE),
Constraint CK_Client_Name Check (LEN(TRIM(CL_NAME)) > 0)
);

Create Table Rent
(
R_ID int Not Null Identity(1,1) Constraint PK_Rent_ID Primary Key(R_ID),
ClientID int Not Null Constraint FK_Rent_Client Foreign Key references Client(CL_ID) ON DELETE NO ACTION,
BikeNumber int Not Null Constraint FK_Rent_Bike Foreign Key references Bike(B_NUMBER) ON DELETE NO ACTION,
R_START datetime Not Null,
R_END datetime Null,
R_COST decimal(8,2) Null,
R_STATUS nvarchar(10) Null,
Constraint CK_Rent_Cost Check (R_COST Is Null OR R_COST >= 0),
Constraint CK_Rent_Status Check (R_STATUS IN (N'Активна', N'Завершена')),
Constraint CK_Rent_End Check (R_END Is Null OR R_END > R_START)
);

Create Table Department
(
D_ID int Not Null Identity(1,1) Constraint PK_Department_ID Primary Key(D_ID),
D_NAME nvarchar(50) Not Null,
Constraint UQ_Department_Name Unique (D_NAME),
Constraint CK_Department_Name Check (LEN(TRIM(D_NAME)) > 0)
);

Create Table Employee
(
E_NUMBER int Not Null Constraint PK_Employee_Number Primary Key(E_NUMBER),
StationID int Null Constraint FK_Employee_Station Foreign Key references Station(S_ID),
DepartmentID int Not Null Constraint FK_Employee_Department Foreign Key references Department(D_ID),
E_NAME nvarchar(100) Not Null,
E_POST nvarchar(50) Not Null,
E_SALARY decimal(8,2) Not Null,
E_BOSS bit Not Null Constraint DF_Employee_Boss Default '0',
Constraint CK_Employee_Number Check (E_NUMBER > 0),
Constraint CK_Employee_Salary Check (E_SALARY > 0),
Constraint CK_Employee_Name Check (LEN(TRIM(E_NAME)) > 0),
Constraint CK_Employee_Post Check (LEN(TRIM(E_POST)) > 0)
);