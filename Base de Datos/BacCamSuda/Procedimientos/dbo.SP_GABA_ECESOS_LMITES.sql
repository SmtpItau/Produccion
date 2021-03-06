USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GABA_ECESOS_LMITES]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GABA_ECESOS_LMITES]
       (@CSISTEMA  CHAR(03)  ,
 @CTIPOOPERACION  CHAR(05)  ,
 @NOPERACION  NUMERIC(10)  ,
 @CTIPOLIMITES  CHAR(06)  ,
 @NCORRELATIVO  NUMERIC(06)  ,
 @NCODIGOEXCESO  NUMERIC(05)  ,
 @FMONTOEXCESO  FLOAT   ,
 @CPARAMETRO  CHAR(1)   ,
 @IPLAZO_LIMITE  INTEGER=0  ,
 @NRUTCLIENTE  NUMERIC(10)=0  ,
 @ICODIGOCLIENTE  INTEGER=0  ,
 @FMONTOOCUPADO  FLOAT=0   )
AS
BEGIN
set nocount on
IF @CPARAMETRO = 'G' 
 INSERT INTO MD_EXCESO_LIMITES
            (
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
                monto_ocupado           
            )
 VALUES
            ( 
                @CSISTEMA  ,
  @CTIPOOPERACION  ,
  @NOPERACION  ,
  @CTIPOLIMITES  ,
  @NCORRELATIVO  ,
  @NCODIGOEXCESO  ,
  @FMONTOEXCESO  ,
  @IPLAZO_LIMITE  ,
  @NRUTCLIENTE  ,
  @ICODIGOCLIENTE  ,
  ''   ,
                @FMONTOOCUPADO          
            )
IF @CPARAMETRO = 'B'
   UPDATE MD_EXCESO_LIMITES SET Estado = 'A'  
  WHERE id_sistema = @CSISTEMA AND
   Tipo_Operacion = @CTIPOOPERACION AND
   Operacion = @NOPERACION
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
