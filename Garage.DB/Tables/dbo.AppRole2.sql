CREATE TABLE [dbo].[AppRole2]
(
[AppRole] [varchar] (50) COLLATE Cyrillic_General_CI_AS NOT NULL,
[Role] [varchar] (50) COLLATE Cyrillic_General_CI_AS NOT NULL,
[Active] [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AppRole2] ADD CONSTRAINT [PK_AppRole2] PRIMARY KEY CLUSTERED  ([AppRole], [Role]) ON [PRIMARY]
GO
