CREATE TABLE [dbo].[Enum]
(
[ParentEnumID] [int] NOT NULL,
[EnumID] [int] NOT NULL,
[Name] [varchar] (150) COLLATE Cyrillic_General_CI_AS NULL,
[Descriptoin] [varchar] (150) COLLATE Cyrillic_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Enum] ADD CONSTRAINT [PK_Enum] PRIMARY KEY CLUSTERED  ([ParentEnumID], [EnumID]) ON [PRIMARY]
GO
