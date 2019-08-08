CREATE TABLE [dbo].[VehicleModel]
(
[VendorID] [int] NOT NULL,
[VehicleModelID] [int] NOT NULL IDENTITY(1, 1),
[VehicleModelName] [nvarchar] (100) COLLATE Cyrillic_General_CI_AS NULL,
[VehicleModelRange] [nvarchar] (20) COLLATE Cyrillic_General_CI_AS NULL,
[Sort] [int] NULL,
[PC] [bit] NULL,
[CV] [bit] NULL,
[AX] [bit] NULL,
[LCV] [bit] NULL,
[MC] [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[VehicleModel] ADD CONSTRAINT [PK_VehicleModel] PRIMARY KEY CLUSTERED  ([VehicleModelID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[VehicleModel] ADD CONSTRAINT [fk_VehicleModelVendor] FOREIGN KEY ([VendorID]) REFERENCES [dbo].[Vendor] ([VendorID])
GO
