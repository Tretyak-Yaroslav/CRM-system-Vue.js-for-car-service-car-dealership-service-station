SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetRole] @emploeeID INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT r.RoleID, r.RoleGroupID, r.RoleName
	FROM dbo.UserRole ur INNER JOIN dbo.Role r ON r.RoleID = ur.RoleID
	WHERE ur.EmploeeID = @emploeeID

END

--EXEC spGetRole 5

GO
