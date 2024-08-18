USE Test
GO
/*-- generate auto stats for SID

--SELECT * FROM dbo.zTest 
SELECT * FROM dbo.vtest WHERE [table] LIKE 'A%' ORDER BY [table]
SELECT * FROM dbo.vtest WHERE [table] LIKE 'B%' ORDER BY [table]
exec sp_helpstats2 @objname='A%'
exec sp_helpstats2 @objname='A%',@col=3

SELECT * FROM sys.stats WHERE object_id = OBJECT_ID('dbo.A1')
*/

/*
SELECT t.Cardin, t.[table], s.name, h.rows, h.rows_sampled --, d.column_id, c.name
FROM #T t 
LEFT JOIN sys.stats s ON s.object_id = t.oidA AND s.stats_id > 1
LEFT JOIN sys.stats_columns d ON d.object_id = s.object_id AND d.stats_id = s.stats_id AND  d.column_id = 3
LEFT JOIN sys.columns c ON c.object_id = d.object_id AND c.column_id = d.column_id 
OUTER APPLY sys.dm_db_stats_properties(s.object_id, s.stats_id) h 
--WHERE h.rows > h.rows_sampled

SELECT t.Cardin, t.[tablb], s.name, h.rows, h.rows_sampled
FROM #T t JOIN sys.stats s ON s.object_id = t.oidB AND s.stats_id > 1
JOIN sys.stats_columns d ON d.object_id = s.object_id AND d.stats_id = s.stats_id AND  d.column_id = 3
JOIN sys.columns c ON c.object_id = d.object_id AND c.column_id = d.column_id 
OUTER APPLY sys.dm_db_stats_properties(s.object_id, s.stats_id) h 
ORDER BY t.Cardin
CREATE STATISTICS ST_SID ON dbo.A2(SID) WITH FULLSCAN
UPDATE STATISTICS dbo.A1(_WA_Sys_00000003_52442E1F) WITH FULLSCAN
-- DROP TABLE #T
*/

GO
/* 
SELECT * FROM #T 
SELECT * FROM #C
TRUNCATE TABLE #C
*/
DROP TABLE IF EXISTS #T
DROP TABLE IF EXISTS #C
CREATE TABLE #T(Cardin int PRIMARY KEY, [table] varchar(50), [tablb] varchar(250), oidA int, oidB int)
INSERT #T(Cardin, [table], [tablb]) 
SELECT Cardin, [table], CONCAT('B', SUBSTRING([table],2,LEN([table]))) tablb FROM dbo.vtest WHERE [table] LIKE 'A%' AND Cardin > 1 ORDER BY [table]
UPDATE #T SET oidA = OBJECT_ID([table]), oidB = OBJECT_ID([tablb])  -- , s.stats_id, d.column_id, c.name -- 

CREATE TABLE #C(Cardin int INDEX CX CLUSTERED, [table] varchar(50), Col varchar(5), stat varchar(250), rows1 bigint, rows_sampled bigint, last_updated datetime2(0))
INSERT #C
SELECT t.Cardin, t.[table], x.name Col, x.stat, h.rows, h.rows_sampled, h.last_updated
FROM #T t OUTER APPLY (
 SELECT s.stats_id, s.name stat, s.auto_created, c.name --, d.stats_column_id, d.column_id, c.name col
 FROM sys.columns c
 LEFT JOIN sys.stats_columns d ON d.object_id = c.object_id AND d.column_id = c.column_id AND d.stats_column_id = 1
 LEFT JOIN sys.stats s ON s.object_id = d.object_id AND s.stats_id = d.stats_id  AND s.stats_id <> 1   -- JOIN  ON d.object_id = s.object_id AND d.stats_id = s.stats_id  -- JOIN  ON c.object_id = d.object_id AND c.column_id = d.column_id 
 WHERE c.object_id = t.oidA AND c.name IN ('SID','BID','AID')
) x OUTER APPLY sys.dm_db_stats_properties(t.oidA, x.stats_id) h 
ORDER BY t.Cardin

