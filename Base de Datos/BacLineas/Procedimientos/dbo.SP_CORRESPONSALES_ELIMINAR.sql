USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CORRESPONSALES_ELIMINAR]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CORRESPONSALES_ELIMINAR](@rutcliente 	NUMERIC(9),
						@codigocliente 	NUMERIC(9))
               
AS 
BEGIN

	SET NOCOUNT ON

	IF EXISTS(SELECT rut_cliente FROM CORRESPONSAL WHERE rut_cliente=@rutcliente AND codigo_cliente = @codigocliente )  
		BEGIN
			DELETE CORRESPONSAL WHERE rut_cliente = @rutcliente AND codigo_cliente = @codigocliente  

			IF @@ERROR <> 0 
				BEGIN
					SELECT 'ERROR'
				END 
			ELSE
				BEGIN
					SELECT 'OK'
				END 
		END 
	ELSE 
		BEGIN
			SELECT 'NO EXISTE'
		END
 
   SET NOCOUNT OFF
  
END

GO
