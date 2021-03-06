USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAR_VALOR_DEFECTO_CARGA_EXT_SPOT]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GRABAR_VALOR_DEFECTO_CARGA_EXT_SPOT] (	@ORIGEN				VARCHAR(10),
                                                         			@CODMON				NUMERIC(5),
																	@TIPOCV				VARCHAR(1),
																	@CORRES_AQUIEN		NUMERIC(5),                                
																	@CORRES_DESDE		NUMERIC(5),
																	@CORRES_DONDE		NUMERIC(5),
																	@FORMA_PAGOMN		NUMERIC(5),
																	@FORMA_PAGOMX		NUMERIC(5),
																	@CODIGO_OMA			NUMERIC(5),
																	@CODIGO_COMERCIO	VARCHAR(6),
																	@OPERADOR			VARCHAR(15)='',
																	@CLIENTE			INT=0 )
AS
BEGIN   
   SET NOCOUNT ON        

   DECLARE @CODIGO_CONCEPTO AS VARCHAR(3)
   IF NOT EXISTS(	SELECT  1 FROM CargaOperaciones_DefectoValores 
					WHERE idPlataforma = @ORIGEN 
					AND idMoneda1 = @CODMON 
					AND idOperacion = @TIPOCV
					AND idCliente = @CLIENTE)
   BEGIN
     INSERT INTO CargaOperaciones_DefectoValores (	idPlataforma,
													idMoneda1,
													idOperacion,
													idMoneda2,
													idCliente,
													Default_iCodCorresponsal,
													Default_iCodCorresponsal_Desde,
													Default_iCodCorresponsal_Donde,
													Default_iCodCorresponsal_Quien,
													Default_iPL_Corres_Desde,
													Default_iPL_Corres_Donde,
													Default_iPL_Corres_Quien,
													Default_iFormaPagoMN,
													Default_iFormaPagoMX,
													Default_sCodigoOMA,
													Default_sCodigoComercio,
													Default_sCodigoConcepto,
													Default_sCodigoUsuario
												)
          
     VALUES (@ORIGEN,@CODMON,@TIPOCV,13,@CLIENTE,0,0,0,0,0,0,0,0,0,0,'','','') 
   END   

   SELECT @CODIGO_CONCEPTO = concepto 
   FROM  Codigo_Comercio 
   WHERE codigo_relacion = @CODIGO_COMERCIO

   set @CODIGO_CONCEPTO = IsNull(@CODIGO_CONCEPTO, '')

   UPDATE CargaOperaciones_DefectoValores
   SET idMoneda2 = 13
      ,Default_iCodCorresponsal = 0
      ,Default_iCodCorresponsal_Desde = @CORRES_DESDE
      ,Default_iCodCorresponsal_Donde = @CORRES_DONDE
      ,Default_iCodCorresponsal_Quien = @CORRES_AQUIEN
      ,Default_iPL_Corres_Desde = 0
      ,Default_iPL_Corres_Donde = 0
      ,Default_iPL_Corres_Quien = 0
      ,Default_iFormaPagoMN = @FORMA_PAGOMN
      ,Default_iFormaPagoMX = @FORMA_PAGOMX
      ,Default_sCodigoOMA = @CODIGO_OMA
      ,Default_sCodigoComercio = @CODIGO_COMERCIO
      ,Default_sCodigoConcepto = @CODIGO_CONCEPTO
      ,Default_sCodigoUsuario= @Operador
  WHERE idPlataforma  = @ORIGEN
    AND idMoneda1  = @CODMON
    AND idOperacion  = @TIPOCV
    AND idCliente = @CLIENTE

   If @@Error <> 0
      SELECT '-1', 'ERROR AL INTENTAR GRABAR LOS DATOS'
   Else
     SELECT '0', 'LA GRABACION DE DATOS TERMINO EXITOSAMENTE'   
      SET NOCOUNT OFF  
END
 
 
 
 
 
GO
