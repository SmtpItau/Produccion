USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAR_VALOR_DEFECTO_CARGA_EXT_FORWARD]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GRABAR_VALOR_DEFECTO_CARGA_EXT_FORWARD] (	@ORIGEN				VARCHAR(10),
																		@CODMON				NUMERIC(5),
																		@TIPOCV				VARCHAR(1), 
																		@FORMA_PAGOMN		NUMERIC(5),
																		@FORMA_PAGOMX		NUMERIC(5),   
																		@CODAREARESPONABLE	VARCHAR(6),
																		@CODCARTNORM		VARCHAR(6),
																		@CODSUBCARTNORM		VARCHAR(6),
																		@CODLIBRO			VARCHAR(6),
																		@CODCART			NUMERIC(9),
																		@NBROKER			NUMERIC(5),
																		@TIPRETIRO			NUMERIC(5),
																		@OPERADOR			CHAR(15)='',
																		@CLIENTE			INT=0 )

AS
BEGIN   
   SET NOCOUNT ON        

   DECLARE @CODIGO_CONCEPTO AS VARCHAR(3)
   IF NOT EXISTS(	SELECT  1 FROM CargaOperaciones_DefectoValores 
					WHERE idPlataforma = @ORIGEN 
					AND idMoneda1 = @CODMON 
					AND idOperacion = @TIPOCV
					and idCliente = @CLIENTE)
   BEGIN
     INSERT 
     INTO CargaOperaciones_DefectoValores (	idPlataforma,
											idMoneda1,
											idOperacion,
											idMoneda2,
											idCliente,											
											Default_iFormaPagoMN,
											Default_iFormaPagoMX,
											Default_sCodAreaResponable,
											Default_sCodCartNormativa,
											Default_sCodSubCartNormativa,
											Default_sCodigoLibro,
											Default_iCodidogCartera,
											Default_iCodigoBroker,
											Default_iTipRetiro,
											Default_sCodigoUsuario     	
											)
     
     VALUES(@ORIGEN,@CODMON,@TIPOCV,13,@CLIENTE,0,0,'','','','',0,0,0,'')
   END   



   UPDATE CargaOperaciones_DefectoValores
   SET idMoneda2 = 13
       ,Default_iFormaPagoMN = @FORMA_PAGOMN
       ,Default_iFormaPagoMX = @FORMA_PAGOMX 
       ,Default_sCodAreaResponable = @CODAREARESPONABLE
       ,Default_sCodCartNormativa = @CODCARTNORM
       ,Default_sCodSubCartNormativa = @CODSUBCARTNORM
       ,Default_sCodigoLibro = @CODLIBRO
       ,Default_iCodidogCartera = @CODCART
       ,Default_iCodigoBroker = @NBROKER
       ,Default_iTipRetiro = @TIPRETIRO
       ,Default_sCodigoUsuario = @Operador
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
