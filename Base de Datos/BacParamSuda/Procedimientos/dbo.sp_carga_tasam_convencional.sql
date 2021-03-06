USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[sp_carga_tasam_convencional]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_carga_tasam_convencional]
			(
			@Cod_Moneda_bkb		CHAR(06)		,
			@DiasDesde			INT             ,
			@DiasHasta			INT             ,
			@MontoMinimo		FLOAT           ,
			@MontoMaximo		FLOAT           ,
			@Tasa           FLOAT
			)
AS 
BEGIN
SET NOCOUNT ON
	DECLARE @Codigo_Moneda NUMERIC(03)

	SELECT @Codigo_Moneda = ISNULL(mncodmon, 0) FROM moneda WHERE mncodbkb = @Cod_Moneda_bkb

		INSERT INTO tasas_maximas_convencional
		SELECT	@Codigo_Moneda		,
			@DiasDesde		,
			@DiasHasta		,
			@MontoMinimo		,
			@MontoMaximo		,
			@Tasa

SET NOCOUNT OFF
END
GO
