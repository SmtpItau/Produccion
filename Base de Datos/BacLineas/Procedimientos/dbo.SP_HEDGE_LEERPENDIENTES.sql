USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_HEDGE_LEERPENDIENTES]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_HEDGE_LEERPENDIENTES](
						@sistema	CHAR(3)
					)
AS
BEGIN

	SET NOCOUNT ON

	SELECT  sistema					,
		nombre_sistema				,
		descripcion				,
		Tipo_Operacion				,
		Monto_Operacion				,
		Usuario					,
		(achedgeactualfuturo+achedgeactualspot)	,
		acmaxintraday				,
		acminintraday
	FROM	aprobacion_hedge	,
		sistema_cnt		,
		producto		,
		view_meac	
	WHERE	( sistema = @sistema 	OR
		@sistema = ' ' )	AND
		Aprobado = 0		AND
		sistema = sistema_cnt.id_sistema	AND
		( mercado = codigo_producto AND
		sistema_cnt.id_sistema = producto.id_sistema )

	SET NOCOUNT OFF

END


-- Sp_Hedge_LeerPendientes ''
-- select * from view_meac
GO
