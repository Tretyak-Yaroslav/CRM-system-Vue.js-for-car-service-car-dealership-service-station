SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

CREATE PROCEDURE [dbo].[spSetOrder] @WorkShopID INT, @CustomerFullName NVARCHAR(100), @CustomerPhoneNumber NVARCHAR(100), @ServiceID INT, @OrderDescription NVARCHAR(1000), @VehicleModelID INT, @VendorID INT
AS BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    --DECLARE	@workShopID INT = 1, @customerFullName NVARCHAR(100) = 'Вова', @customerPhoneNumber NVARCHAR(100) = '0974179250', @ServiceID INT =2,
    --													@orderDescription NVARCHAR(1000) = '????????????', @vehicleModelID INT = 1, @vehicleBrandID INT =1
    DECLARE @vehicleID INT, @customerID INT, @createDate DATETIME, @employeeID INT, @OrderID INT, @WorkPlaceID INT, @VehicleModificationID INT;
    SELECT @createDate=GETDATE();
    --SELECT TOP 1 @employeeID=e.EmployeeID
    --FROM dbo.Employee e
    --WHERE e.WorkShopID=@WorkShopID AND e.EmployeePostID=2;
    --SELECT TOP 1 @WorkPlaceID=wp.WorkPlaceID
    --FROM dbo.WorkPlace wp
    --WHERE wp.WorkShopID=@WorkShopID;

    SELECT @customerID=c.CustomerID
    FROM dbo.Customer c
    WHERE RIGHT(c.CustomerPhoneNumber, 10)=RIGHT(@CustomerPhoneNumber, 10);
    IF @customerID IS NULL BEGIN
        INSERT INTO dbo.Customer(WorkShopID, CustomerFullName, CustomerPhoneNumber)
        VALUES(@WorkShopID, @CustomerFullName, @CustomerPhoneNumber);
        SELECT @customerID=@@IDENTITY;
    END;
    SELECT @vehicleID=v.VehicleID
    FROM dbo.Customer c
         LEFT JOIN dbo.CustomerVehicleBind cvb ON cvb.CustumerID=c.CustomerID AND @createDate BETWEEN cvb.BindFrom AND cvb.BindTo
         LEFT JOIN dbo.Vehicle v ON v.VehicleID=cvb.VehicleID
         LEFT JOIN dbo.VehicleModification vmn ON vmn.VehicleModificationID=v.VehicleModificationID
    WHERE vmn.VehicleModelID=@VehicleModelID AND c.CustomerID=@customerID;
    IF @vehicleID IS NULL BEGIN
        SELECT TOP 1 @VehicleModificationID=vmn.VehicleModificationID
        FROM dbo.VehicleModification vmn
        WHERE vmn.VehicleModelID=@VehicleModelID;
        INSERT INTO dbo.Vehicle(VehicleModificationID, VehicleVinNumber, VehicleRegistrationNumber, VehicleDescription)
        VALUES(@VehicleModificationID, NULL, NULL, NULL);
        SELECT @vehicleID=@@IDENTITY;
        INSERT INTO dbo.CustomerVehicleBind(CustumerID, VehicleID, BindFrom, BindTo)
        VALUES(@customerID, @vehicleID, DATEADD(DAY, -1, @createDate), DATEADD(YEAR, 25, @createDate));
    END;
    INSERT dbo.[Order](VehicleID, StartTime, EndTime, CreateDate, OrderStatusID, EmployeeCreateOrderID, OrderDescription)
    VALUES(@vehicleID, NULL, NULL, @createDate, 1, NULL, @OrderDescription);
    SELECT @OrderID=@@IDENTITY;
    INSERT INTO dbo.OrderDetail(OrderID, ServiceID, UoM, Quantity, EmployeeID, WorkPlaceID)
    VALUES(@OrderID, @ServiceID, NULL, NULL, NULL, NULL);
    SELECT @OrderID;
END;

--EXEC dbo.spSetShortOrder '1' , 'Вова', '0974179250', 2, 'testdesc', 1,1
GO
