CREATE TABLE [dbo].[CatecoryType]
(
[CategoryTypeID] [int] NOT NULL IDENTITY(1, 1),
[CategoryTypeName] [nvarchar] (150) COLLATE Cyrillic_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CatecoryType] ADD CONSTRAINT [PK_CatecoryType] PRIMARY KEY CLUSTERED  ([CategoryTypeID]) ON [PRIMARY]
GO
