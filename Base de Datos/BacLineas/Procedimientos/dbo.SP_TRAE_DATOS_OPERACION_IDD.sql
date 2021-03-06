USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAE_DATOS_OPERACION_IDD]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_TRAE_DATOS_OPERACION_IDD]
				(@cmodulo			CHAR(3)
				,@cproducto			VARCHAR(10)
				,@nOperacion		NUMERIC(9)
				,@nDocumento		NUMERIC(9) 
				,@iCorrelativo		NUMERIC(4)
				)
AS

BEGIN		

		IF @cmodulo = 'BEX'
		BEGIN
			SELECT @cproducto = CASE WHEN @cproducto = 'CP' THEN 'CPX' 
										WHEN @cproducto = 'VP' THEN 'VPX' 
								ELSE @cproducto 
								END
		END


	SELECT 'cliente'		= cli.Codigo_AS400
		,'codigo_cliente'	= 0 --cli.Clcodigo --> 20180125 a solicitud de Bernardo
		,'codgo_facility'	= fac.codigo_facility
		,'plazo_operacion'	= nPlazo
		,'monto_linea'		= nMontoOperacion
		,'moneda_operacion'	= idd.nMoneda
		,'cod_mon_as400'	= 'CHEZ'--mo.mncodbkb
		,'numero_idd'		= idd.nNumeroIdd
	FROM Transacciones_IDD idd
	INNER JOIN BacParamSuda..cliente cli ON
		cli.clrut = idd.iRut
		AND cli.Clcodigo = idd.iCodigo
	INNER JOIN BacParamSuda..productos_mesa_facility fac ON   
		idd.cModulo  = fac.id_sistema  
		AND cProducto = CASE WHEN id_sistema = 'PCS' THEN fac.Codigo_ProductoOtro ELSE fac.Codigo_Producto  END
		AND idd.nIncodigo = fac.Codigo_Instrumento  
	INNER JOIN  bacparamsuda..producto                pro  ON
		pro.Codigo_Producto  = fac.Codigo_Producto
	INNER JOIN bacparamsuda..moneda                mo  ON
		idd.nMoneda = mo.mncodmon
      		
	WHERE cModulo			= @cmodulo
		AND cProducto		= @cproducto
		AND nOperacion		= @nOperacion
		AND (nDocumento		= @nDocumento OR @nDocumento = @nOperacion) -- OR es cuando operacion graba como nDocumento el id de pantalla
		AND iCorrelativo	= @iCorrelativo
		
END
--> +++ cvegasan 2017.08.08 Control Lineas IDD
GO
