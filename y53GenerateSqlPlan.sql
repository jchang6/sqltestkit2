USE Test
GO
/*
SELECT * FROM dbo.vDbPtSt WHERE [table] LIKE 'B%' ORDER BY [table]
exec sp_helpindex2 'B%'
exec sp_spaceused2 @objname='B%', @Ord=1

SELECT Tabl, Cardin, Rang, Cardin*Rang RowCt FROM dbo.zTest WHERE Tabl <> 'A0' --AND Cardin >= 14336
ORDER BY Cardin 
SELECT CONCAT('B',SUBSTRING(Tabl,2,LEN(Tabl)-1)), Cardin, Rang, Cardin*Rang RowCt FROM dbo.zTest WHERE Tabl <> 'A0' ORDER BY Cardin 
*/
GO
SELECT [table], row_count, Cardin, Rang, idp, 8*idp data  FROM dbo.vtest WHERE [table] LIKE 'A%' AND [table] <> 'A' ORDER BY Cardin
/*-- exec sp_executesql @s
*/
GO
SET NOCOUNT ON
DECLARE @T TABLE(ID int IDENTITY PRIMARY KEY, Tabl nvarchar(250), Tabk nvarchar(250), Cardin int, Rang int, RowCt int)
INSERT @T SELECT Tabl, CONCAT('B',SUBSTRING(Tabl,2,LEN(Tabl)-1))
, Cardin, Rang, Cardin*Rang RowCt FROM dbo.zTest WHERE Tabl <> '' ORDER BY Cardin  --SELECT * FROM @T
DECLARE c CURSOR FOR SELECT Tabl, Tabk, Cardin, Rang, RowCt FROM @T ORDER BY Cardin
DECLARE @tabl nvarchar(250), @tabk nvarchar(250), @Card int, @Rg int, @Rw int, @s nvarchar(4000), @s2 nvarchar(1000)
OPEN c
FETCH NEXT FROM c INTO @tabl, @tabk, @Card, @Rg, @Rw
WHILE @@FETCH_STATUS = 0
BEGIN 
 IF @Card = 1 SELECT @tabl = 'A1'
 SELECT @s = CONCAT('SELECT MAX(b.TI) FROM dbo.',@tabl,CASE LEN(@Tabl) WHEN 3 THEN '' ELSE ' ' END
 ,' a INNER LOOP JOIN dbo.A b ON b.AID = a.AID WHERE a.GID = 1', CASE @Card WHEN 1 THEN ' AND a.[SID] = 1' ELSE '' END,' OPTION(MAXDOP 1) ') 
 PRINT @s 
 FETCH NEXT FROM c INTO @tabl, @tabk, @Card, @Rg, @Rw
END
CLOSE c
DEALLOCATE c
GO
/*
*/
GO
DECLARE @T TABLE(ID int IDENTITY PRIMARY KEY, Tabl nvarchar(250), Tabk nvarchar(250), Cardin int, Rang int, RowCt int)
INSERT @T SELECT Tabl, CONCAT('B',SUBSTRING(Tabl,2,LEN(Tabl)-1))
, Cardin, Rang, Cardin*Rang RowCt FROM dbo.zTest WHERE Tabl <> '' ORDER BY Cardin  --SELECT * FROM @T
DECLARE c CURSOR FOR SELECT Tabl, Tabk, Cardin, Rang, RowCt FROM @T ORDER BY Cardin
DECLARE @tabl nvarchar(250), @tabk nvarchar(250), @Card int, @Rg int, @Rw int, @s nvarchar(4000), @s2 nvarchar(1000)
OPEN c
FETCH NEXT FROM c INTO @tabl, @tabk, @Card, @Rg, @Rw
WHILE @@FETCH_STATUS = 0
BEGIN 
 IF @Card = 1 SELECT @tabl = 'A1', @tabk = 'B1'  -- CASE WHEN @Card = 1 THEN 'A1' ELSE @tabl END
 SELECT @s = CONCAT('SELECT MAX(b.TI) FROM dbo.',@tabl,CASE LEN(@Tabl) WHEN 3 THEN '' ELSE ' ' END
 ,' a INNER LOOP JOIN dbo.',@tabk,CASE LEN(@Tabl) WHEN 3 THEN '' ELSE ' ' END
 ,' b ON b.GID = a.GID AND b.SID = a.SID WHERE a.GID = 1', CASE @Card WHEN 1 THEN ' AND a.[SID] = 1' ELSE '' END,' OPTION(MAXDOP 1) ') 
 PRINT @s 
 FETCH NEXT FROM c INTO @tabl, @tabk, @Card, @Rg, @Rw
