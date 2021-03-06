USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_GRILLA]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CARGA_GRILLA] (
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
				AND (id_sistema ='PCS' AND codigo_producto IN ('SM','ST'))
			END
			ELSE
			IF @cModulo='BFW'
			BEGIN
				SELECT * FROM bacParamSuda.dbo.PRODUCTO 
				WHERE (id_sistema = @cModulo OR @cModulo='') 
				AND Estado = 1 AND codigo_producto IN (1,2,3,12)
			END
			ELSE
			BEGIN
				/*
				SELECT codigo_producto, CASE codigo_producto WHEN 'CI' THEN 'PACTOS' ELSE descripcion END
				FROM bacParamSuda.dbo.PRODUCTO 
				WHERE (id_sistema = @cModulo OR @cModulo='') 
				AND Estado = 1 AND codigo_producto NOT IN ('FLI','FLIP','RC','RCA','RV','RVA','WEEK')
				AND (codigo_producto <> 'VI') 
				*/

				SELECT codigo_producto, descripcion
				FROM bacParamSuda.dbo.PRODUCTO 
				WHERE (id_sistema = @cModulo OR @cModulo='') 
				AND Estado = 1 AND codigo_producto NOT IN ('FLI','FLIP','RC','RV','WEEK')
				ORDER BY descripcion 
			END


	END

	IF @iOpcion = 3
	BEGIN
			IF @cModulo = 'BTR' ---AND @cProducto = 'CP' OR @cProducto = 'VP'
				SELECT inglosa, incodigo FROM BacParamSuda.dbo.INSTRUMENTO WHERE incodigo IN(4,6,7,9,11,14,15,20,31,32,33,34,36,37,40,300,301,888)
			IF @cModulo = 'BEX'
				SELECT Descrip_familia,Cod_familia FROM BacBonosExtSuda..text_fml_inm
	END
---				SELECT inglosa, incodigo FROM BacParamSuda.dbo.INSTRUMENTO WHERE incodigo NOT IN(600, 601, 602, 603, 700, 701, 702, 703, 1, 2, 995, 996, 98)
	
	IF @iOpcion = 4
	BEGIN
			IF  (@cModulo = 'BTR' AND @cProducto IN ('CI','VI','RCA','RVA','ICOL','ICAP')  ) /*(@cProducto <> 'CP' OR @cProducto <> 'VP')) */
				SELECT mncodmon,mnglosa FROM bacparamsuda..moneda WHERE mncodmon IN (998,999,13)
			ELSE
				IF   @cProducto IN ('EMPR','ARBI') OR @cProducto = '2'
					SELECT mncodmon, mnglosa FROM bacparamsuda..moneda WHERE mncodmon IN (6,13,24,30,36,37,40,48,51,57,58,64,71,72,82,96,97,102,113,127,132,142,144)
				IF   @cProducto = 'PTAS'
					SELECT mncodmon, mnglosa FROM bacparamsuda..moneda WHERE mncodmon =13
				IF   @cProducto = '1'
					SELECT mncodmon, mnglosa FROM bacparamsuda..moneda WHERE mncodmon IN (999,998)
				IF   @cProducto = '3'
					SELECT mncodmon, mnglosa FROM bacparamsuda..moneda WHERE mncodmon IN (998)

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
