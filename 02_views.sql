USE Test
GO
/*
-- views
*/
/*
SELECT * FROM master.sys.procedures
SELECT * FROM sys.views ORDER BY name
*/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- veqs -- can be in master?
IF NOT EXISTS (
SELECT * FROM sys.views WHERE name = 'veqs'
) 
*/
SELECT * FROM sys.dm_exec_query_stats WHERE total_worker_time > 10000 AND execution_count >= 30 
GO
CREATE OR ALTER VIEW dbo.veqs AS
SELECT SUBSTRING(t.text, (q.statement_start_offset/2)+1, (CASE statement_end_offset WHEN -1 THEN DATALENGTH(t.text) ELSE q.statement_end_offset END - q.statement_start_offset)/2 + 1) AS statement_text
, execution_count, total_worker_time, total_elapsed_time
, total_physical_reads tphys_reads, total_logical_reads tlog_reads, total_rows
, statement_start_offset start_off, statement_end_offset end_off
, CASE execution_count WHEN 0 THEN 0 ELSE (100*total_worker_time/execution_count)*0.01 END av_w
, max_worker_time, max_elapsed_time, max_dop
, q.creation_time, q.last_execution_time
FROM sys.dm_exec_query_stats q OUTER APPLY sys.dm_exec_sql_text(q.sql_handle) as t
GO
/*
SELECT statement_text, execution_count, total_worker_time, total_elapsed_time, tphys_reads, tlog_reads, total_rows, start_off, end_off, last_execution_time, creation_time
FROM dbo.veqs WHERE total_worker_time > 10000 ORDER BY total_worker_time DESC
*/
GO
/*
DROP VIEW dbo.vDbPtSt
IF NOT EXISTS (
SELECT * FROM sys.views WHERE name = 'vDbPtSt'
) 
*/
CREATE OR ALTER VIEW dbo.[vDbPtSt] AS
WITH a AS (
 SELECT object_id, index_id, SUM(in_row_data_page_count) idp, SUM(in_row_used_page_count) iup, SUM(in_row_reserved_page_count) irp, SUM(row_count) row_count
 , SUM(lob_used_page_count) lup, SUM(row_overflow_used_page_count) oup, SUM(CASE row_count WHEN 0 THEN 0 ELSE 1 END) pp, COUNT(*) pt
 FROM sys.dm_db_partition_stats WITH(NOLOCK) WHERE object_id > 1000 GROUP BY object_id, index_id 
) , d AS (
 SELECT object_id, index_id, idp, iup, irp, row_count, lup, oup, pp, pt 
 , CASE idp WHEN 0 THEN 0 ELSE 1.0*row_count/idp END Rw_Pg
 , CASE row_count WHEN 0 THEN 0 ELSE 8096.*idp/row_count END ABR
 , CASE row_count WHEN 0 THEN 1 ELSE CONVERT(int,8096.*idp/row_count) END IBR
 FROM a
)
SELECT o.name [table], i.name [index], d.index_id, i.data_space_id dsid, idp, iup, irp, row_count, o.object_id, o.type
, CONVERT(decimal(19,2),d.Rw_Pg) AS Rw_Pg, CONVERT(decimal(19,2),d.ABR) AS ABR, d.pt, d.pp, d.lup, d.oup
, u.user_seeks, u.user_scans, u.user_lookups, u.user_updates , INDEXPROPERTY(o.object_id, i.name,'IndexDepth') IxDep 
, 8096/IBR RpP, 8096-(8096/IBR)*IBR FpP
, (8096 - (row_count % (8096/IBR))*CONVERT(int,ABR)) % 8096 AS LstPFr , row_count % (8096/IBR) AS lstPRw 
, CONVERT(decimal(19,1), 8096*idp - row_count*ABR) AS altLPg
FROM d JOIN sys.indexes i ON i.object_id = d.object_id AND i.index_id = d.index_id
JOIN sys.objects o ON o.object_id = i.object_id 
LEFT JOIN sys.dm_db_index_usage_stats u ON u.database_id = DB_ID() AND u.object_id = d.object_id AND u.index_id = d.index_id
WHERE o.type <> 'IT' 
GO
/**/
CREATE OR ALTER VIEW dbo.vcol AS
WITH x AS (
 SELECT o.object_id, o.schema_id, o.name, o.type, b.idp, b.row_count, b.index_id, 8096*b.idp tBytes
 , CASE b.row_count WHEN 0 THEN 0. ELSE 8096.*b.idp/b.row_count END ABR
 , CASE b.row_count WHEN 0 THEN 1 ELSE CONVERT(int,8096.*b.idp/b.row_count) END IBR
 FROM sys.objects o
 OUTER APPLY (
	SELECT d.index_id, SUM(in_row_data_page_count) idp, SUM(row_count) row_count
	FROM sys.dm_db_partition_stats d WITH(NOLOCK) 
	WHERE d.object_id = o.object_id AND d.index_id <= 1 GROUP BY d.index_id
 ) b  WHERE o.type = 'U'
) 
SELECT x.object_id, x.schema_id, x.name, x.type, x.idp, x.row_count, x.index_id, a.col, a.byt, j.ix
, CONVERT(decimal(9,2),x.ABR) ABR , 8096/IBR RpP
, 8096-(8096/IBR)*IBR FpP
, (8096 - (row_count % (8096/IBR))*CONVERT(int,ABR)) % 8096 AS LstPFr , row_count % (8096/IBR) AS lstPRw 
, CONVERT(decimal(19,1),8096*idp - row_count*ABR) AS altLPg
, IBR                
, (8096/IBR)*IBR ByUs
--, (8096./IBR)*IBR ByUs
FROM x
CROSS APPLY ( SELECT COUNT(*) col, SUM(max_length) byt FROM sys.columns c WHERE c.object_id = x.object_id GROUP BY c.object_id ) a
OUTER APPLY ( SELECT COUNT(*) ix FROM sys.indexes i WHERE i.object_id = x.object_id AND i.index_id > 1 GROUP BY i.object_id ) j
--WHERE x.type = 'U'
--, tBytes - CONVERT(int,ABR)*row_count uBytes
--, row_count / (8096/IBR) fullP
-- CONVERT(decimal(18,4),(8096.-FpP)/RpP) 
GO
/*
SELECT * FROM dbo.vcol WHERE object_id = OBJECT_ID('Nums')
SELECT name, col, byt, idp, row_count, ABR, ix FROM dbo.vcol 
WHERE name LIKE 'I%' 
*/
GO
CREATE OR ALTER VIEW dbo.vOsBuf AS
SELECT p.object_id, o.name
, b.file_id, b.page_id, b.page_level, b.page_type, b.row_count, b.free_space_in_bytes
, b.numa_node, b.read_microsec, b.is_modified
, a.type, a.data_space_id, a.data_pages
, a.total_pages, a.used_pages
, p.rows, p.index_id
FROM sys.dm_os_buffer_descriptors b WITH(NOLOCK) 
JOIN sys.allocation_units a ON a.allocation_unit_id = b.allocation_unit_id
JOIN sys.partitions p WITH(NOLOCK) ON a.container_id = CASE a.type WHEN 2 THEN p.partition_id ELSE p.hobt_id END
JOIN sys.objects o WITH(NOLOCK) ON o.object_id = p.object_id
WHERE b.database_id = DB_ID()
--AND o.name = 'Nums' --AND page_type = 'DATA_PAGE'
--AND b.row_count <> 100
--ORDER BY b.database_id, b.file_id, b.page_id
GO
/*
*/
GO
CREATE OR ALTER VIEW dbo.vwPartition
AS
 SELECT i.object_id, i.index_id, u.name sch, o.name tabl, i.name [indx]
 , f.name pfn, f.function_id
 , s.name psn, i.data_space_id psi
 , d.partition_number pn
 , r.value
 , d.in_row_data_page_count page_cnt
 , d.row_overflow_used_page_count ovr_cnt
 , d.lob_used_page_count lob_cnt
 , d.reserved_page_count res_cnt
 , d.row_overflow_reserved_page_count ovr_res
 , d.lob_reserved_page_count lob_res
 , d.row_count row_cnt
 , CASE d.row_count WHEN 0 THEN 0 ELSE CONVERT(decimal(18,1),(8192.*d.in_row_data_page_count)/d.row_count) END RwSz
 , CASE d.row_count WHEN 0 THEN 0 ELSE CONVERT(decimal(18,1),(8192.*d.lob_used_page_count)/d.row_count) END LbSz
 , e.data_space_id dsid
 , p.data_compression cmp
 , i.fill_factor ff
 FROM sys.indexes i WITH(NOLOCK) 
 INNER JOIN sys.objects o WITH(NOLOCK) ON o.object_id = i.object_id
 JOIN sys.schemas u ON u.schema_id = o.schema_id
 INNER JOIN sys.dm_db_partition_stats d WITH(NOLOCK) ON d.object_id = i.object_id AND d.index_id = i.index_id 
 LEFT JOIN sys.partition_schemes s WITH(NOLOCK) ON s.data_space_id = i.data_space_id  
 LEFT JOIN sys.partition_functions f WITH(NOLOCK) ON f.function_id = s.function_id
 LEFT JOIN sys.destination_data_spaces e WITH(NOLOCK) ON e.partition_scheme_id = i.data_space_id AND e.destination_id = d.partition_number 
 LEFT JOIN sys.partition_range_values r WITH(NOLOCK) ON r.function_id = s.function_id AND r.boundary_id = e.destination_id - f.boundary_value_on_right
 LEFT JOIN sys.partitions p WITH(NOLOCK) ON p.object_id = d.object_id AND p.index_id = d.index_id AND p.partition_number = d.partition_number
 WHERE i.type IN(0,1,2,5) AND i.is_disabled = 0 AND i.is_hypothetical = 0