END
CLOSE c
DEALLOCATE c
GO
/*
*/
GO
DECLARE @T TABLE(ID int IDENTITY PRIMARY KEY, Tabl nvarchar(250), Tabk nvarchar(250), Cardin int, Rang int, RowCt int)
INSERT @T SELECT Tabl, CONCAT('B',SUBSTRING(Tabl,2,LEN(Tabl)-1))
, Cardin, Rang, Cardin*Rang RowCt FROM dbo.zTest WHERE Tabl <> '' ORDER BY Cardin  --SELECT * FROM @T
DECLARE c CURSOR FOR SELECT Tabl, Tabk, Cardin, Rang, RowCt FROM @T ORDER BY Cardin
DECLARE @tabl nvarchar(250), @tabk nvarchar(250), @Card int, @Rg int, @Rw int, @s nvarchar(4000), @s2 nvarchar(1000)
OPEN c
FETCH NEXT FROM c INTO @tabl, @tabk, @Card, @Rg, @Rw
WHILE @@FETCH_STATUS = 0
BEGIN 
 IF @Card = 1 SELECT @tabl = 'A1', @tabk = 'B1' 
 SELECT @s = CONCAT('SELECT MAX(b.TI) FROM dbo.',@tabl,CASE LEN(@Tabl) WHEN 3 THEN '' ELSE ' ' END
 ,' a INNER MERGE JOIN dbo.',@tabk,CASE LEN(@Tabl) WHEN 3 THEN '' ELSE ' ' END
 ,' b ON b.GID = a.GID AND b.SID = a.SID WHERE a.GID = 1', CASE @Card WHEN 1 THEN ' AND a.[SID] = 1' ELSE '' END,' OPTION(MAXDOP 1) ') 
 PRINT @s 
 FETCH NEXT FROM c INTO @tabl, @tabk, @Card, @Rg, @Rw
END
CLOSE c
DEALLOCATE c
GO
/*
*/
GO
DECLARE @T TABLE(ID int IDENTITY PRIMARY KEY, Tabl nvarchar(250), Tabk nvarchar(250), Cardin int, Rang int, RowCt int)
INSERT @T SELECT Tabl, CONCAT('B',SUBSTRING(Tabl,2,LEN(Tabl)-1)), Cardin, Rang, Cardin*Rang RowCt 
FROM dbo.zTest WHERE Tabl <> '' ORDER BY Cardin  --SELECT * FROM @T
DECLARE c CURSOR FOR SELECT Tabl, Tabk, Cardin, Rang, RowCt FROM @T ORDER BY Cardin
DECLARE @tabl nvarchar(250), @tabk nvarchar(250), @Card int, @Rg int, @Rw int, @s nvarchar(4000), @s2 nvarchar(1000)
OPEN c
FETCH NEXT FROM c INTO @tabl, @tabk, @Card, @Rg, @Rw
WHILE @@FETCH_STATUS = 0
BEGIN 
 IF @Card = 1 SELECT @tabl = 'A1', @tabk = 'B1'  
 SELECT @s = CONCAT('SELECT MAX(b.TI) FROM dbo.',@tabl,CASE LEN(@Tabl) WHEN 3 THEN '' ELSE ' ' END
 ,' a INNER HASH JOIN dbo.',@tabk,CASE LEN(@Tabl) WHEN 3 THEN '' ELSE ' ' END
 ,' b ON b.GID = a.GID AND b.SID = a.SID WHERE a.GID = 1', CASE @Card WHEN 1 THEN ' AND a.[SID] = 1' ELSE '' END,' OPTION(MAXDOP 1'
 , CASE WHEN @Card < 131072 THEN '' ELSE ', USE HINT(''DISALLOW_BATCH_MODE'')' END,')') 
 PRINT @s -- IF @Card >= 131072 -- PRINT REPLACE(@s ,'MAXDOP 1','MAXDOP 1, USE HINT(''DISALLOW_BATCH_MODE'')')
 FETCH NEXT FROM c INTO @tabl, @tabk, @Card, @Rg, @Rw
