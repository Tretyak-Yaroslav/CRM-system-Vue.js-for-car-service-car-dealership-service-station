CREATE TABLE [product].[Item]
(
[ItemID] [int] NOT NULL,
[Article] [nvarchar] (50) COLLATE Cyrillic_General_CI_AS NULL,
[Desription] [nvarchar] (150) COLLATE Cyrillic_General_CI_AS NULL,
[ProductGroupID] [int] NULL,
[IsStorable] [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [product].[Item] ADD CONSTRAINT [PK_Item] PRIMARY KEY CLUSTERED  ([ItemID]) ON [PRIMARY]
GO
