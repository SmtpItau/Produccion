USE [BacParamSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_Monto_Conversion_Moneda]    Script Date: 13-05-2022 10:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[FN_Monto_Conversion_Moneda]
(	@MontoInicial	NUMERIC
,	@MonedaOrigen	CHAR(8)
,	@MonedaDestino	CHAR(8)
,	@Fecha			DATETIME
)
RETURNS NUMERIC 
AS 
BEGIN

	IF	ISDATE(@Fecha) != 1 BEGIN
	     SET	 @Fecha = (SELECT acfecante FROM BacTraderSuda.dbo.VIEW_MFAC)
		 
	END

	DECLARE		@MontoFinal		NUMERIC(21,4)
	DECLARE		@MNRRDA			CHAR(01)
			,	@MNMX			CHAR(01)

	DECLARE		@Tipo_Cambio	DECIMAL
	SET			@Tipo_Cambio = (SELECT Tipo_Cambio FROM BacParamSuda.dbo.VALOR_MONEDA_CONTABLE vmc
		  						WHERE vmc.Codigo_Moneda = 994 AND vmc.Fecha = @Fecha)--(SELECT acfecante FROM BacTraderSuda.dbo.VIEW_MFAC))

	DECLARE		@COD_MONEDA		INT
	SET			@COD_MONEDA	 = (SELECT mncodmon FROM BacParamSuda.dbo.MONEDA WHERE mnnemo = @MonedaDestino)

	SELECT		@MNRRDA			= mnrrda 
    FROM		moneda
	WHERE		mncodmon		= @COD_MONEDA--@MonedaOrigen  -- CAMBIAR POR @COD_MONEDA
	AND			mnmx			= 'C'

	IF			@@ROWCOUNT		= 0 BEGIN
	SET			@MontoFinal	= 0
	END

	ELSE IF		@MNRRDA			= 'D' BEGIN
	SET			@MontoFinal		= @MontoInicial / @Tipo_Cambio
	END
	
	ELSE IF		@MNRRDA			= 'M' BEGIN
	SET			@MontoFinal		= @MontoInicial * @Tipo_Cambio
	END
	
	RETURN @MontoFinal;
END;
GO
