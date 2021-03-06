USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTA_TASAMERCADO]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CONTA_TASAMERCADO]
as
begin
      set nocount on
 declare @ftotnrea float ,
  @ftotsrea float ,
  @ftotmx  float ,
  @fdiferencia   float ,
  @ftipocambio float ,
  @ftotmxclp float ,
  @dfechatm datetime,
  @dfecpro datetime
 select  @dfecpro = acfecproc from MDAC 
 select  @ftotmx   = sum(isnull(rmdiferencia,0)) from MDRM where rmmonemi = 13 
 select  @ftotnrea = sum(isnull(rmdiferencia,0)) from MDRM where rmmonemi = 999
 select  @ftotsrea = sum(isnull(rmdiferencia,0)) from MDRM where rmmonemi <> 13 and rmmonemi <> 999 
 set rowcount 1
 select  @dfechatm = rmfecha  from MDRM 
 set rowcount 0
 select @ftipocambio = isnull(vmvalor,0) 
 from VIEW_VALOR_MONEDA
 where vmcodigo = 994 and vmfecha = @dfecpro
 select @ftotmxclp    = round((@ftotmx * @ftipocambio),0) 
 select @fdiferencia  = (isnull(@ftotnrea,0) +  isnull(@ftotsrea,0) +isnull( @ftotmxclp,0))
 if @dfechatm = @dfecpro 
 begin 
  /* =============================================================================
=========== */
  /* tasa de mercado             */
  /* ======================================================================================== */
-- print '1'
  insert BAC_CNT_CONTABILIZA(
          id_sistema  ,
          tipo_movimiento  ,
          tipo_operacion  ,
          operacion               ,
          correlativo             ,
          valor_presente          ,
          valor_compra            ,
          valor_venta  ,
   utilidad  ,
   perdida   ,
   valor_cupon  ,
          nominalpesos  )
   select 'BTR'                   ,
          'TMF'                   ,
          'TMF'                   ,
          1   ,
          0                       ,
   isnull(@ftotnrea,0)  ,--sin isnull
   isnull(@ftotsrea,0)  ,--sin isnull
   isnull(@ftotmx,0)   ,
   isnull((case when isnull(@fdiferencia,0) > 0 then abs(isnull(@fdiferencia,0)) end),0), --sin isnull
   isnull((case when isnull(@fdiferencia,0) < 0 then abs(isnull(@fdiferencia,0)) end),0), --sin isnull
   isnull(@ftotmx,0), --modificado antes @ftotmx 15/01/2000
   isnull(@ftotmxclp,0) --modificado antes @ftotmxclp 15/01/2000
  if @@error <> 0
  begin
                   set nocount off
     PRINT 'ERROR_PROC FALLA ACTUALIZANDO REGISTRO DE TASA DE MERCADO, ARCHIVO CONTABILIZA.'
     return 1
  end
            set nocount off
 end 
            set nocount off
end
return 0


GO
