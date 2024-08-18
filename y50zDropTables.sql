USE Test
GO
/*
ALTER DATABASE [Test] MODIFY FILE ( NAME = N'Test_1', SIZE = 52GB )
GO
exec sp_spaceused2 @Ord=1
exec sp_spaceused2 @objname='A%', @Ord=1

*/
GO
DECLARE @T TABLE(ID int IDENTITY PRIMARY KEY, name nvarchar(250))
INSERT @T  --SELECT name FROM sys.tables WHERE name LIKE 'A%' AND name <> 'A' AND name <> 'A0' ORDER BY name --SELECT * FROM @T
SELECT Tabl FROM dbo.zTest --WHERE Cardin BETWEEN 8768 AND 8892
DECLARE c CURSOR FOR SELECT name FROM @T --ORDER BY name
DECLARE @n nvarchar(250), @s nvarchar(1000)
OPEN c
FETCH NEXT FROM c INTO @n
WHILE @@FETCH_STATUS = 0
BEGIN
 SELECT @s = CONCAT('DROP TABLE IF EXISTS dbo.',@n); PRINT @s
 exec sp_executesql @s
 FETCH NEXT FROM c INTO @n
END
CLOSE c
DEALLOCATE c
GO
/*
*/
GO
DECLARE @T TABLE(ID int IDENTITY PRIMARY KEY, name nvarchar(250))
INSERT @T --SELECT name FROM sys.tables WHERE name LIKE 'B%' AND name <> 'B' AND name <> 'B0' ORDER BY name --SELECT * FROM @T
SELECT CONCAT('B',SUBSTRING(Tabl,2,LEN(Tabl)-1)) FROM dbo.zTest --WHERE Cardin BETWEEN 8768 AND 8892
DECLARE c CURSOR FOR SELECT name FROM @T --ORDER BY name
DECLARE @n nvarchar(250), @s nvarchar(1000)
OPEN c
FETCH NEXT FROM c INTO @n
WHILE @@FETCH_STATUS = 0
BEGIN
 SELECT @s = CONCAT('DROP TABLE IF EXISTS dbo.',@n); PRINT @s
 exec sp_executesql @s
 FETCH NEXT FROM c INTO @n
END
CLOSE c
DEALLOCATE c

GO
/*
--DROP TABLE AI2, BI2, A
exec sp_spaceused2 @Ord=1
exec sp_spaceused2 @objname='B%', @Ord=1

*/