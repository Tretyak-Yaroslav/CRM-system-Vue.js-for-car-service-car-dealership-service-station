CREATE TABLE [dbo].[Vehicle]
(
[VehicleID] [int] NOT NULL IDENTITY(1, 1),
[VehicleModelID] [int] NULL,
[VehicleVinNumber] [nvarchar] (50) COLLATE Cyrillic_General_CI_AS NULL,
[VehicleRegistrationNumber] [nvarchar] (20) COLLATE Cyrillic_General_CI_AS NULL,
[VehicleDescription] [nvarchar] (250) COLLATE Cyrillic_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Vehicle] ADD CONSTRAINT [PK_Vehicle] PRIMARY KEY CLUSTERED  ([VehicleID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Vehicle] ADD CONSTRAINT [fk_VehicleModification] FOREIGN KEY ([VehicleModelID]) REFERENCES [dbo].[VehicleModel] ([VehicleModelID])
GO
