CREATE TABLE [Client].[Vendor]
(
[VendorID] [int] NOT NULL IDENTITY(1, 1),
[VendorName] [nvarchar] (100) COLLATE Cyrillic_General_CI_AS NULL,
[OE] [bit] NULL,
[PC] [bit] NULL,
[CV] [bit] NULL,
[AX] [bit] NULL,
[EN] [bit] NULL,
[GR] [bit] NULL,
[LCV] [bit] NULL,
[MC] [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Client].[Vendor] ADD CONSTRAINT [PK_Vendor] PRIMARY KEY CLUSTERED  ([VendorID]) ON [PRIMARY]
GO
