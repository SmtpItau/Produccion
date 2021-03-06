USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_RELACIONES]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- SP_CON_RELACIONES 2 , 'BTR' 
CREATE PROCEDURE [dbo].[SP_CON_RELACIONES]	(	@Opcion			INT
					,	@Id_Sistema		CHAR(10)
					,	@Id_Categoria		CHAR(10) = ''
					)
AS
BEGIN

	IF @Opcion = 1 BEGIN

		SELECT	TBGLOSA
		,	TBCODIGO1
		,	ISNULL(Rel_IdCodigo1,'')
		FROM	TABLA_GENERAL_DETALLE
			LEFT JOIN TBL_RELACIONES ON TBCODIGO1	= Rel_IdRelacion1 AND	TBCATEG	= Rel_IdCodigo2	
		WHERE	TBCATEG		= @Id_Categoria
		AND	Rel_IdCodigo1	= @Id_Sistema
		ORDER
		BY	TBGLOSA
	END
	
	IF @Opcion = 2 BEGIN
		SELECT	DISTINCT rcnombre
		,	rcrut
		,	ISNULL(Rel_IdCodigo1,'')
		FROM	TIPO_CARTERA
		     LEFT JOIN TBL_RELACIONES ON CONVERT(CHAR,rcrut) = Rel_IdRelacion1 AND rcsistema = Rel_IdCodigo1
		WHERE	rcsistema		= @Id_Sistema
		ORDER BY 	rcnombre

	END


END
GO
