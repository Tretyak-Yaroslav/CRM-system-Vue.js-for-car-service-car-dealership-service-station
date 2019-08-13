SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetRoleOneFild] @employeeID INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT r.RoleName
	FROM dbo.UserRole ur INNER JOIN dbo.Role r ON r.RoleID = ur.RoleID
	WHERE ur.EmploeeID = @employeeID

END

--EXEC spGetRoleOneFild 5

GO
