CREATE TABLE [dbo].[Role2]
(
[Role] [varchar] (50) COLLATE Cyrillic_General_CI_AS NOT NULL,
[Description] [varchar] (50) COLLATE Cyrillic_General_CI_AS NULL,
[RoleGroup] [varchar] (50) COLLATE Cyrillic_General_CI_AS NULL,
[RoleLevel] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Role2] ADD CONSTRAINT [PK_Role2] PRIMARY KEY CLUSTERED  ([Role]) ON [PRIMARY]
GO
