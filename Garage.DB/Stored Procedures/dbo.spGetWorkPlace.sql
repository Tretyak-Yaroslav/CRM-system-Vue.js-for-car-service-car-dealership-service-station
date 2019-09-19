SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

CREATE PROCEDURE [dbo].[spGetWorkPlace] @workShopID INT
AS BEGIN
    SET NOCOUNT ON;
   -- DECLARE @workShopID INT=1;
	DECLARE @DateNow DATE = GETDATE()
    SELECT wp.WorkPlaceID, wp.CalendarPluginsCode, wp.WorkPlaceName, wpt.WorkPlaceTypeID, wpt.WorkPlaceTypeName, ws.WorkShopID, ws.WorkShopName, CAST(@DateNow AS DATETIME)+ CAST(ws.DoWorkFrom AS DATETIME) DoWorkFrom, CAST(@DateNow AS DATETIME)+ CAST(ws.DoWorkTo AS DATETIME) AS DoWorkTo
    FROM Shop.WorkShop ws
         LEFT JOIN Shop.WorkPlace wp ON wp.WorkShopID=ws.WorkShopID
         LEFT JOIN Shop.WorkPlaceType wpt ON wpt.WorkPlaceTypeID=wp.WorkPlaceTypeID
    WHERE ws.WorkShopID=@WorkShopID;
END;

--EXEC spGetWorkPlace 1
GO
