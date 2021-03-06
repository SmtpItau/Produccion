USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEACREDITOGENERAL_LEE_LINEA_TRANS]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LINEACREDITOGENERAL_LEE_LINEA_TRANS]
		(	@rut_cliente 	NUMERIC(9)	,
			@Cod_cliente 	NUMERIC(9)	,
			@id_sistema 	CHAR(3)    =''
		)
AS 
BEGIN

	SET NOCOUNT ON

	IF @id_sistema ='' 
		BEGIN
			SELECT DISTINCT rut_cliente
			  FROM LINEA_TRANSACCION
			 WHERE rut_cliente    = @rut_cliente
                           AND codigo_cliente = @Cod_cliente
			RETURN 0
		END

	SELECT DISTINCT rut_cliente
	      ,         id_sistema
	  FROM LINEA_TRANSACCION
	 WHERE rut_cliente    = @rut_cliente
           AND codigo_cliente = @Cod_cliente
           AND id_sistema     = @id_sistema			

     SET NOCOUNT OFF

END
GO
