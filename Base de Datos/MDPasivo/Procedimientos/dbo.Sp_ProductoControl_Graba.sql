USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_ProductoControl_Graba]    Script Date: 16-05-2022 11:18:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_ProductoControl_Graba]
		(
		@codigo_control	 CHAR(05)	,
		@estado		 CHAR(01)	,
		@codigo_grupo	 CHAR(10)	,
		@id_sistema	 CHAR(03) = ' '	,
		@codigo_producto CHAR(05) = ' '
		)
AS  BEGIN
SET NOCOUNT ON
SET DATEFORMAT dmy

	IF EXISTS (SELECT 1 FROM PRODUCTO_CONTROL WHERE	codigo_grupo	= @codigo_grupo		AND
							codigo_control	= @codigo_control	AND
							id_sistema	= @id_sistema		AND
							codigo_producto	= @codigo_producto)BEGIN
		UPDATE PRODUCTO_CONTROL SET estado = @estado
		WHERE	codigo_grupo	= @codigo_grupo		AND
			codigo_control	= @codigo_control	AND
			id_sistema	= @id_sistema		AND
			codigo_producto	= @codigo_producto
	END ELSE BEGIN
		INSERT INTO PRODUCTO_CONTROL 
			(
			codigo_grupo	,
			codigo_control	,
			estado		,
			id_sistema	,
			codigo_producto
			)
		VALUES
			(
			@codigo_grupo	,
			@codigo_control	,
			@estado		,
			@id_sistema	,
			@codigo_producto
			)
	END

SET NOCOUNT OFF
END

-- select * from SP_HELP PRODUCTO_CONTROL 



GO
