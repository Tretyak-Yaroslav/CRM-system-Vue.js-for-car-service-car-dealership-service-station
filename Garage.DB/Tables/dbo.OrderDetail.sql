CREATE TABLE [dbo].[OrderDetail]
(
[OrderDetailID] [int] NOT NULL IDENTITY(1, 1),
[OrderID] [int] NOT NULL,
[ItemID] [int] NULL,
[UoM] [nchar] (10) COLLATE Cyrillic_General_CI_AS NULL,
[Quantity] [decimal] (18, 4) NULL,
[EmployeeID] [int] NULL,
[WorkPlaceID] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OrderDetail] ADD CONSTRAINT [PK_OrderDetail] PRIMARY KEY CLUSTERED  ([OrderDetailID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OrderDetail] ADD CONSTRAINT [FK_OrderDetail_OrderDetail] FOREIGN KEY ([OrderDetailID]) REFERENCES [dbo].[OrderDetail] ([OrderDetailID])
GO
ALTER TABLE [dbo].[OrderDetail] ADD CONSTRAINT [fk_OrderDetailEmployee] FOREIGN KEY ([EmployeeID]) REFERENCES [dbo].[Employee] ([EmployeeID])
GO
ALTER TABLE [dbo].[OrderDetail] ADD CONSTRAINT [fk_OrderDetailItem] FOREIGN KEY ([ItemID]) REFERENCES [dbo].[ItemList] ([ItemID])
GO
ALTER TABLE [dbo].[OrderDetail] ADD CONSTRAINT [fk_OrderDetailOrder] FOREIGN KEY ([OrderID]) REFERENCES [dbo].[Order] ([OrderID])
GO
ALTER TABLE [dbo].[OrderDetail] ADD CONSTRAINT [fk_OrderDetailWorkPlace] FOREIGN KEY ([WorkPlaceID]) REFERENCES [dbo].[WorkPlace] ([WorkPlaceID])
GO
