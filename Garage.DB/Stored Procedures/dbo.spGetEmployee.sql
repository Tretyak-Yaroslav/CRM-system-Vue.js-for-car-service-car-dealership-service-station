SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetEmployee] @workShopID INT, @employeePostID INT 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT e.EmployeeID, e.EmployeeFirstName,e.EmployeeLastName,e.EmployeePostID,ep.EmployeePostName
	FROM dbo.Employee e LEFT JOIN dbo.EmployeePost ep ON ep.EmployeePostID = e.EmployeePostID
	WHERE e.WorkShopID = @workShopID AND e.EmployeePostID = @employeePostID

END


--EXEC spGetEmployee 1,2
GO