GO
/*
-- GROUP BY i.object_id, i.index_id, s.function_id, i.data_space_id, d.partition_number 
*/
GO
CREATE OR ALTER VIEW dbo.vtest AS
WITH a AS (
 SELECT object_id, index_id
 , SUM(in_row_data_page_count) idp
 , SUM(in_row_used_page_count) iup
 , SUM(in_row_reserved_page_count) irp
 , SUM(row_count) row_count
 , SUM(lob_used_page_count) lup
 , SUM(row_overflow_used_page_count) oup
 , SUM(CASE row_count WHEN 0 THEN 0 ELSE 1 END) pp, COUNT(*) pt
 FROM sys.dm_db_partition_stats WITH(NOLOCK) WHERE object_id > 1000 AND index_id <= 1
 GROUP BY object_id, index_id 
) , d AS (
 SELECT object_id/*, index_id*/, idp, iup, irp, row_count, lup, oup, pp, pt 
 , CASE idp WHEN 0 THEN 0 ELSE 1.0*row_count/idp END Rw_Pg
 , CASE row_count WHEN 0 THEN 0 ELSE 8096.*idp/row_count END ABR
 , CASE row_count WHEN 0 THEN 1 ELSE CONVERT(int,8096.*idp/row_count) END IBR
 FROM a
)
SELECT o.name [table], row_count --, i.name [index], d.index_id
, d.row_count/h.ubd Cardin, h.ubd Rang
, idp, iup, irp, o.object_id, o.type
, CONVERT(decimal(19,2),d.Rw_Pg) AS Rw_Pg
, CONVERT(decimal(19,2),d.ABR) AS ABR
, d.pt, d.pp, d.lup, d.oup
, u.user_seeks, u.user_scans, u.user_lookups, u.user_updates
, INDEXPROPERTY(o.object_id, i.name,'IndexDepth') IxDep 
, 8096/IBR RpP, 8096-(8096/IBR)*IBR FpP
, (8096 - (row_count % (8096/IBR))*CONVERT(int,ABR)) % 8096 AS LstPFr 
, row_count % (8096/IBR) AS lstPRw 
, CONVERT(decimal(19,1), 8096*idp - row_count*ABR) AS altLPg
, i.data_space_id dsid
FROM d 
LEFT JOIN sys.indexes i ON i.object_id = d.object_id AND i.index_id IN (0,1) -- d.index_id
JOIN sys.objects o ON o.object_id = d.object_id 
LEFT JOIN sys.dm_db_index_usage_stats u ON u.database_id = DB_ID() AND u.object_id = i.object_id AND u.index_id = i.index_id
OUTER APPLY (
 SELECT MIN(h.range_high_key) lbd , CONVERT(bigint,MAX(h.range_high_key)) ubd , SUM(h.range_rows) + SUM(h.equal_rows) srw 
 FROM sys.dm_db_stats_histogram (o.object_id, 1) h
) h
WHERE o.type IN ('U', 'V') -- <> 'IT' 
--AND o.name LIKE 'A%' AND o.name <> 'A'
--ORDER BY o.name
GO
GO
/*
CREATE OR ALTER VIEW dbo.vtest AS
SELECT o.name Tabl, d.row_count, h.ubd Rang
, d.row_count/h.ubd Cardin
, d.in_row_data/8 irp, in_row_data ird, d.row_count - h.srw rerr --, CONVERT(int,(8.*row_count)/in_row_data+.01) rpp
, d.row_count - (d.row_count/h.ubd)*h.ubd rem
FROM sys.objects o JOIN sys.schemas s ON s.schema_id = o.schema_id
OUTER APPLY (
 SELECT in_row_data = 8*SUM(d.in_row_data_page_count) , row_count = SUM(row_count) 
 FROM sys.dm_db_partition_stats d WITH(NOLOCK) 
 JOIN sys.partitions r WITH(NOLOCK) ON r.partition_id = d.partition_id
 WHERE d.object_id = o.object_id --GROUP BY d.object_id
) d OUTER APPLY (
 SELECT MIN(h.range_high_key) lbd, CONVERT(bigint,MAX(h.range_high_key)) ubd, SUM(h.range_rows) + SUM(h.equal_rows) srw 
 FROM sys.dm_db_stats_histogram (o.object_id, 1) h
) h
WHERE o.type IN ('U', 'V') AND o.name <> 'A' -- o.name LIKE @objname AND 
--ORDER BY row_count/h.ubd, o.name
*/
GO
SELECT * FROM sys.views
GO
