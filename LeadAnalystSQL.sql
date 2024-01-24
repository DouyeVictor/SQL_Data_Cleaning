CREATE DATABASE CARE;

--Viewing Tables
SELECT TOP 5*
FROM Clean_Client_Table$
--Deleting row where Age Group is 'Unknown'
DELETE FROM Clean_Client_Table$
WHERE [Age Group] = 'Unknown'
SELECT TOP 5*
FROM Clean_Date_Table$
SELECT TOP 5*
FROM Clean_Long_Term_Support_Table$
SELECT TOP 5*
FROM Clean_New_Admissions_Table$
SELECT TOP 5*
FROM Clean_Request_Table$  

SELECT*
FROM Care_Table

--Joining Data
SELECT
c.[Client Key],
c.[Age Group],
d.[Date],
d.[Day],
d.[Month],
d.[Year],
d.[Month Order],
d.[Fiscal Year],
d.[Quarter],
r.NewExisting,
r.RouteOfAccess,
r.SequelToRequest,
r.STSinPrevious6Months,
r.SALT_Year,
na.SettingClassification,
na.StartDate,
na.EndDate,
na.[Primary Support Reason],
na.PurchasingTeam,
lts.SupportType
INTO Care_Table
FROM Clean_Client_Table$ c
LEFT JOIN Clean_Request_Table$ r ON c.[Client Key] = r.[Client Key]
LEFT JOIN Clean_Date_Table$ d ON r.[Date] = d.[Date]
INNER JOIN [Clean_New_Admissions_Table$] na ON c.[Client Key] = na.[Client Key]
INNER JOIN [Clean_Long_Term_Support_Table$] lts ON c.[Client Key] = lts.[Client Key];

DELETE FROM Care_Table
WHERE [Date] is null 
and [Day] is null
and [Month] is null
and [Year] is null
and [Month Order] is null
and [Fiscal Year] is null
and [Quarter] is null
and NewExisting is null
and RouteOfAccess is null
and SequelToRequest is null
and STSinPrevious6Months is null
and SALT_Year is null

SELECT*
FROM Care_Table
