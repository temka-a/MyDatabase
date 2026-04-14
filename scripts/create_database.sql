Create Database BikeRental
ON
(
NAME=BikeRental_data,
FILENAME='C:\Program Files\Microsoft SQL Server\MSSQL17.SQLEXPRESS\MSSQL\DATABikeRental.mdf',
SIZE=10MB,
MAXSIZE=100MB,
FILEGROWTH=5MB
)
LOG ON
(
NAME=BikeRental_log,
FILENAME='C:\Program Files\Microsoft SQL Server\MSSQL17.SQLEXPRESS\MSSQL\DATABikeRental.ldf',
SIZE=10MB,
MAXSIZE=100MB,
FILEGROWTH=5MB
);