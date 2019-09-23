SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Andrey>
-- Create date: <Create Date,,Sept 13 2019>
-- Description:	<Description,, Get user by email>
-- =============================================
CREATE PROCEDURE [dbo].[spGetEmployeeByEmail] @email NVARCHAR(150)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT e.EmployeeID, e.EmployeeEMail, e.EmployeeBlocked
	FROM HumanResources.Employee e
	WHERE e.EmployeeEMail = @email

END
GO
