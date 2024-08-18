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
DECLARE @n nvarchar(50), @s nvarchar(1000)
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
DECLARE @n nvarchar(50), @s nvarchar(1000)
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
DROP TABLE AI2, BI2
DROP TABLE BD3,BD4,BD7,BD9

exec dbo.sp_spaceused2 @Ord=1
exec dbo.sp_spaceused2 @objname='A%', @Ord=1
exec dbo.sp_spaceused2 @objname='B%', @Ord=1
-- ztest should have beeen created
SELECT * FROM dbo.zTest

SELECT * FROM dbo.vDbPtSt WHERE [table] LIKE 'A%' ORDER BY [table] -- , iup, irp

SELECT [table], [index], idp, row_count, Rw_Pg, ABR, IxDep, RpP, FpP, LstPFr, lstPRw, altLPg 
FROM dbo.vDbPtSt WHERE [table] LIKE 'A%' AND [table] <> 'A' AND index_id <= 1 ORDER BY [table]

SELECT [table], Cardin, Rang, row_count, irp --, 1.0*row_count/101 rd , row_count/101 dp, row_count - (row_count/101)*101 diff , ird, rerr, rem 
FROM dbo.vtest WHERE [table] LIKE 'A%' AND [table] <> 'A' ORDER BY Cardin

SELECT [table], Cardin, Rang, row_count, idp, idp*8 data, irp FROM dbo.vtest WHERE [table] LIKE 'A%' AND [table] <> 'A' ORDER BY Cardin
SELECT [table], Cardin, Rang, row_count, idp, idp*8 data, irp FROM dbo.vtest WHERE [table] LIKE 'B%' AND [table] <> 'B' ORDER BY Cardin

SELECT Tabl, Cardin, Rang, RowCt, ird , RowCt - Cardin*Rang, ird - RowCt/101.  FROM dbo.zTest
SELECT Tabl, Cardin, Rang, Cardin*Rang RowCt FROM dbo.zTest ORDER BY Cardin

SELECT Tabl, CONCAT('B',SUBSTRING(Tabl,2,LEN(Tabl)-1)) Tabb
, Cardin, Rang, Cardin*Rang RowCt FROM dbo.zTest ORDER BY Cardin
--SELECT name FROM sys.tables WHERE name LIKE 'B%' AND name <> 'B' AND name <> 'B0' ORDER BY name --SELECT * FROM @T
*/
GO
/* -- Create tables
SELECT * FROM @T WHERE Tabl = 'AE3'
*/
GO
DECLARE @T TABLE(ID int IDENTITY PRIMARY KEY, Tabl nvarchar(250), Cardin int, Rang int, RowCt int)
INSERT @T 
SELECT Tabl, Cardin, Rang, Cardin*Rang RowCt FROM dbo.zTest --WHERE Cardin BETWEEN 8768 AND 8892
ORDER BY Cardin 
DECLARE c CURSOR FOR SELECT Tabl, Cardin, Rang, RowCt FROM @T ORDER BY Cardin
DECLARE @tabl nvarchar(50), @Card int, @Rg int, @Rw int, @s nvarchar(4000)
OPEN c
FETCH NEXT FROM c INTO @tabl, @Card, @Rg, @Rw
WHILE @@FETCH_STATUS = 0
BEGIN
 SELECT @s = CONCAT('IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(''dbo.',@tabl,'''))
 ','CREATE TABLE dbo.',@tabl,'(AID int NOT NULL, GID int NOT NULL, [SID] int NOT NULL, BID int NOT NULL, CID int NOT NULL, DID int NOT NULL, EID int NOT NULL
 , R1 int NOT NULL, R2 int NOT NULL, R3 int NOT NULL, R4 int NOT NULL, R5 int NOT NULL, R6 int NOT NULL, R7 int NOT NULL, R8 int NOT NULL, R9 int NOT NULL, RA int NOT NULL, TI tinyint NOT NULL
 , CONSTRAINT PK_',@tabl,' PRIMARY KEY CLUSTERED(',CASE WHEN @tabl NOT IN ('A','B') THEN 'GID,SID' ELSE 'AID' END,'))') 
 IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(@tabl))
 PRINT @s
 exec sp_executesql @s
 FETCH NEXT FROM c INTO @tabl, @Card, @Rg, @Rw
END
CLOSE c
DEALLOCATE c
GO
DECLARE @T TABLE(ID int IDENTITY PRIMARY KEY, Tabl nvarchar(250), Cardin int, Rang int, RowCt int)
INSERT @T 
SELECT CONCAT('B',SUBSTRING(Tabl,2,LEN(Tabl)-1)), Cardin, Rang, Cardin*Rang RowCt FROM dbo.zTest WHERE Cardin > 1 --WHERE Cardin BETWEEN 8768 AND 8892
ORDER BY Cardin 
DECLARE c CURSOR FOR SELECT Tabl, Cardin, Rang, RowCt FROM @T ORDER BY Cardin
DECLARE @tabl nvarchar(50), @Card int, @Rg int, @Rw int, @s nvarchar(4000)
OPEN c
FETCH NEXT FROM c INTO @tabl, @Card, @Rg, @Rw
WHILE @@FETCH_STATUS = 0
BEGIN
 SELECT @s = CONCAT('IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(''dbo.',@tabl,'''))
 ','CREATE TABLE dbo.',@tabl,'(AID int NOT NULL, GID int NOT NULL, [SID] int NOT NULL, BID int NOT NULL, CID int NOT NULL, DID int NOT NULL, EID int NOT NULL
 , R1 int NOT NULL, R2 int NOT NULL, R3 int NOT NULL, R4 int NOT NULL, R5 int NOT NULL, R6 int NOT NULL, R7 int NOT NULL, R8 int NOT NULL, R9 int NOT NULL, RA int NOT NULL, TI tinyint NOT NULL
 , CONSTRAINT PK_',@tabl,' PRIMARY KEY CLUSTERED(',CASE WHEN @tabl NOT IN ('A','B') THEN 'GID,SID' ELSE 'AID' END,'))') 
 IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(@tabl))
 PRINT @s
 exec sp_executesql @s
 FETCH NEXT FROM c INTO @tabl, @Card, @Rg, @Rw
