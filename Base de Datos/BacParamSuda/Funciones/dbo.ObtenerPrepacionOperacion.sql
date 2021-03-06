USE [BacParamSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[ObtenerPrepacionOperacion]    Script Date: 13-05-2022 10:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[ObtenerPrepacionOperacion]
(
	 @numero_operacion numeric(7,0)
	,@id_sistema	char (3)
)
RETURNS NVARCHAR(40)
AS
BEGIN
	DECLARE @Name NVARCHAR(40)
	SET @Name = ''
	BEGIN 
		SET @Name = (
						SELECT 'AccionOP' = CASE WHEN COD_OPERACION = 'A' THEN 'ANULAR       '
												 WHEN COD_OPERACION = 'U' THEN 'UNWIND       '
												 WHEN COD_OPERACION = 'M' THEN 'MODIFICAR    '
												 WHEN COD_OPERACION = 'S' THEN 'SIN ACCION   '
												 WHEN COD_OPERACION = 'X' THEN 'MODIFICADA   '
												 END
							FROM TBL_PREPARA_OPERACIONES 
								WHERE NRO_OPERACION = @numero_operacion
								AND ID_SISTEMA = @id_sistema 
								AND ESTADO <> 'F'
					)
	END
	IF @Name = ''
	BEGIN 
		SET @Name ='SIN ACCION   '
	END
	RETURN @Name
END


GO
