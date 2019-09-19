CREATE TABLE [Shop].[Query]
(
[QueryID] [int] NOT NULL IDENTITY(1, 1),
[VehicleID] [int] NOT NULL,
[WorkShopID] [int] NULL,
[StartTime] [datetime] NULL,
[EndTime] [datetime] NULL,
[CreateDate] [datetime] NULL,
[QueryStatusID] [int] NOT NULL,
[EmployeeMasterID] [int] NULL,
[EmployeeID] [int] NULL,
[WorkPlaceID] [int] NULL,
[ItemID] [int] NULL,
[QuerySource] [nvarchar] (100) COLLATE Cyrillic_General_CI_AS NULL,
[QueryDescription] [nvarchar] (max) COLLATE Cyrillic_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [Shop].[Query] ADD CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED  ([QueryID]) ON [PRIMARY]
GO
ALTER TABLE [Shop].[Query] ADD CONSTRAINT [fk_QueryEmployee] FOREIGN KEY ([EmployeeID]) REFERENCES [HumanResources].[Employee] ([EmployeeID])
GO
ALTER TABLE [Shop].[Query] ADD CONSTRAINT [fk_QueryEmployeeMaster] FOREIGN KEY ([EmployeeMasterID]) REFERENCES [HumanResources].[Employee] ([EmployeeID])
GO
ALTER TABLE [Shop].[Query] ADD CONSTRAINT [fk_QueryItemList] FOREIGN KEY ([ItemID]) REFERENCES [Service].[ItemList] ([ItemID])
GO
ALTER TABLE [Shop].[Query] ADD CONSTRAINT [fk_QueryStatus] FOREIGN KEY ([QueryStatusID]) REFERENCES [Shop].[QueryStatus] ([QueryStatusID])
GO
ALTER TABLE [Shop].[Query] ADD CONSTRAINT [fk_QueryVehicle] FOREIGN KEY ([VehicleID]) REFERENCES [Client].[Vehicle] ([VehicleID])
GO
ALTER TABLE [Shop].[Query] ADD CONSTRAINT [fk_QueryWorkPlace] FOREIGN KEY ([WorkPlaceID]) REFERENCES [Shop].[WorkPlace] ([WorkPlaceID])
GO
ALTER TABLE [Shop].[Query] ADD CONSTRAINT [fk_QueryWorkShop] FOREIGN KEY ([WorkShopID]) REFERENCES [Shop].[WorkShop] ([WorkShopID])
GO
