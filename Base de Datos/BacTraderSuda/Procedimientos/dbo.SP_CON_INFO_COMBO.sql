USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_INFO_COMBO]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CON_INFO_COMBO]
   (   @opcion			INT	= 0
   ,   @Parametro1		CHAR(10)= ''
   ,   @Parametro2		CHAR(10)= ''
   ,   @Parametro3		CHAR(10)= ''
   ,   @Parametro4		CHAR(10)= ''
   ,   @Parametro5		CHAR(10)= ''
   ,   @Parametro6		CHAR(15)= ''
   )
AS
BEGIN

SET NOCOUNT ON

/* LD1-COR-035 FUSION CORPBANCA - ITAU --> GRABACION DE COMPRAS DEFINITIVAS - CARGA DE COMBO VOLCKER RULE **/
/***********************************************************************/
/*SISTEMA: BACTRADERSUDA */


	IF @OPCION = 1 BEGIN 
		SELECT 	tbcateg 
		,		tbcodigo1 
		,		tbtasa 
		,		tbfecha                     
		,		tbvalor              
		,		tbglosa                                            
		,		nemo       
		FROM	VIEW_TABLA_GENERAL_DETALLE 
		,		VIEW_TBL_RELACIONES
		WHERE	tbcateg				= @Parametro1
		AND		tbcodigo1			= Rel_IdRelacion1
		AND		(Rel_IdRelacion1	= @Parametro3 OR @Parametro3= '')
		AND		Rel_IdCodigo1		= @Parametro2
		AND		tbcateg				= Rel_IdCodigo2
		ORDER 
		BY	 tbcodigo1

	END

	IF @OPCION = 2 BEGIN	
	
		SELECT	rcsistema 
		,		rcrut   
		,		RCCODPRO 
		,		rcdv 
		,		rcnumcorr   
		,		tbglosa	--rcnombre
		FROM	VIEW_TIPO_CARTERA
		,		VIEW_TABLA_GENERAL_DETALLE
		WHERE 	(RCCODPRO		= @Parametro1 OR @Parametro1 = '')
		AND 	rcsistema		= @Parametro3
		AND		(rcrut			= CONVERT(INT,@Parametro4) OR @Parametro4 = '')
		AND		tbcateg			= @Parametro2
		AND		tbcodigo1		= LTRIM(RTRIM(CONVERT(CHAR,rcrut)))
	END

	IF @OPCION = 3 BEGIN -- opcion para reportes junto con la 4
		SELECT 	A.tbcateg 
		,		A.tbcodigo1 
		,		A.tbtasa 
		,		A.tbfecha                     
		,		A.tbvalor              
		,		A.tbglosa                                            
		,		A.nemo       
		FROM	VIEW_TABLA_GENERAL_DETALLE	A
		WHERE	A.tbcateg		= @Parametro1
		ORDER 
		BY	 A.tbcodigo1

	END

	IF @OPCION = 4 BEGIN	--OPCION PARA REPORTES

		--sp_con_info_combo 4, '', '1111', 'BTR', '', ''

		SELECT	DISTINCT rcsistema 
		,	rcrut   
		,	''
		,	rcdv 
		,	rcnumcorr   
		,	tbglosa	--rcnombre
		FROM	VIEW_TIPO_CARTERA
		,		VIEW_TABLA_GENERAL_DETALLE
		WHERE 	(RCCODPRO		= @Parametro1 OR @Parametro1 = '')
		AND 	rcsistema		= @Parametro3
		AND		(rcrut			= CONVERT(INT,@Parametro4) OR @Parametro4 = '')
		AND		tbcateg			= @Parametro2
		AND		tbcodigo1		= LTRIM(RTRIM(CONVERT(CHAR,rcrut)))
	END


	IF @OPCION = 5 BEGIN-- LIBROS RELACIONADOS A LOS SISTEMAS...
	
		SELECT	''
		,	TBCODIGO1
		,	''
		,	''
		,	''
		,	TBGLOSA
		FROM	VIEW_TABLA_GENERAL_DETALLE
		,		VIEW_TBL_RELACION_PRODUCTO_LIBRO
		WHERE	RPL_IDSISTEMA	= @Parametro1
		AND		RPL_IDPRODUCTO	= @Parametro2
		AND		(RPL_IDLIBRO	= @Parametro4	OR @Parametro4 = '')
		AND		TBCATEG			= @Parametro3
		AND		TBCODIGO1		= RPL_IDLIBRO
	END

	IF @OPCION = 6 BEGIN -- CARTERA SUPER RELACIONADA CON LOS LIBROS
		SELECT	''
		,	TBCODIGO1
		,	''
		,	''
		,	''
		,	TBGLOSA
		FROM	VIEW_TABLA_GENERAL_DETALLE
		,		VIEW_TBL_RELACION_LIBRO_CARTERASUPER
		WHERE	RLC_IDSISTEMA		= @Parametro1
		AND		RLC_IDPRODUCTO		= @Parametro2
		AND		RLC_IDLIBRO		= @Parametro3
		AND		(RLC_IDCARTERASUPER	= @Parametro5	OR @Parametro5 = '')
		AND		TBCATEG			= @Parametro4
		AND		TBCODIGO1		= RLC_IDCARTERASUPER

	END

	IF @OPCION = 7 BEGIN --2 BEGIN-- CARTERA FINANCIERA - USUARIO
		SELECT	rcsistema 
		,	rcrut   	
		,	RCCODPRO 
		,	rcdv 
		,	rcnumcorr   
		,	tbglosa
		,	Ucf_Default
		FROM	VIEW_TIPO_CARTERA
		,		VIEW_TABLA_GENERAL_DETALLE
		,		VIEW_USU_CART_FINANCIERA --DBO.TBL_REL_USU_CART_FINANCIERA
		WHERE 	(rccodpro		= @Parametro1 OR @Parametro1 = '')
		AND		tbcateg			= case when @Parametro2 =''then 0 else @Parametro2 end    --  REQ. 7619
		AND 	rcsistema		= @Parametro3
		AND		(rcrut			= CONVERT(INT,@Parametro4) OR @Parametro4 = '')
		AND		tbcodigo1		= LTRIM(RTRIM(CONVERT(CHAR,rcrut)))
		AND		Ucf_Usuario		= @Parametro5
		AND		Ucf_Sistema		= rcsistema
		AND		Ucf_Producto	= rccodpro
		AND		Ucf_Codigo_Cart	= rcrut
		ORDER BY Ucf_Default	DESC
	END


      IF @OPCION = 8 
      BEGIN-- 5 LIBROS RELACIONADOS A LOS SISTEMAS...

         IF NOT EXISTS( SELECT 1 FROM BacParamSuda.dbo.PRODUCTO WHERE id_sistema = 'BTR' and codigo_producto = @Parametro2 )
         BEGIN
            IF SUBSTRING(@Parametro2,3,1) = 'A'
               SET @Parametro2 = SUBSTRING(@Parametro2,1,2)
   
            IF @Parametro2 = 'IB'
               SET @Parametro2 = 'ICAP'

            IF @Parametro2 = 'ST'
               SET @Parametro2 = 'CP'

         END

         SELECT	DISTINCT
			'Blanco_Uno'	= ' '
		,	'Codigo'		= LTRIM(RTRIM(TBCODIGO1))
		,	'Blanco_Dos'	= ' '
		,	'Blanco_Tres'	= ' '
		,	'Blanco_Cuatro'	= ' '
		,	'Glosa'			= LTRIM(RTRIM(TBGLOSA))
		,	'Prioridad'		= Ucn_Default
		INTO	#TEMPORAL_USUARIO_LIBRO
		FROM	VIEW_TABLA_GENERAL_DETALLE
		,		VIEW_TBL_RELACION_PRODUCTO_LIBRO
		,		VIEW_REL_USUARIO_NORMATIVO
		WHERE	RPL_IDSISTEMA		= @Parametro1
		AND		RPL_IDPRODUCTO		= @Parametro2
		AND		TBCATEG				= @Parametro3
		AND		(RPL_IDLIBRO		= @Parametro4  OR @Parametro4 = '')
		AND		TBCODIGO1			= RPL_IDLIBRO
		AND		Ucn_Usuario			= @Parametro5
		AND		Ucn_Sistema			= Rpl_IdSistema
		AND		Ucn_Producto		= Rpl_IdProducto	
		AND		Ucn_Codigo_Lib		= Rpl_Idlibro
		ORDER BY Ucn_Default	DESC

		UPDATE	#TEMPORAL_USUARIO_LIBRO
		SET		Prioridad ='S'
		FROM	#TEMPORAL_USUARIO_LIBRO
		,		#TEMPORAL_USUARIO_LIBRO TUL
		WHERE	#TEMPORAL_USUARIO_LIBRO.Codigo = TUL.Codigo
		AND		#TEMPORAL_USUARIO_LIBRO.Prioridad= 'N'
		AND		TUL.Prioridad	= 'S'

         SELECT DISTINCT *
         FROM  #TEMPORAL_USUARIO_LIBRO
         ORDER BY Prioridad DESC
      END


	IF @OPCION = 9 BEGIN --6 CARTERA SUPER RELACIONADA CON LOS LIBROS
		SELECT	DISTINCT
			'Blanco_Uno'	= ' '
		,	'Codigo'		= LTRIM(RTRIM(TBCODIGO1)) 
		,	'Blanco_Dos'	= ' '
		,	'Blanco_Tres'	= ' '
		,	'Blanco_Cuatro'	= ' '
		,	'Glosa'			= RTRIM(LTRIM(TBGLOSA))
		,	'Prioridad'		= Ucn_Default
		Into 	#Temporal_Usuario_Cart_Norm
		FROM	VIEW_TABLA_GENERAL_DETALLE
		,		VIEW_TBL_RELACION_LIBRO_CARTERASUPER
		,		VIEW_REL_USUARIO_NORMATIVO
		WHERE	RLC_IDSISTEMA		= @Parametro1
		AND		RLC_IDPRODUCTO		= @Parametro2
		AND		RLC_IDLIBRO			= @Parametro3
		AND		(RLC_IDCARTERASUPER	= @Parametro5	OR @Parametro5 = '')
		AND		TBCATEG				= @Parametro4
		AND		Ucn_Usuario			= @Parametro6
		AND		TBCODIGO1			= Rlc_IDCARTERASUPER
		AND		Ucn_Sistema			= Rlc_IdSistema
		AND		Ucn_Producto		= Rlc_IdProducto	
		AND		Ucn_Codigo_Lib		= Rlc_Idlibro
		AND		Ucn_Codigo_CartN	= Rlc_IDCARTERASUPER
		ORDER BY Ucn_Default	DESC
		
		UPDATE 	#Temporal_Usuario_Cart_Norm
		SET 	Prioridad = 'S'
		FROM	#Temporal_Usuario_Cart_Norm
		,		#Temporal_Usuario_Cart_Norm TUCN
		WHERE	#Temporal_Usuario_Cart_Norm.Codigo = TUCN.Codigo
		AND		#Temporal_Usuario_Cart_Norm.Prioridad = 'N'
		AND		TUCN.Prioridad = 'S'

		SELECT DISTINCT * 
		FROM	#Temporal_Usuario_Cart_Norm
		ORDER 
		BY	Prioridad DESC
	END

	IF @OPCION=10 BEGIN --CARGA PORFOLIO DE LOS USUARIOS
		SELECT	''
		,	Upf_Codigo_Porfolio
		,	''
		,	''
		,	''
		,	tbglosa
		,	Upf_Default 		
		FROM	bacparamsuda..TBL_REL_USU_PORFOLIO
		,		bacparamsuda..tabla_general_detalle
		WHERE	(Upf_Usuario			= @Parametro1		OR @Parametro1	= '')
		AND		(Upf_Codigo_Porfolio	= @Parametro2		OR @Parametro2	= '')
		AND		tbcateg					= @Parametro3
		AND		tbcodigo1				= Upf_Codigo_Porfolio
		order by Upf_Default desc
	END

		/*LD1-COR-035* --> CARGAR CARTERA VOLCKER RULE POR USUARIO*/
	 IF @OPCION = 11 BEGIN
 	  
		SELECT	''
			,	Ucvr_Codigo_Cart
			,	''
			,	''		
			,	Ucvr_Default			
			,	tgd.tbglosa
		FROM	BACPARAMSUDA..TBL_REL_USU_CART_VOLCKER_RULE with(nolock)
		left join  BACPARAMSUDA..TABLA_GENERAL_DETALLE  tgd with(nolock)	
		on tbcodigo1	= Ucvr_Codigo_Cart
		and tgd.tbcateg = @Parametro2
		WHERE	 Ucvr_Usuario	= @Parametro5
		AND	(Ucvr_Sistema		= @Parametro3	OR @Parametro3	= '')
		AND	(Ucvr_Producto		= @Parametro1	OR @Parametro1	= '')
		order by Ucvr_Default desc

	 END
   SET NOCOUNT OFF

END
GO
