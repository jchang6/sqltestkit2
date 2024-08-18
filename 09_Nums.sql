IF NOT EXISTS (
 SELECT * FROM sys.objects WHERE name = 'Nums'
) CREATE TABLE dbo.Nums (I int NOT NULL) --ON FG2
GO
SET NOCOUNT ON
DECLARE @I int = 1
BEGIN TRAN
WHILE (@I <= 10574) BEGIN -- 10574
-- IF NOT EXISTS (SELECT * FROM dbo.Nums WHERE I = @I)
 INSERT dbo.Nums VALUES(@I)
 SET @I = @I + 1
END
COMMIT TRAN
SELECT @@TRANCOUNT TranCt
GO
/*
SELECT COUNT(*) FROM Nums
SELECT * FROM Nums
*/
IF NOT EXISTS (
 SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID('Nums') AND index_id = 1
) CREATE UNIQUE CLUSTERED INDEX UCX ON dbo.Nums(I) WITH (SORT_IN_TEMPDB = ON, FILLFACTOR = 100, MAXDOP = 1) ON [PRIMARY]
ELSE 
 ALTER INDEX ALL ON Nums REBUILD

SELECT * FROM dbo.vcol WHERE object_id = OBJECT_ID('Nums')
SELECT name, idp, row_count, index_id, col, byt, ix, ABR, RpP, FpP, CONVERT(decimal(18,4),(8096.-FpP)/RpP) RpP2 FROM dbo.vcol WHERE object_id = OBJECT_ID('Nums')
SELECT * FROM dbo.vDbPtSt WHERE [table] = 'Nums'
