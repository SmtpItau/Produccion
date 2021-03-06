USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAR_VALOR_DEFECTO]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GRABAR_VALOR_DEFECTO] (	@ID_PRODUCTO					SMALLINT,
												@ID_OPERACION					SMALLINT,	
												@ID_MONEDA1						SMALLINT,
												@ID_MONEDA2						SMALLINT,
												@ID_PLATAFORMA					SMALLINT,
												@ID_CLIENTE						INT,
												@MODALIDAD						CHAR(1),
												@FORMAPAGO_MN					SMALLINT,
												@FORMAPAGO_MX					SMALLINT,
												@COD_CORRESPONSAL				NUMERIC(9),
												@COD_CORRESPONSAL_DESDE			NUMERIC(5),
												@COD_CORRESPONSAL_DONDE			NUMERIC(5),
												@COD_CORRESPONSAL_QUIEN			NUMERIC(5),
												@COD_COMERCIO					VARCHAR(6),	
												@COD_OMA						VARCHAR(5),	
												@COD_USUARIO					VARCHAR(15),
												@COD_AREA_RESPONSABLE			VARCHAR(06),	
												@COD_CART_NORMATIVA				VARCHAR(06),	
												@COD_CART_SUB_NORMATIVA			VARCHAR(06),	
												@COD_LIBRO						VARCHAR(06),	
												@COD_CARTERA					NUMERIC(05),
												@COD_BROKER						NUMERIC(05),
												@TIPO_RETIRO					NUMERIC(05)
	
)
 AS
 BEGIN

   SET NOCOUNT ON        

   DECLARE @COD_CONCEPTO AS CHAR(3)
   
   SELECT @COD_CONCEPTO = concepto 
   FROM  Codigo_Comercio 
   WHERE codigo_relacion = @COD_COMERCIO

   set @COD_CONCEPTO = IsNull(@COD_CONCEPTO, '')
   
   IF NOT EXISTS(SELECT 1 FROM CargaOperaciones_DefectoValores 
                 WHERE idProducto = @ID_PRODUCTO 
                 AND idOperacion = @ID_OPERACION 
                 AND idMoneda1 = @ID_MONEDA1
				 AND idMoneda2 = @ID_MONEDA2
				 AND idPlataforma = @ID_PLATAFORMA
				 AND idCliente = @ID_CLIENTE)
   BEGIN
     INSERT INTO CargaOperaciones_DefectoValores
     VALUES(@ID_PRODUCTO,
			@ID_OPERACION,
			@ID_MONEDA1,
			@ID_MONEDA2,
			@ID_PLATAFORMA,
			@ID_CLIENTE,
			@MODALIDAD,
			@FORMAPAGO_MN,
			@FORMAPAGO_MX,
			@COD_CORRESPONSAL,
			@COD_CORRESPONSAL_DESDE,
			@COD_CORRESPONSAL_DONDE,
			@COD_CORRESPONSAL_QUIEN,
			0,
			0,
			0,
			@COD_COMERCIO,	
			@COD_OMA,	
			@COD_CONCEPTO,	
			@COD_USUARIO,
			@COD_AREA_RESPONSABLE,	
			@COD_CART_NORMATIVA,	
			@COD_CART_SUB_NORMATIVA,	
			@COD_LIBRO,	
			@COD_CARTERA,
			@COD_BROKER,
			@TIPO_RETIRO,
			'L') 
   END   

   UPDATE CargaOperaciones_DefectoValores
   SET
		Default_sModalidad = @MODALIDAD,
		Default_iFormaPagoMN = @FORMAPAGO_MN,
		Default_iFormaPagoMX = @FORMAPAGO_MX,
		Default_iCodCorresponsal = @COD_CORRESPONSAL,
		Default_iCodCorresponsal_Desde = @COD_CORRESPONSAL_DESDE,
		Default_iCodCorresponsal_Donde = @COD_CORRESPONSAL_DONDE,
		Default_iCodCorresponsal_Quien = @COD_CORRESPONSAL_QUIEN,
		Default_iPL_Corres_Desde = 0,
		Default_iPL_Corres_Donde = 0,
		Default_iPL_Corres_Quien = 0,
		Default_sCodigoComercio = @COD_COMERCIO,	
		Default_sCodigoOMA = @COD_OMA,	
		Default_sCodigoConcepto = @COD_CONCEPTO,	
		Default_sCodigoUsuario = @COD_USUARIO,
		Default_sCodAreaResponable = @COD_AREA_RESPONSABLE,	
		Default_sCodCartNormativa = @COD_CART_NORMATIVA,	
		Default_sCodSubCartNormativa = @COD_CART_SUB_NORMATIVA,	
		Default_sCodigoLibro = @COD_LIBRO,	
		Default_iCodidogCartera	= @COD_CARTERA,
		Default_iCodigoBroker = @COD_BROKER,
		Default_iTipRetiro = @TIPO_RETIRO
  WHERE idProducto = @ID_PRODUCTO
  AND	idOperacion	= @ID_OPERACION
  AND	idMoneda1 =	@ID_MONEDA1
  AND	idMoneda2 = @ID_MONEDA2
  AND	idPlataforma = @ID_PLATAFORMA
  AND	idCliente = @ID_CLIENTE

   If @@Error <> 0
      SELECT '-1', 'ERROR AL INTENTAR GRABAR LOS DATOS'
   Else
     SELECT '0', 'LA GRABACION DE DATOS TERMINO EXITOSAMENTE'   
      SET NOCOUNT OFF  

 END
 
 
GO
