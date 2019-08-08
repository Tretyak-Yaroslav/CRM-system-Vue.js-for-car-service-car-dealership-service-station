CREATE TABLE [dbo].[WorkShop]
(
[WorkShopID] [int] NOT NULL IDENTITY(1, 1),
[ParentWorkShopID] [int] NULL,
[DoWorkFrom] [time] NULL,
[DoWorkTo] [time] NULL,
[WorkShopName] [nvarchar] (150) COLLATE Cyrillic_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[WorkShop] ADD CONSTRAINT [PK__Station__E0D8A6DD6C2FF3C5] PRIMARY KEY CLUSTERED  ([WorkShopID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[WorkShop] ADD CONSTRAINT [fk_StationParent] FOREIGN KEY ([ParentWorkShopID]) REFERENCES [dbo].[WorkShop] ([WorkShopID])
GO
