CREATE TABLE [dbo].[RoleGroup]
(
[RoleGroupID] [int] NOT NULL IDENTITY(1, 1),
[RoleGroupName] [nvarchar] (150) COLLATE Cyrillic_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RoleGroup] ADD CONSTRAINT [PK_RoleGroup] PRIMARY KEY CLUSTERED  ([RoleGroupID]) ON [PRIMARY]
GO
