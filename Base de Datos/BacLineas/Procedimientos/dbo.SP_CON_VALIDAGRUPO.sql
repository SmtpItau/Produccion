USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_VALIDAGRUPO]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CON_VALIDAGRUPO]
          ( 
                @grupo CHAR(5)	
           )
AS
BEGIN
	DECLARE @existe	CHAR(1)

	SET NOCOUNT ON
	
	SELECT 	@existe	= 'S'
	FROM	producto_sistema
	WHERE	Codigo_Producto = @grupo

	SELECT @existe	= ISNULL(@existe,'N')

	SELECT @existe	
	SET NOCOUNT OFF

END
GO
