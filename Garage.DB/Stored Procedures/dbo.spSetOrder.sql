SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

CREATE PROCEDURE [dbo].[spSetOrder] @orderID INT=0, @workShopID INT, @customerFullName NVARCHAR(100), @customerPhoneNumber NVARCHAR(100), @itemID INT, @orderDescription NVARCHAR(1000),
	@vehicleModelID INT, @vehicleModificationID INT = NULL, @vehicleRegistrationNumber NVARCHAR(100) = NULL, @employeeID INT = NULL, @EmployeeCreateOrderID INT = NULL,  @WorkPlaceID INT = NULL,
	@startTime DATETIME = NULL, @endTime DATETIME = NULL, @OrderStatusID INT = NULL, @vendorID INT =NULL
AS BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    --DECLARE	@workShopID INT = 1, @customerFullName NVARCHAR(100) = 'Вова', @customerPhoneNumber NVARCHAR(100) = '0974179250', @ServiceID INT =2,
    --													@orderDescription NVARCHAR(1000) = '????????????', @vehicleModelID INT = 1, @vehicleBrandID INT =1
    DECLARE @vehicleID INT, @customerID INT, @createDate DATETIME
    SELECT @createDate=GETDATE();
    --SELECT TOP 1 @employeeID=e.EmployeeID
    --FROM dbo.Employee e
    --WHERE e.WorkShopID=@WorkShopID AND e.EmployeePostID=2;
	--IF @WorkPlaceID IS NULL
	--BEGIN
	--	SELECT TOP 1 @WorkPlaceID=wp.WorkPlaceID
	--	FROM dbo.WorkPlace wp
	--	WHERE wp.WorkShopID=@WorkShopID;
	--END

    SELECT @customerID=c.CustomerID
    FROM dbo.Customer c
    WHERE RIGHT(c.CustomerPhoneNumber, 10)=RIGHT(@customerPhoneNumber, 10);
    IF @customerID IS NULL BEGIN
        INSERT INTO dbo.Customer(WorkShopID, CustomerFullName, CustomerPhoneNumber)
        VALUES(@workShopID, @customerFullName, @customerPhoneNumber);
        SELECT @customerID=@@IDENTITY;
    END;
    SELECT @vehicleID=v.VehicleID
    FROM dbo.Customer c
         LEFT JOIN dbo.CustomerVehicleBind cvb ON cvb.CustumerID=c.CustomerID AND @createDate BETWEEN cvb.BindFrom AND cvb.BindTo
         LEFT JOIN dbo.Vehicle v ON v.VehicleID=cvb.VehicleID
         LEFT JOIN dbo.VehicleModification vmn ON vmn.VehicleModificationID=v.VehicleModificationID
    WHERE vmn.VehicleModelID=@vehicleModelID AND c.CustomerID=@customerID --AND v.VehicleRegistrationNumber = @vehicleRegistrationNumber 
    IF @vehicleID IS NULL BEGIN
		IF @vehicleModificationID IS NULL 
		BEGIN
			SELECT TOP 1 @vehicleModificationID=vmn.VehicleModificationID
			FROM dbo.VehicleModification vmn
			WHERE vmn.VehicleModelID=@vehicleModelID;
		END
        INSERT INTO dbo.Vehicle(vehicleModificationID, VehicleVinNumber, VehicleRegistrationNumber, VehicleDescription)
        VALUES(@vehicleModificationID, NULL, @vehicleRegistrationNumber, NULL);
        SELECT @vehicleID=@@IDENTITY;
        INSERT INTO dbo.CustomerVehicleBind(CustumerID, VehicleID, BindFrom, BindTo)
        VALUES(@customerID, @vehicleID, DATEADD(DAY, -1, @createDate), DATEADD(YEAR, 25, @createDate));
    END;

	IF @orderID = 0
	BEGIN	
		INSERT dbo.[Order](VehicleID, WorkShopID, StartTime, EndTime, CreateDate, OrderStatusID, EmployeeCreateOrderID, OrderDescription)
		VALUES(@vehicleID, @WorkShopID, NULL, NULL, @createDate, 1, NULL, @orderDescription);
		SELECT @orderID=@@IDENTITY;
		INSERT INTO dbo.OrderDetail(OrderID, ItemID, UoM, Quantity, EmployeeID, WorkPlaceID)
		VALUES(@orderID, @itemID, NULL, NULL, NULL, NULL);
	END
	ELSE
	BEGIN
		UPDATE dbo.[Order]
		SET VehicleID=@vehicleID, StartTime=@startTime, EndTime=@endTime, OrderStatusID=@OrderStatusID,EmployeeCreateOrderID=@EmployeeCreateOrderID,OrderDescription=@orderDescription
		WHERE OrderID = @orderID
		UPDATE dbo.OrderDetail
		SET ItemID = @itemID,EmployeeID=@employeeID,WorkPlaceID=@WorkPlaceID
		WHERE OrderID = @orderID
	END
	SELECT @orderID;
END;

--EXEC dbo.spSetOrder 0, '1' , 'Вова', '0974179250', 2, 'testdesc', 95,NULL,56,'007'
--EXEC dbo.spSetOrder 58, '1' , 'Вова', '0974179250', 2, 'testdesc', 95,NULL,'007',1,5,1,'2019-08-03 9:00','2019-08-03 12:00',2


GO
