USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DILEERDISP]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** objeto:  procedimiento  almacenado dbo.sp_dileerdisp    fecha de la secuencia de comandos: 05/04/2001 13:13:22 ******/
CREATE PROCEDURE [dbo].[SP_DILEERDISP] (@rutcart1 numeric(09,0),
                           @numdocu1 numeric(10,0),
                           @correla1 numeric(05,0),
                           @sqlvari1 varchar(255),
                           @sqlfami1 varchar(255),
                           @sqlemis1 varchar(255),
                           @sqlmone1 varchar(255),
                           @contador1   numeric(19,00))
as
begin
set nocount on
 declare @sqlfijo1 varchar(255)
 declare @sqlfijo2 varchar(255)
 declare @sqlfijo3 varchar(255)
-- set rowcount 17
 -- asigna la parte fija de la consulta
 select @sqlfijo1 = 'select dirutcart,dinumdocu,dicorrela,diinstser,digenemi,dinemmon,dinominal,ditircomp,dipvpcomp,divptirc,blusuario,ditipoper, dicontador from MDDI LEFT OUTER JOIN MDBL ON dirutcart = blrutcart 
                              and dinumdocu = blnumdocu 
                              and dicorrela = blcorrela  '
 select @sqlfijo2 = 'where dirutcart = ' + convert(varchar,@rutcart1) + ' and dicontador >= ' + convert(varchar,@contador1) + ' and dinominal <> 0 and diserie<>''ICAP''' + ' and diserie<>''ICOL'''
   
 -- ejecuta la consulta
   exec (@sqlfijo1 + @sqlfijo2 + @sqlvari1 + @sqlfami1 + @sqlemis1 + @sqlmone1 + @sqlfijo3 + 'order by diinstser, dinominal')
-- set rowcount 0
end
-- sp_dileerdisp 97024000,1,1,' and ditipcart = 1','','','',0
--Sp_Devengo 6.0,6.0,6.0 
--select dirutcart,dinumdocu,dicorrela,diinstser,digenemi,dinemmon,dinominal,ditircomp,dipvpcomp,divptirc,blusuario,ditipoper from MDDI,MDBL where dirutcart*=blrutcart and dinumdocu*=blnumdocu and dicorrela*=blcorrela and dirutcart = 97024000 and dinumdocu  
--select * from MDAC
-- sp_dileerdisp 97024000,0,0,' and ditipcart = 1','','','',243
--sp_dileerdisp 97024000,6,17,' and ditipcart = 1','','',''
--select dinumdocu, dicorrela, dinominal, diinstser, dicontador from MDDI
--sp_dileerdisp 97024000,0,0,' and ditipcart = 1','','','',0
-- select * from MDBL


GO
