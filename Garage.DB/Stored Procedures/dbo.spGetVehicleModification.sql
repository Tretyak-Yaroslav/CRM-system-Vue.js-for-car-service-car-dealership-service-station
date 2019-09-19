SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetVehicleModification] @VehicleModificationID INT = 0, @VehicleModelID INT = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT vmn.VehicleModificationID,vmn.VehicleModelID,vmn.TypeName,vmn.TypeRange,vmn.Engines,vmn.KW,vmn.HP,vmn.ccmTech,vmn.Capacity,vmn.Cylinders,vmn.Valve,vmn.Fuel,vmn.EngineType,vmn.FuelPreparation,vmn.BodyType,vmn.DriveType,vmn.Tonnage
	FROM Client.VehicleModification vmn
	WHERE (vmn.VehicleModificationID = @VehicleModificationID OR @VehicleModificationID = 0) AND (vmn.VehicleModelID = @VehicleModelID OR @VehicleModelID = 0)

END

--EXEC dbo.spGetVehicleModification 0,1


GO
