USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_LineaCreditoLinea_Busca]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_LineaCreditoLinea_Busca]
		(
		@RUTCLIENTE	NUMERIC(09)	,
		@CODCLIENTE	NUMERIC(09)	,
		@codigo_grupo	CHAR(10) = ''
		)
AS BEGIN
SET NOCOUNT ON
SET DATEFORMAT dmy
	SELECT 	rut_cliente	,
		codigo_cliente	,
		codigo_grupo	,
		plazodesde	,
		plazohasta	,
		porcentaje	,
		totalasignado	,
		totalocupado	,
	        totaldisponible	,
		totalexceso	,
	        totaltraspaso	,
	        totalrecibido   ,
                SinRiesgoAsignado,
                SinRiesgoOcupado,
                SinRiesgoDisponible,
                SinRiesgoExceso, 
                ConRiesgoAsignado,
                ConRiesgoOcupado,
                ConRiesgoDisponible,
                ConRiesgoExceso
	FROM LINEA_POR_PLAZO
	WHERE	rut_cliente	= @rutcliente	AND
		codigo_cliente	= @codcliente	AND
		(codigo_grupo	= @codigo_grupo OR @codigo_grupo = '')


	SET NOCOUNT OFF
END





GO
