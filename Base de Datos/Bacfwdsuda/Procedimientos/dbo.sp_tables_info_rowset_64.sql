USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[sp_tables_info_rowset_64]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
create procedure [dbo].[sp_tables_info_rowset_64] @table_name sysname, @table_schema sysname = null, @table_type nvarchar(255) = null 
as
declare @Result int
select @Result = 0
exec @Result = sp_tables_info_rowset @table_name, @table_schema, @table_type
GO
