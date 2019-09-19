CREATE TABLE [Shop].[WorkOrder]
(
[WorkOrderID] [int] NOT NULL IDENTITY(1, 1),
[OrderID] [int] NOT NULL,
[ItemID] [int] NULL,
[UoM] [nchar] (10) COLLATE Cyrillic_General_CI_AS NULL,
[Quantity] [decimal] (18, 4) NULL,
[EmployeeID] [int] NULL,
[WorkPlaceID] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Shop].[WorkOrder] ADD CONSTRAINT [PK_OrderDetail] PRIMARY KEY CLUSTERED  ([WorkOrderID]) ON [PRIMARY]
GO
ALTER TABLE [Shop].[WorkOrder] ADD CONSTRAINT [fk_OrderWorkOrder] FOREIGN KEY ([OrderID]) REFERENCES [Shop].[Order] ([OrderID])
GO
ALTER TABLE [Shop].[WorkOrder] ADD CONSTRAINT [fk_WorkOrderEmployee] FOREIGN KEY ([EmployeeID]) REFERENCES [HumanResources].[Employee] ([EmployeeID])
GO
ALTER TABLE [Shop].[WorkOrder] ADD CONSTRAINT [fk_WorkOrderItem] FOREIGN KEY ([ItemID]) REFERENCES [Service].[ItemList] ([ItemID])
GO
ALTER TABLE [Shop].[WorkOrder] ADD CONSTRAINT [fk_WorkOrderWorkPlace] FOREIGN KEY ([WorkPlaceID]) REFERENCES [Shop].[WorkPlace] ([WorkPlaceID])
GO
ALTER TABLE [Shop].[WorkOrder] ADD CONSTRAINT [FK_WorkOrdreWorkOrder] FOREIGN KEY ([WorkOrderID]) REFERENCES [Shop].[WorkOrder] ([WorkOrderID])
GO
