SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetOrder] @from DATETIME, @to DATETIME, @WorkShopID INT, @orderStatusID INT = 0, @notShortOrder INT = 1
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

			--DECLARE  @from DATETIME = '20190101', @to DATETIME = '20200101' , @stationID INT = 1

			SELECT o.OrderID, o.StartTime,o.EndTime,o.OrderStatusID, o.OrderDescription, o.CreateDate, os.OrderStatusName, e.EmployeeID, e.EmployeeLastName,e.EmployeeFirstName, 
			o.EmployeeCreateOrderID, ee.EmployeeLastName AS EmployeeCreateLastName, ee.EmployeeFirstName AS EmployeeCreateFirstName, ep.EmployeePostName, 
			v.VehicleID, v.VehicleRegistrationNumber,v.VehicleVinNumber, vmn.VehicleModificationID, vmn.TypeName, vmn.TypeRange, vm.VehicleModelID, vm.VehicleModelName, vm.VehicleModelRange, vr.VendorID,vr.VendorName,
			c.CustomerID,c.CustomerFullName, c.CustomerPhoneNumber, wp.WorkPlaceID, wp.WorkPlaceName, wp.CalendarPluginsCode, wpt.WorkPlaceTypeName, ws.WorkShopID, ws.WorkShopName, il.ItemID, il.ItemName
			FROM dbo.[Order] o LEFT JOIN dbo.OrderDetail od ON od.OrderID = o.OrderID
								LEFT JOIN dbo.OrderStatus os ON os.OrderStatusID = o.OrderStatusID
								LEFT JOIN dbo.Vehicle v ON v.VehicleID = o.VehicleID
								LEFT JOIN dbo.VehicleModification vmn ON vmn.VehicleModificationID = v.VehicleModificationID                               
								LEFT JOIN dbo.VehicleModel vm ON vm.VehicleModelID = vmn.VehicleModelID
								LEFT JOIN dbo.Vendor vr ON vr.VendorID = vm.VendorID
								LEFT JOIN dbo.CustomerVehicleBind cvb ON cvb.VehicleID = v.VehicleID
								LEFT JOIN dbo.Customer c ON c.CustomerID = cvb.CustumerID
								LEFT JOIN dbo.WorkPlace wp ON wp.WorkPlaceID = od.WorkPlaceID 
								LEFT JOIN dbo.WorkShop ws ON ws.WorkShopID = o.WorkShopID
								LEFT JOIN dbo.WorkPlaceType wpt ON wpt.WorkPlaceTypeID = wp.WorkPlaceTypeID
								LEFT JOIN dbo.Employee e ON e.EmployeeID = od.EmployeeID
								LEFT JOIN dbo.EmployeePost ep ON ep.EmployeePostID = e.EmployeePostID
								LEFT JOIN dbo.ItemList il ON il.ItemID = od.ItemID
								LEFT JOIN dbo.Employee ee ON ee.EmployeeID = o.EmployeeCreateOrderID
			WHERE ((CAST(o.CreateDate AS DATE) BETWEEN @from AND @to AND o.StartTime IS NULL) OR CAST(o.StartTime AS DATE) BETWEEN @from AND @to)
			AND o.WorkShopID =  @WorkShopID 
					AND (os.OrderStatusID = @orderStatusID OR @orderStatusID = 0 )
					 AND (os.OrderStatusID != @notShortOrder)
END
--EXEC dbo.spGetOrder '2019-07-01 14:29:00','2020-07-30 14:29:00',1,0,1
GO
