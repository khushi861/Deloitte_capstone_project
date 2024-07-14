create database capstone;

use capstone; 

CREATE TABLE Customer (
	customerID INT PRIMARY KEY,
    Gender VARCHAR(10),
    SEniorCitizen BOOLEAN,
    Partner VARCHAR(10), 
    Dependents VARCHAR(10)
);


CREATE TABLE Account ( 
    customerID INT PRIMARY KEY, 
    Tenure INT, 
    Contract VARCHAR(20), 
    PaperlessBilling VARCHAR(10), 
    PaymentMethod VARCHAR(50), 
    MonthlyCharges FLOAT,
    TotalCharges FLOAT, 
    FOREIGN KEY (customerID) REFERENCES Customer(customerID) 
);

drop table Account;

CREATE TABLE Services ( 
	customerID INT PRIMARY KEY, 
    PhoneService VARCHAR(10), 
    MultipleLines VARCHAR(20), 
    InternetService VARCHAR(20), 
    OnlineSecurity VARCHAR(20), 
    OnlineBackup VARCHAR(20), 
    DeviceProtection VARCHAR(20), 
    TechSupport VARCHAR(20), 
    StreamingTV VARCHAR(20), 
    StreamingMovies VARCHAR(20), 
    FOREIGN KEY (customerID) REFERENCES Customer(customerID) 
); 

CREATE TABLE Churn ( 
	customerID INT PRIMARY KEY, 
    Churn VARCHAR(10), 
    FOREIGN KEY (customerID) REFERENCES Customer(customerID) 
); 

LOAD DATA INFILE "C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\CleanData\\Customer_demographics.csv"
INTO TABLE Customer
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(customerID, Gender, @SeniorCitizen, Partner, Dependents)
SET SeniorCitizen = IF(@SeniorCitizen='NaN', NULL, @SeniorCitizen);

LOAD DATA INFILE "C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\CleanData\\Customer_account_info.csv"
INTO TABLE Account
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(customerID, @Tenure, @Contract, @PaperlessBilling, @PaymentMethod, @MonthlyCharges, @TotalCharges)
SET 
	Tenure = IF(@Tenure='NaN', NULL, @Tenure),
    Contract= If(@Contract='NaN', NULL, @Contract), 
    PaperlessBilling= IF(@PaperlessBilling='NaN', NULL, @PaperlessBilling),
    PaymentMethod= IF(@PaymentMethod='NaN', NULL, @PaymentMethod),
    MonthlyCharges=IF(@MonthlyCharges='NaN', NULL, @MonthlyCharges),
    TotalCharges=IF(@TotalCharges='NaN',NULL, @TotalCharges);


LOAD DATA INFILE "C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\CleanData\\Customer_Churn.csv"
INTO TABLE Churn
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(customerID, @Churn)
SET Churn= IF(@Churn='NAN', NULL, @Churn);


LOAD DATA INFILE "C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\CleanData\\Customer_services.csv"
INTO TABLE Services
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(customerID, @PhoneService, MultipleLines, InternetService, @OnlineSecurity, OnlineBackup, DeviceProtection, @TechSupport, StreamingTV, StreamingMovies)
SET 
	PhoneService= IF(@PhoneService='NaN',NULL, @PhoneService),
    OnlineSecurity=IF(@OnlineSecurity='NaN', NULL, @OnlineSecurity),
    TechSupport= IF(@TechSupport='NaN', NULL, @TechSupport);


