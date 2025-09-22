create table customers(Customer_id text primary key,
Gender varchar(20),
Age int,
Married varchar(20),
State text,
Number_of_Referrals int,
Tenure_in_Months int,
Value_Deal text,
Phone_Service varchar(20),
Multiple_Lines varchar(20),
Internet_Service varchar(20),
Internet_Type varchar(30),
Online_Security varchar(20),
Online_Backup varchar(20),
Device_Protection_Plan varchar(20),
Premium_Support varchar(20),
Streaming_TV varchar(20),
Streaming_Movies varchar(20),
Streaming_Music varchar(20),
Unlimited_Data varchar(20),
Contract varchar (30),
Paperless_Billing varchar(20),
Payment_Method varchar(30),
Monthly_Charge Numeric,
Total_Charges Numeric,
Total_Refunds Numeric,
Total_Extra_Data_Charges int,
Total_Long_Distance_Charges Numeric,
Total_Revenue Numeric,
Customer_Status varchar(20),
Churn_Category varchar(30),
Churn_Reason text
);

-- \copy customers FROM 'C:/Users/Mousa/Downloads/Customer_Data.csv' DELIMITER ',' CSV HEADER;
-- OR --
/* \copy customers(Customer_id, Gender, Age, Married, State, Number_of_Referrals, Tenure_in_Months, Value_Deal,
Phone_Service, Multiple_Lines, Internet_Service, Internet_Type, Online_Security, Online_Backup,
Device_Protection_Plan, Premium_Support, Streaming_TV, Streaming_Movies, Streaming_Music, Unlimited_Data,
Contract, Paperless_Billing, Payment_Method, Monthly_Charge, Total_Charges, Total_Refunds,
Total_Extra_Data_Charges, Total_Long_Distance_Charges, Total_Revenue, Customer_Status, Churn_Category, Churn_Reason)
FROM 'C:/Users/Mousam/Downloads/customers.csv'
DELIMITER ',' CSV HEADER;*/



select * from customers;
select count(*) from customers;

SELECT Gender, Count(Gender) as TotalCount,
Count(Gender) * 1.0 / (Select Count(*) from customers)  as Percentage
from customers
Group by Gender;

SELECT Contract, Count(Contract) as TotalCount,
Count(Contract) * 1.0 / (Select Count(*) from customers)  as Percentage
from customers
Group by Contract;

SELECT Customer_Status, Count(Customer_Status) as TotalCount, Sum(Total_Revenue) as TotalRev,
Sum(Total_Revenue) / (Select sum(Total_Revenue) from customers) * 100  as RevPercentage
from customers
Group by Customer_Status;

SELECT State, Count(State) as TotalCount,
Count(State) * 1.0 / (Select Count(*) from customers)  as Percentage
from customers
Group by State
Order by Percentage desc;

