SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

CREATE PROCEDURE [dbo].[spGetVehicleModel] @VendorID INT=0, @VehicleModelID INT = 0
AS BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SELECT vm.VendorID, vm.VehicleModelID, vm.VehicleModelName, vm.VehicleModelRange
	FROM dbo.VehicleModel vm
	WHERE (vm.VendorID = @VendorID OR @VendorID = 0) AND ( vm.VehicleModelID = @VehicleModelID OR @VehicleModelID = 0)
END

--EXEC spGetVehicleModel 1
GO
