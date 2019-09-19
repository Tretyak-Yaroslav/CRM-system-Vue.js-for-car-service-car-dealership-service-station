CREATE TABLE [Shop].[WorkPlaceType]
(
[WorkPlaceTypeID] [int] NOT NULL IDENTITY(1, 1),
[WorkPlaceTypeName] [nvarchar] (150) COLLATE Cyrillic_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [Shop].[WorkPlaceType] ADD CONSTRAINT [PK__WorkPlac__89E997B86066E865] PRIMARY KEY CLUSTERED  ([WorkPlaceTypeID]) ON [PRIMARY]
GO
