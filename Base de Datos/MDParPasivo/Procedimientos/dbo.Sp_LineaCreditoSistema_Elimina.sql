USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_LineaCreditoSistema_Elimina]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_LineaCreditoSistema_Elimina]
		(
		@rut_cliente	NUMERIC	(09)	,
		@codigo_cliente	NUMERIC	(09)	,
		@sw		CHAR	(03)=' '
		)
AS BEGIN 

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	SET NOCOUNT ON
	SET DATEFORMAT dmy

	IF @sw = '1' BEGIN
		SELECT DISTINCT
			A.Rut_Cliente		,
			A.Codigo_Cliente	,
			A.codigo_grupo		,
			A.FechaAsignacion	,
			A.FechaVencimiento	,
			A.FechaFinContrato	,
			A.RealizaTraspaso	,
			A.Bloqueado		,
			A.Compartido		,
			A.ControlaPlazo		,
			A.TotalAsignado		,
			A.TotalOcupado		,
			A.TotalDisponible	,
			A.TotalExceso		,
			A.TotalTraspaso		,
			A.TotalRecibido		,
			A.SinRiesgoAsignado	,
			A.SinRiesgoOcupado	,
			A.SinRiesgoDisponible	,
			A.SinRiesgoExceso	,
			A.ConRiesgoAsignado	,
			A.ConRiesgoOcupado	,
			A.ConRiesgoDisponible	,
			A.ConRiesgoExceso
		INTO #TEMP
		FROM LINEA_SISTEMA	AS A WITH (NOLOCK)
		INNER JOIN LINEA_TRANSACCION AS B ON
			A.rut_cliente = @rut_cliente AND
	                A.rut_cliente = B.rut_cliente AND
	                A.codigo_grupo <> B.codigo_grupo

		IF EXISTS(SELECT 1 FROM #TEMP)BEGIN
			DELETE A FROM LINEA_SISTEMA A WITH (NOLOCK), #TEMP B
			WHERE	A.rut_cliente    = @rut_cliente AND
				A.codigo_cliente = @codigo_cliente AND
				B.codigo_grupo = A.codigo_grupo
		END

		DROP TABLE #TEMP
	        RETURN 0
         END

	DELETE LINEA_SISTEMA
	WHERE	rut_cliente    = @rut_cliente	AND
		codigo_cliente = @codigo_cliente
			       

END



GO
