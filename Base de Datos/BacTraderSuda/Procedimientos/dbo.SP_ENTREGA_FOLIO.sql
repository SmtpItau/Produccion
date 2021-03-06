USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ENTREGA_FOLIO]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[SP_ENTREGA_FOLIO]
            ( @codigo char(10) )
as
begin
   set nocount on
      declare @folio numeric(10)
      select @folio = folio from GEN_FOLIOS where codigo = @codigo
      update GEN_FOLIOS set folio = @folio + 1 where codigo = @codigo
   select @folio
   set nocount off
end   /* fin procedimiento */
--select * from GEN_FOLIOS
--insert GEN_FOLIOS values( 'dcv', 1 )
--  sp_entrega_folio 'dcv'

GO
