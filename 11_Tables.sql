
exec sp_spaceused2
exec sp_spaceused2 @objname='A%', @Ord=1
exec sp_spaceused2 @objname='B%', @Ord=1
exec sp_helpindex2 'A4'

exec sp_helpstats2 'A4'

DECLARE @T TABLE(ID int IDENTITY PRIMARY KEY, name nvarchar(250))
INSERT @T  --SELECT name FROM sys.tables WHERE name LIKE 'A%' AND name <> 'A' AND name <> 'A0' ORDER BY name --SELECT * FROM @T
--SELECT Tabl FROM dbo.zTest --WHERE Cardin BETWEEN 8768 AND 8892
SELECT CONCAT('B',SUBSTRING(Tabl,2,LEN(Tabl)-1)) FROM dbo.zTest --WHERE Cardin BETWEEN 8768 AND 8892

SELECT * FROM dbo.zTest WHERE Cardin IN (1,2,16,32)

SELECT [table], row_count, Cardin, Rang, idp, iup, irp, Rw_Pg, ABR, IxDep 
FROM dbo.vtest WHERE [table] LIKE 'A%' ORDER BY Cardin


SELECT [table], Cardin, Rang, row_count, irp --, 1.0*row_count/101 rd , row_count/101 dp, row_count - (row_count/101)*101 diff , ird, rerr, rem 
FROM dbo.vtest WHERE [table] LIKE 'A%' --AND [table] <> 'A' 
ORDER BY Cardin

IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('dbo.A'))
 CREATE TABLE dbo.A(AID int NOT NULL, GID int NOT NULL, [SID] int NOT NULL, BID int NOT NULL, CID int NOT NULL, DID int NOT NULL, EID int NOT NULL
 , R1 int NOT NULL, R2 int NOT NULL, R3 int NOT NULL, R4 int NOT NULL, R5 int NOT NULL, R6 int NOT NULL, R7 int NOT NULL, R8 int NOT NULL, R9 int NOT NULL, RA int NOT NULL, TI tinyint NOT NULL
 , CONSTRAINT PK_A PRIMARY KEY CLUSTERED(AID))

IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('dbo.A4'))
 CREATE TABLE dbo.A4(AID int NOT NULL, GID int NOT NULL, [SID] int NOT NULL, BID int NOT NULL, CID int NOT NULL, DID int NOT NULL, EID int NOT NULL
 , R1 int NOT NULL, R2 int NOT NULL, R3 int NOT NULL, R4 int NOT NULL, R5 int NOT NULL, R6 int NOT NULL, R7 int NOT NULL, R8 int NOT NULL, R9 int NOT NULL, RA int NOT NULL, TI tinyint NOT NULL
 , CONSTRAINT PK_A4 PRIMARY KEY CLUSTERED(GID,SID))

IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('dbo.A5'))
 CREATE TABLE dbo.A5(AID int NOT NULL, GID int NOT NULL, [SID] int NOT NULL, BID int NOT NULL, CID int NOT NULL, DID int NOT NULL, EID int NOT NULL
 , R1 int NOT NULL, R2 int NOT NULL, R3 int NOT NULL, R4 int NOT NULL, R5 int NOT NULL, R6 int NOT NULL, R7 int NOT NULL, R8 int NOT NULL, R9 int NOT NULL, RA int NOT NULL, TI tinyint NOT NULL
 , CONSTRAINT PK_A5 PRIMARY KEY CLUSTERED(GID,SID))

IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('dbo.A6'))
 CREATE TABLE dbo.A6(AID int NOT NULL, GID int NOT NULL, [SID] int NOT NULL, BID int NOT NULL, CID int NOT NULL, DID int NOT NULL, EID int NOT NULL
 , R1 int NOT NULL, R2 int NOT NULL, R3 int NOT NULL, R4 int NOT NULL, R5 int NOT NULL, R6 int NOT NULL, R7 int NOT NULL, R8 int NOT NULL, R9 int NOT NULL, RA int NOT NULL, TI tinyint NOT NULL
 , CONSTRAINT PK_A6 PRIMARY KEY CLUSTERED(GID,SID))
GO
exec sp_spaceused2
/*
  MB	pages	 rows			rang
 128	16384	 1,654,784		 103424
 384	49152	 4,964,352		 310272
1536	196608	19,857,408		1241088
*/

