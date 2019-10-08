SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetQuery] @from DATETIME, @to DATETIME, @WorkShopID INT, @QueryStatusID INT = 0, @notShortQuery INT = 1, @queryID INT = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

			--DECLARE  @from DATETIME = '20190101', @to DATETIME = '20200101' , @stationID INT = 1

			SELECT q.QueryID, q.StartTime,q.EndTime,q.QueryStatusID, q.QueryDescription, q.CreateDate, q.ModificationDate, q.IsDeleted, qs.QueryStatusName, qs.QueryStatusColor, e.EmployeeID, e.EmployeeLastName,e.EmployeeFirstName, e.EmployeeColor,
			q.EmployeeMasterID, ee.EmployeeLastName AS EmployeeMasterLastName, ee.EmployeeFirstName AS EmployeeMasterFirstName, ee.EmployeeColor AS EmployeeMasterColor, ep.EmployeePostName, 
			v.VehicleID, v.VehicleRegistrationNumber,v.VehicleVinNumber,
			vm.VehicleModelID, vm.VehicleModelName, vm.VehicleModelRange, vr.VendorID,vr.VendorName,
			c.CustomerID,c.CustomerFullName, c.CustomerPhoneNumber, wp.WorkPlaceID, wp.WorkPlaceName, wp.CalendarPluginsCode, wpt.WorkPlaceTypeName, ws.WorkShopID, ws.WorkShopName, il.ItemID, il.ItemName
			FROM Shop.Query q 	LEFT JOIN Shop.QueryStatus qs ON qs.QueryStatusID = q.QueryStatusID
								LEFT JOIN Client.Vehicle v ON v.VehicleID = q.VehicleID
								LEFT JOIN Client.VehicleModel vm ON vm.VehicleModelID = v.VehicleModelID
								LEFT JOIN Client.Vendor vr ON vr.VendorID = vm.VendorID
								LEFT JOIN Client.CustomerVehicleBind cvb ON cvb.VehicleID = v.VehicleID
								LEFT JOIN Client.Customer c ON c.CustomerID = cvb.CustumerID
								LEFT JOIN Shop.WorkPlace wp ON wp.WorkPlaceID = q.WorkPlaceID 
								LEFT JOIN Shop.WorkShop ws ON ws.WorkShopID = q.WorkShopID
								LEFT JOIN Shop.WorkPlaceType wpt ON wpt.WorkPlaceTypeID = wp.WorkPlaceTypeID
								LEFT JOIN HumanResources.Employee e ON e.EmployeeID = q.EmployeeID
								LEFT JOIN HumanResources.EmployeePost ep ON ep.EmployeePostID = e.EmployeePostID
								LEFT JOIN Service.ItemList il ON il.ItemID = q.ItemID
								LEFT JOIN HumanResources.Employee ee ON ee.EmployeeID = q.EmployeeMasterID
			WHERE ((CAST(q.CreateDate AS DATE) BETWEEN @from AND @to AND q.StartTime IS NULL) OR CAST(q.StartTime AS DATE) BETWEEN @from AND @to)
			AND (q.QueryID = @QueryID OR  @QueryID = 0)
			AND q.WorkShopID =  @WorkShopID 
			AND (qs.QueryStatusID = @QueryStatusID OR @QueryStatusID = 0 )
			AND (qs.QueryStatusID != @notShortQuery)
			AND (q.IsDeleted IS NULL OR q.IsDeleted != 1 )
			
END
--EXEC dbo.[spGetQuery] '2019-07-01 14:29:00','2020-08-30 14:29:00',1,0,1
GO