END
CLOSE c
DEALLOCATE c
GO
/*
exec sp_spaceused2 @objname='A%', @Ord=1 
exec sp_spaceused2 @objname='B%', @Ord=1 

DROP TABLE dbo.B0
TRUNCATE TABLE dbo.A8D
TRUNCATE TABLE dbo.B8D
-- Populate tables
--SELECT * FROM @T
-- Cardin < 65536  -- Tabl IN ('AE2','AE3') -- 
*/
GO
DECLARE @T TABLE(ID int IDENTITY PRIMARY KEY, Tabl nvarchar(250), Cardin int, Rang int, RowCt int)
INSERT @T 
SELECT Tabl, Cardin, Rang, Cardin*Rang RowCt FROM dbo.zTest WHERE Tabl <> 'A0' --AND Cardin = 352 --  BETWEEN 8768 AND 8892  Cardin IN (1536,3072) 
ORDER BY Cardin 
DECLARE c CURSOR FOR SELECT Tabl, Cardin, Rang, RowCt FROM @T ORDER BY Cardin
DECLARE @tabl nvarchar(50), @Card int, @Rg int, @Rw int, @s nvarchar(4000), @s2 nvarchar(1000), @sp nvarchar(1)
OPEN c
FETCH NEXT FROM c INTO @tabl, @Card, @Rg, @Rw
WHILE @@FETCH_STATUS = 0
BEGIN 
 SELECT @sp = CASE LEN(@Tabl) WHEN 3 THEN '' ELSE ' ' END 
 SELECT @s = CONCAT('SET NOCOUNT ON; 
DECLARE @I int = 0, @N int = 10574, @Card int = ',@Card,', @Rn int = ',@Rg,', @T int = ',@Rw,', @Rh int; 
DECLARE @R1 int=2, @R2 int=4, @R3 int=8, @R4 int=16, @R5 int=32, @R6 int=64, @R7 int=128, @R8 int=256, @R9 int=512, @RA int=1024, @RY int=250
IF NOT EXISTS(SELECT * FROM dbo.',@tabl,')
BEGIN
 SELECT @Rh = Rang FROM dbo.zTest WHERE Cardin = 2
 SELECT @Rn = CASE @Card WHEN 1 THEN @Rh ELSE @Rn END
WHILE @I*@N < @T
BEGIN
 INSERT dbo.',@tabl, '
 SELECT ID+1 ID, G, S, B, (S-1)%@R1+1 C, (S-1)%@R2+1 D, (S-1)%@R3+1 E
 , ID%@R1+1 R1, ID%@R2+1 R2, ID%@R3+1 R3, ID%@R4+1 R4, ID%@R5+1 R5, ID%@R6+1 R6, ID%@R7+1 R7, ID%@R8+1 R8, ID%@R9+1 R9, ID%@RA+1 RA, ID%@RY+1 GT
 FROM (SELECT ID ID, ID%@Rn+1 G, ID/@Rn+1 S, ID/@Rn+1 B FROM (SELECT @I*@N+I-1 ID FROM dbo.Nums) a ) b WHERE ID < @T; 
 SELECT @I = @I+1
END 
ALTER INDEX ALL ON dbo.',@tabl,' REBUILD WITH(SORT_IN_TEMPDB=ON, MAXDOP=1, FILLFACTOR=100)
PRINT @tabl
END ') 
 exec sp_executesql @s, N'@tabl nvarchar(50)', @tabl
--SELECT @s2 = CONCAT('IF NOT EXISTS(SELECT * FROM dbo.',@tabl,') PRINT @s')
-- exec sp_executesql @s2, N'@s nvarchar(4000)', @s
-- PRINT @s
-- SELECT @s2 = CONCAT('ALTER INDEX ALL ON dbo.',@tabl,' REBUILD WITH(SORT_IN_TEMPDB=ON, MAXDOP=1, FILLFACTOR=100) ')  -- PRINT @s -- PRINT @s2
-- exec sp_executesql @s2
-- PRINT @s2
 -- PRINT CONCAT('--',CONVERT(char(23),GETDATE(),121),', ',@Tabl,@sp,', ',STR(@Card,7),', ',STR(@Rg,6),', ',@Rw)
 FETCH NEXT FROM c INTO @tabl, @Card, @Rg, @Rw
END
CLOSE c
DEALLOCATE c
GO
/*
exec sp_spaceused2 @Ord=1, @objname='A%'
-- Cardin >= 65536  IN ('AE2','AE3') -- --SELECT * FROM @T --AND Cardin >= 14336
*/
GO
DECLARE @T TABLE(ID int IDENTITY PRIMARY KEY, Tabl nvarchar(250), Cardin int, Rang int, RowCt int)
INSERT @T SELECT CONCAT('B',SUBSTRING(Tabl,2,LEN(Tabl)-1)), Cardin, Rang, Cardin*Rang RowCt FROM dbo.zTest WHERE Tabl <> 'A' --AND Cardin = 352 -- IN (1536,3072) -- BETWEEN 320 AND 352
ORDER BY Cardin 

DECLARE c CURSOR FOR SELECT Tabl, Cardin, Rang, RowCt FROM @T ORDER BY Cardin
DECLARE @tabl nvarchar(50), @Card int, @Rg int, @Rw int, @s nvarchar(4000), @s2 nvarchar(1000), @sp nvarchar(1)
OPEN c
FETCH NEXT FROM c INTO @tabl, @Card, @Rg, @Rw
WHILE @@FETCH_STATUS = 0
BEGIN 
 SELECT @sp = CASE LEN(@Tabl) WHEN 3 THEN '' ELSE ' ' END 
 SELECT @s = CONCAT('SET NOCOUNT ON; 
DECLARE @I int = 0, @N int = 10574, @Card int = ',@Card,', @Rn int = ',@Rg,', @T int = ',@Rw,'; 
DECLARE @R1 int=2, @R2 int=4, @R3 int=8, @R4 int=16, @R5 int=32, @R6 int=64, @R7 int=128, @R8 int=256, @R9 int=512, @RA int=1024, @RY int=250
IF NOT EXISTS(SELECT * FROM dbo.',@tabl,')
BEGIN
WHILE @I*@N < @T
BEGIN
 INSERT dbo.',@tabl, '
 SELECT ID+1 ID, G, S, B, (S-1)%@R1+1 C, (S-1)%@R2+1 D, (S-1)%@R3+1 E
 , ID%@R1+1 R1, ID%@R2+1 R2, ID%@R3+1 R3, ID%@R4+1 R4, ID%@R5+1 R5, ID%@R6+1 R6, ID%@R7+1 R7, ID%@R8+1 R8, ID%@R9+1 R9, ID%@RA+1 RA, ID%@RY+1 GT
 FROM (SELECT ID ID, ID%@Rn+1 G, ID/@Rn+1 S, ID/@Rn+1 B FROM (SELECT @I*@N+I-1 ID FROM dbo.Nums) a ) b WHERE ID < @T; 
 SELECT @I = @I+1
END 
ALTER INDEX ALL ON dbo.',@tabl,' REBUILD WITH(SORT_IN_TEMPDB=ON, MAXDOP=1, FILLFACTOR=100) 
PRINT @tabl
END ') 
 exec sp_executesql @s, N'@tabl nvarchar(50)', @tabl -- SELECT @s2 = CONCAT('ALTER INDEX ALL ON dbo.',@tabl,' REBUILD WITH(SORT_IN_TEMPDB=ON, MAXDOP=1, FILLFACTOR=100) ') 
 PRINT @s -- PRINT @s2 -- exec sp_executesql @s2 
 PRINT CONCAT('--',CONVERT(char(23),GETDATE(),121),', ',@Tabl,@sp,', ',STR(@Card,6),', ',STR(@Rg,6),', ',@Rw)
 FETCH NEXT FROM c INTO @tabl, @Card, @Rg, @Rw
END
CLOSE c
DEALLOCATE c
GO
GO
/*
1363648
1363488
SELECT z.Tabl, z.Cardin, z.Rang, z.RowCt, z.ird, z.Loop1, z.Loop2, z.Merg, z.Hasj, z.SMer, z.Mtm FROM dbo.zTest z  ORDER BY z.Cardin
SELECT [table], Cardin, Rang, row_count, idp, LstPFr, lstPRw FROM dbo.vtest WHERE [table] LIKE 'A%' AND [table] <> 'Ax' ORDER BY Cardin
SELECT [table], Cardin, Rang, row_count, idp, LstPFr, lstPRw FROM dbo.vtest WHERE [table] LIKE 'B%' AND [table] <> 'Ax' ORDER BY Cardin

DECLARE @T TABLE(Tabl varchar(3),Cardin int, Rang int, row_count int, idp int, LstPFr int, lstPRw int)
INSERT @T
SELECT [table], Cardin, Rang, row_count, idp, LstPFr, lstPRw FROM dbo.vtest WHERE [table] LIKE 'A%' AND [table] <> 'Ax' ORDER BY Cardin

SELECT z.Tabl, z.Cardin, z.Rang, z.RowCt, z.ird, z.Loop1, z.Loop2, z.Merg, z.Hasj, z.SMer, z.Mtm, t.Tabl, t.Cardin, t.Rang, t.row_count, t.idp,  LstPFr, lstPRw
FROM dbo.zTest z LEFT JOIN @T t ON t.Cardin = z.Cardin
ORDER BY z.Cardin

SELECT [table], Cardin, Rang, row_count, idp, irp, 8*idp data FROM dbo.vtest WHERE [table] LIKE 'A%' AND [table] <> 'A' ORDER BY Cardin
SELECT [table], Cardin, Rang, row_count, idp, irp, 8*idp data FROM dbo.vtest WHERE [table] LIKE 'B%' AND [table] <> 'B' ORDER BY Cardin
--, 1.0*row_count/101 rd , row_count/101 dp, row_count - (row_count/101)*101 diff , ird, rerr, rem 
exec sp_spaceused2 @Ord=1
SELECT [table], Cardin, Rang, row_count, idp FROM dbo.vtest WHERE [table] LIKE 'A%' AND [table] <> 'A' ORDER BY Cardin

SELECT Tabl, Cardin, Rang, Cardin*Rang rw, Cardin*Rang - RowCt diff, Cardin*Rang/101., Cardin*Rang/101. - ird irx, ird
FROM dbo.zTest 
--WHERE Cardin*Rang <> RowCt 
*/
/*
SELECT * FROM dbo.vDbPtSt WHERE [table] LIKE 'A%' AND [table] <> 'A' ORDER BY [table]
SELECT * FROM dbo.vDbPtSt WHERE [table] LIKE 'B%' ORDER BY [table]

exec sp_helpindex2 'A%'
exec sp_spaceused2 @objname='A%', @Ord=1
exec sp_spaceused2 @objname='B%', @Ord=1
exec sp_helpstats2 'A%'
*/

/*
SELECT CONCAT(',(''',Tabl,''',', Cardin,',',Rang,',',row_count,',',irp,',0,0,0,0,0,0)') --, 1.0*row_count/101 rd , row_count/101 dp, row_count - (row_count/101)*101 diff , ird, rerr, rem 
FROM dbo.vtest WHERE Tabl LIKE 'A%' AND Tabl <> 'A' ORDER BY Cardin

SELECT Tabl, Cardin, Rang, row_count, irp --, 1.0*row_count/101 rd , row_count/101 dp, row_count - (row_count/101)*101 diff , ird, rerr, rem 
FROM dbo.vtest WHERE Tabl LIKE 'A%' AND Tabl <> 'A' ORDER BY Cardin

SELECT 13238272/2 -- 6619136

IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('dbo.A0'))
 CREATE TABLE dbo.A0 (AID int NOT NULL, GID int NOT NULL, [SID] int NOT NULL, BID int NOT NULL, CID int NOT NULL, DID int NOT NULL, EID int NOT NULL
 , R1 int NOT NULL, R2 int NOT NULL, R3 int NOT NULL, R4 int NOT NULL, R5 int NOT NULL, R6 int NOT NULL, R7 int NOT NULL, R8 int NOT NULL, R9 int NOT NULL, RA int NOT NULL, TI tinyint NOT NULL
 , CONSTRAINT PK_A0 PRIMARY KEY CLUSTERED(AID))

SET NOCOUNT ON; DECLARE @I int = 0, @N int = 10574, @Card int = 2, @Rn int = 6619136, @T int; SELECT @T =@Card*@Rn
SELECT @T, @T/101 WholeP, @T-(@T/101)*101

SET NOCOUNT ON; DECLARE @I int = 0, @N int = 10574, @Card int = 2, @Rn int = 681800, @T int; SELECT @T =@Card*@Rn
SELECT @T, @T/101 WholeP, @T-(@T/101)*101
--, @T int = 131072*101;  DECLARE @R1 int=@T/@R; SELECT @T = @Card*@R1 -- double size
DECLARE @R1 int=2, @R2 int=4, @R3 int=8, @R4 int=16, @R5 int=32, @R6 int=64, @R7 int=128, @R8 int=256, @R9 int=512, @RA int=1024, @RY int=250
WHILE @I*@N < @T
BEGIN
 --INSERT dbo.A0  
 SELECT ID+1 ID, G, S, B, (S-1)%@R1+1 C, (S-1)%@R2+1 D, (S-1)%@R3+1 E
 , ID%@R1+1 R1, ID%@R2+1 R2, ID%@R3+1 R3, ID%@R4+1 R4, ID%@R5+1 R5, ID%@R6+1 R6, ID%@R7+1 R7, ID%@R8+1 R8, ID%@R9+1 R9, ID%@RA+1 RA, ID%@RY+1 GT
 FROM (SELECT ID ID, ID%@Rn+1 G, ID/@Rn+1 S, ID/@Rn+1 B FROM (SELECT @I*@N+I-1 ID FROM dbo.Nums) a ) b WHERE ID < @T ;  SELECT @I = @I+1
END 

*/

GO




/*
exec sp_spaceused2 @objname='B%', @Ord=1
-- SELECT @T =@Card*@Rn -- SELECT @T, @T/101 WholeP, @T-(@T/101)*101
-- Test
SET NOCOUNT ON; 
DECLARE @I int = 0, @N int = 10574, @Card int = 2, @Rn int = 681800, @T int = 1363600; 
DECLARE @R1 int=2, @R2 int=4, @R3 int=8, @R4 int=16, @R5 int=32, @R6 int=64, @R7 int=128, @R8 int=256, @R9 int=512, @RA int=1024, @RY int=250
IF NOT EXISTS(SELECT * FROM dbo.A1)
BEGIN
WHILE @I*@N < @T
BEGIN
 INSERT dbo.A1
 SELECT ID+1 ID, G, S, B, (S-1)%@R1+1 C, (S-1)%@R2+1 D, (S-1)%@R3+1 E
 , ID%@R1+1 R1, ID%@R2+1 R2, ID%@R3+1 R3, ID%@R4+1 R4, ID%@R5+1 R5, ID%@R6+1 R6, ID%@R7+1 R7, ID%@R8+1 R8, ID%@R9+1 R9, ID%@RA+1 RA, ID%@RY+1 GT
 FROM (SELECT ID ID, ID%@Rn+1 G, ID/@Rn+1 S, ID/@Rn+1 B FROM (SELECT @I*@N+I-1 ID FROM dbo.Nums) a ) b WHERE ID < @T; 
 SELECT @I = @I+1
END 
END 
--SELECT * FROM @T
-- Cardin < 65536  -- Tabl IN ('AE2','AE3') -- 
*/

/*
DECLARE @T TABLE(ID int IDENTITY PRIMARY KEY, Tabl nvarchar(250), Cardin int, Rang int, RowCt int)
INSERT @T SELECT Tabl, Cardin, Rang, Cardin*Rang RowCt FROM dbo.zTest WHERE Tabl <> 'A0' AND Cardin <= 65536
ORDER BY Cardin --SELECT * FROM @T
DECLARE c CURSOR FOR SELECT Tabl, Cardin, Rang, RowCt FROM @T ORDER BY Cardin
DECLARE @tabl nvarchar(250), @Card int, @Rg int, @Rw int, @s2 nvarchar(4000)
OPEN c
FETCH NEXT FROM c INTO @tabl, @Card, @Rg, @Rw
WHILE @@FETCH_STATUS = 0
BEGIN 
 SELECT @s2 = CONCAT('ALTER INDEX ALL ON dbo.',@tabl,' REBUILD WITH(SORT_IN_TEMPDB=ON, MAXDOP=1, FILLFACTOR=100) ') 
-- PRINT @s2
 exec sp_executesql @s2
 PRINT CONCAT('--',CONVERT(char(23),GETDATE(),121),', ',@Tabl,', ',@Card,', ',@Rg,', ',@Rw)
 FETCH NEXT FROM c INTO @tabl, @Card, @Rg, @Rw
END
CLOSE c
DEALLOCATE c
*/
 -- Test only
/*
DECLARE @T TABLE(ID int IDENTITY PRIMARY KEY, Tabl nvarchar(250), Cardin int, Rang int, RowCt int)
INSERT @T 
SELECT Tabl, Cardin, Rang, Cardin*Rang RowCt FROM dbo.zTest WHERE Tabl <> 'A0' AND Cardin BETWEEN 8768 AND 8892
ORDER BY Cardin 
DECLARE c CURSOR FOR SELECT Tabl, Cardin, Rang, RowCt FROM @T ORDER BY Cardin
DECLARE @tabl nvarchar(250), @Card int, @Rg int, @Rw int, @s nvarchar(4000), @s2 nvarchar(1000), @sp nvarchar(1)
OPEN c
FETCH NEXT FROM c INTO @tabl, @Card, @Rg, @Rw
WHILE @@FETCH_STATUS = 0
BEGIN 
 SELECT @sp = CASE LEN(@Tabl) WHEN 3 THEN '' ELSE ' ' END 
 SELECT @s = CONCAT('SET NOCOUNT ON; 
DECLARE @I int = 0, @N int = 10574, @Card int = ',@Card,', @Rn int = ',@Rg,', @T int = ',@Rw,'; 
DECLARE @R1 int=2, @R2 int=4, @R3 int=8, @R4 int=16, @R5 int=32, @R6 int=64, @R7 int=128, @R8 int=256, @R9 int=512, @RA int=1024, @RY int=250
IF NOT EXISTS(SELECT * FROM dbo.',@tabl,')
BEGIN
WHILE @I*@N < @T
BEGIN
 INSERT dbo.',@tabl, '
 SELECT ID+1 ID, G, S, B, (S-1)%@R1+1 C, (S-1)%@R2+1 D, (S-1)%@R3+1 E
 , ID%@R1+1 R1, ID%@R2+1 R2, ID%@R3+1 R3, ID%@R4+1 R4, ID%@R5+1 R5, ID%@R6+1 R6, ID%@R7+1 R7, ID%@R8+1 R8, ID%@R9+1 R9, ID%@RA+1 RA, ID%@RY+1 GT
 FROM (SELECT ID ID, ID%@Rn+1 G, ID/@Rn+1 S, ID/@Rn+1 B FROM (SELECT @I*@N+I-1 ID FROM dbo.Nums) a ) b WHERE ID < @T; 
 SELECT @I = @I+1
END 
END ') 
 SELECT @s2 = CONCAT('ALTER INDEX ALL ON dbo.',@tabl,' REBUILD WITH(SORT_IN_TEMPDB=ON, MAXDOP=1, FILLFACTOR=100) ') 
 PRINT @s
-- PRINT @s2
 PRINT CONCAT('--',CONVERT(char(23),GETDATE(),121),', ',@Tabl,@sp,', ',STR(@Card,6),', ',STR(@Rg,6),', ',@Rw)
 FETCH NEXT FROM c INTO @tabl, @Card, @Rg, @Rw
END
CLOSE c
DEALLOCATE c
*/
GO