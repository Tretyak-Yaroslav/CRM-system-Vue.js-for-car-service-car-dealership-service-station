CREATE TABLE [dbo].[EmployeePost]
(
[EmployeePostID] [int] NOT NULL IDENTITY(1, 1),
[EmployeePostName] [nvarchar] (150) COLLATE Cyrillic_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EmployeePost] ADD CONSTRAINT [PK__Employee__01E6CEAB2E71BF45] PRIMARY KEY CLUSTERED  ([EmployeePostID]) ON [PRIMARY]
GO
