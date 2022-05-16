USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_PRODUCTOS]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEER_PRODUCTOS]( @Sistema CHAR(03) ) 
AS
BEGIN
	SELECT   codigo_producto
		,descripcion
		,id_sistema	
		,estado
	FROM	producto
	WHERE	id_sistema = @Sistema
END

-- SP_AUTORIZA_EJECUTAR 'bacuser'
GO
