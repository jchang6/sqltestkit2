USE Test
/*
-- Form1 Comet
UPDATE dbo.zTest SET Loop1 = 0
SELECT * FROM dbo.zTest WHERE Loop1 = 0
SET NOCOUNT OFF
SET NOCOUNT ON
SELECT Tabl, Cardin, Rang, Cardin*Rang rw, Cardin*Rang - RowCt diff, Cardin*Rang/101., Cardin*Rang/101. - ird irx, ird FROM dbo.zTest --WHERE Cardin*Rang <> RowCt 
*/
DECLARE @T TABLE(Tabl varchar(3),Cardin int, Rang int, row_count int, idp int, LstPFr int, lstPRw int)
INSERT @T
SELECT [table], Cardin, Rang, row_count, idp, LstPFr, lstPRw FROM dbo.vtest WHERE [table] LIKE 'A%' AND [table] <> 'Ax' ORDER BY Cardin

SELECT z.Tabl, z.Cardin, z.Rang, z.RowCt, z.ird, z.Loop1, z.Loop2, z.Merg, z.Hasj, z.SMer, z.Mtm, t.Tabl, t.Cardin, t.Rang, t.row_count, t.idp,  LstPFr, lstPRw
FROM dbo.zTest z LEFT JOIN @T t ON t.Cardin = z.Cardin
ORDER BY z.Cardin

--SELECT * FROM dbo.vtest WHERE [table] LIKE 'A%' AND [table] <> 'A' ORDER BY Cardin

