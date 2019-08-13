CREATE TABLE [dbo].[Role]
(
[RoleID] [int] NOT NULL IDENTITY(1, 1),
[RoleGroupID] [int] NULL,
[RoleName] [nvarchar] (150) COLLATE Cyrillic_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Role] ADD CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED  ([RoleID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Role] ADD CONSTRAINT [fk_RoleGroup] FOREIGN KEY ([RoleGroupID]) REFERENCES [dbo].[RoleGroup] ([RoleGroupID])
GO
