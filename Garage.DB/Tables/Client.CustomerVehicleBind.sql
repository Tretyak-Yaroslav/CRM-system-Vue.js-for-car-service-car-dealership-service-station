CREATE TABLE [Client].[CustomerVehicleBind]
(
[CustomerIDeteilID] [int] NOT NULL IDENTITY(1, 1),
[CustumerID] [int] NULL,
[VehicleID] [int] NULL,
[BindFrom] [datetime] NULL,
[BindTo] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Client].[CustomerVehicleBind] ADD CONSTRAINT [PK_CustomerDeteilBind] PRIMARY KEY CLUSTERED  ([CustomerIDeteilID]) ON [PRIMARY]
GO
ALTER TABLE [Client].[CustomerVehicleBind] ADD CONSTRAINT [fk_CustomerDeteilBind] FOREIGN KEY ([CustumerID]) REFERENCES [Client].[Customer] ([CustomerID])
GO
ALTER TABLE [Client].[CustomerVehicleBind] ADD CONSTRAINT [fk_CustomerVehicle] FOREIGN KEY ([VehicleID]) REFERENCES [Client].[Vehicle] ([VehicleID])
GO
