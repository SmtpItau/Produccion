USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ENTREGA_CORREL_SOMA]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_ENTREGA_CORREL_SOMA]
--            ( @codigo char(10) )
as
begin

   set nocount on

	declare @folio numeric(10)

	select  @folio = Max(CorrelOpe) from CARGASOMA --where codigo = @codigo

	select @folio

   set nocount off
end   /* fin procedimiento */

GO
