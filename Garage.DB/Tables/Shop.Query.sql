CREATE TABLE [Shop].[Query]
(
[QueryID] [int] NOT NULL IDENTITY(1, 1),
[VehicleID] [int] NOT NULL,
[WorkShopID] [int] NULL,
[StartTime] [datetime] NULL,
[EndTime] [datetime] NULL,
[CreateDate] [datetime] NULL,
[ModificationDate] [datetime] NULL,
[QueryStatusID] [int] NOT NULL,
[EmployeeMasterID] [int] NULL,
[EmployeeID] [int] NULL,
[WorkPlaceID] [int] NULL,
[ItemID] [int] NULL,
[QuerySource] [nvarchar] (100) COLLATE Cyrillic_General_CI_AS NULL,
[QueryDescription] [nvarchar] (max) COLLATE Cyrillic_General_CI_AS NULL,
[IsDeleted] [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Shop].[Query] ADD CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED  ([QueryID]) ON [PRIMARY]
GO
