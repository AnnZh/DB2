USE AdventureWorks2012;
GO

--1
SELECT
Employee.BusinessEntityID,
Employee.OrganizationLevel,
Employee.JobTitle,
JobCandidate.JobCandidateID,
JobCandidate.Resume
FROM HumanResources.JobCandidate
INNER JOIN HumanResources.Employee
ON JobCandidate.BusinessEntityID = Employee.BusinessEntityID
WHERE JobCandidate.Resume IS NOT NULL 
GO

--2
SELECT Department.DepartmentID, 
Department.Name, 
COUNT(*) AS EmpCount
FROM HumanResources.Department
INNER JOIN HumanResources.EmployeeDepartmentHistory
ON Department.DepartmentID = EmployeeDepartmentHistory.DepartmentID
WHERE EmployeeDepartmentHistory.EndDate IS NULL
GROUP BY Department.DepartmentID, Department.Name
HAVING COUNT(*) > 10
GO

--3
SELECT Department.Name, 
Employee.HireDate, 
Employee.SickLeaveHours, 
SUM(Employee.SickLeaveHours) OVER (PARTITION BY Department.Name ORDER BY Employee.Hiredate) AS AccumulativeSum
FROM HumanResources.Employee
INNER JOIN HumanResources.EmployeeDepartmentHistory
ON Employee.BusinessEntityID = EmployeeDepartmentHistory.BusinessEntityID AND EmployeeDepartmentHistory.EndDate IS NULL
INNER JOIN HumanResources.Department
ON Department.DepartmentID = EmployeeDepartmentHistory.DepartmentID;
GO



