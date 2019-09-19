CREATE TABLE [HumanResources].[RoleGroup]
(
[RoleGroup] [nvarchar] (50) COLLATE Cyrillic_General_CI_AS NOT NULL,
[RoleGroupDescription] [nvarchar] (150) COLLATE Cyrillic_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [HumanResources].[RoleGroup] ADD CONSTRAINT [PK_RoleGroup_1] PRIMARY KEY CLUSTERED  ([RoleGroup]) ON [PRIMARY]
GO
