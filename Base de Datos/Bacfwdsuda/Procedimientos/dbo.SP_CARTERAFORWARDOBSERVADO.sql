USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARTERAFORWARDOBSERVADO]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CARTERAFORWARDOBSERVADO]( @producto		INT
					,	@Cat_CartNorm		CHAR(06)
					,	@Cat_SubCartNorm	CHAR(06)
					,	@Cat_Libro		CHAR(06)
									       )
AS
BEGIN


/*                                    
  EXEC sp_CarteraForwardObservado 14,1111,1554,1552
 -- EXEC sp_CarteraForwardObservado 14,1111,1554,1552

*/
	SET NOCOUNT ON
	DECLARE @nvaluf     FLOAT  
	DECLARE @nvalob     FLOAT
	DECLARE @cnomprop   CHAR(40)
	DECLARE @cdirprop   CHAR(40)
	DECLARE @cfecproc   CHAR(10)
	DECLARE @dfecproc   DATETIME
	DECLARE @nspotuhoy  FLOAT
	DECLARE @observado  NUMERIC(12,04) ,
		@uf   NUMERIC(12,04) ,
		@fecha_observado CHAR(10) ,
		@fecha_uf  CHAR(10) 	,
  	 @Glosa_Cartera Char   (20)

	Select @Glosa_Cartera = '' 

	Select @Glosa_Cartera = '<COMPRA Y VENTAS>'

	EXECUTE sp_parametros_reporte 	@observado  OUTPUT ,
					@uf   OUTPUT ,
					@fecha_observado OUTPUT ,
					@fecha_uf  OUTPUT
  
	SELECT	@cnomprop = (Select rcnombre from VIEW_ENTIDAD)  ,
               	@cdirprop = a.acdirprop                          ,
               	@dfecproc = a.acfecproc                          ,
               	@cfecproc = CONVERT( CHAR(10), a.acfecproc, 103 )
	FROM    MFAC a            

	EXECUTE sp_div @observado, @uf, @nspotuhoy OUTPUT
	SELECT @nspotuhoy = ROUND ( @nspotuhoy, 11 )
	SELECT @nspotuhoy = ISNULL( @nspotuhoy,1 )
	SELECT @nspotuhoy = CASE @nspotuhoy WHEN 0 THEN 1 ELSE @nspotuhoy END

	IF EXISTS(  	SELECT 1
			FROM    mfca              a,
				view_cliente      b,
				view_moneda       c,
				view_moneda       d,
				view_moneda       e
			WHERE  	a.cacodpos1  = @producto    AND  
				(a.cacodigo   = b.clrut     AND
				a.cacodcli   = b.clcodigo ) AND
				a.camdausd   = c.mncodmon   AND   
				a.cacodmon1  = d.mncodmon   AND
				a.cacodmon2  = e.mncodmon   AND
				a.cafecvcto  > @dfecproc    			
	          		)   

			SELECT 	'Numero'               = a.canumoper                      ,
				'Operacion'            = a.catipoper                      ,
				'Cliente'              = ISNULL(clnombre,' ')             ,
				'Fecha Inicio'         = CONVERT(CHAR(10),a.cafecha,103)  ,
				'Fecha Termino'        = CONVERT(CHAR(10),a.cafecvcto,103),
				'M/X'                  = ISNULL(d.mnnemo,'N/D')           ,
				'Mto M/X Comprado'     = a.camtomon1 ,
				'Moneda'               = ISNULL(c.mnnemo,'N/D' )          ,
				'T/C Obs Ini'          = a.capremon1                      ,  --En Realidad es el TCR de Entrada
				'Mto CLP Inicial T/C'  = a.caequmon1                      ,
				'M/N CNV'              = ISNULL(e.mnnemo,'N/D')           ,
				'T/C Inicial'          = CASE a.cacodmon2 WHEN 998 
								THEN	a.capremon2
								ELSE	a.catipcam
							  END                              ,
				'Monto CNV'            = a.camtomon2, -- CASE WHEN @dfecproc < a.CaFechaStarting THEN 0.0 ELSE a.camtomon2 END , Obs.1 Cert 5522
				'Monto CNV En Pesos'   = a.caequmon2, -- CASE WHEN @dfecproc < a.CaFechaStarting THEN 0.0 ELSE a.caequmon2 END , Obs.1 Cert 5522
				'Valor a Diferir'      = a.cautildiferir + a.caperddiferir,
				'Devengo Acumulado'    = a.cautilacum + a.caperdacum      ,
				'Ajuste Variacion UF'  = a.carevuf                        ,
				'Valorizacion'         = a.carevtot                       ,
				'Modalidad'            = a.catipmoda                      ,
				'Tasa'                 = a.caprecal                       ,
				'Dias'                 = a.caplazo                        ,
				'Dias residuales'      = a.caplazovto                     ,
				'Precio Equilibrio'    = CASE a.cacodmon2 WHEN 998 THEN
							 ROUND ( ( ( ( a.catipcam / @nspotuhoy ) - 1 ) * 36000 ) / ( CASE a.caplazovto WHEN 0 THEN 1 ELSE a.caplazovto END ) , 11 )
							 ELSE	a.catipcam
							 END                                ,
				'Fecha Proceso'        = @cfecproc                        ,
				'Nombre Empresa'       = @cnomprop                        ,
				'Direccion Empresa'    = @cdirprop                        ,
				'Valor UF'             = @uf                              ,
				'Valor Observado'      = @observado       ,
				'fecha_UF'             = @fecha_uf       ,
				'fecha_Observado'      = @fecha_observado      ,
				'Entidad'              = ( SELECT rcnombre
							   FROM   VIEW_ENTIDAD
							   WHERE  rccodcar = a.cacodsuc1 ),
				'Hora'                  = CONVERT(CHAR(5),getdate(),108 )  ,
				'producto'		= @producto			,
				'glosa_producto'	= f.descripcion			,
				'Tipo_Cart'	 	= (SELECT Distinct IsNull(rcnombre,'') FROM   BacParamSuda..TIPO_CARTERA WHERE  rcsistema = 'BFW' And rccodpro = cacodpos1 and rcrut = cacodcart ),
				'Tipo_InV'	 	= @Glosa_Cartera	,
				'cartnorm'	= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_cartnorm AND tbcodigo1 = cacartera_normativa),'No Especificado')	,
				'subcart'	= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_subcartnorm  AND tbcodigo1 = casubcartera_normativa),'No Especificado')	,
				'Libro'		= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_libro        AND tbcodigo1 = calibro),'No Especificado') ,
                'FechaStarting' = CONVERT(CHAR(10),a.CaFechaStarting,103) ,   
                'T/C Fijado'    = a.catipcam ,
                'Puntos Cierre' = a.CaPuntosFwdCierre ,
                'Puntos Trans. Obs.' = a.CaPuntosTransfObs ,
                'Puntos Trans. Fwd.' = a.CaPuntosTransfFwd ,
                'Result. Obtenido'   = a.fRes_Obtenido,
                'Mensaje Fijacion'   = ( select max( Case when cc.CaFechaStarting = @dfecproc 
                                                            then 'HAY FIJACIONES: EMITIR CONTRATOS DEFINITIVOS HOY' else
                                                                 '                                            ' end ) 
                                                          from MFCA cc where cc.CaCodPos1 = 14 )  ,
                'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)

			FROM    mfca              a,
				view_cliente      b,
				view_moneda       c,
				view_moneda       d,
				view_moneda       e,
				view_producto	  f   -- select * from view_producto
			WHERE    a.cacodpos1  = @producto    	AND 
                       		(a.cacodigo   = b.clrut    	AND 
				a.cacodcli   = b.clcodigo ) 	AND 
				a.camdausd   = c.mncodmon   	AND   
				a.cacodmon1  = d.mncodmon   	AND
				a.cacodmon2  = e.mncodmon   	AND  
				a.cafecvcto  > @dfecproc	AND  
			        @producto    = f.codigo_producto 	AND 
				  ( 'BFW'		= f.id_sistema	)	
                        -- Listado de Fijaciones
                        UNION
			SELECT 	'Numero'               = a.canumoper                      ,
				'Operacion'            = case when a.catipoper = 'C' then 'Y' else 'Z' end  , -- a.catipoper                      ,
				'Cliente'              = ISNULL(clnombre,' ')             ,
				'Fecha Inicio'         = CONVERT(CHAR(10),a.cafecha,103)  ,
				'Fecha Termino'        = CONVERT(CHAR(10),a.cafecvcto,103),
				'M/X'                  = ISNULL(d.mnnemo,'N/D')           ,
				'Mto M/X Comprado'     = a.camtomon1 ,
				'Moneda'               = ISNULL(c.mnnemo,'N/D' )          ,
				'T/C Obs Ini'          = a.capremon1                      ,  --En Realidad es el TCR de Entrada
				'Mto CLP Inicial T/C'  = a.caequmon1                      ,
				'M/N CNV'              = ISNULL(e.mnnemo,'N/D')           ,
				'T/C Inicial'          = CASE a.cacodmon2 WHEN 998 
								THEN	a.capremon2
								ELSE	a.catipcam
							  END                              ,
				'Monto CNV'            = a.camtomon2, -- CASE WHEN @dfecproc < a.CaFechaStarting THEN 0.0 ELSE a.camtomon2 END , Obs.1 Cert 5522
				'Monto CNV En Pesos'   = a.caequmon2, -- CASE WHEN @dfecproc < a.CaFechaStarting THEN 0.0 ELSE a.caequmon2 END , Obs.1 Cert 5522
				'Valor a Diferir'      = a.cautildiferir + a.caperddiferir,
				'Devengo Acumulado'    = a.cautilacum + a.caperdacum      ,
				'Ajuste Variacion UF'  = a.carevuf                        ,
				'Valorizacion'         = a.carevtot                       ,
				'Modalidad'            = a.catipmoda                      ,
				'Tasa'                 = a.caprecal                       ,
				'Dias'                 = a.caplazo                        ,
				'Dias residuales'      = a.caplazovto                     ,
				'Precio Equilibrio'    = CASE a.cacodmon2 WHEN 998 THEN
							 ROUND ( ( ( ( a.catipcam / @nspotuhoy ) - 1 ) * 36000 ) / ( CASE a.caplazovto WHEN 0 THEN 1 ELSE a.caplazovto END ) , 11 )
							 ELSE	a.catipcam
							 END                                ,
				'Fecha Proceso'        = @cfecproc                        ,
				'Nombre Empresa'       = @cnomprop                        ,
				'Direccion Empresa'    = @cdirprop                        ,
				'Valor UF'             = @uf                              ,
				'Valor Observado'      = @observado       ,
				'fecha_UF'             = @fecha_uf       ,
				'fecha_Observado'      = @fecha_observado      ,
				'Entidad'              = ( SELECT rcnombre
							   FROM   VIEW_ENTIDAD
							   WHERE  rccodcar = a.cacodsuc1 ),
				'Hora'                  = CONVERT(CHAR(5),getdate(),108 )  ,
				'producto'		= @producto			,
				'glosa_producto'	= f.descripcion			,
				'Tipo_Cart'	 	= (SELECT Distinct IsNull(rcnombre,'') FROM   BacParamSuda..TIPO_CARTERA WHERE  rcsistema = 'BFW' And rccodpro = cacodpos1 and rcrut = cacodcart ),
				'Tipo_InV'	 	= @Glosa_Cartera	,
				'cartnorm'	= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_cartnorm AND tbcodigo1 = cacartera_normativa),'No Especificado')	,
				'subcart'	= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_subcartnorm  AND tbcodigo1 = casubcartera_normativa),'No Especificado')	,
				'Libro'		= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_libro        AND tbcodigo1 = calibro),'No Especificado') ,
                'FechaStarting' = CONVERT(CHAR(10),a.CaFechaStarting,103) ,   
                'T/C Fijado'    = a.catipcam ,
                'Puntos Cierre' = a.CaPuntosFwdCierre ,
                'Puntos Trans. Obs.' = a.CaPuntosTransfObs ,
                'Puntos Trans. Fwd.' = a.CaPuntosTransfFwd ,
                'Result. Obtenido'   = a.fRes_Obtenido,
                'Mensaje Fijacion'   = ( select max( Case when cc.CaFechaStarting = @dfecproc 
                                                            then 'HAY FIJACIONES: EMITIR CONTRATOS DEFINITIVOS HOY' else
                                                                 '                                            ' end ) 
                                                          from MFCA cc where cc.CaCodPos1 = 14 )  ,
                'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)

			FROM    mfca              a,
				view_cliente      b,
				view_moneda       c,
				view_moneda       d,
				view_moneda       e,
				view_producto	  f   -- select * from view_producto
			WHERE    a.cacodpos1  = @producto    	AND 
                       		(a.cacodigo   = b.clrut    	AND 
				a.cacodcli   = b.clcodigo ) 	AND 
				a.camdausd   = c.mncodmon   	AND   
				a.cacodmon1  = d.mncodmon   	AND
				a.cacodmon2  = e.mncodmon   	AND  
				a.cafecvcto  > @dfecproc	AND  
			        @producto    = f.codigo_producto 	AND 
				  ( 'BFW'		= f.id_sistema	) AND
                                a.CaFechaStarting = @dfecproc
                        -- Listado de Fijaciones
			-- ORDER BY canumoper 
                ELSE
			SELECT 	'Numero'               = 0 ,
				'Operacion'            = '',
				'Cliente'              = 'SIN DATOS ',
				'Fecha Inicio'         = CONVERT(CHAR(10),'19000101',103),
				'Fecha Termino'        = CONVERT(CHAR(10),'19000101',103),
				'M/X'                  = 'N/D',           
				'Mto M/X Comprado'     = 0,
				'Moneda'               = 'N/D',
				'T/C Obs Ini'          = 0.0,  --En Realidad es el TCR de Entrada
				'Mto CLP Inicial T/C'  = 0.0,
				'M/N CNV'              = 'N/D',
				'T/C Inicial'          = 0.0,
				'Monto CNV'            = 0.0, -- CASE WHEN @dfecproc < a.CaFechaStarting THEN 0.0 ELSE a.camtomon2 END , Obs.1 Cert 5522
				'Monto CNV En Pesos'   = 0.0, -- CASE WHEN @dfecproc < a.CaFechaStarting THEN 0.0 ELSE a.caequmon2 END , Obs.1 Cert 5522
				'Valor a Diferir'      = 0.0,
				'Devengo Acumulado'    = 0.0,
				'Ajuste Variacion UF'  = 0.0,
				'Valorizacion'         = 0.0,
				'Modalidad'            = ' ',
				'Tasa'                 = 0.0,
				'Dias'                 = 0  ,
				'Dias residuales'      = 0  ,
				'Precio Equilibrio'    = 0.0,
				'Fecha Proceso'        = @cfecproc                        ,
				'Nombre Empresa'       = @cnomprop                        ,
				'Direccion Empresa'    = @cdirprop                        ,
				'Valor UF'             = @uf                              ,
				'Valor Observado'      = @observado       ,
				'fecha_UF'             = @fecha_uf       ,
				'fecha_Observado'      = @fecha_observado      ,
				'Entidad'              = ( SELECT rcnombre
							   FROM   VIEW_ENTIDAD )
							   ,
				'Hora'                  = CONVERT(CHAR(5),getdate(),108 )  ,
				'producto'		= @producto			,
				'glosa_producto'	= 'SIN FORWARD A OBSERVADO'			,
				'Tipo_Cart'	 	= '           '                 ,
				'Tipo_InV'	 	= '           '         	,
				'cartnorm'				= 'No Especificado'	,
				'subcart'				= 'No Especificado'	,
				'Libro'					= 'No Especificado'	,
                'FechaStarting'			= CONVERT(CHAR(10),'19000101',103) ,   
                'T/C Fijado'			= 0.0 ,
                'Puntos Cierre'			= 0.0 ,
                'Puntos Trans. Obs.'	= 0.0 ,
                'Puntos Trans. Fwd.'	= 0.0 ,
                'Result. Obtenido'		= 0.0,
                'Mensaje Fijacion'		= '                                            ' ,
				'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)


	SET NOCOUNT OFF
END


GO
