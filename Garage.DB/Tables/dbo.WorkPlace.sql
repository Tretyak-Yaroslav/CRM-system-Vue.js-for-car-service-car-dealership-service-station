CREATE TABLE [dbo].[WorkPlace]
(
[WorkPlaceID] [int] NOT NULL IDENTITY(1, 1),
[WorkShopID] [int] NOT NULL,
[WorkPlaceTypeID] [int] NOT NULL,
[CalendarPluginsCode] [varchar] (50) COLLATE Cyrillic_General_CI_AS NULL,
[WorkPlaceName] [nvarchar] (150) COLLATE Cyrillic_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[WorkPlace] ADD CONSTRAINT [PK__WorkPlac__0C3674E6E7B08D16] PRIMARY KEY CLUSTERED  ([WorkPlaceID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[WorkPlace] ADD CONSTRAINT [fk_Station] FOREIGN KEY ([WorkShopID]) REFERENCES [dbo].[WorkShop] ([WorkShopID])
GO
ALTER TABLE [dbo].[WorkPlace] ADD CONSTRAINT [FK_WorkPlace_WorkPlaceType] FOREIGN KEY ([WorkPlaceTypeID]) REFERENCES [dbo].[WorkPlaceType] ([WorkPlaceTypeID])
GO
