IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'ESO\Gayduk')
CREATE LOGIN [ESO\Gayduk] FROM WINDOWS
GO
CREATE USER [ESO\Gayduk] FOR LOGIN [ESO\Gayduk]
GO
