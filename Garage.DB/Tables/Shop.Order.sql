CREATE TABLE [Shop].[Order]
(
[OrderID] [int] NOT NULL IDENTITY(1, 1),
[QueryID] [int] NULL,
[OrderStatusID] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Shop].[Order] ADD CONSTRAINT [PK_Order_1] PRIMARY KEY CLUSTERED  ([OrderID]) ON [PRIMARY]
GO
ALTER TABLE [Shop].[Order] ADD CONSTRAINT [fk_OrderQuery] FOREIGN KEY ([QueryID]) REFERENCES [Shop].[Query] ([QueryID])
GO
