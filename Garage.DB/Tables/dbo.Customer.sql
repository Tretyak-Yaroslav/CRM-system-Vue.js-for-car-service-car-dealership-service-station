CREATE TABLE [dbo].[Customer]
(
[CustomerID] [int] NOT NULL IDENTITY(1, 1),
[ParentCustomerID] [int] NULL,
[WorkShopID] [int] NULL,
[CustomerFullName] [nvarchar] (150) COLLATE Cyrillic_General_CI_AS NULL,
[CustomerPhoneNumber] [nvarchar] (15) COLLATE Cyrillic_General_CI_AS NULL,
[CustomerMail] [nvarchar] (50) COLLATE Cyrillic_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Customer] ADD CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED  ([CustomerID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Customer] ADD CONSTRAINT [fk_CustomerStation] FOREIGN KEY ([WorkShopID]) REFERENCES [dbo].[WorkShop] ([WorkShopID])
GO
ALTER TABLE [dbo].[Customer] ADD CONSTRAINT [fk_ParentCustomer] FOREIGN KEY ([ParentCustomerID]) REFERENCES [dbo].[Customer] ([CustomerID])
GO