DECLARE @Cardin int, @table varchar(50), @Col varchar(5), @stat varchar(250), @rows1 bigint, @rows_sampled bigint, @sql nvarchar(1000)
DECLARE c CURSOR FOR  SELECT Cardin, [table], Col, stat, rows1, rows_sampled FROM #C --WHERE rows1 > rows_sampled OR stat IS NULL
OPEN c
FETCH NEXT FROM c INTO @Cardin, @table, @Col, @stat, @rows1, @rows_sampled
WHILE @@FETCH_STATUS = 0 
BEGIN
 IF @stat IS NOT NULL AND @stat LIKE '%WA%Sys%'
 BEGIN
	SELECT @sql = CONCAT ('DROP STATISTICS dbo.',@table,'.',@stat); PRINT @sql
	exec sp_executesql @sql; SELECT @stat = NULL
 END
 IF @stat IS NOT NULL AND @rows1 > @rows_sampled
	SELECT @sql = CONCAT ('UPDATE STATISTICS dbo.',@table,'(',@stat,') WITH FULLSCAN')
 ELSE IF @stat IS NULL
	SELECT @sql = CONCAT ('CREATE STATISTICS ST_',@Col,' ON dbo.',@table,'(',@Col,') WITH FULLSCAN')
 ELSE SELECT @sql = CONCAT('-- ',@table,' -- no action ',@rows1,', ',@rows_sampled)
 exec sp_executesql @sql ;  PRINT @sql
 FETCH NEXT FROM c INTO @Cardin, @table, @Col, @stat, @rows1, @rows_sampled -- PRINT CONCAT (@Cardin,', ',@table,', ', @stat)
END
CLOSE c
DEALLOCATE c

TRUNCATE TABLE #C

INSERT #C
SELECT t.Cardin, t.[tablb], x.name Col, x.stat, h.rows, h.rows_sampled, h.last_updated
FROM #T t OUTER APPLY (
 SELECT s.stats_id, s.name stat, s.auto_created, c.name 
 FROM sys.columns c LEFT JOIN sys.stats_columns d ON d.object_id = c.object_id AND d.column_id = c.column_id AND d.stats_column_id = 1
 LEFT JOIN sys.stats s ON s.object_id = d.object_id AND s.stats_id = d.stats_id  AND s.stats_id <> 1   
 WHERE c.object_id = t.oidB AND c.name IN ('SID','BID')
) x OUTER APPLY sys.dm_db_stats_properties(t.oidB, x.stats_id) h 
ORDER BY t.Cardin
-- DECLARE @Cardin int, @table varchar(50), @Col varchar(5), @stat varchar(250), @rows1 bigint, @rows_sampled bigint, @sql nvarchar(1000)
DECLARE c CURSOR FOR  SELECT Cardin, [table], Col, stat, rows1, rows_sampled FROM #C --WHERE rows1 > rows_sampled OR stat IS NULL
OPEN c
FETCH NEXT FROM c INTO @Cardin, @table, @Col, @stat, @rows1, @rows_sampled
WHILE @@FETCH_STATUS = 0 
BEGIN
  IF @stat IS NOT NULL AND @stat LIKE '%WA%Sys%'
 BEGIN
	SELECT @sql = CONCAT ('DROP STATISTICS dbo.',@table,'.',@stat); PRINT @sql
	exec sp_executesql @sql; SELECT @stat = NULL
 END
 IF @stat IS NOT NULL AND @rows1 > @rows_sampled
	SELECT @sql = CONCAT ('UPDATE STATISTICS dbo.',@table,'(',@stat,') WITH FULLSCAN')
 ELSE IF @stat IS NULL
	SELECT @sql = CONCAT ('CREATE STATISTICS ST_',@Col,' ON dbo.',@table,'(',@Col,') WITH FULLSCAN')
 ELSE SELECT @sql = CONCAT('-- ',@table,', ',@stat,' -- no action ',@rows1,', ',@rows_sampled)
 exec sp_executesql @sql ;  PRINT @sql
 FETCH NEXT FROM c INTO @Cardin, @table, @Col, @stat, @rows1, @rows_sampled -- PRINT CONCAT (@Cardin,', ',@table,', ', @stat)
END
CLOSE c
DEALLOCATE c

DROP TABLE IF EXISTS #T
DROP TABLE IF EXISTS #C

