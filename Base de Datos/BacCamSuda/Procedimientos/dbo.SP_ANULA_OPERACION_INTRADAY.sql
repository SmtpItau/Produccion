USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ANULA_OPERACION_INTRADAY]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[SP_ANULA_OPERACION_INTRADAY]
  (
    @numopera numeric(7)
  )
as
begin
   set nocount on
   declare @monumfut numeric(8)
   select @monumfut = (select monumfut from MEMO where monumope = @numopera)
   
 update MEMO
 set moestatus =   'a'
    ,marca =   ''
 where monumope =   @numopera
   if @monumfut > 0 
   begin
        update VIEW_MFCA
           set caestado = 'a',
               marca    = ''
           where canumoper = @monumfut 
   end
 --------------------------<< actualiza mepos
 execute Sp_Recalc                  -- posicion usd
 --if @codmon <> 'usd'                -- posicion m/e (arbitraje)
 execute Sp_Recalcmx 'usd'--@codmon
   set nocount off
end




GO
