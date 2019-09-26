SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

CREATE PROCEDURE [dbo].[spSetQuery] @queryID INT=0, @workShopID INT, @customerFullName NVARCHAR(100), @customerPhoneNumber NVARCHAR(20), @itemID INT, @queryDescription NVARCHAR(1000),
@vehicleModelID INT, @vehicleModificationID INT=NULL, @vehicleRegistrationNumber NVARCHAR(100) =NULL, @employeeID INT=NULL, @employeeMasterID INT=NULL, @workPlaceID INT=NULL, 
@startTime DATETIME=NULL, @endTime DATETIME=NULL, @queryStatusID INT=1, @vendorID INT=NULL, @querySource NVARCHAR(100) = NULL, @vehicleID INT = NULL, @customerID INT = NULL, @IsDeleted BIT = NULL
AS BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET XACT_ABORT, NOCOUNT ON;
    BEGIN TRY
        --DECLARE	@workShopID INT = 1, @customerFullName NVARCHAR(100) = 'Вова', @customerPhoneNumber NVARCHAR(100) = '0974179250', @ServiceID INT =2,
        --													@orderDescription NVARCHAR(1000) = '????????????', @vehicleModelID INT = 1, @vehicleBrandID INT =1

		 
        DECLARE @createDate DATETIME, @orderCrossPeriod INT= 0;
        SELECT @createDate=GETDATE();

        SELECT TOP(1) @orderCrossPeriod = q.QueryID
        FROM Shop.Query q
        WHERE ((q.StartTime > @startTime AND q.StartTime < @endTime) 
		OR (q.EndTime > @startTime AND q.EndTime < @endTime) 
		OR (q.StartTime = @startTime AND q.EndTime = @endTime)
		OR (q.StartTime = @startTime AND q.EndTime > @endTime)) AND 
		q.WorkShopID = @workShopID AND q.WorkPlaceID = @workPlaceID AND q.QueryID <> @queryID
        ORDER BY q.StartTime DESC;

        IF(@orderCrossPeriod > 0)	
		BEGIN
            DECLARE @str NVARCHAR(100);
            SELECT @str=CONCAT('Вибраний період пересікається із заявкою:  ', CAST(@orderCrossPeriod AS NVARCHAR(100)));
            RAISERROR(@str, 16, 1);
        END;

        --SELECT TOP 1 @employeeID=e.EmployeeID
        --FROM dbo.Employee e
        --WHERE e.WorkShopID=@WorkShopID AND e.EmployeePostID=2;
        --IF @WorkPlaceID IS NULL
        --BEGIN
        --	SELECT TOP 1 @WorkPlaceID=wp.WorkPlaceID
        --	FROM dbo.WorkPlace wp
        --	WHERE wp.WorkShopID=@WorkShopID;
        --END

		IF ISNULL(@customerID,0) = 0
		BEGIN
			SELECT @customerID=c.CustomerID
			FROM Client.Customer c
			WHERE RIGHT(c.CustomerPhoneNumber, 10)=RIGHT(@customerPhoneNumber, 10);
			
			IF @customerID IS NULL BEGIN
				INSERT INTO Client.Customer(WorkShopID, CustomerFullName, CustomerPhoneNumber)
				VALUES(@workShopID, @customerFullName, @customerPhoneNumber);
				SELECT @customerID=@@IDENTITY;
			END;
		END
		BEGIN
			UPDATE Client.Customer 
			SET CustomerFullName = @customerFullName, CustomerPhoneNumber = @customerPhoneNumber
			WHERE CustomerID = @customerID
		END

		IF ISNULL(@vehicleID,0) = 0
		BEGIN
			SELECT @vehicleID=v.VehicleID
			FROM Client.Customer c
					LEFT JOIN Client.CustomerVehicleBind cvb ON cvb.CustumerID=c.CustomerID AND @createDate BETWEEN cvb.BindFrom AND cvb.BindTo
					LEFT JOIN Client.Vehicle v ON v.VehicleID=cvb.VehicleID
			--LEFT JOIN dbo.VehicleModification vmn ON vmn.VehicleModificationID=v.VehicleModificationID
			WHERE v.VehicleModelID=@vehicleModelID AND c.CustomerID=@customerID AND v.VehicleRegistrationNumber=@vehicleRegistrationNumber;
			IF @vehicleID IS NULL BEGIN
				--IF @vehicleModificationID IS NULL 
				--BEGIN
				--	SELECT TOP 1 @vehicleModificationID=vmn.VehicleModificationID
				--	FROM dbo.VehicleModification vmn
				--	WHERE vmn.VehicleModelID=@vehicleModelID;
				--END
				INSERT INTO Client.Vehicle(VehicleModelID, VehicleVinNumber, VehicleRegistrationNumber, VehicleDescription)
				VALUES(@vehicleModelID, NULL, @vehicleRegistrationNumber, NULL);
				SELECT @vehicleID=@@IDENTITY;
				INSERT INTO Client.CustomerVehicleBind(CustumerID, VehicleID, BindFrom, BindTo)
				VALUES(@customerID, @vehicleID, DATEADD(DAY, -1, @createDate), DATEADD(YEAR, 25, @createDate));
			END
		END
		BEGIN
			UPDATE Client.Vehicle
			SET VehicleRegistrationNumber = @vehicleRegistrationNumber,VehicleModelID = @vehicleModelID
			WHERE VehicleID = @vehicleID
		END
		
        IF @queryID=0 BEGIN
			
			INSERT Shop.Query(VehicleID, WorkShopID, StartTime, EndTime, CreateDate, QueryStatusID, EmployeeMasterID, EmployeeID, WorkPlaceID, ItemID, QuerySource, QueryDescription)
			VALUES(@vehicleID,   @workShopID, @startTime,@endTime, @createDate, @queryStatusID, @employeeMasterID, @employeeID, @workPlaceID, @itemID, @querySource, @queryDescription)
            SELECT @queryID=@@IDENTITY;

            --INSERT dbo.[Order](VehicleID, WorkShopID, StartTime, EndTime, CreateDate, OrderStatusID, EmployeeCreateOrderID, OrderDescription)
            --VALUES(@vehicleID, @workShopID, @startTime, @endTime, @createDate, ISNULL(@orderStatusID, 1), @employeeCreateOrderID, @orderDescription);
            --INSERT INTO dbo.OrderDetail(OrderID, ItemID, UoM, Quantity, EmployeeID, WorkPlaceID)
            --VALUES(@queryID, @itemID, NULL, NULL, @employeeID, @workPlaceID);
        END;
        ELSE BEGIN
			UPDATE Shop.Query
			SET VehicleID=@vehicleID, StartTime=@startTime, EndTime=@endTime, QueryStatusID=@queryStatusID, EmployeeMasterID=@employeeMasterID, QueryDescription=@queryDescription,
				ItemID=@itemID, EmployeeID=@employeeID, WorkPlaceID=@workPlaceID, IsDeleted=@IsDeleted
			WHERE QueryID = @queryID
			
            --UPDATE dbo.[Order]
            --SET VehicleID=@vehicleID, StartTime=@startTime, EndTime=@endTime, OrderStatusID=@orderStatusID, EmployeeCreateOrderID=@employeeCreateOrderID, OrderDescription=@orderDescription
            --WHERE OrderID=@queryID;
            --UPDATE dbo.OrderDetail
            --SET ItemID=@itemID, EmployeeID=@employeeID, WorkPlaceID=@workPlaceID
            --WHERE OrderID=@queryID;
        END;
        SELECT @queryID;
    END TRY
    BEGIN CATCH
	  DECLARE @msg nvarchar(2048) = error_message()  
      RAISERROR (@msg, 16, 1)
    END CATCH;
END;

--EXEC dbo.spSetQuery 0, '1' , 'Вова', '0974179250', 2, 'testdesc', 95,NULL,'007',1,5,1,'2019-08-03 9:00','2019-08-03 12:00',2
--EXEC dbo.spSetQuery 237, '1' , 'Вова', '0974179250', 2, 'testdesc', 95,NULL,'007',1,5,1,'2019-08-03 9:00','2019-08-03 12:00',2
GO
