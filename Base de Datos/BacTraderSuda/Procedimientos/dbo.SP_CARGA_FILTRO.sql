USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_FILTRO]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CARGA_FILTRO]
   (   
        @iTag      	INTEGER 
      , @nRut      	INTEGER 	=0
      , @cLibro    	VARCHAR(255) = ''
      , @cTipoCar  	VARCHAR(255) = ''
      , @cCarSuper 	VARCHAR(255) = ''
      , @Cadena_Familia VARCHAR(255) = ''
      , @Cadena_Emisor  VARCHAR(255) = ''
      , @Cadena_Moneda  VARCHAR(255) = ''   )

AS	
BEGIN
   SET NOCOUNT ON
   DECLARE @dFechaPro   DATETIME
   SELECT  @dFechaPro   = acfecproc   FROM    MDAC

   IF @ITAG = 1
   BEGIN
      SELECT tbcodigo1
      ,      tbglosa
      FROM   bacparamsuda.dbo.TABLA_GENERAL_DETALLE 
      WHERE  tbcateg = 1552 --> LIBRO
   END

   IF @ITAG = 2
   BEGIN
		SELECT	rcrut   
		,	tbglosa	--rcnombre
		FROM VIEW_TIPO_CARTERA
		  ,  VIEW_TABLA_GENERAL_DETALLE
		WHERE 	(rccodpro		= 'VI' )
		AND 	 rcsistema		= 'BTR'
		AND	 tbcateg		= '204'
		AND	 tbcodigo1		= LTRIM(RTRIM(CONVERT(CHAR,rcrut)))
   END

   IF @ITAG = 3
   BEGIN --categoria super
	SELECT	 TBCODIGO1
		,TBGLOSA
		FROM	VIEW_TABLA_GENERAL_DETALLE
		,	VIEW_TBL_RELACION_LIBRO_CARTERASUPER
		WHERE	RLC_IDSISTEMA		= 'BTR'
		AND	RLC_IDPRODUCTO		= 'VI'
		AND 	(CHARINDEX(RTRIM(LTRIM(RLC_IDLIBRO))  , @cLibro ) > 0  or @cLibro = '')
		AND	TBCATEG			= 1111 
		AND	TBCODIGO1		= RLC_IDCARTERASUPER
   END

   IF @ITAG = 4
   BEGIN
    --fAMILIA
     SELECT DISTINCT 'serie' = inserie 
      FROM   MDDI 
      ,      VIEW_INSTRUMENTO
      ,      MDAC
      WHERE  inserie    = diserie 
      AND    dirutcart  = @nRut 
      AND    ditipoper <> 'IB' 
      AND    dinominal  > 0
      AND    (CHARINDEX(RTRIM(LTRIM(ditipcart)),@cTipoCar) > 0  or @cTipoCar = '')
      AND   (digenemi  <> 'BCO' or diserie <> 'LCHR')  -- VGS 07/04/2005
      AND    SUBSTRING(diserie,1,3) <> 'DPX'
      AND    Fecha_PagoMañana <= @dFechaPro	
      ORDER BY inserie
   END

  IF @ITAG = 5
   BEGIN
   --EMISOR
    SELECT DISTINCT emgeneric
      FROM   MDDI
      ,      VIEW_EMISOR
      WHERE  emgeneric = digenemi 
      AND    dirutcart = @nRut 
      AND    dinominal > 0
      AND   (CHARINDEX(RTRIM(LTRIM(ditipcart)),@cTipoCar) > 0  or @cTipoCar = '')
      AND   (digenemi <> 'BCO' or diserie <> 'LCHR')  
      AND    SUBSTRING(diserie,1,3) <> 'DPX'
      AND    Fecha_PagoMañana <= @dFechaPro	
   END

  IF @ITAG = 6
   BEGIN
   --MONEDA
      SELECT DISTINCT 'Nemotecnico'= b.mnnemo 
      FROM   MDDI  	  A
      ,      VIEW_MONEDA  B
      WHERE  b.mnnemo   	= a.dinemmon 
      AND    a.dirutcart  	= @nRut 
      AND    a.dinominal  	> 0
      AND   (CHARINDEX(RTRIM(LTRIM(ditipcart)),@cTipoCar) > 0  or @cTipoCar = '')
      AND   (a.digenemi  <> 'BCO' or a.diserie <> 'LCHR') 
      AND    SUBSTRING( a.diserie, 1, 3 ) <> 'DPX'
      AND    Fecha_PagoMañana <= @dFechaPro	
   END

  IF @ITAG = 7
   BEGIN

	SELECT	DISTINCT A.diinstser	AS 'PAPEL'
	       ,B.cpcodigo		AS 'CODIGO'
	FROM	MDDI	A
               ,MDCP	B
		WHERE	A.dinominal							> 0 
		AND	A.Estado_Operacion_Linea					= ''
		AND    (A.digenemi <> 'BCO' OR A.diserie <> 'LCHR')
		AND    (CHARINDEX(RTRIM(LTRIM(A.diserie))  , @Cadena_Familia )		> 0 OR @Cadena_Familia = '' )--@Cadena_Familia
		AND    (CHARINDEX(RTRIM(LTRIM(A.digenemi)) , @Cadena_Emisor ) 		> 0 OR @Cadena_Emisor = '' )--@Cadena_Emisor
		AND    (CHARINDEX(RTRIM(LTRIM(A.dinemmon)) , @Cadena_Moneda ) 		> 0 OR @Cadena_Moneda = '' )--@Cadena_Moneda
		AND    (CHARINDEX(RTRIM(LTRIM(A.id_libro)) , @cLibro ) 			> 0 OR @cLibro 		= '')
		AND    (CHARINDEX(RTRIM(LTRIM(A.codigo_carterasuper)), @cCarSuper) 	> 0 OR @cCarSuper 	= '')
		AND    (CHARINDEX(RTRIM(LTRIM(ditipcart)),@cTipoCar) 			> 0 OR @cTipoCar 	= '')
		AND	cprutcart 							= A.dirutcart
		AND	cpnumdocu 							= A.dinumdocu
		AND	cpcorrela							= A.dicorrela
		AND     A.Fecha_PagoMañana 						<=@dFechaPro	
     END
END


GO
