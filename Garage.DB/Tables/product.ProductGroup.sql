CREATE TABLE [product].[ProductGroup]
(
[ParentID] [int] NOT NULL CONSTRAINT [DF_ProductGroup_ParentID] DEFAULT ((0)),
[ProductGroupID] [int] NOT NULL IDENTITY(1, 1),
[GroupName] [nvarchar] (150) COLLATE Cyrillic_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [product].[ProductGroup] ADD CONSTRAINT [PK_ProductGroup] PRIMARY KEY CLUSTERED  ([ParentID], [ProductGroupID]) ON [PRIMARY]
GO
