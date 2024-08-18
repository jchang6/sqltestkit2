USE Test
GO
/*
SELECT * FROM dbo.vDbPtSt WHERE [table] LIKE 'B%' ORDER BY [table]
exec sp_helpindex2 'B%'
exec sp_spaceused2 @objname='A%', @Ord=1
exec sp_spaceused2 @objname='B%', @Ord=1
exec sp_configure 'max server memory (MB)'
exec sp_configure
*/
/*
cost threshold for parallelism
max degree of parallelism
SELECT * FROM dbo.zTest2 --WHERE Loop1 = 0

SELECT Tabl, Cardin, Rang, Cardin*Rang RowCt, Loop1 FROM dbo.zTest2 WHERE Tabl <> 'A0' --AND Cardin >= 14336
ORDER BY Cardin 

SELECT CONCAT('B',SUBSTRING(Tabl,2,LEN(Tabl)-1)), Cardin, Rang, Cardin*Rang RowCt 
FROM dbo.zTest2 WHERE Tabl <> 'A0' ORDER BY Cardin 
*/
/*
*/
-- check contents of buffer pool
--SELECT [name], index_id, COUNT(*) FROM dbo.vOsBuf  WHERE object_id > 1000   GROUP BY [name], index_id ORDER BY index_id, [name]
/*
SELECT MAX(b.TI), COUNT(*) FROM dbo.AJ a INNER LOOP JOIN dbo.A0 b ON b.AID = a.AID 
SELECT MAX(b.TI), COUNT(*) FROM dbo.A0 a INNER LOOP JOIN dbo.AI b ON b.GID = a.GID AND b.[SID] = a.[SID]
*/
GO
/*
-- load tables to buffer pool
*/
GO
PRINT @@SERVERNAME
SET NOCOUNT ON
DECLARE @T TABLE(ID int IDENTITY PRIMARY KEY, Tabl nvarchar(250), Tabk nvarchar(250), Cardin int, Rang int, RowCt int, Loop1 int)
INSERT @T SELECT Tabl, CONCAT('B',SUBSTRING(Tabl,2,LEN(Tabl)-1)), Cardin, Rang, Cardin*Rang RowCt, Loop1 
FROM dbo.zTest2 WHERE Tabl <> '' ORDER BY Cardin  --SELECT * FROM @T
DECLARE c CURSOR FOR SELECT Tabl, Tabk, Cardin, Rang, RowCt FROM @T ORDER BY Cardin
DECLARE @tabl nvarchar(250), @tabk nvarchar(250), @Card int, @Rg int, @Rw int, @s nvarchar(4000), @s2 nvarchar(1000), @sp nvarchar(1)
OPEN c
FETCH NEXT FROM c INTO @tabl, @tabk, @Card, @Rg, @Rw
WHILE @@FETCH_STATUS = 0
BEGIN 
 IF @Card = 1 SELECT @tabl = 'A1'
 SELECT @sp = CASE LEN(@Tabl) WHEN 3 THEN '' ELSE ' ' END 
-- SELECT @s = CONCAT('SELECT MAX(b.TI), COUNT(*) FROM dbo.',@tabl,CASE LEN(@Tabl) WHEN 3 THEN '' ELSE ' ' END,' a INNER LOOP JOIN dbo.A0 b ON b.AID = a.AID  ') 
 SELECT @s = CONCAT('SELECT MAX(b.TI), COUNT(*) FROM dbo.',@tabl,CASE LEN(@Tabl) WHEN 3 THEN '' ELSE ' ' END
 ,' a INNER LOOP JOIN dbo.',@tabk,CASE LEN(@Tabl) WHEN 3 THEN '' ELSE ' ' END
 ,' b ON b.GID = a.GID AND b.SID = a.SID ') -- WHERE a.GID = 1 OPTION(MAXDOP 1) --PRINT @s 
-- exec sp_executesql @s
 PRINT CONCAT('--',CONVERT(char(23),GETDATE(),121),', ',@tabl,@sp,', ',STR(@Card,6),', ',STR(@Rg,7),', ',@Rw)
 FETCH NEXT FROM c INTO @tabl, @tabk, @Card, @Rg, @Rw
