SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Andrey>
-- Create date: <Create Date,, Sept 13 2019>
-- Description:	<Description,, Set new password for user by MD5>
-- =============================================
CREATE PROCEDURE [dbo].[spSetEmployeePassword] @EmployeeID INT, @password NVARCHAR(50)
AS BEGIN
	SET XACT_ABORT, NOCOUNT ON;
	  BEGIN TRY
		UPDATE HumanResources.Employee SET EmployeePwdHash = CONVERT(NVARCHAR(150),HASHBYTES('MD5', @password),2) WHERE EmployeeID = @EmployeeID;
	  END TRY
	  BEGIN CATCH
		 DECLARE @msg nvarchar(2048) = error_message()  
		 RAISERROR (@msg, 16, 1)
    END CATCH;

END

--EXEC dbo.spSetEmployeePassword 30,'768678678786778'
GO
