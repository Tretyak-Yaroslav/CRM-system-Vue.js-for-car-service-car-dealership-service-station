CREATE TABLE [Client].[Customer]
(
[CustomerID] [int] NOT NULL IDENTITY(1, 1),
[ParentCustomerID] [int] NULL,
[WorkShopID] [int] NULL,
[CustomerFullName] [nvarchar] (150) COLLATE Cyrillic_General_CI_AS NULL,
[CustomerPhoneNumber] [nvarchar] (20) COLLATE Cyrillic_General_CI_AS NULL,
[CustomerMail] [nvarchar] (50) COLLATE Cyrillic_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [Client].[Customer] ADD CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED  ([CustomerID]) ON [PRIMARY]
GO
ALTER TABLE [Client].[Customer] ADD CONSTRAINT [fk_CustomerStation] FOREIGN KEY ([WorkShopID]) REFERENCES [Shop].[WorkShop] ([WorkShopID])
GO
ALTER TABLE [Client].[Customer] ADD CONSTRAINT [fk_ParentCustomer] FOREIGN KEY ([ParentCustomerID]) REFERENCES [Client].[Customer] ([CustomerID])
GO
