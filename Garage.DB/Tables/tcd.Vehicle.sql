CREATE TABLE [tcd].[Vehicle]
(
[TypeID] [int] NOT NULL,
[ModelID] [int] NULL,
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