exec sp_helpstats2 'A8D'
exec sp_helpstats2 'B8D'
/*
SELECT * FROM #C
exec sp_helpstats2 @objname='A%', @col=3
exec sp_helpstats2 @objname='B%'
DBCC SHOW_STATISTICS('dbo.B1',ST_SID)

SELECT Tabl, Cardin, Rang, Cardin*Rang rw, Cardin*Rang - RowCt diff, Cardin*Rang/101., Cardin*Rang/101. - ird irx, ird
FROM dbo.zTest --WHERE Cardin*Rang <> RowCt 

SELECT [table], Cardin, Rang, row_count, idp FROM dbo.vtest WHERE [table] LIKE 'A%' AND [table] <> 'A' ORDER BY Cardin

SELECT * FROM dbo.vtest WHERE [table] LIKE 'A%' AND [table] <> 'A' ORDER BY Cardin

DECLARE @objname nvarchar(4000) = 'A%', @ds sysname = NULL , @sch sysname = NULL, @not sysname = NULL, @col int = 3

DECLARE @obj TABLE(schema_id int, object_id int primary key, [type] char(2), [Object] sysname, pt int, pp int, uPgC bigint, rct bigint, create_date datetime)
INSERT @obj
exec dbo.sp_parseobjects @objname, @ds, @sch, @not

 UPDATE o  SET pt = d.pt, pp = d.pp, uPgC = d.uPgC, rct = d.rct 
 FROM @obj o OUTER APPLY ( 
	SELECT COUNT(*) pt, SUM(CASE d.row_count WHEN 0 THEN 0 ELSE 1 END) pp , SUM(d.used_page_count) uPgC, SUM(d.row_count) rct
	FROM sys.dm_db_partition_stats d WHERE d.object_id = o.object_id AND d.index_id IN (0,1) ) d -- SELECT * FROM @obj

;WITH j AS ( 
 SELECT j.object_id, j.stats_id, STRING_AGG(c.name+CASE partition_ordinal WHEN 1 THEN '*' ELSE '' END,',') WITHIN GROUP(ORDER BY k.key_ordinal, stats_column_id) Cols
 FROM sys.stats_columns j INNER JOIN sys.columns c ON c.object_id = j.object_id AND c.column_id = j.column_id 
 AND (@col IS NULL OR (j.column_id = @col AND j.stats_column_id =1))
 LEFT JOIN sys.index_columns k ON k.object_id = j.object_id AND k.index_id = j.stats_id AND k.index_column_id = j.stats_column_id
 GROUP BY  j.object_id, j.stats_id
) 
SELECT a.*, t.name, t.stats_id, j.*
FROM @obj a JOIN sys.objects o ON o.object_id = a.object_id
LEFT JOIN sys.stats t ON t.object_id = o.object_id 
LEFT JOIN j ON j.object_id = t.object_id AND j.stats_id = t.stats_id
WHERE @col IS NULL OR j.stats_id IS NOT NULL



--SELECT * FROM @obj
 SELECT j.object_id, j.stats_id, j.stats_column_id, c.name, j.column_id
 FROM sys.stats_columns j INNER JOIN sys.columns c ON c.object_id = j.object_id AND c.column_id = j.column_id 
 WHERE (@col IS NULL OR j.column_id = @col)

 SELECT j.object_id, j.stats_id, STRING_AGG(c.name+CASE partition_ordinal WHEN 1 THEN '*' ELSE '' END,',') WITHIN GROUP(ORDER BY k.key_ordinal, stats_column_id) Cols
 FROM sys.stats_columns j INNER JOIN sys.columns c ON c.object_id = j.object_id AND c.column_id = j.column_id 
 AND (@col IS NULL OR j.column_id = @col)
 LEFT JOIN sys.index_columns k ON k.object_id = j.object_id AND k.index_id = j.stats_id AND k.index_column_id = j.stats_column_id
 GROUP BY  j.object_id, j.stats_id
*/

DECLARE @T TABLE(Tabl varchar(3),Cardin int, Rang int, row_count int, idp int, LstPFr int, lstPRw int)
INSERT @T
SELECT [table], Cardin, Rang, row_count, idp, LstPFr, lstPRw FROM dbo.vtest WHERE [table] LIKE 'A%' AND [table] <> 'Ax' ORDER BY Cardin

SELECT z.Tabl, z.Cardin, z.Rang, z.RowCt, z.ird, z.Loop1, z.Loop2, z.Merg, z.Hasj, z.SMer, z.Mtm, t.Tabl, t.Cardin, t.Rang, t.row_count, t.idp,  LstPFr, lstPRw
FROM dbo.zTest z LEFT JOIN @T t ON t.Cardin = z.Cardin
ORDER BY z.Cardin
