USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_LEER_ORIGEN_PRODUCTO_MONEDA]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SADP_LEER_ORIGEN_PRODUCTO_MONEDA]
	(	@iTag		INT		
	,	@cFiltro	VARCHAR(15)	= ''
	,	@bModExt	INT			= -1
	)
AS
BEGIN

	SET NOCOUNT ON

	IF @iTag = 1
	BEGIN
		SELECT Modulo = nombre_sistema + SPACE(100) + Id_sistema, 'BAC' 
		 FROM BacParamSuda.dbo.SISTEMA_CNT WHERE operativo = 'S' AND gestion = 'N' 

		UNION

		SELECT Modulo = Descripcion + SPACE(100) + Nemo, 'OTRO'
		  FROM SADP_MODULOS_EXTERNOS
	END

	IF @iTag = 2
	BEGIN
		SELECT  DISTINCT Descripcion = descripcion + SPACE(100) + codigo_producto
		FROM	BacParamSuda.dbo.PRODUCTO
		WHERE   id_sistema = @cFiltro and Estado = 1

		UNION
		
		SELECT  DISTINCT Descripcion = Producto + SPACE(100) + codigo
		FROM	dbo.SADP_PRODUCTO_MODULOEXTERNO
		WHERE   modulo = @cFiltro
		
	END				  

	IF @iTag = 3
	BEGIN

		SELECT mnglosa + SPACE(100) + LTRIM(RTRIM( mncodmon )) --> mnnemo --> CONVERT(CHAR(5), mncodmon )
		  FROM BacParamSuda.dbo.MONEDA with(nolock) 
		 WHERE ( mntipmon = 2 OR mncodmon IN(994, 997, 998, 999) )
		   AND   mncodmon IN(999, 13)
	  ORDER BY mnglosa
	END
	
	IF @iTag = 4
	BEGIN
	   SELECT fpa.glosa + SPACE(100) + LTRIM(RTRIM( fpa.codigo )) FROM BacParamSuda.dbo.MONEDA_FORMA_DE_PAGO	 mpa
									     INNER JOIN BacParamSuda.dbo.FORMA_DE_PAGO fpa ON fpa.codigo   = mpa.mfcodfor
									     INNER JOIN BacParamSuda.dbo.MONEDA		 mon ON mon.mncodmon = mpa.mfcodmon
								   WHERE mon.mncodmon = CONVERT(NUMERIC(5), @cFiltro) -->  mon.mnnemo	= @cFiltro
	END

	IF @iTag = 5
	BEGIN 
		SELECT cDescripcion + SPACE(100) + nCodExterno 
		  FROM BacParamSuda.dbo.SADP_RELACION_FPAGO
		 WHERE (cOrigen = @cFiltro OR @cFiltro = '')
	END

	IF @iTag = 6
	BEGIN
		IF @bModExt = -1
			SELECT	fpa.glosa + SPACE(100) + LTRIM(RTRIM( fpa.codigo ))
			FROM	BacParamSuda.dbo.FPAGO_CANAL				 cfp
					INNER JOIN BacParamSuda.dbo.FORMA_DE_PAGO fpa ON fpa.codigo = cfp.Codigo_FormaPago
			ORDER BY fpa.glosa
		ELSE
			SELECT	fpa.glosa + SPACE(100) + LTRIM(RTRIM( fpa.codigo ))
			FROM	BacParamSuda.dbo.FPAGO_CANAL				 cfp
					INNER JOIN BacParamSuda.dbo.FORMA_DE_PAGO fpa ON fpa.codigo = cfp.Codigo_FormaPago
			WHERE	fpa.codigo	IN(5, 103, 105, 128, 129, 130)
			ORDER BY fpa.glosa
	END

	IF @iTag = 7
	BEGIN
		SELECT fpa.glosa + SPACE(100) + LTRIM(RTRIM( fpa.codigo ))
		  FROM BacParamSuda.dbo.FORMA_DE_PAGO fpa 
		 WHERE fpa.codigo	IN(5, 103, 105, 134, 129, 130,222,128)
	 	 ORDER 
	 	    BY fpa.glosa
	END

END
GO
