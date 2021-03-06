USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ENTREGA_DOLAR_CONTABLE_DIARIO]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_ENTREGA_DOLAR_CONTABLE_DIARIO]
(   @dFecha         DATETIME
,   @iValor         NUMERIC(21,4) OUTPUT
,   @iValorAnt         NUMERIC(21,4) OUTPUT
)
AS
BEGIN
	SELECT @iValor = CONVERT(NUMERIC(21,4),Mon.Tipo_Cambio),
             @iValorAnt = (Select CONVERT(NUMERIC(21,4),Tipo_Cambio)
			FROM  BACPARAMSUDA..VALOR_MONEDA_CONTABLE  
			Where Fecha  		= Fec.acfecante
			AND   Codigo_Moneda 	= 994)

	FROM  BACPARAMSUDA..VALOR_MONEDA_CONTABLE Mon,
	      TEXT_ARC_CTL_DRI Fec	
	WHERE Mon.Fecha = @dFecha
	And Mon.Fecha = Fec.acfecproc
	And Mon.Codigo_Moneda = 994
END

GO
