CREATE TABLE [tcd].[Model]
(
[MarkID] [int] NOT NULL,
[ModelID] [int] NOT NULL,
[Model] [nvarchar] (100) COLLATE Cyrillic_General_CI_AS NULL,
[ModelRange] [nvarchar] (20) COLLATE Cyrillic_General_CI_AS NULL,
[Sort] [int] NULL,
[PC] [bit] NULL,
[CV] [bit] NULL,
[AX] [bit] NULL,
[LCV] [bit] NULL,
[MC] [bit] NULL
) ON [PRIMARY]
GO
