CREATE TABLE [HumanResources].[Role]
(
[RoleGroup] [nvarchar] (50) COLLATE Cyrillic_General_CI_AS NOT NULL,
[Role] [nvarchar] (150) COLLATE Cyrillic_General_CI_AS NOT NULL,
[RoleDescription] [nvarchar] (250) COLLATE Cyrillic_General_CI_AS NULL,
[RoleLevel] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [HumanResources].[Role] ADD CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED  ([RoleGroup], [Role]) ON [PRIMARY]
GO
