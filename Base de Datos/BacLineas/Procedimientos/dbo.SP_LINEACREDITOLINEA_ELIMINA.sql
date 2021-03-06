USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEACREDITOLINEA_ELIMINA]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LINEACREDITOLINEA_ELIMINA]
	(	@rutcliente 	NUMERIC(9)	,
	 	@codcliente 	NUMERIC(9)	,
	 	@id_sistema 	CHAR(3)       =''
	)
AS
BEGIN


	SET NOCOUNT ON

	IF @id_sistema = ''
	BEGIN
		DELETE LINEA_PRODUCTO_POR_PLAZO
		 WHERE rut_cliente    = @rutcliente
                   AND codigo_cliente = @codcliente
                   AND TotalOcupado   = 0
	       	RETURN
	END

	IF EXISTS( SELECT DISTINCT rut_cliente
		   ,      id_sistema
		   ,      codigo_producto 
		     FROM LINEA_TRANSACCION
		    WHERE (rut_cliente   = @rutcliente
		      AND codigo_cliente = @codcliente )
		      AND id_sistema     = @id_sistema )
		BEGIN
			SELECT 'NO'
			RETURN
		END	
	
	DELETE LINEA_PRODUCTO_POR_PLAZO
	 WHERE (rut_cliente   = @rutcliente
           AND codigo_cliente = @codcliente)
           AND id_sistema     = @id_sistema
           AND TotalOcupado   = 0


	SET NOCOUNT OFF

END
GO
