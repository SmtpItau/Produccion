USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MARKTOMARKET]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MARKTOMARKET](  
					@Curva          CHAR(20)  	,
					@Plazo		INTEGER		,
					@Flujo		FLOAT		,
					@Fecha_Calculo  DATETIME	,
					@Valor_Mercado	FLOAT		OUTPUT , 
					@Tasa		FLOAT	        OUTPUT 
				)
AS
BEGIN

	SET NOCOUNT ON
	DECLARE @Tm NUMERIC(6,2)

	/* BUSCA TASA SWAP --------------------------------------------------------------- */
	SELECT @Tm = Tasa FROM TASAS_MTM WHERE Curva = @Curva AND Fecha = @Fecha_Calculo

	IF @Tm IS NULL
	   SELECT @Tasa = 0.0
	ELSE
	   SELECT @Tasa = @Tm

	SELECT @Valor_Mercado = @Flujo/POWER(1.0+(@Tasa/100.0), @Plazo/360.0 )

	SET NOCOUNT OFF
END 

--SELECT * FROM TASAS_MTM
GO
