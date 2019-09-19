CREATE TABLE [Client].[VehicleModification]
(
[VehicleModificationID] [int] NOT NULL IDENTITY(1, 1),
[VehicleModelID] [int] NULL,
[Sort] [int] NULL,
[TypeName] [nvarchar] (100) COLLATE Cyrillic_General_CI_AS NULL,
[TypeRange] [nvarchar] (100) COLLATE Cyrillic_General_CI_AS NULL,
[Engines] [nvarchar] (400) COLLATE Cyrillic_General_CI_AS NULL,
[KW] [varchar] (50) COLLATE Cyrillic_General_CI_AS NULL,
[HP] [varchar] (50) COLLATE Cyrillic_General_CI_AS NULL,
[ccmTech] [int] NULL,
[Capacity] [float] NULL,
[Cylinders] [int] NULL,
[Valve] [int] NULL,
[Fuel] [nvarchar] (100) COLLATE Cyrillic_General_CI_AS NULL,
[EngineType] [nvarchar] (100) COLLATE Cyrillic_General_CI_AS NULL,
[FuelPreparation] [nvarchar] (100) COLLATE Cyrillic_General_CI_AS NULL,
[BodyType] [nvarchar] (100) COLLATE Cyrillic_General_CI_AS NULL,
[DriveType] [nvarchar] (100) COLLATE Cyrillic_General_CI_AS NULL,
[Tonnage] [float] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Client].[VehicleModification] ADD CONSTRAINT [PK_VehicleModification] PRIMARY KEY CLUSTERED  ([VehicleModificationID]) ON [PRIMARY]
GO
ALTER TABLE [Client].[VehicleModification] ADD CONSTRAINT [fk_VehicleModificationModel] FOREIGN KEY ([VehicleModelID]) REFERENCES [Client].[VehicleModel] ([VehicleModelID])
GO
