USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_INFO_COMBO]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC [dbo].[SP_CON_INFO_COMBO] (	@opcion			INT	= 0	,
					@Parametro1		CHAR(06)= ''	,
					@Parametro2		CHAR(06)= ''	,
					@Parametro3		CHAR(06)= ''	,
					@Parametro4		CHAR(06)= ''	,
					@Parametro5		CHAR(06)= ''	)
AS
BEGIN

SET NOCOUNT ON

	IF @OPCION = 1 BEGIN 
		SELECT 	tbcateg 
		,	tbcodigo1 
		,	tbtasa 
		,	tbfecha                     
		,	tbvalor              
		,	tbglosa                                            
		,	nemo       
		FROM	VIEW_TABLA_GENERAL_DETALLE 
		,	BACPARAMSUDA.dbo.TBL_RELACIONES
		WHERE	tbcateg			= @Parametro1
		AND	tbcodigo1		= Rel_IdRelacion1
		AND	(Rel_IdRelacion1	= @Parametro3 OR @Parametro3= '')
		AND	Rel_IdCodigo1		= @Parametro2
		AND	tbcateg			= Rel_IdCodigo2
		ORDER 
		BY	 tbcodigo1

	END

	IF @OPCION = 2 BEGIN	

	-- sp_con_info_combo 2, 'CP', 'BTR', '204', '', ''
		SELECT	rcsistema 
		,	rcrut   
		,	RCCODPRO 
		,	rcdv 
		,	rcnumcorr   
		,	tbglosa	--rcnombre
		FROM	BACPARAMSUDA.dbo.TIPO_CARTERA
		,	VIEW_TABLA_GENERAL_DETALLE
		WHERE 	(RCCODPRO		= @Parametro1 OR @Parametro1 = '')
		AND 	rcsistema		= @Parametro3
		AND	(rcrut			= CONVERT(INT,@Parametro4) OR @Parametro4 = '')
		AND	tbcateg			= @Parametro2
		AND	tbcodigo1		= LTRIM(RTRIM(CONVERT(CHAR,rcrut)))
	END

	IF @OPCION = 3 BEGIN -- opcion para reportes junto con la 4
		SELECT 	A.tbcateg 
		,	A.tbcodigo1 
		,	A.tbtasa 
		,	A.tbfecha                     
		,	A.tbvalor              
		,	A.tbglosa                                            
		,	A.nemo       
		FROM	VIEW_TABLA_GENERAL_DETALLE	A
		WHERE	A.tbcateg		= @Parametro1
		ORDER 
		BY	 A.tbcodigo1

	END

	IF @OPCION = 4 BEGIN	--OPCION PARA REPORTES

		SELECT	DISTINCT rcsistema 
		,	rcrut   
		,	''
		,	rcdv 
		,	rcnumcorr   
		,	tbglosa	--rcnombre
		FROM	BACPARAMSUDA.dbo.TIPO_CARTERA
		,	VIEW_TABLA_GENERAL_DETALLE
		WHERE 	(RCCODPRO		= @Parametro1 OR @Parametro1 = '')
		AND 	rcsistema		= @Parametro3
		AND	(rcrut			= CONVERT(INT,@Parametro4) OR @Parametro4 = '')
		AND	tbcateg			= @Parametro2
		AND	tbcodigo1		= LTRIM(RTRIM(CONVERT(CHAR,rcrut)))
	END


	IF @OPCION = 5 BEGIN-- LIBROS RELACIONADOS A LOS SISTEMAS...
	
		SELECT	''
		,	TBCODIGO1
		,	''
		,	''
		,	''
		,	TBGLOSA
		FROM	VIEW_TABLA_GENERAL_DETALLE
		,	BACPARAMSUDA.dbo.TBL_RELACION_PRODUCTO_LIBRO
		WHERE	RPL_IDSISTEMA	= @Parametro1
		AND	RPL_IDPRODUCTO	= @Parametro2
		AND	(RPL_IDLIBRO	= @Parametro4	OR @Parametro4 = '')
		AND	TBCATEG		= @Parametro3
		AND	TBCODIGO1	= RPL_IDLIBRO
	END

	IF @OPCION = 6 BEGIN -- CARTERA SUPER RELACIONADA CON LOS LIBROS
		SELECT	''
		,	TBCODIGO1
		,	''
		,	''
		,	''
		,	TBGLOSA
		FROM	VIEW_TABLA_GENERAL_DETALLE
		,	BACPARAMSUDA.dbo.TBL_RELACION_LIBRO_CARTERASUPER
		WHERE	RLC_IDSISTEMA		= @Parametro1
		AND	RLC_IDPRODUCTO		= @Parametro2
		AND	RLC_IDLIBRO		= @Parametro3
		AND	(RLC_IDCARTERASUPER	= @Parametro5	OR @Parametro5 = '')
		AND	TBCATEG			= @Parametro4
		AND	TBCODIGO1		= RLC_IDCARTERASUPER

	END
	
	IF @OPCION = 7 BEGIN	-- CODIGO Y NOMBRE DE LOS SISTEMAS 
		SELECT	''
		,	id_sistema 
		,	''
		,	''
		,	''
		,	nombre_sistema
		FROM	BACPARAMSUDA.dbo.SISTEMA_CNT
		WHERE	(operativo	= @Parametro1	OR @Parametro1 = '')
		AND	(gestion	= @Parametro2	OR @Parametro2 = '')
		AND	(id_sistema	= @Parametro3	OR @Parametro3 = '')
	END

	IF @OPCION = 8 BEGIN	-- CODIGO Y NOMBRE DE MONEDAS
		SELECT	''
		,	mncodmon 
		,	''
		,	''
		,	''
		,	LTRIM(RTRIM(mnnemo)) + SPACE(8-LEN(mnnemo)) + LTRIM(RTRIM(mnglosa))
		FROM	BACPARAMSUDA.dbo.MONEDA
		WHERE	(mncodmon	= CONVERT(INT,@Parametro1)	OR @Parametro1 = '')
		AND	mntipmon	IN (@Parametro1, @Parametro2, @Parametro3, @Parametro4, @Parametro5)
		ORDER
		BY	mnnemo
	END

	IF @OPCION = 9 BEGIN
		SELECT	Pll_Moneda
		,	Pll_Codigo 
		,	''
		,	''
		,	Pll_IdSistema
		,	'DE ' + LTRIM(RTRIM(CONVERT(CHAR,Pll_Desde))) + ' A ' + LTRIM(RTRIM(CONVERT(CHAR,Pll_Hasta)))
		FROM	TBL_PLAZOS_LINEAS
		WHERE	(Pll_IdSistema	= @Parametro1	OR @Parametro1	= '')
		AND	(Pll_Moneda	= @Parametro2	OR @Parametro2	= '')
		AND	(Pll_Codigo	= @Parametro3	OR @Parametro3	= '')
                order by Pll_Hasta
	END

SET NOCOUNT OFF

END
GO
