SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetRole] @employeeID INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT DISTINCT r2.RoleGroup,r2.Role AS RoleName,r2.RoleDescription,r2.RoleLevel
	FROM HumanResources.Role r LEFT JOIN HumanResources.AppRole ar ON ar.AppRole=r.Role
								INNER JOIN HumanResources.UserRole ur ON ur.Role = r.Role
								INNER JOIN HumanResources.Employee e ON e.EmployeeLogin = ur.EmployeeLogin
								LEFT JOIN HumanResources.Role r2 ON r2.Role = ISNULL(ar.Role,r.role)
	WHERE e.EmployeeID = @employeeID

END

--EXEC spGetRole 28


GO
