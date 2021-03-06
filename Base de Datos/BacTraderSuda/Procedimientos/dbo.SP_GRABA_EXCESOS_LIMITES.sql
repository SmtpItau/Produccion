USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_EXCESOS_LIMITES]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_GRABA_EXCESOS_LIMITES]
                                          ( @csistema  char(03)  ,
      @ctipooperacion  char(05)  ,
      @noperacion  numeric(10)  ,
      @ctipolimites  char(06)  ,
      @ncorrelativo  numeric(06)  ,
      @ncodigoexceso  numeric(05)  ,
      @fmontoexceso  float   ,
      @cparametro  char(1)   ,
      @iplazo_limite  integer=0  ,
      @nrutcliente  numeric(10)=0  ,
      @icodigocliente  integer=0  ,
      @fmontoocupado  float=0   )
as
begin
set nocount on
if @cparametro = 'G' 
 insert into MD_EXCESO_LIMITES(
  id_sistema  ,
  tipo_operacion  ,
  operacion  ,
  tipo_limites  ,
  correlativo  ,
  codigo_exceso  ,
  monto_exceso  ,
  plazo   ,
  rut_cliente  ,
  codigo_rut  ,
  estado   ,
                monto_ocupado           )
 values( @csistema  ,
  @ctipooperacion  ,
  @noperacion  ,
  @ctipolimites  ,
  @ncorrelativo  ,
  @ncodigoexceso  ,
  @fmontoexceso  ,
  @iplazo_limite  ,
  @nrutcliente  ,
  @icodigocliente  ,
  ''   ,
                @fmontoocupado          )
if @cparametro = 'B'
   update MD_EXCESO_LIMITES set estado = 'A'  
  where id_sistema = @csistema and
   tipo_operacion = @ctipooperacion and
   operacion = @noperacion
if @@error <> 0 
begin
   set nocount off
   select -1
   return
end
set nocount off
select 0
end   /* fin procedimiento */
/*
sp_help md_exceso_limites 
*/

GO