-- NULL VALUES 
SELECT 
    SUM(CASE WHEN Customer_ID IS NULL THEN 1 ELSE 0 END) AS Customer_ID_Null_Count,
    SUM(CASE WHEN Gender IS NULL THEN 1 ELSE 0 END) AS Gender_Null_Count,
    SUM(CASE WHEN Age IS NULL THEN 1 ELSE 0 END) AS Age_Null_Count,
    SUM(CASE WHEN Married IS NULL THEN 1 ELSE 0 END) AS Married_Null_Count,
    SUM(CASE WHEN State IS NULL THEN 1 ELSE 0 END) AS State_Null_Count,
    SUM(CASE WHEN Number_of_Referrals IS NULL THEN 1 ELSE 0 END) AS Number_of_Referrals_Null_Count,
    SUM(CASE WHEN Tenure_in_Months IS NULL THEN 1 ELSE 0 END) AS Tenure_in_Months_Null_Count,
    SUM(CASE WHEN Value_Deal IS NULL THEN 1 ELSE 0 END) AS Value_Deal_Null_Count,
    SUM(CASE WHEN Phone_Service IS NULL THEN 1 ELSE 0 END) AS Phone_Service_Null_Count,
    SUM(CASE WHEN Multiple_Lines IS NULL THEN 1 ELSE 0 END) AS Multiple_Lines_Null_Count,
    SUM(CASE WHEN Internet_Service IS NULL THEN 1 ELSE 0 END) AS Internet_Service_Null_Count,
    SUM(CASE WHEN Internet_Type IS NULL THEN 1 ELSE 0 END) AS Internet_Type_Null_Count,
    SUM(CASE WHEN Online_Security IS NULL THEN 1 ELSE 0 END) AS Online_Security_Null_Count,
    SUM(CASE WHEN Online_Backup IS NULL THEN 1 ELSE 0 END) AS Online_Backup_Null_Count,
    SUM(CASE WHEN Device_Protection_Plan IS NULL THEN 1 ELSE 0 END) AS Device_Protection_Plan_Null_Count,
    SUM(CASE WHEN Premium_Support IS NULL THEN 1 ELSE 0 END) AS Premium_Support_Null_Count,
    SUM(CASE WHEN Streaming_TV IS NULL THEN 1 ELSE 0 END) AS Streaming_TV_Null_Count,
    SUM(CASE WHEN Streaming_Movies IS NULL THEN 1 ELSE 0 END) AS Streaming_Movies_Null_Count,
    SUM(CASE WHEN Streaming_Music IS NULL THEN 1 ELSE 0 END) AS Streaming_Music_Null_Count,
    SUM(CASE WHEN Unlimited_Data IS NULL THEN 1 ELSE 0 END) AS Unlimited_Data_Null_Count,
    SUM(CASE WHEN Contract IS NULL THEN 1 ELSE 0 END) AS Contract_Null_Count,
    SUM(CASE WHEN Paperless_Billing IS NULL THEN 1 ELSE 0 END) AS Paperless_Billing_Null_Count,
    SUM(CASE WHEN Payment_Method IS NULL THEN 1 ELSE 0 END) AS Payment_Method_Null_Count,
    SUM(CASE WHEN Monthly_Charge IS NULL THEN 1 ELSE 0 END) AS Monthly_Charge_Null_Count,
    SUM(CASE WHEN Total_Charges IS NULL THEN 1 ELSE 0 END) AS Total_Charges_Null_Count,
    SUM(CASE WHEN Total_Refunds IS NULL THEN 1 ELSE 0 END) AS Total_Refunds_Null_Count,
    SUM(CASE WHEN Total_Extra_Data_Charges IS NULL THEN 1 ELSE 0 END) AS Total_Extra_Data_Charges_Null_Count,
    SUM(CASE WHEN Total_Long_Distance_Charges IS NULL THEN 1 ELSE 0 END) AS Total_Long_Distance_Charges_Null_Count,
    SUM(CASE WHEN Total_Revenue IS NULL THEN 1 ELSE 0 END) AS Total_Revenue_Null_Count,
    SUM(CASE WHEN Customer_Status IS NULL THEN 1 ELSE 0 END) AS Customer_Status_Null_Count,
    SUM(CASE WHEN Churn_Category IS NULL THEN 1 ELSE 0 END) AS Churn_Category_Null_Count,
    SUM(CASE WHEN Churn_Reason IS NULL THEN 1 ELSE 0 END) AS Churn_Reason_Null_Count
FROM customers;
-- New Customers Table 

CREATE TABLE newcustomers AS
SELECT 
    Customer_ID,
    Gender,
    Age,
    Married,
    State,
    Number_of_Referrals,
    Tenure_in_Months,
    COALESCE(Value_Deal, 'None') AS Value_Deal,
    Phone_Service,
    COALESCE(Multiple_Lines, 'No') AS Multiple_Lines,
    Internet_Service,
    COALESCE(Internet_Type, 'None') AS Internet_Type,
    COALESCE(Online_Security, 'No') AS Online_Security,
    COALESCE(Online_Backup, 'No') AS Online_Backup,
    COALESCE(Device_Protection_Plan, 'No') AS Device_Protection_Plan,
    COALESCE(Premium_Support, 'No') AS Premium_Support,
    COALESCE(Streaming_TV, 'No') AS Streaming_TV,
    COALESCE(Streaming_Movies, 'No') AS Streaming_Movies,
    COALESCE(Streaming_Music, 'No') AS Streaming_Music,
    COALESCE(Unlimited_Data, 'No') AS Unlimited_Data,
    Contract,
    Paperless_Billing,
    Payment_Method,
    Monthly_Charge,
    Total_Charges,
    Total_Refunds,
    Total_Extra_Data_Charges,
    Total_Long_Distance_Charges,
    Total_Revenue,
    Customer_Status,
    COALESCE(Churn_Category, 'Others') AS Churn_Category,
    COALESCE(Churn_Reason, 'Others') AS Churn_Reason
FROM customers;

select * from newcustomers;

-- Create View 
CREATE VIEW vw_churndata AS
SELECT *
FROM newcustomers
WHERE Customer_Status IN ('Churned', 'Stayed');

CREATE VIEW vw_joindata AS
SELECT *
FROM newcustomers
WHERE Customer_Status = 'Joined';

select * from vw_churndata;
select * from vw_joindata;
