USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Perfil_Contable_BuscaProd]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Perfil_Contable_BuscaProd]
			(
			@pareid_sistema	CHAR(03)
			)
AS BEGIN
SET DATEFORMAT dmy
SET NOCOUNT ON
	SELECT	codigo_producto,
		descripcion
	FROM	PRODUCTO
	WHERE	id_sistema	= @pareid_sistema
SET NOCOUNT OFF
END












GO
