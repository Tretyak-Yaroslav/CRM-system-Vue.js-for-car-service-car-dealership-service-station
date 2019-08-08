CREATE TABLE [dbo].[OrderStatus]
(
[OrderStatusID] [int] NOT NULL IDENTITY(1, 1),
[OrderStatusName] [nvarchar] (70) COLLATE Cyrillic_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OrderStatus] ADD CONSTRAINT [PK_OrderStatus] PRIMARY KEY CLUSTERED  ([OrderStatusID]) ON [PRIMARY]
GO