GO
SET NOCOUNT ON; 
DECLARE @I int = 0, @N int = 10574, @Card int = 1, @Rn int = 19857408, @T int = 19857408, @Rh int; 
DECLARE @R1 int=2, @R2 int=4, @R3 int=8, @R4 int=16, @R5 int=32, @R6 int=64, @R7 int=128, @R8 int=256, @R9 int=512, @RA int=1024, @RY int=250
IF NOT EXISTS(SELECT * FROM dbo.A)
BEGIN
 SELECT @Rh = Rang FROM dbo.zTest WHERE Cardin = 2
 SELECT @Rn = CASE @Card WHEN 1 THEN @Rh ELSE @Rn END
WHILE @I*@N < @T
BEGIN
 INSERT dbo.A
 SELECT ID+1 ID, G, S, B, (S-1)%@R1+1 C, (S-1)%@R2+1 D, (S-1)%@R3+1 E
 , ID%@R1+1 R1, ID%@R2+1 R2, ID%@R3+1 R3, ID%@R4+1 R4, ID%@R5+1 R5, ID%@R6+1 R6, ID%@R7+1 R7, ID%@R8+1 R8, ID%@R9+1 R9, ID%@RA+1 RA, ID%@RY+1 GT
 FROM (SELECT ID ID, ID%@Rn+1 G, ID/@Rn+1 S, ID/@Rn+1 B FROM (SELECT @I*@N+I-1 ID FROM dbo.Nums) a ) b WHERE ID < @T; 
 SELECT @I = @I+1
END 
ALTER INDEX ALL ON dbo.A REBUILD WITH(SORT_IN_TEMPDB=ON, MAXDOP=1, FILLFACTOR=100)
END 
GO

CREATE STATISTICS ST_GID ON dbo.A(GID) WITH FULLSCAN
CREATE STATISTICS ST_SID ON dbo.A([SID]) WITH FULLSCAN
CREATE STATISTICS ST_BID ON dbo.A(BID) WITH FULLSCAN
CREATE STATISTICS ST_CID ON dbo.A(CID) WITH FULLSCAN

GO
SET NOCOUNT ON; 
DECLARE @I int = 0, @N int = 10574, @Card int = 16, @Rn int = 1241088, @T int = 19857408; 
DECLARE @R1 int=2, @R2 int=4, @R3 int=8, @R4 int=16, @R5 int=32, @R6 int=64, @R7 int=128, @R8 int=256, @R9 int=512, @RA int=1024, @RY int=250
IF NOT EXISTS(SELECT * FROM dbo.A4)
BEGIN
WHILE @I*@N < @T
BEGIN
 INSERT dbo.A4
 SELECT ID+1 ID, G, S, B, (S-1)%@R1+1 C, (S-1)%@R2+1 D, (S-1)%@R3+1 E
 , ID%@R1+1 R1, ID%@R2+1 R2, ID%@R3+1 R3, ID%@R4+1 R4, ID%@R5+1 R5, ID%@R6+1 R6, ID%@R7+1 R7, ID%@R8+1 R8, ID%@R9+1 R9, ID%@RA+1 RA, ID%@RY+1 GT
 FROM (SELECT ID ID, ID%@Rn+1 G, ID/@Rn+1 S, ID/@Rn+1 B FROM (SELECT @I*@N+I-1 ID FROM dbo.Nums) a ) b WHERE ID < @T; 
 SELECT @I = @I+1
END 
ALTER INDEX ALL ON dbo.A4 REBUILD WITH(SORT_IN_TEMPDB=ON, MAXDOP=1, FILLFACTOR=100)
END 
GO
CREATE STATISTICS ST_AID ON dbo.A4(AID) WITH FULLSCAN
CREATE STATISTICS ST_SID ON dbo.A4([SID]) WITH FULLSCAN
exec sp_helpstats2 'A4'

GO
SET NOCOUNT ON; 
DECLARE @I int = 0, @N int = 10574, @Card int = 16, @Rn int = 310272, @T int = 4964352; 
DECLARE @R1 int=2, @R2 int=4, @R3 int=8, @R4 int=16, @R5 int=32, @R6 int=64, @R7 int=128, @R8 int=256, @R9 int=512, @RA int=1024, @RY int=250
IF NOT EXISTS(SELECT * FROM dbo.A5)
BEGIN
WHILE @I*@N < @T
BEGIN
 INSERT dbo.A5
 SELECT ID+1 ID, G, S, B, (S-1)%@R1+1 C, (S-1)%@R2+1 D, (S-1)%@R3+1 E
 , ID%@R1+1 R1, ID%@R2+1 R2, ID%@R3+1 R3, ID%@R4+1 R4, ID%@R5+1 R5, ID%@R6+1 R6, ID%@R7+1 R7, ID%@R8+1 R8, ID%@R9+1 R9, ID%@RA+1 RA, ID%@RY+1 GT
 FROM (SELECT ID ID, ID%@Rn+1 G, ID/@Rn+1 S, ID/@Rn+1 B FROM (SELECT @I*@N+I-1 ID FROM dbo.Nums) a ) b WHERE ID < @T; 
 SELECT @I = @I+1
