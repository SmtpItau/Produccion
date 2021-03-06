USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_RELACIONES]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ACT_RELACIONES]	(	@Opcion			INT
					,	@Id_Codigo1		CHAR(10)
					,	@Id_Codigo2		CHAR(10)
					,	@Id_Relacion1		CHAR(10)
					,	@Id_Relacion2		CHAR(10) = ''
					)
AS
BEGIN

	IF @Opcion = 1 BEGIN --BORRAR
	
		DELETE	TBL_RELACIONES
		WHERE	Rel_IdCodigo1	= @Id_Codigo1
		AND	Rel_IdCodigo2	= @Id_Codigo2
	END
	
	IF @Opcion = 2 BEGIN --INSERTAR
		INSERT INTO TBL_RELACIONES
			(	Rel_IdCodigo1
			,	Rel_IdCodigo2	
			,	Rel_IdRelacion1	
			,	Rel_IdRelacion2	
			)
		VALUES	(	@Id_Codigo1
			,	@Id_Codigo2
			,	@Id_Relacion1
			,	@Id_Relacion2
			)
	END
END
GO
