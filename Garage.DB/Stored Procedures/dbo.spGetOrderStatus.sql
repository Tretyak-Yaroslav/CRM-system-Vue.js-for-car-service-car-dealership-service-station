SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetOrderStatus] @OrderStatusID INT = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT os.OrderStatusID,os.OrderStatusName
	FROM dbo.OrderStatus os
	WHERE os.OrderStatusID = @OrderStatusID OR @OrderStatusID = 0

END

--EXEC spGetOrderStatus 0
GO
