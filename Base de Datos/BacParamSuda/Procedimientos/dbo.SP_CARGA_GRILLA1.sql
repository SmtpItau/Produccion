USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_GRILLA1]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CARGA_GRILLA1] (
	  @iOpcion    INTEGER
	, @cModulo   CHAR(3) 	 = ''
	, @cProducto VARCHAR(5)  = ''
	, @iMoneda   INTEGER 	 = 0
	, @sInstrum  VARCHAR(20) = ''
)

AS
BEGIN

	SET NOCOUNT ON
	IF @iOpcion = 1
			SELECT id_sistema, nombre_sistema  FROM BacParamSuda.dbo.SISTEMA_CNT WHERE operativo = 'S' AND gestion = 'N'
	IF @iOpcion = 2
	BEGIN
			IF @cModulo='PCS'
			BEGIN
				SELECT codigo_producto, CASE codigo_producto WHEN 'CI' THEN 'PACTOS' ELSE descripcion END
				FROM bacParamSuda.dbo.PRODUCTO 
				WHERE (id_sistema = @cModulo OR @cModulo='') AND Estado = 1 
				AND id_sistema = @cModulo
			END
			ELSE
			IF @cModulo='BFW'
			BEGIN
				SELECT * FROM bacParamSuda.dbo.PRODUCTO 
				WHERE id_sistema = @cModulo
				AND Estado = 1
			END
			ELSE
			BEGIN
				SELECT codigo_producto, descripcion
				FROM bacParamSuda.dbo.PRODUCTO 
				WHERE (id_sistema = @cModulo OR @cModulo='') 
				AND Estado = 1
				ORDER BY descripcion 
			END
	END

	IF @iOpcion = 3
	BEGIN
			IF @cModulo = 'BTR'
				SELECT inglosa, incodigo FROM BacParamSuda.dbo.INSTRUMENTO
			IF @cModulo = 'BEX'
				SELECT Descrip_familia,Cod_familia FROM BacBonosExtSuda..text_fml_inm
	END
	
	IF @iOpcion = 4
	BEGIN
		SELECT mncodmon, mnglosa FROM BacParamSuda..MONEDA
		WHERE mncodmon IN (SELECT mpcodigo FROM BacPAramSuda..PRODUCTO_MONEDA
							WHERE mpsistema = @cModulo AND mpproducto = @cProducto)
	END
	IF @iOpcion = 5
	BEGIN
		IF  @cProducto = 'CI' 
		BEGIN
			SELECT CodigoCurva FROM bacparamsuda..curvas_producto
			WHERE (Modulo = @cModulo OR @cModulo = '') AND (moneda = @iMoneda OR @iMoneda = 0) 
			AND (Producto = 'CI'  OR Producto = 'VI' OR @cProducto = '') 
			AND (instrumento = @sInstrum OR @sInstrum = '')  
			ORDER BY Instrumento
		END
		ELSE
		BEGIN
			SELECT CodigoCurva FROM bacparamsuda..curvas_producto
			WHERE (Modulo = @cModulo OR @cModulo = '') AND (moneda = @iMoneda OR @iMoneda = 0) 
			AND (Producto = @cProducto OR @cProducto = '') 
			AND (instrumento = @sInstrum OR @sInstrum = '')  
			ORDER BY Instrumento
		END
	
	END

	SET NOCOUNT OFF
END
GO
