CREATE TABLE [Shop].[QueryStatus]
(
[QueryStatusID] [int] NOT NULL IDENTITY(1, 1),
[QueryStatusName] [nvarchar] (70) COLLATE Cyrillic_General_CI_AS NULL,
[QueryStatusColor] [nvarchar] (50) COLLATE Cyrillic_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [Shop].[QueryStatus] ADD CONSTRAINT [PK_OrderStatus] PRIMARY KEY CLUSTERED  ([QueryStatusID]) ON [PRIMARY]
GO
