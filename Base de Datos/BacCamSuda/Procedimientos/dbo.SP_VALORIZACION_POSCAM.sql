USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALORIZACION_POSCAM]    Script Date: 11-05-2022 16:43:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[SP_VALORIZACION_POSCAM] 
 @fecha_pro datetime = null
as begin
-------------------------------------------------------------------------------------------------
--- notas:
-------------------------------------------------------------------------------------------------
--- el calculo utiliza el tipo de cambio observado y las paridades que informa el banco que 
--- informa el banco central de chile diariamente.
-------------------------------------------------------------------------------------------------
set nocount on
declare @nemo_me  char(8)  ,
 @rel_dolar  char(1)  ,
 @codigo_me   numeric(5) ,
 @posini_me   numeric(19,4) ,
 @posini_mn   numeric(19,4) ,
 @totcom_me   numeric(19,4) ,
 @totcom_mn   numeric(19,4) ,
 @totven_me   numeric(19,4) ,
 @totven_mn   numeric(19,4) ,
 @posact_me   numeric(19,4) ,
 @posact_mn   numeric(19,4) ,
 @cuenta_cambio  numeric(19) ,
 @cuenta_ajustada numeric(19) ,
 @valor_ajuste  numeric(19) ,
 @utilidad  numeric(19) ,
 @perdida  numeric(19) ,
 @paridad  float  ,
 @tipocambio  float  ,
 @precio   float  
     
     if @fecha_pro is null  begin
 select @fecha_pro = acfecpro from MEAC
     end
     select @tipocambio = vmvalor from VIEW_VALOR_MONEDA where vmcodigo = 994 and vmfecha = @fecha_pro
     if ( @tipocambio = 0 or @tipocambio is null ) begin
        declare @a datetime
        select @a = @fecha_pro
 select 1,'ERROR: EL TIPO DE CAMBIO OBSERVADO NO HA SIDO INGRESADO PARA EL DIA ' + convert(char(10), @a,103)
 set nocount off
 return 1
     end
     begin transaction 
     delete MERS where rsfecha = @fecha_pro
     declare CUR_POSICION cursor for 
 select nemo_me   = mnnemo         ,
  rel_dolar = mnrrda         ,
  codigo_me = mncodmon         ,
  posini_me = vmposini         ,
  posini_mn = round( convert(numeric(19,4),vmposini * vmpreini) ,0)  ,
  totcom_me = vmtotco         ,
  totcom_mn = vmtotcope         ,
  totven_me = vmtotve         ,
  totven_mn = vmtotvepe         ,
  posact_me = vmposic         ,
  posact_mn = round( convert(numeric(19,4),vmposic * vmprecierre) , 0)  ,
  paridad   = vmparidad  
    from VIEW_POSICION_SPT  ,
  VIEW_MONEDA
   where vmfecha   = @fecha_pro and
  mnnemo   = vmcodigo
     open CUR_POSICION 
     while ( 1 = 1 ) begin
  fetch next from CUR_POSICION into 
    @nemo_me   ,
    @rel_dolar ,  
    @codigo_me ,
    @posini_me ,
    @posini_mn ,
    @totcom_me ,
    @totcom_mn ,
    @totven_me ,
    @totven_mn ,
    @posact_me ,
    @posact_mn ,
    @paridad
  if @@fetch_status = -1
   break
  --------------------------------------------------------------------
  -- calcula el precio de valorizacion basado en la paridad de mercado
  --------------------------------------------------------------------
  if @paridad = 0 begin
  
   select @precio = 0
  end else begin
   --------------------------------------------------------------------
   -- calcula el precio de valorizacion basado en la paridad de mercado
   --------------------------------------------------------------------
   if @rel_dolar = 'D'
    select @precio = round( @tipocambio / @paridad , 8 )
   else
    select @precio = round( @tipocambio * @paridad , 8 )
 
  end
  -----------------------------------------------------------------------------
  -- calcula la utilidad o perdida de cambios
  -----------------------------------------------------------------------------
  select @cuenta_cambio = @posini_mn + @totcom_mn - @totven_mn
  select @cuenta_ajustada = round( @posact_me * @precio , 0 )
  select @valor_ajuste = @cuenta_ajustada - @cuenta_cambio
  select @utilidad = 0
  select @perdida  = 0
  if @posact_me > 0 begin
   if @valor_ajuste > 0 
    select @utilidad = @valor_ajuste 
   else
    select @perdida  = abs(@valor_ajuste)
  end else begin
   if @valor_ajuste < 0 
    select @utilidad =  abs(@valor_ajuste)
   else
    select @perdida  = @valor_ajuste
 end
 
  ------------------------------------------------------------------------------
  --- registra la valorizacion en la tabla de resultados
  ------------------------------------------------------------------------------
  if @valor_ajuste <> 0 begin
                        --select  * from mers
   insert into MERS ( rsfecha    , rsnemome, rscodigome, rsposicion, rscuentacambio, rscuentaajustada, rsvalorajuste, rsutilidad, rsperdida)
    values  ( @fecha_pro , @nemo_me, @codigo_me, @posact_me, @cuenta_cambio, @cuenta_ajustada, @valor_ajuste, @utilidad , @perdida )
  end
     end
     close CUR_POSICION
     deallocate CUR_POSICION
     commit transaction
     select 0,'OK'
set nocount off
     return 0
set nocount off
end



GO
