USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_EXCESOS_LIMITES]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GRABA_EXCESOS_LIMITES]( @cSistema  CHAR(03)  ,
      @cTipoOperacion  CHAR(05)  ,
      @nOperacion	NUMERIC(10)  ,
      @cTipoLimites  CHAR(06)  ,
      @nCorrelativo  NUMERIC(06)  ,
      @nCodigoExceso  NUMERIC(05)  ,
      @fMontoExceso  FLOAT   ,
      @cParametro  CHAR(1)   ,
      @iplazo_limite  INTEGER=0  ,
      @nrutcliente  NUMERIC(10)=0  ,
      @icodigocliente  INTEGER=0  ,
      @fMontoOcupado  FLOAT=0   )
AS
BEGIN
set nocount on
IF @cParametro = 'G' 
 INSERT INTO 
 md_exceso_limites(
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
 
VALUES( @cSistema  ,
  @cTipoOperacion  ,
  @nOperacion  ,
  @cTipoLimites  ,
  @nCorrelativo  ,
  @nCodigoExceso  ,
  @fMontoExceso  ,
  @iplazo_limite  ,
  @nrutcliente  ,
  @icodigocliente  ,
  ''   ,
                @fMontoOcupado          
)
IF @cParametro = 'B'
   UPDATE md_exceso_limites SET Estado = 'A'  
  WHERE id_sistema = @cSistema AND
   Tipo_Operacion = @cTipoOperacion AND
   Operacion = @nOperacion
IF @@ERROR <> 0 
BEGIN
   SELECT -1
 set nocount off
   RETURN
END
SELECT 0
set nocount off
END
GO
