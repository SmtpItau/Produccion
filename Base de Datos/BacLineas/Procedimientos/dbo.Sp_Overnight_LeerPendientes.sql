USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Overnight_LeerPendientes]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE PROCEDURE [dbo].[Sp_Overnight_LeerPendientes](
						@sistema	CHAR(3)
					)
AS
BEGIN

	SET NOCOUNT ON

	SELECT  sistema				,
		nombre_sistema			,
		Usuario				,
		Monto_Operacion			,
		ISNULL(acmaxovernight,0)	,
		ISNULL(acminovernight,0)
	FROM	aprobacion_hedge	,
		sistema_cnt		,
		view_meac	
	WHERE	( sistema = @sistema 	OR
		@sistema = " " )	AND
		Aprobado = 0		AND
		sistema = sistema_cnt.id_sistema	AND
		mercado = "SPOT"

	SET NOCOUNT OFF

END


-- Sp_Hedge_LeerPendientes ''
-- select * from aprobacion_hedge





GO