BEGIN TRAN Loop1 
UPDATE dbo.zTest SET Loop1 =120000, Loop2 = 160000, Merg = 200000, Hasj = 26000, SMer = 110000 WHERE Cardin = 16
UPDATE dbo.zTest SET Loop1 =100000, Loop2 = 130000, Merg = 200000, Hasj = 25500, SMer = 95000 WHERE Cardin = 24
UPDATE dbo.zTest SET Loop1 =80000, Loop2 = 100000, Merg = 190000, Hasj = 25000, SMer = 85000 WHERE Cardin = 32
UPDATE dbo.zTest SET Loop1 =60000, Loop2 = 80000, Merg = 160000, Hasj = 24500, SMer = 80000 WHERE Cardin = 48
UPDATE dbo.zTest SET Loop1 =50000, Loop2 = 65000, Merg = 140000, Hasj = 24000, SMer = 70000 WHERE Cardin = 64
UPDATE dbo.zTest SET Loop1 =35000, Loop2 = 50000, Merg = 110000, Hasj = 22000, SMer = 60000 WHERE Cardin = 96
UPDATE dbo.zTest SET Loop1 =25000, Loop2 = 35000, Merg = 90000, Hasj = 20000, SMer = 55000 WHERE Cardin = 128
UPDATE dbo.zTest SET Loop1 =20000, Loop2 = 27000, Merg = 70000, Hasj = 18000, SMer = 45000 WHERE Cardin = 192
UPDATE dbo.zTest SET Loop1 =15000, Loop2 = 20000, Merg = 50000, Hasj = 16000, SMer = 35000 WHERE Cardin = 256
UPDATE dbo.zTest SET Loop1 =13000, Loop2 = 17000, Merg = 46000, Hasj = 15500, SMer = 30000 WHERE Cardin = 320
UPDATE dbo.zTest SET Loop1 =12000, Loop2 = 16000, Merg = 44000, Hasj = 15000, SMer = 29000 WHERE Cardin = 336
UPDATE dbo.zTest SET Loop1 =11000, Loop2 = 15000, Merg = 42000, Hasj = 14500, SMer = 28000 WHERE Cardin = 352
UPDATE dbo.zTest SET Loop1 =10000, Loop2 = 14000, Merg = 40000, Hasj = 14000, SMer = 27000 WHERE Cardin = 384
UPDATE dbo.zTest SET Loop1 =7500, Loop2 = 10000, Merg = 30000, Hasj = 12000, SMer = 20000 WHERE Cardin = 512
UPDATE dbo.zTest SET Loop1 =6000, Loop2 = 7000, Merg = 23000, Hasj = 10000, SMer = 15000 WHERE Cardin = 768
UPDATE dbo.zTest SET Loop1 =4000, Loop2 = 5000, Merg = 17000, Hasj = 8000, SMer = 11000 WHERE Cardin = 1024
UPDATE dbo.zTest SET Loop1 =3000, Loop2 = 3500, Merg = 13000, Hasj = 6500, SMer = 8500 WHERE Cardin = 1536
UPDATE dbo.zTest SET Loop1 =1850, Loop2 = 2500, Merg = 8000, Hasj = 4500, SMer = 6000 WHERE Cardin = 2048
UPDATE dbo.zTest SET Loop1 =1500, Loop2 = 1900, Merg = 6500, Hasj = 3500, SMer = 4500 WHERE Cardin = 3072
UPDATE dbo.zTest SET Loop1 =1000, Loop2 = 1300, Merg = 4500, Hasj = 2500, SMer = 3200 WHERE Cardin = 4096
UPDATE dbo.zTest SET Loop1 =800, Loop2 = 1000, Merg = 3500, Hasj = 2000, SMer = 2500 WHERE Cardin = 5120
UPDATE dbo.zTest SET Loop1 =500, Loop2 = 650, Merg = 2100, Hasj = 1260, SMer = 1500 WHERE Cardin = 8192
UPDATE dbo.zTest SET Loop1 =480, Loop2 = 600, Merg = 2050, Hasj = 1250, SMer = 1470 WHERE Cardin = 8704
UPDATE dbo.zTest SET Loop1 =440, Loop2 = 595, Merg = 2030, Hasj = 1230, SMer = 1450 WHERE Cardin = 8832
UPDATE dbo.zTest SET Loop1 =440, Loop2 = 585, Merg = 2000, Hasj = 1200, SMer = 1410 WHERE Cardin = 8890
UPDATE dbo.zTest SET Loop1 =440, Loop2 = 590, Merg = 2020, Hasj = 1220, SMer = 1420 WHERE Cardin = 8891
UPDATE dbo.zTest SET Loop1 =430, Loop2 = 570, Merg = 2010, Hasj = 1200, SMer = 1380 WHERE Cardin = 8960
UPDATE dbo.zTest SET Loop1 =420, Loop2 = 550, Merg = 2000, Hasj = 1120, SMer = 1320 WHERE Cardin = 9216
UPDATE dbo.zTest SET Loop1 =400, Loop2 = 520, Merg = 1900, Hasj = 1100, SMer = 1300 WHERE Cardin = 9728
UPDATE dbo.zTest SET Loop1 =390, Loop2 = 510, Merg = 1800, Hasj = 1020, SMer = 1240 WHERE Cardin = 10000
UPDATE dbo.zTest SET Loop1 =380, Loop2 = 500, Merg = 1700, Hasj = 1000, SMer = 1200 WHERE Cardin = 10240
UPDATE dbo.zTest SET Loop1 =320, Loop2 = 420, Merg = 1600, Hasj = 850, SMer = 1000 WHERE Cardin = 12288
UPDATE dbo.zTest SET Loop1 =280, Loop2 = 350, Merg = 1300, Hasj = 700, SMer = 900 WHERE Cardin = 14336
UPDATE dbo.zTest SET Loop1 =230, Loop2 = 320, Merg = 1200, Hasj = 600, SMer = 800 WHERE Cardin = 16384
UPDATE dbo.zTest SET Loop1 =150, Loop2 = 210, Merg = 700, Hasj = 420, SMer = 500 WHERE Cardin = 24576
UPDATE dbo.zTest SET Loop1 =120, Loop2 = 160, Merg = 600, Hasj = 320, SMer = 400 WHERE Cardin = 32768
UPDATE dbo.zTest SET Loop1 =80, Loop2 = 110, Merg = 400, Hasj = 220, SMer = 260 WHERE Cardin = 49152
UPDATE dbo.zTest SET Loop1 =60, Loop2 = 80, Merg = 300, Hasj = 160, SMer = 200 WHERE Cardin = 65536
UPDATE dbo.zTest SET Loop1 =45, Loop2 = 55, Merg = 200, Hasj = 110, SMer = 140 WHERE Cardin = 98304
UPDATE dbo.zTest SET Loop1 =40, Loop2 = 50, Merg = 180, Hasj = 90, SMer = 120 WHERE Cardin = 114688
UPDATE dbo.zTest SET Loop1 =37, Loop2 = 40, Merg = 150, Hasj = 80, SMer = 105 WHERE Cardin = 130048
UPDATE dbo.zTest SET Loop1 =36, Loop2 = 35, Merg = 140, Hasj = 75, SMer = 95 WHERE Cardin = 131071
UPDATE dbo.zTest SET Loop1 =35, Loop2 = 40, Merg = 145, Hasj = 80, SMer = 100 WHERE Cardin = 131072
UPDATE dbo.zTest SET Loop1 =33, Loop2 = 35, Merg = 120, Hasj = 55, SMer = 80 WHERE Cardin = 163840
UPDATE dbo.zTest SET Loop1 =32, Loop2 = 32, Merg = 110, Hasj = 50, SMer = 70 WHERE Cardin = 196608
UPDATE dbo.zTest SET Loop1 =31, Loop2 = 31, Merg = 105, Hasj = 42, SMer = 60 WHERE Cardin = 229376
UPDATE dbo.zTest SET Loop1 =30, Loop2 = 30, Merg = 100, Hasj = 40, SMer = 50 WHERE Cardin = 262144