END 
ALTER INDEX ALL ON dbo.A5 REBUILD WITH(SORT_IN_TEMPDB=ON, MAXDOP=1, FILLFACTOR=100)
END 
GO

CREATE STATISTICS ST_AID ON dbo.A5(AID) WITH FULLSCAN
CREATE STATISTICS ST_SID ON dbo.A5([SID]) WITH FULLSCAN

SET NOCOUNT ON; 
DECLARE @I int = 0, @N int = 10574, @Card int = 16, @Rn int = 103424, @T int = 1654784; 
DECLARE @R1 int=2, @R2 int=4, @R3 int=8, @R4 int=16, @R5 int=32, @R6 int=64, @R7 int=128, @R8 int=256, @R9 int=512, @RA int=1024, @RY int=250
IF NOT EXISTS(SELECT * FROM dbo.A6)
BEGIN
WHILE @I*@N < @T
BEGIN
 INSERT dbo.A6
 SELECT ID+1 ID, G, S, B, (S-1)%@R1+1 C, (S-1)%@R2+1 D, (S-1)%@R3+1 E
 , ID%@R1+1 R1, ID%@R2+1 R2, ID%@R3+1 R3, ID%@R4+1 R4, ID%@R5+1 R5, ID%@R6+1 R6, ID%@R7+1 R7, ID%@R8+1 R8, ID%@R9+1 R9, ID%@RA+1 RA, ID%@RY+1 GT
 FROM (SELECT ID ID, ID%@Rn+1 G, ID/@Rn+1 S, ID/@Rn+1 B FROM (SELECT @I*@N+I-1 ID FROM dbo.Nums) a ) b WHERE ID < @T; 
 SELECT @I = @I+1
END 
ALTER INDEX ALL ON dbo.A6 REBUILD WITH(SORT_IN_TEMPDB=ON, MAXDOP=1, FILLFACTOR=100)
END 
GO

CREATE STATISTICS ST_AID ON dbo.A6(AID) WITH FULLSCAN
CREATE STATISTICS ST_SID ON dbo.A6([SID]) WITH FULLSCAN

exec sp_helpstats2 'A5'
exec sp_helpstats2 'A6'

DBCC FREEPROCCACHE
GO
DECLARE @I int, @R int SELECT @I = 1+1241088*RAND(CHECKSUM(NEWID())); SELECT @R=MAX(b.TI) FROM dbo.A4  a INNER LOOP JOIN dbo.A b ON b.AID = a.AID WHERE a.GID = @I OPTION(MAXDOP 1)
GO 10000
DECLARE @I int, @R int SELECT @I = 1+310272*RAND(CHECKSUM(NEWID())); SELECT @R=MAX(b.TI) FROM dbo.A5  a INNER LOOP JOIN dbo.A b ON b.AID = a.AID WHERE a.GID = @I OPTION(MAXDOP 1)
GO 10000
DECLARE @I int, @R int SELECT @I = 1+103424*RAND(CHECKSUM(NEWID())); SELECT @R=MAX(b.TI) FROM dbo.A6  a INNER LOOP JOIN dbo.A b ON b.AID = a.AID WHERE a.GID = @I OPTION(MAXDOP 1)
GO 10000

SELECT '' code, statement_text, execution_count, total_worker_time, total_elapsed_time, tphys_reads, tlog_reads, total_rows, start_off, end_off,  av_w, creation_time, last_execution_time 
FROM dbo.veqs WHERE  total_worker_time > 100000 AND execution_count >= 30 
ORDER BY last_execution_time


SELECT * FROM dbo.vDbPtSt
SELECT * FROM dbo.vtest

SELECT * FROM sys.views

exec sp_spaceused2
exec sp_helpstats2 'A%'

SELECT * FROM dbo.A  WHERE AID <= 32
SELECT * FROM dbo.A4 WHERE GID <= 2


GO

GO

SELECT * FROM dbo.zTest WHERE Cardin IN (1,2,16,32)
