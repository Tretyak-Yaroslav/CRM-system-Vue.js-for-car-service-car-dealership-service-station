SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

CREATE PROCEDURE [dbo].[spGetVendor] @vendorID INT=0
AS BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;
    SELECT DISTINCT v.VendorID, v.VendorName
    FROM dbo.Vendor v LEFT JOIN dbo.VehicleModel vm ON vm.VendorID = v.VendorID
    WHERE(v.VendorID=@vendorID OR @vendorID=0)
		AND v.PC=1
		AND vm.VehicleModelID IS NOT NULL
	ORDER BY v.VendorName ASC
END;
--EXEC dbo.spGetVendor @vendorID=0
GO
