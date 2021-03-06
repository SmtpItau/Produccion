USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_CARGA_USUARIOS]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SADP_CARGA_USUARIOS]
	(	@iTipo		SMALLINT
	,	@cValor		VARCHAR(20)	= ''	
	)
AS
BEGIN

	SET NOCOUNT ON

	IF @iTipo = 1
		SELECT Descripcion, Tipo_Usuario FROM BacParamSuda.dbo.GEN_TIPOS_USUARIO ORDER BY Descripcion
	
	IF @iTipo = 2
		SELECT Nombre, usuario FROM BacParamSuda.dbo.USUARIO ORDER BY Nombre 

	IF @iTipo = 3
		SELECT Indice		= Men.Indice
			,  Posicion		= (Men.Posicion - 1)
			,  Opcion		= Men.Opcion
			,  Descripcion	= Men.Descripcion
			,  Habilitado	= ISNULL( Tip.Habilitado, 0)
		FROM   BacParamSuda.dbo.SADP_MENU				   Men
			   LEFT JOIN BacParamSuda.dbo.SADP_PRIVILEGIOS Tip ON Tip.Tipo = 'T' AND Tip.Nombre = @cValor AND Tip.Opcion = Men.Opcion 
		WHERE  Men.Posicion	> 0 and Men.Descripcion <> 'Cerrar'

	IF @iTipo = 4
		SELECT Indice		= Men.Indice
			,  Posicion		= (Men.Posicion - 1)
			,  Opcion		= Men.Opcion
			,  Descripcion	= Men.Descripcion
			,  Habilitado	= ISNULL( Tip.Habilitado, 0)
		FROM   BacParamSuda.dbo.SADP_MENU				   Men
			   LEFT JOIN BacParamSuda.dbo.SADP_PRIVILEGIOS Tip ON Tip.Tipo = 'U' AND Tip.Nombre = @cValor AND Tip.Opcion = Men.Opcion
		WHERE  Men.Posicion	> 0 and Men.Descripcion <> 'Cerrar'

END
GO
