CREATE TABLE [dbo].[UserRole]
(
[UserRoleID] [int] NOT NULL IDENTITY(1, 1),
[EmploeeID] [int] NULL,
[RoleID] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[UserRole] ADD CONSTRAINT [PK_UserRole] PRIMARY KEY CLUSTERED  ([UserRoleID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[UserRole] ADD CONSTRAINT [fk_UserRole] FOREIGN KEY ([RoleID]) REFERENCES [dbo].[Role] ([RoleID])
GO
ALTER TABLE [dbo].[UserRole] ADD CONSTRAINT [fk_UserRoleEmployee] FOREIGN KEY ([EmploeeID]) REFERENCES [dbo].[Employee] ([EmployeeID])
GO
