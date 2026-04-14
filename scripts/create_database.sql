Create Database BikeRental
ON
(
NAME=BikeRental_data,
FILENAME='<path>\BikeRental.mdf',
SIZE=10MB,
MAXSIZE=100MB,
FILEGROWTH=5MB
)
LOG ON
(
NAME=BikeRental_log,
FILENAME='<path>\BikeRental.ldf',
SIZE=10MB,
MAXSIZE=100MB,
FILEGROWTH=5MB
);