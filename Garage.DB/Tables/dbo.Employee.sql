CREATE TABLE [dbo].[Employee]
(
[EmployeeID] [int] NOT NULL IDENTITY(1, 1),
[EmployeePostID] [int] NOT NULL,
[WorkShopID] [int] NULL,
[EmployeeLastName] [nvarchar] (70) COLLATE Cyrillic_General_CI_AS NULL,
[EmployeeFirstName] [nvarchar] (70) COLLATE Cyrillic_General_CI_AS NULL,
[EmployeeLogin] [nvarchar] (50) COLLATE Cyrillic_General_CI_AS NULL,
[EmployeePwd] [nvarchar] (50) COLLATE Cyrillic_General_CI_AS NULL,
[EmployeePwdHash] [nvarchar] (150) COLLATE Cyrillic_General_CI_AS NULL,
[EmployeePhone] [nchar] (50) COLLATE Cyrillic_General_CI_AS NULL,
[EmployeeEMail] [nvarchar] (150) COLLATE Cyrillic_General_CI_AS NULL,
[EmployeeEMailConfirmed] [bit] NULL,
[EmployeeBlocked] [bit] NULL,
[EmployeeLastLogined] [datetime] NULL,
[EmployeeCreatedDate] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Employee] ADD CONSTRAINT [PK__Employee__7AD04FF15F149944] PRIMARY KEY CLUSTERED  ([EmployeeID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Employee] ADD CONSTRAINT [fk_EmployeePost] FOREIGN KEY ([EmployeePostID]) REFERENCES [dbo].[EmployeePost] ([EmployeePostID])
GO
ALTER TABLE [dbo].[Employee] ADD CONSTRAINT [fk_EmployeeStation] FOREIGN KEY ([WorkShopID]) REFERENCES [dbo].[WorkShop] ([WorkShopID])
GO