COMMIT TRAN Loop1 
SELECT @@TRANCOUNT

/*
UPDATE dbo.zTest SET Loop1 =	200000, Loop2 =	200000	WHERE Cardin =	1
UPDATE dbo.zTest SET Loop1 =	200000, Loop2 =	200000	WHERE Cardin =	2
UPDATE dbo.zTest SET Loop1 =	200000, Loop2 =	200000	WHERE Cardin =	3
UPDATE dbo.zTest SET Loop1 =	180000, Loop2 =	200000	WHERE Cardin =	4
UPDATE dbo.zTest SET Loop1 =	160000	WHERE Cardin =	6
UPDATE dbo.zTest SET Loop1 =	150000	WHERE Cardin =	8
UPDATE dbo.zTest SET Loop1 =	135000	WHERE Cardin =	12
UPDATE dbo.zTest SET Loop1 =	120000	WHERE Cardin =	16
UPDATE dbo.zTest SET Loop1 =	100000	WHERE Cardin =	24
UPDATE dbo.zTest SET Loop1 =	80000	WHERE Cardin =	32
UPDATE dbo.zTest SET Loop1 =	60000	WHERE Cardin =	48
UPDATE dbo.zTest SET Loop1 =	50000	WHERE Cardin =	64
UPDATE dbo.zTest SET Loop1 =	35000	WHERE Cardin =	96
UPDATE dbo.zTest SET Loop1 =	25000	WHERE Cardin =	128
UPDATE dbo.zTest SET Loop1 =	20000	WHERE Cardin =	192
UPDATE dbo.zTest SET Loop1 =	15000	WHERE Cardin =	256

UPDATE dbo.zTest SET Loop1 =	10000	WHERE Cardin =	384
UPDATE dbo.zTest SET Loop1 =	7500	WHERE Cardin =	512
UPDATE dbo.zTest SET Loop1 =	6000	WHERE Cardin =	768
UPDATE dbo.zTest SET Loop1 =	4000	WHERE Cardin =	1024
UPDATE dbo.zTest SET Loop1 =	1850	WHERE Cardin =	2048
UPDATE dbo.zTest SET Loop1 =	1000	WHERE Cardin =	4096
UPDATE dbo.zTest SET Loop1 =	800	WHERE Cardin =	5120
UPDATE dbo.zTest SET Loop1 =	500	WHERE Cardin =	8192
UPDATE dbo.zTest SET Loop1 =	480	WHERE Cardin =	8704 --UPDATE dbo.zTest SET Loop1 =	450	WHERE Cardin =	8768
UPDATE dbo.zTest SET Loop1 =	440	WHERE Cardin =	8832 --UPDATE dbo.zTest SET Loop1 =	440	WHERE Cardin =	8848 --UPDATE dbo.zTest SET Loop1 =	440	WHERE Cardin =	8864 --UPDATE dbo.zTest SET Loop1 =	440	WHERE Cardin =	8880 
--UPDATE dbo.zTest SET Loop1 =	440	WHERE Cardin =	8884 --UPDATE dbo.zTest SET Loop1 =	440	WHERE Cardin =	8888  --UPDATE dbo.zTest SET Loop1 =	440	WHERE Cardin =	8889
UPDATE dbo.zTest SET Loop1 =	440	WHERE Cardin =	8890
UPDATE dbo.zTest SET Loop1 =	440	WHERE Cardin =	8891 --UPDATE dbo.zTest SET Loop1 =	440	WHERE Cardin =	8892 --UPDATE dbo.zTest SET Loop1 =	440	WHERE Cardin =	8896
UPDATE dbo.zTest SET Loop1 =	430	WHERE Cardin =	8960 --UPDATE dbo.zTest SET Loop1 =	430	WHERE Cardin =	9088
UPDATE dbo.zTest SET Loop1 =	420	WHERE Cardin =	9216
UPDATE dbo.zTest SET Loop1 =	400	WHERE Cardin =	9728
UPDATE dbo.zTest SET Loop1 =	390	WHERE Cardin =	10000
UPDATE dbo.zTest SET Loop1 =	380	WHERE Cardin =	10240
UPDATE dbo.zTest SET Loop1 =	320	WHERE Cardin =	12288
UPDATE dbo.zTest SET Loop1 =	280	WHERE Cardin =	14336
UPDATE dbo.zTest SET Loop1 =	230	WHERE Cardin =	16384
UPDATE dbo.zTest SET Loop1 =	150	WHERE Cardin =	24576
UPDATE dbo.zTest SET Loop1 =	120	WHERE Cardin =	32768
UPDATE dbo.zTest SET Loop1 =	80	WHERE Cardin =	49152
UPDATE dbo.zTest SET Loop1 =	60	WHERE Cardin =	65536
UPDATE dbo.zTest SET Loop1 =	45	WHERE Cardin =	98304
UPDATE dbo.zTest SET Loop1 =	40	WHERE Cardin =	114688 --UPDATE dbo.zTest SET Loop1 =	35	WHERE Cardin =	129999
UPDATE dbo.zTest SET Loop1 =	35	WHERE Cardin =	130048
UPDATE dbo.zTest SET Loop1 =	30	WHERE Cardin =	131071
UPDATE dbo.zTest SET Loop1 =	35	WHERE Cardin =	131072

UPDATE dbo.zTest SET Loop1 =	33	WHERE Cardin =	163840
UPDATE dbo.zTest SET Loop1 =	32	WHERE Cardin =	196608
UPDATE dbo.zTest SET Loop1 =	31	WHERE Cardin =	229376

UPDATE dbo.zTest SET Loop1 =	30	WHERE Cardin =	262144
*/
GO
SELECT * FROM dbo.zTest -- WHERE Loop1 = 0
GO
/*
BEGIN TRAN Loop2
UPDATE dbo.zTest SET Loop2 =	200000	WHERE Cardin =	1
UPDATE dbo.zTest SET Loop2 =	200000	WHERE Cardin =	2
UPDATE dbo.zTest SET Loop2 =	200000	WHERE Cardin =	3
UPDATE dbo.zTest SET Loop2 =	200000	WHERE Cardin =	4
UPDATE dbo.zTest SET Loop2 =	200000	WHERE Cardin =	6
UPDATE dbo.zTest SET Loop2 =	200000	WHERE Cardin =	8
UPDATE dbo.zTest SET Loop2 =	180000	WHERE Cardin =	12
UPDATE dbo.zTest SET Loop2 =	160000	WHERE Cardin =	16
UPDATE dbo.zTest SET Loop2 =	130000	WHERE Cardin =	24
UPDATE dbo.zTest SET Loop2 =	100000	WHERE Cardin =	32
UPDATE dbo.zTest SET Loop2 =	80000	WHERE Cardin =	48
UPDATE dbo.zTest SET Loop2 =	65000	WHERE Cardin =	64
UPDATE dbo.zTest SET Loop2 =	50000	WHERE Cardin =	96
UPDATE dbo.zTest SET Loop2 =	35000	WHERE Cardin =	128
UPDATE dbo.zTest SET Loop2 =	27000	WHERE Cardin =	192
UPDATE dbo.zTest SET Loop2 =	20000	WHERE Cardin =	256
UPDATE dbo.zTest SET Loop2 =	14000	WHERE Cardin =	384
UPDATE dbo.zTest SET Loop2 =	10000	WHERE Cardin =	512
UPDATE dbo.zTest SET Loop2 =	7000	WHERE Cardin =	768
UPDATE dbo.zTest SET Loop2 =	5000	WHERE Cardin =	1024
UPDATE dbo.zTest SET Loop2 =	2500	WHERE Cardin =	2048
UPDATE dbo.zTest SET Loop2 =	1300	WHERE Cardin =	4096
UPDATE dbo.zTest SET Loop2 =	1000	WHERE Cardin =	5120
UPDATE dbo.zTest SET Loop2 =	650	WHERE Cardin =	8192
UPDATE dbo.zTest SET Loop2 =	600	WHERE Cardin =	8704 --UPDATE dbo.zTest SET Loop2 =	600	WHERE Cardin =	8768
UPDATE dbo.zTest SET Loop2 =	595	WHERE Cardin =	8832 --UPDATE dbo.zTest SET Loop2 =	585	WHERE Cardin =	8848 --UPDATE dbo.zTest SET Loop2 =	585	WHERE Cardin =	8864 --UPDATE dbo.zTest SET Loop2 =	585	WHERE Cardin =	8880
--UPDATE dbo.zTest SET Loop2 =	585	WHERE Cardin =	8884 --UPDATE dbo.zTest SET Loop2 =	585	WHERE Cardin =	8888 --UPDATE dbo.zTest SET Loop2 =	585	WHERE Cardin =	8889
UPDATE dbo.zTest SET Loop2 =	585	WHERE Cardin =	8890
UPDATE dbo.zTest SET Loop2 =	590	WHERE Cardin =	8891 --UPDATE dbo.zTest SET Loop2 =	585	WHERE Cardin =	8892 --UPDATE dbo.zTest SET Loop2 =	580	WHERE Cardin =	8896
UPDATE dbo.zTest SET Loop2 =	570	WHERE Cardin =	8960 --UPDATE dbo.zTest SET Loop2 =	560	WHERE Cardin =	9088
UPDATE dbo.zTest SET Loop2 =	550	WHERE Cardin =	9216
UPDATE dbo.zTest SET Loop2 =	520	WHERE Cardin =	9728
UPDATE dbo.zTest SET Loop2 =	510	WHERE Cardin =	10000
UPDATE dbo.zTest SET Loop2 =	500	WHERE Cardin =	10240
UPDATE dbo.zTest SET Loop2 =	420	WHERE Cardin =	12288
UPDATE dbo.zTest SET Loop2 =	350	WHERE Cardin =	14336
UPDATE dbo.zTest SET Loop2 =	320	WHERE Cardin =	16384
UPDATE dbo.zTest SET Loop2 =	210	WHERE Cardin =	24576
UPDATE dbo.zTest SET Loop2 =	160	WHERE Cardin =	32768
UPDATE dbo.zTest SET Loop2 =	110	WHERE Cardin =	49152
UPDATE dbo.zTest SET Loop2 =	80	WHERE Cardin =	65536
UPDATE dbo.zTest SET Loop2 =	55	WHERE Cardin =	98304
UPDATE dbo.zTest SET Loop2 =	50	WHERE Cardin =	114688 --UPDATE dbo.zTest SET Loop2 =	40	WHERE Cardin =	129999
UPDATE dbo.zTest SET Loop2 =	40	WHERE Cardin =	130048
UPDATE dbo.zTest SET Loop2 =	35	WHERE Cardin =	131071
UPDATE dbo.zTest SET Loop2 =	40	WHERE Cardin =	131072
UPDATE dbo.zTest SET Loop2 =	35	WHERE Cardin =	163840
UPDATE dbo.zTest SET Loop2 =	32	WHERE Cardin =	196608
UPDATE dbo.zTest SET Loop2 =	31	WHERE Cardin =	229376
UPDATE dbo.zTest SET Loop2 =	30	WHERE Cardin =	262144
COMMIT TRAN Loop2
SELECT @@TRANCOUNT
*/
GO
SELECT * FROM dbo.zTest WHERE Loop2 = 0
GO
/*
BEGIN TRAN MergeJ
UPDATE dbo.zTest SET Merg =	200000	WHERE Cardin =	1
UPDATE dbo.zTest SET Merg =	200000	WHERE Cardin =	2
UPDATE dbo.zTest SET Merg =	200000	WHERE Cardin =	3
UPDATE dbo.zTest SET Merg =	200000	WHERE Cardin =	4
UPDATE dbo.zTest SET Merg =	200000	WHERE Cardin =	6
UPDATE dbo.zTest SET Merg =	200000	WHERE Cardin =	8
UPDATE dbo.zTest SET Merg =	200000	WHERE Cardin =	12
UPDATE dbo.zTest SET Merg =	200000	WHERE Cardin =	16
UPDATE dbo.zTest SET Merg =	200000	WHERE Cardin =	24
UPDATE dbo.zTest SET Merg =	190000	WHERE Cardin =	32
UPDATE dbo.zTest SET Merg =	160000	WHERE Cardin =	48
UPDATE dbo.zTest SET Merg =	140000	WHERE Cardin =	64
UPDATE dbo.zTest SET Merg =	110000	WHERE Cardin =	96
UPDATE dbo.zTest SET Merg =	90000	WHERE Cardin =	128
UPDATE dbo.zTest SET Merg =	70000	WHERE Cardin =	192
UPDATE dbo.zTest SET Merg =	50000	WHERE Cardin =	256
UPDATE dbo.zTest SET Merg =	40000	WHERE Cardin =	384
UPDATE dbo.zTest SET Merg =	30000	WHERE Cardin =	512
UPDATE dbo.zTest SET Merg =	23000	WHERE Cardin =	768
UPDATE dbo.zTest SET Merg =	17000	WHERE Cardin =	1024
UPDATE dbo.zTest SET Merg =	8000	WHERE Cardin =	2048
UPDATE dbo.zTest SET Merg =	4500	WHERE Cardin =	4096
UPDATE dbo.zTest SET Merg =	3500	WHERE Cardin =	5120
UPDATE dbo.zTest SET Merg =	2100	WHERE Cardin =	8192
UPDATE dbo.zTest SET Merg =	2050	WHERE Cardin =	8704 --UPDATE dbo.zTest SET Merg =	2000	WHERE Cardin =	8768
UPDATE dbo.zTest SET Merg =	2030	WHERE Cardin =	8832 --UPDATE dbo.zTest SET Merg =	2000	WHERE Cardin =	8848 --UPDATE dbo.zTest SET Merg =	2000	WHERE Cardin =	8864 --UPDATE dbo.zTest SET Merg =	2000	WHERE Cardin =	8880
--UPDATE dbo.zTest SET Merg =	2000	WHERE Cardin =	8884 --UPDATE dbo.zTest SET Merg =	2000	WHERE Cardin =	8888 --UPDATE dbo.zTest SET Merg =	2000	WHERE Cardin =	8889
UPDATE dbo.zTest SET Merg =	2000	WHERE Cardin =	8890
UPDATE dbo.zTest SET Merg =	2020	WHERE Cardin =	8891 --UPDATE dbo.zTest SET Merg =	2000	WHERE Cardin =	8892 --UPDATE dbo.zTest SET Merg =	2000	WHERE Cardin =	8896
UPDATE dbo.zTest SET Merg =	2010	WHERE Cardin =	8960 -- UPDATE dbo.zTest SET Merg =	2000	WHERE Cardin =	9088
UPDATE dbo.zTest SET Merg =	2000	WHERE Cardin =	9216
UPDATE dbo.zTest SET Merg =	1900	WHERE Cardin =	9728
UPDATE dbo.zTest SET Merg =	1800	WHERE Cardin =	10000
UPDATE dbo.zTest SET Merg =	1700	WHERE Cardin =	10240
UPDATE dbo.zTest SET Merg =	1600	WHERE Cardin =	12288
UPDATE dbo.zTest SET Merg =	1300	WHERE Cardin =	14336
UPDATE dbo.zTest SET Merg =	1200	WHERE Cardin =	16384
UPDATE dbo.zTest SET Merg =	700	WHERE Cardin =	24576
UPDATE dbo.zTest SET Merg =	600	WHERE Cardin =	32768
UPDATE dbo.zTest SET Merg =	400	WHERE Cardin =	49152
UPDATE dbo.zTest SET Merg =	300	WHERE Cardin =	65536
UPDATE dbo.zTest SET Merg =	200	WHERE Cardin =	98304
UPDATE dbo.zTest SET Merg =	180	WHERE Cardin =	114688 -- UPDATE dbo.zTest SET Merg =	150	WHERE Cardin =	129999
UPDATE dbo.zTest SET Merg =	150	WHERE Cardin =	130048
UPDATE dbo.zTest SET Merg =	140	WHERE Cardin =	131071
UPDATE dbo.zTest SET Merg =	145	WHERE Cardin =	131072
UPDATE dbo.zTest SET Merg =	120	WHERE Cardin =	163840
UPDATE dbo.zTest SET Merg =	110	WHERE Cardin =	196608
UPDATE dbo.zTest SET Merg =	105	WHERE Cardin =	229376
UPDATE dbo.zTest SET Merg =	100	WHERE Cardin =	262144
COMMIT TRAN MergeJ
SELECT @@TRANCOUNT
*/
GO
SELECT * FROM dbo.zTest WHERE Merg = 0
GO
/*
BEGIN TRAN Hasj
UPDATE dbo.zTest SET Hasj =	35000	WHERE Cardin =	1
UPDATE dbo.zTest SET Hasj =	30000	WHERE Cardin =	2
UPDATE dbo.zTest SET Hasj =	29000	WHERE Cardin =	3
UPDATE dbo.zTest SET Hasj =	28000	WHERE Cardin =	4
UPDATE dbo.zTest SET Hasj =	27500	WHERE Cardin =	6
UPDATE dbo.zTest SET Hasj =	27000	WHERE Cardin =	8
UPDATE dbo.zTest SET Hasj =	26500	WHERE Cardin =	12
UPDATE dbo.zTest SET Hasj =	26000	WHERE Cardin =	16
UPDATE dbo.zTest SET Hasj =	25500	WHERE Cardin =	24
UPDATE dbo.zTest SET Hasj =	25000	WHERE Cardin =	32
UPDATE dbo.zTest SET Hasj =	24500	WHERE Cardin =	48
UPDATE dbo.zTest SET Hasj =	24000	WHERE Cardin =	64
UPDATE dbo.zTest SET Hasj =	22000	WHERE Cardin =	96
UPDATE dbo.zTest SET Hasj =	20000	WHERE Cardin =	128
UPDATE dbo.zTest SET Hasj =	18000	WHERE Cardin =	192
UPDATE dbo.zTest SET Hasj =	16000	WHERE Cardin =	256
UPDATE dbo.zTest SET Hasj =	14000	WHERE Cardin =	384
UPDATE dbo.zTest SET Hasj =	12000	WHERE Cardin =	512
UPDATE dbo.zTest SET Hasj =	10000	WHERE Cardin =	768
UPDATE dbo.zTest SET Hasj =	8000	WHERE Cardin =	1024
UPDATE dbo.zTest SET Hasj =	4500	WHERE Cardin =	2048
UPDATE dbo.zTest SET Hasj =	2500	WHERE Cardin =	4096
UPDATE dbo.zTest SET Hasj =	2000	WHERE Cardin =	5120
UPDATE dbo.zTest SET Hasj =	1260	WHERE Cardin =	8192
UPDATE dbo.zTest SET Hasj =	1250	WHERE Cardin =	8704 --UPDATE dbo.zTest SET Hasj =	1240	WHERE Cardin =	8768
UPDATE dbo.zTest SET Hasj =	1230	WHERE Cardin =	8832 --UPDATE dbo.zTest SET Hasj =	1230	WHERE Cardin =	8848 --UPDATE dbo.zTest SET Hasj =	1220	WHERE Cardin =	8864 --UPDATE dbo.zTest SET Hasj =	1220	WHERE Cardin =	8880
--UPDATE dbo.zTest SET Hasj =	1220	WHERE Cardin =	8884 --UPDATE dbo.zTest SET Hasj =	1220	WHERE Cardin =	8888 --UPDATE dbo.zTest SET Hasj =	1220	WHERE Cardin =	8889
UPDATE dbo.zTest SET Hasj =	1200	WHERE Cardin =	8890
UPDATE dbo.zTest SET Hasj =	1220	WHERE Cardin =	8891 --UPDATE dbo.zTest SET Hasj =	1220	WHERE Cardin =	8892 --UPDATE dbo.zTest SET Hasj =	1220	WHERE Cardin =	8896
UPDATE dbo.zTest SET Hasj =	1200	WHERE Cardin =	8960 -- UPDATE dbo.zTest SET Hasj =	1150	WHERE Cardin =	9088
UPDATE dbo.zTest SET Hasj =	1120	WHERE Cardin =	9216
UPDATE dbo.zTest SET Hasj =	1100	WHERE Cardin =	9728
UPDATE dbo.zTest SET Hasj =	1020	WHERE Cardin =	10000
UPDATE dbo.zTest SET Hasj =	1000	WHERE Cardin =	10240
UPDATE dbo.zTest SET Hasj =	850	WHERE Cardin =	12288
UPDATE dbo.zTest SET Hasj =	700	WHERE Cardin =	14336
UPDATE dbo.zTest SET Hasj =	600	WHERE Cardin =	16384
UPDATE dbo.zTest SET Hasj =	420	WHERE Cardin =	24576
UPDATE dbo.zTest SET Hasj =	320	WHERE Cardin =	32768
UPDATE dbo.zTest SET Hasj =	220	WHERE Cardin =	49152
UPDATE dbo.zTest SET Hasj =	160	WHERE Cardin =	65536
UPDATE dbo.zTest SET Hasj =	110	WHERE Cardin =	98304
UPDATE dbo.zTest SET Hasj =	90	WHERE Cardin =	114688 --UPDATE dbo.zTest SET Hasj =	80	WHERE Cardin =	129999
UPDATE dbo.zTest SET Hasj =	80	WHERE Cardin =	130048
UPDATE dbo.zTest SET Hasj =	75	WHERE Cardin =	131071
UPDATE dbo.zTest SET Hasj =	80	WHERE Cardin =	131072
UPDATE dbo.zTest SET Hasj =	55	WHERE Cardin =	163840
UPDATE dbo.zTest SET Hasj =	50	WHERE Cardin =	196608
UPDATE dbo.zTest SET Hasj =	42	WHERE Cardin =	229376
UPDATE dbo.zTest SET Hasj =	40	WHERE Cardin =	262144
COMMIT TRAN Hasj
SELECT @@TRANCOUNT
*/
GO
SELECT * FROM dbo.zTest WHERE Hasj = 0
GO
/*
BEGIN TRAN SortM
UPDATE dbo.zTest SET SMer =	130000	WHERE Cardin =	2
UPDATE dbo.zTest SET SMer =	127000	WHERE Cardin =	3
UPDATE dbo.zTest SET SMer =	125000	WHERE Cardin =	4
UPDATE dbo.zTest SET SMer =	120000	WHERE Cardin =	6
UPDATE dbo.zTest SET SMer =	115000	WHERE Cardin =	8
UPDATE dbo.zTest SET SMer =	112000	WHERE Cardin =	12
UPDATE dbo.zTest SET SMer =	110000	WHERE Cardin =	16
UPDATE dbo.zTest SET SMer =	95000	WHERE Cardin =	24
UPDATE dbo.zTest SET SMer =	85000	WHERE Cardin =	32
UPDATE dbo.zTest SET SMer =	80000	WHERE Cardin =	48
UPDATE dbo.zTest SET SMer =	70000	WHERE Cardin =	64
UPDATE dbo.zTest SET SMer =	60000	WHERE Cardin =	96
UPDATE dbo.zTest SET SMer =	55000	WHERE Cardin =	128
UPDATE dbo.zTest SET SMer =	45000	WHERE Cardin =	192
UPDATE dbo.zTest SET SMer =	35000	WHERE Cardin =	256
UPDATE dbo.zTest SET SMer =	27000	WHERE Cardin =	384
UPDATE dbo.zTest SET SMer =	20000	WHERE Cardin =	512
UPDATE dbo.zTest SET SMer =	15000	WHERE Cardin =	768
UPDATE dbo.zTest SET SMer =	11000	WHERE Cardin =	1024
UPDATE dbo.zTest SET SMer =	6000	WHERE Cardin =	2048
UPDATE dbo.zTest SET SMer =	3200	WHERE Cardin =	4096
UPDATE dbo.zTest SET SMer =	2500	WHERE Cardin =	5120
UPDATE dbo.zTest SET SMer =	1500	WHERE Cardin =	8192
UPDATE dbo.zTest SET SMer =	1470	WHERE Cardin =	8704 --UPDATE dbo.zTest SET SMer =	1460	WHERE Cardin =	8768
UPDATE dbo.zTest SET SMer =	1450	WHERE Cardin =	8832 --UPDATE dbo.zTest SET SMer =	1440	WHERE Cardin =	8848 --UPDATE dbo.zTest SET SMer =	1430	WHERE Cardin =	8864 --UPDATE dbo.zTest SET SMer =	1420	WHERE Cardin =	8880
--UPDATE dbo.zTest SET SMer =	1420	WHERE Cardin =	8884 --UPDATE dbo.zTest SET SMer =	1420	WHERE Cardin =	8888 --UPDATE dbo.zTest SET SMer =	1420	WHERE Cardin =	8889
UPDATE dbo.zTest SET SMer =	1410	WHERE Cardin =	8890
UPDATE dbo.zTest SET SMer =	1420	WHERE Cardin =	8891 --UPDATE dbo.zTest SET SMer =	1420	WHERE Cardin =	8892 --UPDATE dbo.zTest SET SMer =	1400	WHERE Cardin =	8896
UPDATE dbo.zTest SET SMer =	1380	WHERE Cardin =	8960 --UPDATE dbo.zTest SET SMer =	1360	WHERE Cardin =	9088
UPDATE dbo.zTest SET SMer =	1320	WHERE Cardin =	9216
UPDATE dbo.zTest SET SMer =	1300	WHERE Cardin =	9728
UPDATE dbo.zTest SET SMer =	1240	WHERE Cardin =	10000
UPDATE dbo.zTest SET SMer =	1200	WHERE Cardin =	10240
UPDATE dbo.zTest SET SMer =	1000	WHERE Cardin =	12288
UPDATE dbo.zTest SET SMer =	900	WHERE Cardin =	14336
UPDATE dbo.zTest SET SMer =	800	WHERE Cardin =	16384
UPDATE dbo.zTest SET SMer =	500	WHERE Cardin =	24576
UPDATE dbo.zTest SET SMer =	400	WHERE Cardin =	32768
UPDATE dbo.zTest SET SMer =	260	WHERE Cardin =	49152
UPDATE dbo.zTest SET SMer =	200	WHERE Cardin =	65536
UPDATE dbo.zTest SET SMer =	140	WHERE Cardin =	98304
UPDATE dbo.zTest SET SMer =	120	WHERE Cardin =	114688 -- UPDATE dbo.zTest SET SMer =	110	WHERE Cardin =	129999
UPDATE dbo.zTest SET SMer =	105	WHERE Cardin =	130048
UPDATE dbo.zTest SET SMer =	95	WHERE Cardin =	131071
UPDATE dbo.zTest SET SMer =	100	WHERE Cardin =	131072
UPDATE dbo.zTest SET SMer =	80	WHERE Cardin =	163840
UPDATE dbo.zTest SET SMer =	70	WHERE Cardin =	196608
UPDATE dbo.zTest SET SMer =	60	WHERE Cardin =	229376
UPDATE dbo.zTest SET SMer =	50	WHERE Cardin =	262144
COMMIT TRAN SortM
SELECT @@TRANCOUNT
*/
GO

SELECT * FROM dbo.zTest
SELECT [table], Cardin, Rang, row_count, idp FROM dbo.vtest WHERE [table] LIKE 'A%' AND [table] <> 'A' ORDER BY Cardin

SELECT Tabl, Cardin, Rang, Cardin*Rang rw, Cardin*Rang - RowCt diff, Cardin*Rang/101., Cardin*Rang/101. - ird irx, ird
FROM dbo.zTest --WHERE Cardin*Rang <> RowCt 

