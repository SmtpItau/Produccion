USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELI_MATRIZ_ATRIBUCION]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_ELI_MATRIZ_ATRIBUCION]
		(
		@tipo_usuario		CHAR	(15),
		@Id_Sistema		CHAR	(03),
		@Codigo_Producto	CHAR	(05),
		@InCodigo		NUMERIC	(05),
		@Moneda			NUMERIC	(03)=0
		)
AS BEGIN 
SET NOCOUNT ON
SET DATEFORMAT dmy
		DELETE MATRIZ_ATRIBUCION
			WHERE	tipo_usuario	= @tipo_usuario		AND
				Id_Sistema	= @Id_Sistema		AND
				Codigo_Producto = @Codigo_Producto	AND
				InCodigo	= @InCodigo		AND
				Moneda		= @Moneda
SET NOCOUNT OFF
END



GO
