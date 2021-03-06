USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGARDOCBLOQUEADOS]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CARGARDOCBLOQUEADOS]
               (   @usuario   char(20))
as 
begin
   set nocount on
   select       blrutcart, blnumdocu, blcorrela, blhwnd, blusuario, diinstser
          from  MDBL, MDDI
          where MDBL.blusuario = @usuario                       and
                MDBL.blrutcart = MDDI.dirutcart  and 
                MDBL.blnumdocu = MDDI.dinumdocu  and
                MDBL.blcorrela = MDDI.dicorrela
      
   set nocount off            
   
end
--    select * from  MDBL
--select * from MDCI
--select mdse.semascara,mdse.seserie from mdse
--select * from MDDI
--select * from MDBL order by blnumdocu
--1376770
--diinstser
--dirutcart,dinumdocu,dicorrela
-- sp_cargardocbloqueados 'administra'
-- sp_help MDBL


GO
