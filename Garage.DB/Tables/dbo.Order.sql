CREATE TABLE [dbo].[Order]
(
[OrderID] [int] NOT NULL IDENTITY(1, 1),
[VehicleID] [int] NOT NULL,
[WorkShopID] [int] NULL,
[StartTime] [datetime] NULL,
[EndTime] [datetime] NULL,
[CreateDate] [datetime] NULL,
[OrderStatusID] [int] NOT NULL,
[EmployeeCreateOrderID] [int] NULL,
[OrderDescription] [nvarchar] (max) COLLATE Cyrillic_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Order] ADD CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED  ([OrderID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Order] ADD CONSTRAINT [fk_OrderEmployee] FOREIGN KEY ([EmployeeCreateOrderID]) REFERENCES [dbo].[Employee] ([EmployeeID])
GO
ALTER TABLE [dbo].[Order] ADD CONSTRAINT [fk_OrderStatus] FOREIGN KEY ([OrderStatusID]) REFERENCES [dbo].[OrderStatus] ([OrderStatusID])
GO
ALTER TABLE [dbo].[Order] ADD CONSTRAINT [fk_OrderVehicle] FOREIGN KEY ([VehicleID]) REFERENCES [dbo].[Vehicle] ([VehicleID])
GO
ALTER TABLE [dbo].[Order] ADD CONSTRAINT [fk_OrderWorkShop] FOREIGN KEY ([WorkShopID]) REFERENCES [dbo].[WorkShop] ([WorkShopID])
GO
