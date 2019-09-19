CREATE TABLE [Service].[ItemCategory]
(
[ItemCategoryID] [int] NOT NULL IDENTITY(1, 1),
[CtegoryTypeID] [int] NULL,
[ItemCategoryName] [nvarchar] (180) COLLATE Cyrillic_General_CI_AS NULL,
[ItemCategoryDescription] [nvarchar] (550) COLLATE Cyrillic_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [Service].[ItemCategory] ADD CONSTRAINT [PK_ServiceType] PRIMARY KEY CLUSTERED  ([ItemCategoryID]) ON [PRIMARY]
GO
ALTER TABLE [Service].[ItemCategory] ADD CONSTRAINT [fk_ItemCategoryType] FOREIGN KEY ([CtegoryTypeID]) REFERENCES [Service].[CatecoryType] ([CategoryTypeID])
GO
