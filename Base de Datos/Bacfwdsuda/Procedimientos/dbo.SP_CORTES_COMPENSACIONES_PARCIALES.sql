USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CORTES_COMPENSACIONES_PARCIALES]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


-- sp_cortes_compensaciones_parciales 2,'1111','1554','1552'
CREATE PROCEDURE [dbo].[SP_CORTES_COMPENSACIONES_PARCIALES]	(	@Cartera_Inv		INT
							,	@Cat_CartNorm		CHAR(06) = ''
							,	@Cat_SubCartNorm	CHAR(06) = ''
							,	@Cat_Libro		CHAR(06) = ''
							)
AS
BEGIN

	SET NOCOUNT ON

	DECLARE @nvaluf     		FLOAT  
	DECLARE @nvalob     		FLOAT
	DECLARE @cnomprop   		CHAR(40)
	DECLARE @cdirprop   		CHAR(40)
	DECLARE @cfecproc   		CHAR(10)
	DECLARE @dfecproc   		DATETIME
	DECLARE @nspotuhoy  		FLOAT
	DECLARE @observado  		NUMERIC(12,04) 	,
		@uf   			NUMERIC(12,04) 	,
		@fecha_observado 	CHAR(10) 	,
		@fecha_uf  		CHAR(10) 	,
		@numerico		NUMERIC(21,04)	,
		@numericoI		NUMERIC(21,00)	,
      	        @Glosa_Cartera 		Char   (20)

	Select @Glosa_Cartera = '' 

   SELECT Distinct
	  @Glosa_Cartera = IsNull(rcnombre,'')
   FROM   BacParamSuda..TIPO_CARTERA
   WHERE  rcsistema = 'BFW'
     And  rcrut     = @Cartera_INV
   --ORDER BY rcrut

  if @Glosa_Cartera = '' 
	Select @Glosa_Cartera = '< TODAS >'


	EXECUTE sp_parametros_reporte 	@observado  		OUTPUT 	,
					@uf   			OUTPUT 	,
					@fecha_observado 	OUTPUT	,
					@fecha_uf  		OUTPUT
  
	SELECT	@cnomprop = (SELECT rcnombre FROM view_entidad)  ,
               	@cdirprop = a.acdirprop                          ,
               	@dfecproc = a.acfecproc                          ,
               	@cfecproc = CONVERT( CHAR(10), a.acfecproc, 103 )
	FROM    mfac a            

	SELECT @numerico = 0

	select distinct Operacopn = cornumoper 
	Into #Operaciones_Cortes
	from cortes

	Create Table	#Cartera (
		Operacion	Numeric(20)	,
		Rut_Cli		Numeric(10)	,
		Codigo_Cli	Numeric(02)	,
		Tipo_Op		Numeric(05)	,
		Cartera		Numeric(05)	,
		Cartera_Norm	CHAR(50)	,
		SubCartera_Norm	CHAR(50)	,
		Libro		CHAR(50)	)

	Insert #Cartera
	select  canumoper,cacodigo,cacodcli,cacodpos1,cacodcart, cacartera_normativa ,casubcartera_normativa ,calibro 
	from mfca,#Operaciones_Cortes
	Where canumoper in (Operacopn)

	Insert #Cartera
	select  monumoper,mocodigo,mocodcli,mocodpos1,mocodcart, mocartera_normativa, mosubcartera_normativa, molibro 
	from mfmoh ,#Operaciones_Cortes
	Where monumoper in (Operacopn)

	SELECT 	'Operacion'	= a.cornumoper 						,
		'Correlativo'	= a.corcorrela						,
		'Cliente'	= SPACE(50)						,
		'FecInicio'	= ISNULL( CASE a.corcorrela WHEN 1 
						  THEN ( SELECT cafecha
							 FROM	mfca 
							 WHERE	canumoper = a.cornumoper	)
						  ELSE 	( SELECT c.corfecvcto
							 FROM	cortes c
							 WHERE	c.cornumoper = a.cornumoper AND
								c.corcorrela = a.corcorrela-1)
					   END , a.corfecvcto)	,
		'FecVcto'	= a.corfecvcto						,
		'Dias'		= 0							,
		'Valor_Tasa'	= a.cortastab						,
		'Monto_Usd'	= @numerico						,
		'T_C'		= @numerico						,
		'Pesos_Usd'	= @numericoI						,
		'Monto_Cnv'	= cormontocomp						,
		'Valor_Uf'	= @numerico						,
		'Pesos_Cnv'	= @numericoI						,
		'Liq_Pesos'	= a.corresclp						,
		'Liq_UM'	= a.correscnv						,
		'Reajustes'	= a.correajac						,
		'Intereses'	= a.cointeresac						,
	    	'Tipo_Cart'     = (SELECT Distinct IsNull(rcnombre,'') FROM   BacParamSuda..TIPO_CARTERA WHERE  rcsistema = 'BFW' And rccodpro = c.Tipo_Op and rcrut = c.cartera ),
    		'Tipo_InV'	= @Glosa_Cartera					,
		'Cartera_Norm'	= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_cartnorm     AND tbcodigo1 = c.Cartera_Norm),'No Especificado')	,
		'SubCartera_Norm'	= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_subcartnorm  AND tbcodigo1 = c.SubCartera_Norm),'No Especificado')	,
		'Libro'		= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_libro        AND tbcodigo1 = c.Libro),'No Especificado') 
	INTO	#tmp_cartera
	FROM	cortes	a,
		mfac	b,
		#Cartera c
	WHERE	a.cornumoper = c.operacion and 
		(   c.cartera   =  @Cartera_INV or @Cartera_INV = 0)

	UPDATE 	#tmp_cartera
	SET	dias 		= DATEDIFF(DD,FecInicio,FecVcto)	,
		Monto_Usd	= camtomon1				,
		T_C		= ISNULL( ( 	SELECT 	vmvalor 
						FROM	view_valor_moneda,
							mfac
						WHERE	CONVERT(CHAR(8),FecVcto,112) = vmfecha AND
							accodmondolobs		     = vmcodigo ) , 0 ) ,
		Valor_Uf	= ISNULL( ( 	SELECT 	vmvalor 
						FROM	view_valor_moneda	,
							mfac
						WHERE	CONVERT(CHAR(8),FecVcto,112) = vmfecha AND
							accodmonuf		     = vmcodigo ) , 0 ) ,
		Cliente		= LEFT( clnombre ,50)
	FROM	mfca	,
		view_cliente
	WHERE	Operacion = canumoper	AND
		(clrut    = cacodigo	AND
		 clcodigo = cacodcli	)


	UPDATE 	#tmp_cartera
	SET	Pesos_Usd	= ROUND( Monto_Usd * T_C      , 0 )	,
		Pesos_Cnv	= ROUND( Monto_Cnv *  Valor_Uf, 0 )


	IF EXISTS( SELECT 1 FROM #tmp_cartera )
		SELECT	Operacion							,
			Correlativo							,
			Cliente								,
			'FecInicio' = CONVERT(CHAR(10),FecInicio,103)			,
			'FecVcto'   = CONVERT(CHAR(10),FecVcto,103)			,
			Dias								,
			Valor_Tasa							,
			Monto_Usd							,
			T_C								,
			Pesos_Usd							,
			Monto_Cnv							,
			Valor_Uf							,
			Pesos_Cnv							,
			Liq_Pesos							,
			Liq_UM								,
			Reajustes							,
			Intereses							,
			'Fecha Proceso'        = @cfecproc                        	,
			'Nombre Empresa'       = @cnomprop                        	,
			'Direccion Empresa'    = @cdirprop                        	,
			'Valor UF'             = @uf                              	,
			'Valor Observado'      = @observado       			,
			'fecha_UF'             = @fecha_uf       			,
			'fecha_Observado'      = @fecha_observado      			,
			'Hora'                 = CONVERT(CHAR(8),GETDATE(),108 ) 	, 
		    	Tipo_Cart     							,
	    		Tipo_InV							,
			Cartera_Norm							,
			SubCartera_Norm							,
			Libro								
		FROM 	#tmp_cartera
	ELSE
		SELECT 	'Operacion'	= 0 						,
			'Correlativo'	= 0						,
			'Cliente'	= ''						,
			'FecInicio'	= ''						,
			'FecVcto'	= ''						,
			'Dias'		= 0						,
			'Valor_Tasa'	= 0						,
			'Monto_Usd'	= @numerico					,
			'T_C'		= @numerico					,
			'Pesos_Usd'	= @numericoI					,
			'Monto_Cnv'	= 0						,
			'Valor_Uf'	= @numerico					,
			'Pesos_Cnv'	= @numericoI					,
			'Liq_Pesos'	= 0						,
			'Liq_UM'	= 0						,
			'Reajustes'	= 0						,
			'Intereses'	= 0						,
			'Fecha Proceso'        = @cfecproc                        	,
			'Nombre Empresa'       = @cnomprop                        	,
			'Direccion Empresa'    = @cdirprop                        	,
			'Valor UF'             = @uf                              	,
			'Valor Observado'      = @observado       			,
			'fecha_UF'             = @fecha_uf       			,
			'fecha_Observado'      = @fecha_observado      			,
			'Hora'                 = CONVERT(CHAR(8),GETDATE(),108 )  	,
		    	'Tipo_Cart'     = ''						,
    			'Tipo_InV'	= @Glosa_Cartera				,
			'Cartera_Norm'		= ''					,
			'SubCartera_Norm'	= ''					,
			'Libro'			= ''					

	SET NOCOUNT OFF

END

GO
