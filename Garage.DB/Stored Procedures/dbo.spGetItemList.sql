SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetItemList] @itemCategoryID INT = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	SELECT i.ItemID,i.ItemCategoryID,i.ItemName,i.ItemDescription,i.ItemPrice
	FROM Service.ItemList i
	WHERE (i.ItemCategoryID = @itemCategoryID OR @itemCategoryID = 0)

END

--EXEC spGetItemList 0
GO
