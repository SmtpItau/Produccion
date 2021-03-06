USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAR_PRODUCTOXSISTEMA]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_GRABAR_PRODUCTOXSISTEMA]( @Sistema	CHAR(03)
					    ,@Producto	CHAR(05)
					    ,@Estado	CHAR(01)
					   )
AS 
BEGIN
	UPDATE  producto 
	SET	estado = @Estado 
	WHERE	id_sistema      = @Sistema And 
		codigo_producto = @Producto
END

-- sp_autoriza_ejecutar 'bacuser'
GO
