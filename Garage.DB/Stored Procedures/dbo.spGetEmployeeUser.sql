SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetEmployeeUser] @workShopID INT, @employeeLogin NVARCHAR(50), @employeePwd NVARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT e.EmployeeID, e.EmployeeFirstName,e.EmployeeLastName,e.EmployeeLogin,e.EmployeePwd,e.EmployeePhone,e.EmployeeEMail,e.EmployeeEMailConfirmed,e.EmployeeBlocked,e.EmployeeLastLogined,e.EmployeeCreatedDate,e.WorkShopID
	FROM HumanResources.Employee e
	WHERE e.WorkShopID = @workShopID AND  e.EmployeeLogin = @EmployeeLogin AND e.EmployeePwd = @EmployeePwd

END


--EXEC spGetEmployeeUser 1,'engineer','engineer'
GO
