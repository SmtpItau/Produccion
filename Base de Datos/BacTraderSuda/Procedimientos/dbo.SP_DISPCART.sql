USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DISPCART]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** objeto:  procedimiento  almacenado dbo.sp_dispcart    fecha de la secuencia de comandos: 05/04/2001 13:13:22 ******/
CREATE PROCEDURE [dbo].[SP_DISPCART] (@rutcart1 numeric(09,0),
                           @numdocu1 numeric(10,0),
                           @correla1 numeric(05,0),
                           @sqlvari1 varchar(255),
                           @sqlfami1 varchar(255),
                           @sqlemis1 varchar(255),
      @fecha1 char(10) )
as
begin
 declare @sqlfijo1 varchar(255)
 declare @sqlfijo2 varchar(255)
 --set rowcount 17
 -- asigna la parte fija de la consulta
--  REQ. 7619
 select @sqlfijo1 = 'select dinumdocu,dicorrela, diinstser,digenemi,dinominal,ditircomp,difecsal from MDDI LEFT OUTER JOIN MDBL ON dirutcart = blrutcart 
                              and dinumdocu = blnumdocu 
                              and dicorrela = blcorrela  '
 if @fecha1 = ''
  select @sqlfijo2 = 'where dirutcart = ' + convert(varchar,@rutcart1) + ' and dinominal <> 0 '
 else
  select @sqlfijo2 = 'where dirutcart = ' + convert(varchar,@rutcart1) + ' and dinominal <> 0 and difecsal = ' +  @fecha1 + '' print @sqlfijo2
 -- ejecuta la consulta
 exec (@sqlfijo1 + @sqlfijo2 + @sqlvari1 + @sqlfami1 + @sqlemis1  + ' order by dicontador')
 --set rowcount 0
end
--sp_dispcart 97024000,0,0,'','','','12/31/1998'
--select difecsal from MDDI where difecsal > '09/02/1999' and dinominal <> 0
-- sp_dispcart 97024000,36,1,' and ditipcart = 1','','','',0
-- sp_dispcart 97024000,0,0,'','','','',0
-- sp_dispcart 97024000,0,0,'',' and diserie in ('dpr') ',' and digenemi in ('abn') ','',0
-- select * from MDBL
--and diserie<>'ICAP' and diserie<>'ICOL' ' -- and difecsal = @fech
-- and dirutcart = ' + convert(varchar,@rutcart1) + '
--sp_dispcart 97024000,0,0,'','','','','09/02/1999'
-- sp_helptext sp_dispcart 
-- sp_dispcart 97024000,0,0,'','','','','09/02/1999'
-- sp_dispcart 97024000,0,0,'','','',''
--sp_dispcart 97024000,0,0,'','','','12/31/1998'


GO