END
CLOSE c
DEALLOCATE c
DECLARE c CURSOR FOR SELECT Tabl, Tabk, Cardin, Rang, RowCt FROM @T WHERE Cardin >= 131072 ORDER BY Cardin
OPEN c
FETCH NEXT FROM c INTO @tabl, @tabk, @Card, @Rg, @Rw
WHILE @@FETCH_STATUS = 0
BEGIN 
 SELECT @s = CONCAT('SELECT MAX(b.TI) FROM dbo.',@tabl,CASE LEN(@Tabl) WHEN 3 THEN '' ELSE ' ' END
 ,' a INNER HASH JOIN dbo.',@tabk,CASE LEN(@Tabl) WHEN 3 THEN '' ELSE ' ' END
 ,' b ON b.GID = a.GID AND b.SID = a.SID WHERE a.GID = 1', CASE @Card WHEN 1 THEN ' AND a.[SID] = 1' ELSE '' END,' OPTION(MAXDOP 1) ') 
 PRINT @s
 FETCH NEXT FROM c INTO @tabl, @tabk, @Card, @Rg, @Rw
END
CLOSE c
DEALLOCATE c
GO
/*
*/
GO
DECLARE @T TABLE(ID int IDENTITY PRIMARY KEY, Tabl nvarchar(250), Tabk nvarchar(250), Cardin int, Rang int, RowCt int)
INSERT @T SELECT Tabl, CONCAT('B',SUBSTRING(Tabl,2,LEN(Tabl)-1)), Cardin, Rang, Cardin*Rang RowCt 
FROM dbo.zTest WHERE Tabl <> 'A0' ORDER BY Cardin  --SELECT * FROM @T

DECLARE c CURSOR FOR SELECT Tabl, Tabk, Cardin, Rang, RowCt FROM @T ORDER BY Cardin
DECLARE @tabl nvarchar(250), @tabk nvarchar(250), @Card int, @Rg int, @Rw int, @s nvarchar(4000), @s2 nvarchar(1000)
OPEN c
FETCH NEXT FROM c INTO @tabl, @tabk, @Card, @Rg, @Rw
WHILE @@FETCH_STATUS = 0
BEGIN 
 IF @Card = 1 SELECT @tabl = 'A1', @tabk = 'B1'  
 SELECT @s = CONCAT('SELECT MAX(b.TI) FROM dbo.',@tabl,CASE LEN(@Tabl) WHEN 3 THEN '' ELSE ' ' END
 ,' a INNER MERGE JOIN dbo.',@tabk,CASE LEN(@Tabl) WHEN 3 THEN '' ELSE ' ' END
 ,' b ON b.GID = a.GID AND b.BID = a.SID WHERE a.GID = 1', CASE @Card WHEN 1 THEN ' AND a.[SID] = 1' ELSE '' END, ' OPTION(MAXDOP 1'
 , CASE WHEN @Card < 131072 THEN '' ELSE ', USE HINT(''DISALLOW_BATCH_MODE'')' END,')') 
 PRINT @s 
 FETCH NEXT FROM c INTO @tabl, @tabk, @Card, @Rg, @Rw
