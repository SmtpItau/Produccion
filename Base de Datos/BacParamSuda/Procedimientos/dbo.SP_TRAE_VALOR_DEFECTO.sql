USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAE_VALOR_DEFECTO]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_TRAE_VALOR_DEFECTO]( @SISTEMA    CHAR(3),
                                      			@COD_PROD   CHAR(10),
                                      			@COD_AREA   CHAR(10),
                                      			@CLIENTE	INT=0 )
AS
BEGIN

   DECLARE	@id_sistema					NUMERIC(1),
			@codigo_producto			SMALLINT,
			@codigo_area				SMALLINT,
			@compra_forma_pagomn		SMALLINT,
			@compra_forma_pagomx		SMALLINT,		
			@compra_codigo_oma			VARCHAR(5),
			@compra_codigo_comercio		VARCHAR(6),
			@compra_codigo_concepto		VARCHAR(3),
			@venta_forma_pagomn			SMALLINT,
			@venta_forma_pagomx			SMALLINT,
			@venta_codigo_oma			VARCHAR(5),
			@venta_codigo_comercio		VARCHAR(6),
			@venta_codigo_concepto		VARCHAR(4),
			@contabiliza				NUMERIC(1),
			@monto_operacion			NUMERIC(1),
			@codigo_moneda				SMALLINT,
			@Corres_Compra				NUMERIC(9),
			@Corres_Venta				NUMERIC(9)

	SET @id_sistema=0
	SET @contabiliza=0
	SET @monto_operacion=0
	
	IF NOT EXISTS(	SELECT 1 FROM BacParamSuda.dbo.CargaOperaciones_DefectoValores
					WHERE idProducto       = @COD_AREA
					AND idPlataforma      = @COD_PROD
					AND idCliente		  = @CLIENTE
					AND idOperacion=1   )
	BEGIN    
		   SELECT	@codigo_producto=idPlataforma,
					@codigo_area=idProducto,
					@compra_forma_pagomn=Default_iFormaPagoMN,
					@compra_forma_pagomx=Default_iFormaPagoMX,
					@compra_codigo_oma=Default_sCodigoOMA,
					@compra_codigo_comercio=Default_sCodigoComercio,
					@compra_codigo_concepto=Default_sCodigoConcepto,
					@codigo_moneda=idMoneda1,
					@Corres_Compra=Default_iCodCorresponsal
		   FROM CargaOperaciones_DefectoValores
		   WHERE idProducto       = @COD_AREA
			AND idPlataforma      = @COD_PROD
			AND idCliente		  = 0
			AND idOperacion=1    
    
	END

	ELSE
	BEGIN
		   SELECT	@codigo_producto=idPlataforma,
					@codigo_area=idProducto,
					@compra_forma_pagomn=Default_iFormaPagoMN,
					@compra_forma_pagomx=Default_iFormaPagoMX,
					@compra_codigo_oma=Default_sCodigoOMA,
					@compra_codigo_comercio=Default_sCodigoComercio,
					@compra_codigo_concepto=Default_sCodigoConcepto,
					@codigo_moneda=idMoneda1,
					@Corres_Compra=Default_iCodCorresponsal
		   FROM CargaOperaciones_DefectoValores
		   WHERE idProducto       = @COD_AREA
			AND idPlataforma      = @COD_PROD
			AND idCliente		  = @CLIENTE
			AND idOperacion=1  
	END

	IF NOT EXISTS(	SELECT 1 FROM BacParamSuda.dbo.CargaOperaciones_DefectoValores
					WHERE idProducto       = @COD_AREA
					AND idPlataforma      = @COD_PROD
					AND idCliente		  = @CLIENTE
					AND idOperacion=2   )
	BEGIN    
		   SELECT	@codigo_producto=idPlataforma,
					@codigo_area=idProducto,
					@venta_forma_pagomn=Default_iFormaPagoMN,
					@venta_forma_pagomx=Default_iFormaPagoMX,
					@venta_codigo_oma=Default_sCodigoOMA,
					@venta_codigo_comercio=Default_sCodigoComercio,
					@venta_codigo_concepto=Default_sCodigoConcepto,
					@codigo_moneda=idMoneda1,
					@Corres_Venta=Default_iCodCorresponsal
		   FROM CargaOperaciones_DefectoValores
		   WHERE idProducto       = @COD_AREA
			AND idPlataforma      = @COD_PROD
			AND idCliente		  = 0
			AND idOperacion=2
    
	END

	ELSE
	BEGIN
		   SELECT	@codigo_producto=idPlataforma,
					@codigo_area=idProducto,
					@venta_forma_pagomn=Default_iFormaPagoMN,
					@venta_forma_pagomx=Default_iFormaPagoMX,
					@venta_codigo_oma=Default_sCodigoOMA,
					@venta_codigo_comercio=Default_sCodigoComercio,
					@venta_codigo_concepto=Default_sCodigoConcepto,
					@codigo_moneda=idMoneda1,
					@Corres_Venta=Default_iCodCorresponsal
		   FROM CargaOperaciones_DefectoValores
		   WHERE idProducto       = @COD_AREA
			AND idPlataforma      = @COD_PROD
			AND idCliente		  = @CLIENTE
			AND idOperacion=2
	END

	SELECT  @id_sistema,
			@codigo_producto,
			@codigo_area,
			@compra_forma_pagomn,
			@compra_forma_pagomx,		
			@compra_codigo_oma,
			@compra_codigo_comercio,
			@compra_codigo_concepto,
			@venta_forma_pagomn,
			@venta_forma_pagomx,
			@venta_codigo_oma,
			@venta_codigo_comercio,
			@venta_codigo_concepto,
			@contabiliza,
			@monto_operacion,
			@codigo_moneda,
			@Corres_Compra,
			@Corres_Venta
	FROM DUAL

END
 
 
 
 
 
GO
