CREATE TABLE [HumanResources].[Employee]
(
[WorkShopID] [int] NOT NULL,
[EmployeeID] [int] NOT NULL IDENTITY(1, 1),
[EmployeePostID] [int] NOT NULL,
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
[EmployeeCreatedDate] [datetime] NULL,
[EmployeeColor] [nvarchar] (10) COLLATE Cyrillic_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [HumanResources].[Employee] ADD CONSTRAINT [PK_Employee_1] PRIMARY KEY CLUSTERED  ([EmployeeID]) ON [PRIMARY]
GO
ALTER TABLE [HumanResources].[Employee] ADD CONSTRAINT [fk_EmployeePost] FOREIGN KEY ([EmployeePostID]) REFERENCES [HumanResources].[EmployeePost] ([EmployeePostID])
GO
ALTER TABLE [HumanResources].[Employee] ADD CONSTRAINT [fk_EmployeeStation] FOREIGN KEY ([WorkShopID]) REFERENCES [Shop].[WorkShop] ([WorkShopID])
GO