END
CLOSE c
DEALLOCATE c
DECLARE d CURSOR FOR SELECT Tabl, Tabk, Cardin, Rang, RowCt FROM @T WHERE Cardin >= 131072 ORDER BY Cardin
OPEN d
FETCH NEXT FROM d INTO @tabl, @tabk, @Card, @Rg, @Rw
WHILE @@FETCH_STATUS = 0
BEGIN 
 SELECT @s = CONCAT('SELECT MAX(b.TI) FROM dbo.',@tabl,CASE LEN(@Tabl) WHEN 3 THEN '' ELSE ' ' END
 ,' a INNER MERGE JOIN dbo.',@tabk,CASE LEN(@Tabl) WHEN 3 THEN '' ELSE ' ' END
 ,' b ON b.GID = a.GID AND b.BID = a.SID WHERE a.GID = 1', CASE @Card WHEN 1 THEN ' AND a.[SID] = 1' ELSE '' END,' OPTION(MAXDOP 1) ') 
 PRINT @s  --IF @Card >= 131072 PRINT REPLACE(@s ,'MAXDOP 1','MAXDOP 1, USE HINT(''DISALLOW_BATCH_MODE'')')
 FETCH NEXT FROM d INTO @tabl, @tabk, @Card, @Rg, @Rw
END
CLOSE d
DEALLOCATE d
GO
/*
*/
GO
DECLARE @T TABLE(ID int IDENTITY PRIMARY KEY, Tabl nvarchar(250), Tabk nvarchar(250), Cardin int, Rang int, RowCt int)
INSERT @T SELECT Tabl, CONCAT('B',SUBSTRING(Tabl,2,LEN(Tabl)-1)), Cardin, Rang, Cardin*Rang RowCt 
FROM dbo.zTest WHERE Tabl <> 'A' ORDER BY Cardin  --SELECT * FROM @T

DECLARE c CURSOR FOR SELECT Tabl, Tabk, Cardin, Rang, RowCt FROM @T ORDER BY Cardin
DECLARE @tabl nvarchar(250), @tabk nvarchar(250), @Card int, @Rg int, @Rw int, @s nvarchar(4000), @s2 nvarchar(1000)
OPEN c
FETCH NEXT FROM c INTO @tabl, @tabk, @Card, @Rg, @Rw
WHILE @@FETCH_STATUS = 0
BEGIN 
 SELECT @s = CONCAT('SELECT MAX(b.TI) FROM dbo.',@tabl,CASE LEN(@Tabl) WHEN 3 THEN '' ELSE ' ' END
 ,' a INNER MERGE JOIN dbo.',@tabk,CASE LEN(@Tabl) WHEN 3 THEN '' ELSE ' ' END
 ,' b ON b.GID = a.GID AND b.SID = a.BID WHERE a.GID = 1', CASE @Card WHEN 1 THEN ' AND a.[SID] = 1' ELSE '' END,' OPTION(MAXDOP 1'
 , CASE WHEN @Card < 131072 THEN '' ELSE ', USE HINT(''DISALLOW_BATCH_MODE'')' END,')') 
 PRINT @s 
 FETCH NEXT FROM c INTO @tabl, @tabk, @Card, @Rg, @Rw
END
CLOSE c
DEALLOCATE c

DECLARE c CURSOR FOR SELECT Tabl, Tabk, Cardin, Rang, RowCt FROM @T WHERE Cardin >= 131072 ORDER BY Cardin
OPEN c
FETCH NEXT FROM c INTO @tabl, @tabk, @Card, @Rg, @Rw
WHILE @@FETCH_STATUS = 0
BEGIN 
 SELECT @s = CONCAT('SELECT MAX(b.TI) FROM dbo.',@tabl,CASE LEN(@Tabl) WHEN 3 THEN '' ELSE ' ' END
 ,' a INNER MERGE JOIN dbo.',@tabk,CASE LEN(@Tabl) WHEN 3 THEN '' ELSE ' ' END
 ,' b ON b.GID = a.GID AND b.SID = a.BID WHERE a.GID = 1', CASE @Card WHEN 1 THEN ' AND a.[SID] = 1' ELSE '' END,' OPTION(MAXDOP 1)')
 PRINT @s 
 FETCH NEXT FROM c INTO @tabl, @tabk, @Card, @Rg, @Rw
END
CLOSE c
DEALLOCATE c
GO
/*



