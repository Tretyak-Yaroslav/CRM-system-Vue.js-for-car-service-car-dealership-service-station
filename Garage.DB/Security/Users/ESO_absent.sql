IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'ESO\absent')
CREATE LOGIN [ESO\absent] FROM WINDOWS
GO
CREATE USER [ESO\absent] FOR LOGIN [ESO\absent]
GO
