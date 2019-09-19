CREATE TABLE [Service].[ItemList]
(
[ItemID] [int] NOT NULL IDENTITY(1, 1),
[ItemCategoryID] [int] NULL,
[ItemName] [nvarchar] (180) COLLATE Cyrillic_General_CI_AS NOT NULL,
[ItemDescription] [nvarchar] (350) COLLATE Cyrillic_General_CI_AS NULL,
[ItemPrice] [decimal] (14, 4) NULL
) ON [PRIMARY]
GO
ALTER TABLE [Service].[ItemList] ADD CONSTRAINT [PK_Service] PRIMARY KEY CLUSTERED  ([ItemID]) ON [PRIMARY]
GO
ALTER TABLE [Service].[ItemList] ADD CONSTRAINT [fk_ServiceType] FOREIGN KEY ([ItemCategoryID]) REFERENCES [Service].[ItemCategory] ([ItemCategoryID])
GO
