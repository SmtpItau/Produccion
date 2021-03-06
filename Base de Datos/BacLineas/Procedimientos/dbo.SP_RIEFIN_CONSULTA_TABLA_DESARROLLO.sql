USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_RIEFIN_CONSULTA_TABLA_DESARROLLO]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_RIEFIN_CONSULTA_TABLA_DESARROLLO] (@Nemo CHAR(31))
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	

    SELECT
		[Vencimiento] = tdfecven
	,	[Flujo] = tdflujo
	,	[Amortizacion] = tdamort
	,	[Interes] = tdinteres
	FROM
		BacParamSuda.dbo.TABLA_DESARROLLO
	WHERE
		tdmascara = @Nemo
	
	UNION
	
	SELECT
		[Vencimiento] = fecha_vcto_cupon
	,	[Flujo] = flujo
	,	[Amortizacion] = amortizacion
	,	[Interes] = interes
	FROM
		BacBonosExtSuda.dbo.TExt_dsa
	WHERE
		cod_nemo = @Nemo
	
	ORDER BY
		[Vencimiento]
	
END
GO