END
CLOSE c
DEALLOCATE c
GO
/*
*/
GO
-- verify buffer pool
--SELECT [name], index_id, COUNT(*) FROM dbo.vOsBuf  WHERE object_id > 1000  GROUP BY [name], index_id ORDER BY index_id, [name]
GO
/*
-- Loop 1
--SELECT * FROM @T
SELECT * FROM dbo.zTest2 WHERE Tabl <> 'A0' ORDER BY Cardin  
*/
GO
SET NOCOUNT ON
PRINT CONCAT('-- ',@@SERVERNAME,' Loop 1')
DECLARE @T TABLE(ID int IDENTITY PRIMARY KEY, Tabl nvarchar(250), Tabk nvarchar(250), Cardin int, Rang int, RowCt int, ExCt int)
INSERT @T SELECT Tabl, CONCAT('B',SUBSTRING(Tabl,2,LEN(Tabl)-1)), Cardin, Rang, Cardin*Rang RowCt, Loop1 
FROM dbo.zTest2 WHERE Tabl <> '' ORDER BY Cardin  
DECLARE c CURSOR FOR SELECT Tabl, Tabk, Cardin, Rang, ExCt FROM @T ORDER BY Cardin
DECLARE @tabl nvarchar(250), @tabk nvarchar(250), @Card int, @Rg int, @Rh int, @Ec int, @s nvarchar(4000), @s2 nvarchar(1000)
OPEN c
FETCH NEXT FROM c INTO @tabl, @tabk, @Card, @Rg, @Ec
WHILE @@FETCH_STATUS = 0
BEGIN 
 IF @Card = 1 SELECT @tabl = 'A1', @tabk = 'B1'
 SELECT @Rh = Rang FROM dbo.zTest2 WHERE Cardin = 2
 SELECT @Rg = CASE @Card WHEN 1 THEN @Rh ELSE @Rg END
 SELECT @s = CONCAT('DECLARE @I int, @R int SELECT @I = 1+'
 ,@Rg,'*RAND(CHECKSUM(NEWID())); SELECT @R=MAX(b.TI) FROM dbo.',@tabl,CASE LEN(@Tabl) WHEN 3 THEN '' ELSE ' ' END
 ,' a INNER LOOP JOIN dbo.A b ON b.AID = a.AID WHERE a.GID = @I',CASE @Card WHEN 1 THEN ' AND a.[SID] = 1' ELSE '' END,' OPTION(MAXDOP 1)
GO ',@Ec) 
PRINT @s -- exec sp_executesql @s
-- PRINT CONCAT('--',CONVERT(char(23),GETDATE(),121),', ',@tabl,', ',@Card,', ',@Rg,', ',@Ec)
 FETCH NEXT FROM c INTO @tabl, @tabk, @Card, @Rg, @Ec
END
CLOSE c
DEALLOCATE c
GO
/**/
GO
SET NOCOUNT ON
PRINT CONCAT('-- ',@@SERVERNAME,' Loop 2')
DECLARE @T TABLE(ID int IDENTITY PRIMARY KEY, Tabl nvarchar(250), Tabk nvarchar(250), Cardin int, Rang int, RowCt int, ExCt int)
INSERT @T SELECT Tabl, CONCAT('B',SUBSTRING(Tabl,2,LEN(Tabl)-1)), Cardin, Rang, Cardin*Rang RowCt, Loop2 
FROM dbo.zTest2 WHERE Tabl <> '' ORDER BY Cardin ; --SELECT * FROM @T
DECLARE c CURSOR FOR SELECT Tabl, Tabk, Cardin, Rang, ExCt FROM @T ORDER BY Cardin
DECLARE @tabl nvarchar(250), @tabk nvarchar(250), @Card int, @Rg int, @Rh int, @Ec int, @s nvarchar(4000), @s2 nvarchar(1000)
OPEN c
FETCH NEXT FROM c INTO @tabl, @tabk, @Card, @Rg, @Ec
WHILE @@FETCH_STATUS = 0
BEGIN 
 IF @Card = 1 SELECT @tabl = 'A1', @tabk = 'B1'
 SELECT @Rh = Rang FROM dbo.zTest2 WHERE Cardin = 2
 SELECT @Rg = CASE @Card WHEN 1 THEN @Rh ELSE @Rg END
 SELECT @s = CONCAT('DECLARE @I int, @R int SELECT @I = 1+'
 ,@Rg,'*RAND(CHECKSUM(NEWID())); SELECT @R=MAX(b.TI) FROM dbo.',@tabl,CASE LEN(@Tabl) WHEN 3 THEN '' ELSE ' ' END
 ,' a INNER LOOP JOIN dbo.',@tabk,CASE LEN(@Tabl) WHEN 3 THEN '' ELSE ' ' END
 ,' b ON b.GID = a.GID AND b.[SID] = a.[SID] WHERE a.GID = @I',CASE @Card WHEN 1 THEN ' AND a.[SID] = 1' ELSE '' END,' OPTION(MAXDOP 1)
GO ',@Ec) 
PRINT @s  -- exec sp_executesql @s
 FETCH NEXT FROM c INTO @tabl, @tabk, @Card, @Rg, @Ec
END
CLOSE c
DEALLOCATE c
GO
/**/
GO
SET NOCOUNT ON
PRINT CONCAT('-- ',@@SERVERNAME,' Merge')
DECLARE @T TABLE(ID int IDENTITY PRIMARY KEY, Tabl nvarchar(250), Tabk nvarchar(250), Cardin int, Rang int, RowCt int, ExCt int)
INSERT @T SELECT Tabl, CONCAT('B',SUBSTRING(Tabl,2,LEN(Tabl)-1)), Cardin, Rang, Cardin*Rang RowCt, Merg 
FROM dbo.zTest2 WHERE Tabl <> '' ORDER BY Cardin ;  --SELECT * FROM @T
DECLARE c CURSOR FOR SELECT Tabl, Tabk, Cardin, Rang, ExCt FROM @T ORDER BY Cardin
DECLARE @tabl nvarchar(250), @tabk nvarchar(250), @Card int, @Rg int, @Rh int, @Ec int, @s nvarchar(4000), @s2 nvarchar(1000)
OPEN c
FETCH NEXT FROM c INTO @tabl, @tabk, @Card, @Rg, @Ec
WHILE @@FETCH_STATUS = 0
BEGIN 
 IF @Card = 1 SELECT @tabl = 'A1', @tabk = 'B1'
 SELECT @Rh = Rang FROM dbo.zTest2 WHERE Cardin = 2
 SELECT @Rg = CASE @Card WHEN 1 THEN @Rh ELSE @Rg END
 SELECT @s = CONCAT('DECLARE @I int, @R int SELECT @I = 1+'
 ,@Rg,'*RAND(CHECKSUM(NEWID())); SELECT @R=MAX(b.TI) FROM dbo.',@tabl,CASE LEN(@Tabl) WHEN 3 THEN '' ELSE ' ' END
 ,' a INNER MERGE JOIN dbo.',@tabk,CASE LEN(@Tabl) WHEN 3 THEN '' ELSE ' ' END
 ,' b ON b.GID = a.GID AND b.[SID] = a.[SID] WHERE a.GID = @I',CASE @Card WHEN 1 THEN ' AND a.[SID] = 1' ELSE '' END,' OPTION(MAXDOP 1)
GO ',@Ec) 
PRINT @s -- exec sp_executesql @s
 FETCH NEXT FROM c INTO @tabl, @tabk, @Card, @Rg, @Ec
END
CLOSE c
DEALLOCATE c
GO
/**/
GO
SET NOCOUNT ON
PRINT CONCAT('-- ',@@SERVERNAME,' Hash')
DECLARE @T TABLE(ID int IDENTITY PRIMARY KEY, Tabl nvarchar(250), Tabk nvarchar(250), Cardin int, Rang int, RowCt int, ExCt int)
INSERT @T SELECT Tabl, CONCAT('B',SUBSTRING(Tabl,2,LEN(Tabl)-1)), Cardin, Rang, Cardin*Rang RowCt, Hasj 
FROM dbo.zTest2 WHERE Tabl <> '' ORDER BY Cardin ; --SELECT * FROM @T

DECLARE @tabl nvarchar(250), @tabk nvarchar(250), @Card int, @Rg int, @Rh int, @Ec int, @s nvarchar(4000), @s2 nvarchar(1000)
DECLARE c CURSOR FOR SELECT Tabl, Tabk, Cardin, Rang, ExCt FROM @T ORDER BY Cardin
OPEN c
FETCH NEXT FROM c INTO @tabl, @tabk, @Card, @Rg, @Ec
WHILE @@FETCH_STATUS = 0
BEGIN 
 IF @Card = 1 SELECT @tabl = 'A1', @tabk = 'B1'
 SELECT @Rh = Rang FROM dbo.zTest2 WHERE Cardin = 2
 SELECT @Rg = CASE @Card WHEN 1 THEN @Rh ELSE @Rg END
 SELECT @s = CONCAT('DECLARE @I int, @R int SELECT @I = 1+'
 ,@Rg,'*RAND(CHECKSUM(NEWID())); SELECT @R=MAX(b.TI) FROM dbo.',@tabl,CASE LEN(@Tabl) WHEN 3 THEN '' ELSE ' ' END
 ,' a INNER HASH JOIN dbo.',@tabk,CASE LEN(@Tabl) WHEN 3 THEN '' ELSE ' ' END
 ,' b ON b.GID = a.GID AND b.[SID] = a.[SID] WHERE a.GID = @I',CASE @Card WHEN 1 THEN ' AND a.[SID] = 1' ELSE '' END,' OPTION(MAXDOP 1'
 , CASE WHEN @Card < 131072 THEN '' ELSE ', USE HINT(''DISALLOW_BATCH_MODE'')' END,')
GO ',@Ec) 
PRINT @s -- exec sp_executesql @s
 FETCH NEXT FROM c INTO @tabl, @tabk, @Card, @Rg, @Ec
END
CLOSE c
DEALLOCATE c

DECLARE c CURSOR FOR SELECT Tabl, Tabk, Cardin, Rang, ExCt FROM @T WHERE Cardin >= 131072 ORDER BY Cardin
OPEN c
FETCH NEXT FROM c INTO @tabl, @tabk, @Card, @Rg, @Ec
WHILE @@FETCH_STATUS = 0
BEGIN 
 SELECT @s = CONCAT('DECLARE @I int, @R int SELECT @I = 1+'
 ,@Rg,'*RAND(CHECKSUM(NEWID())); SELECT @R=MAX(b.TI) FROM dbo.',@tabl,CASE LEN(@Tabl) WHEN 3 THEN '' ELSE ' ' END
 ,' a INNER HASH JOIN dbo.',@tabk,CASE LEN(@Tabl) WHEN 3 THEN '' ELSE ' ' END
 ,' b ON b.GID = a.GID AND b.[SID] = a.[SID] WHERE a.GID = @I',CASE @Card WHEN 1 THEN ' AND a.[SID] = 1' ELSE '' END,' OPTION(MAXDOP 1)
GO ',2*@Ec) 
PRINT @s -- exec sp_executesql @s
 FETCH NEXT FROM c INTO @tabl, @tabk, @Card, @Rg, @Ec
END
CLOSE c
DEALLOCATE c

GO
/**/
GO
SET NOCOUNT ON
PRINT CONCAT('-- ',@@SERVERNAME,' Sort M')
DECLARE @T TABLE(ID int IDENTITY PRIMARY KEY, Tabl nvarchar(250), Tabk nvarchar(250), Cardin int, Rang int, RowCt int, ExCt int)
INSERT @T SELECT Tabl, CONCAT('B',SUBSTRING(Tabl,2,LEN(Tabl)-1)), Cardin, Rang, Cardin*Rang RowCt, SMer 
FROM dbo.zTest2 WHERE Tabl <> 'A' ORDER BY Cardin ; --SELECT * FROM @T
DECLARE @tabl nvarchar(250), @tabk nvarchar(250), @Card int, @Rg int, @Rh int, @Ec int, @s nvarchar(4000), @s2 nvarchar(1000)

DECLARE c CURSOR FOR SELECT Tabl, Tabk, Cardin, Rang, ExCt FROM @T ORDER BY Cardin
OPEN c
FETCH NEXT FROM c INTO @tabl, @tabk, @Card, @Rg, @Ec
WHILE @@FETCH_STATUS = 0
BEGIN 
 IF @Card = 1 SELECT @tabl = 'A1', @tabk = 'B1'
 SELECT @Rh = Rang FROM dbo.zTest2 WHERE Cardin = 2
 SELECT @Rg = CASE @Card WHEN 1 THEN @Rh ELSE @Rg END
 SELECT @s = CONCAT('DECLARE @I int, @R int SELECT @I = 1+'
 ,@Rg,'*RAND(CHECKSUM(NEWID())); SELECT @R=MAX(b.TI) FROM dbo.',@tabl,CASE LEN(@Tabl) WHEN 3 THEN '' ELSE ' ' END
 ,' a INNER MERGE JOIN dbo.',@tabk,CASE LEN(@Tabl) WHEN 3 THEN '' ELSE ' ' END
 ,' b ON b.GID = a.GID AND b.BID = a.[SID] WHERE a.GID = @I',CASE @Card WHEN 1 THEN ' AND a.[SID] = 1' ELSE '' END,' OPTION(MAXDOP 1'
 , CASE WHEN @Card < 131072 THEN '' ELSE ', USE HINT(''DISALLOW_BATCH_MODE'')' END,')
GO ',@Ec) 
PRINT @s -- exec sp_executesql @s
 FETCH NEXT FROM c INTO @tabl, @tabk, @Card, @Rg, @Ec
END
CLOSE c
DEALLOCATE c

DECLARE c CURSOR FOR SELECT Tabl, Tabk, Cardin, Rang, ExCt FROM @T WHERE Cardin >= 131072 ORDER BY Cardin
OPEN c
FETCH NEXT FROM c INTO @tabl, @tabk, @Card, @Rg, @Ec
WHILE @@FETCH_STATUS = 0
BEGIN 
 SELECT @s = CONCAT('DECLARE @I int, @R int SELECT @I = 1+'
 ,@Rg,'*RAND(CHECKSUM(NEWID())); SELECT @R=MAX(b.TI) FROM dbo.',@tabl,CASE LEN(@Tabl) WHEN 3 THEN '' ELSE ' ' END
 ,' a INNER MERGE JOIN dbo.',@tabk,CASE LEN(@Tabl) WHEN 3 THEN '' ELSE ' ' END
 ,' b ON b.GID = a.GID AND b.BID = a.[SID] WHERE a.GID = @I',CASE @Card WHEN 1 THEN ' AND a.[SID] = 1' ELSE '' END,' OPTION(MAXDOP 1)
GO ',2*@Ec) 
PRINT @s -- exec sp_executesql @s
 FETCH NEXT FROM c INTO @tabl, @tabk, @Card, @Rg, @Ec
END
CLOSE c
DEALLOCATE c
GO

/*
*/
GO
/*
*/
GO
/*
SELECT 'xx' a, statement_text, execution_count, total_worker_time, total_elapsed_time, tphys_reads, tlog_reads, total_rows, start_off, end_off,  av_w, creation_time, last_execution_time 
--into dbo.stat20221209a
FROM dbo.veqs WHERE  total_worker_time > 100000 AND execution_count >= 30  --AND start_off BETWEEN 200 AND 250  --
ORDER BY last_execution_time 

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
DBCC USEROPTIONS

--DROP TABLE IF EXISTS dbo.stat20221209a
*/
GO
SET NOCOUNT ON
GO
DBCC FREEPROCCACHE
GO

GO
/*
*/
GO
