CREATE TABLE [Service].[CatecoryType]
(
[CategoryTypeID] [int] NOT NULL IDENTITY(1, 1),
[CategoryTypeName] [nvarchar] (150) COLLATE Cyrillic_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [Service].[CatecoryType] ADD CONSTRAINT [PK_CatecoryType] PRIMARY KEY CLUSTERED  ([CategoryTypeID]) ON [PRIMARY]
GO
