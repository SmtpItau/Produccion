USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEAS_ENDEUDA_POR_TIPO_CLIENTE]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LINEAS_ENDEUDA_POR_TIPO_CLIENTE](
							@ID_Sistema	CHAR(03)	,
							@Rut_Cliente	NUMERIC	(09,0)	,
							@Codigo_Cliente	NUMERIC	(09,0)	,
							@Monto		NUMERIC	(19,4)	,
							@Tipo_Riesgo	CHAR	(1)	,
                                                        @Patrimonio_Efectivo FLOAT      )
AS
BEGIN

   SET TRANSACTION ISOLATION LEVEL READ COMMITTED
   SET DATEFORMAT dmy
   SET NOCOUNT ON

	DECLARE @Tipo_Cliente		NUMERIC(05)
	,	@Nombre_Banco		CHAR(70)
	,	@OcupadoConRiesgo	FLOAT
	,	@OcupadoSinRiesgo	FLOAT
	,	@PorcentajeConRiesgo	FLOAT
	,	@PorcentajeSinRiesgo	FLOAT

	IF @Codigo_Cliente = 0			-- Generalmente cuando se envia a Chequear un emisor
		SELECT 	@Codigo_Cliente = clcodigo
		FROM 	CLIENTE WITH (NOLOCK)
		WHERE	clrut	 = @Rut_Cliente


	SELECT @Tipo_Cliente = 0

	SELECT @Tipo_Cliente = cltipcli
	,      @Nombre_Banco = clnombre
		FROM CLIENTE WITH (NOLOCK)
		WHERE clrut    = @Rut_Cliente
		AND   clcodigo = @Codigo_Cliente

	SELECT @OcupadoConRiesgo = CASE WHEN @Tipo_Riesgo = 'C' THEN SUM(ConRiesgoOcupado) ELSE 0 END
	,      @OcupadoSinRiesgo = CASE WHEN @Tipo_Riesgo = 'S' THEN SUM(SinRiesgoOcupado) ELSE 0 END
		FROM LINEA_SISTEMA WITH (NOLOCK)
		WHERE Rut_Cliente = @Rut_Cliente
		AND   Codigo_Cliente = @Codigo_Cliente


	IF @Tipo_Cliente = 1 BEGIN
		SELECT @PorcentajeConRiesgo = CASE WHEN @Tipo_Riesgo = 'C' THEN (@Patrimonio_Efectivo * 0.30) ELSE 0 END
		SELECT @PorcentajeSinRiesgo = CASE WHEN @Tipo_Riesgo = 'S' THEN (@Patrimonio_Efectivo * 0.30) ELSE 0 END
	END 
	ELSE BEGIN
		SELECT @PorcentajeConRiesgo = CASE WHEN @Tipo_Riesgo = 'C' THEN (@Patrimonio_Efectivo * 0.05) ELSE 0 END
		SELECT @PorcentajeSinRiesgo = CASE WHEN @Tipo_Riesgo = 'S' THEN (@Patrimonio_Efectivo * 0.25) ELSE 0 END
	END

	IF @Tipo_Riesgo = 'C' BEGIN
		IF (@OcupadoConRiesgo + @Monto) > @PorcentajeConRiesgo
			INSERT #Temp1 VALUES  ('Monto excede del porcentaje con riesgo del patrimonio efectivo para ' + RTRIM(LTRIM(@Nombre_Banco)))
	END

	IF @Tipo_Riesgo = 'S' BEGIN
		IF (@OcupadoSinRiesgo + @Monto) > @PorcentajeSinRiesgo
			INSERT #Temp1 VALUES  ('Monto excede del porcentaje sin riesgo del patrimonio efectivo para ' + RTRIM(LTRIM(@Nombre_Banco)))
	END

END






GO
