SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetQueryStatus] @queryStatusID INT = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT qs.QueryStatusID, qs.QueryStatusName, qs.QueryStatusColor
 	FROM Shop.QueryStatus qs
	WHERE qs.QueryStatusID = @queryStatusID OR @queryStatusID = 0

END

--EXEC [spGetQueryStatus] 0
GO
