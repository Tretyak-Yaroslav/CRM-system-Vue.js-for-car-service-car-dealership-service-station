CREATE TABLE [dbo].[User2]
(
[ComID] [int] NULL,
[Login] [varchar] (50) COLLATE Cyrillic_General_CI_AS NULL,
[Pwd] [varchar] (50) COLLATE Cyrillic_General_CI_AS NULL,
[Name] [varchar] (50) COLLATE Cyrillic_General_CI_AS NULL,
[EMail] [varchar] (50) COLLATE Cyrillic_General_CI_AS NULL,
[Active] [bit] NULL
) ON [PRIMARY]
GO
