IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'ESO\y_tretyak')
CREATE LOGIN [ESO\y_tretyak] FROM WINDOWS
GO
CREATE USER [ESO\y_tretyak] FOR LOGIN [ESO\y_tretyak]
GO
