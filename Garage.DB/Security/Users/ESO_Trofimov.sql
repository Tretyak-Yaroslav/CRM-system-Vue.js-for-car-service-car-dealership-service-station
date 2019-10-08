IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'ESO\Trofimov')
CREATE LOGIN [ESO\Trofimov] FROM WINDOWS
GO
CREATE USER [ESO\Trofimov] FOR LOGIN [ESO\Trofimov]
GO
