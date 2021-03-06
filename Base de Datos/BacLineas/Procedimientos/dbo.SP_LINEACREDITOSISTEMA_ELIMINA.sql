USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEACREDITOSISTEMA_ELIMINA]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LINEACREDITOSISTEMA_ELIMINA]
	(	@rut_cliente 	NUMERIC(9)	,
		@codigo_cliente NUMERIC(9)	,
		@sw 		CHAR   (3)    =''
	)
AS
BEGIN 

	SET NOCOUNT ON
	IF @sw = '1'
	BEGIN

		SELECT DISTINCT
			a.* 
		INTO	#TEMP
		FROM	LINEA_SISTEMA     a,
			LINEA_TRANSACCION b
		WHERE	( a.rut_cliente  = @rut_cliente
		AND	a.codigo_cliente = @codigo_cliente )
		AND	( a.rut_cliente  = b.rut_cliente
		AND	a.codigo_cliente = b.codigo_cliente )
		AND	a.id_sistema     <> b.id_sistema


		IF EXISTS(SELECT 1 FROM #TEMP)	
		BEGIN

			
			DELETE	a
			FROM	LINEA_PRODUCTO_POR_PLAZO	a,
				#TEMP 				b
			WHERE	a.rut_cliente    = @rut_cliente
			AND	a.codigo_cliente = @codigo_cliente
			AND	b.id_sistema	 = a.id_sistema 
			AND	a.TotalOcupado	 = 0


			DELETE	a
			FROM	LINEA_SISTEMA a,
				#TEMP         b
			WHERE	a.rut_cliente    = @rut_cliente
			AND	a.codigo_cliente = @codigo_cliente
			AND	b.id_sistema	 = a.id_sistema 
			AND	a.TotalOcupado	 = 0
		END


		DROP TABLE #temp
	
	        RETURN 0

         END

	DELETE	LINEA_PRODUCTO_POR_PLAZO
	WHERE	rut_cliente    	= @rut_cliente
	AND	codigo_cliente 	= @codigo_cliente
	AND	TotalOcupado	= 0			       


	DELETE	LINEA_SISTEMA
	WHERE	rut_cliente    	= @rut_cliente
	AND	codigo_cliente 	= @codigo_cliente
	AND	TotalOcupado	= 0			       

	SET NOCOUNT OFF

END
GO
