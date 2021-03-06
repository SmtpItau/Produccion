USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Inf_Margen_Inversion]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Inf_Margen_Inversion]
      (
            @USUARIO   VARCHAR(15))
            
      
AS
BEGIN

     SET DATEFORMAT DMY
     SET NOCOUNT ON

     DECLARE	@acfecproc	CHAR	(10)	
	,	@acfecprox	CHAR	(10)	
	,	@uf_hoy		NUMERIC(21,4)  
        ,	@uf_man		NUMERIC(21,4)   
        ,	@ivp_hoy	NUMERIC(21,4)   
	,	@ivp_man	NUMERIC(21,4)   
	,	@do_hoy		NUMERIC(21,4)   
	,	@do_man		NUMERIC(21,4)   
	,	@da_hoy		NUMERIC(21,4) 
        ,       @da_man         NUMERIC(21,4)  
	,	@acnomprop	CHAR	(40)	
	,	@rut_empresa	CHAR	(12)	
	,	@hora		CHAR	(08)	
        ,       @fecha_busqueda DATETIME
          
	SELECT @fecha_busqueda= (SELECT Fecha_Proceso FROM DATOS_GENERALES )

	EXECUTE	Sp_Base_Del_Informe
		@acfecproc	OUTPUT
	,	@acfecprox	OUTPUT
	,	@uf_hoy		OUTPUT
        ,	@uf_man		OUTPUT
        ,	@ivp_hoy	OUTPUT
	,	@ivp_man	OUTPUT
	,	@do_hoy		OUTPUT 
	,	@do_man		OUTPUT 
	,	@da_hoy		OUTPUT
        ,       @da_man         OUTPUT
	,	@acnomprop	OUTPUT
	,	@rut_empresa	OUTPUT
	,	@hora		OUTPUT
        ,       @fecha_busqueda 
     IF EXISTS (SELECT 1 FROM MARGEN_INVERSION_INSTRUMENTO)
            BEGIN
                    SELECT  'rut_cartera'          = ISNULL( rut_cartera           , ' ' )
                     ,      'id_sistema'           = ISNULL( id_sistema            , ' ' )
                     ,      'instrumento'          = ISNULL( ( SELECT inserie FROM INSTRUMENTO WHERE instrumento = incodigo ), ' ' )
                     ,      'codigo_moneda'        = ISNULL( M.mnsimbol            , ' ' )
                     ,      'rut_emisor'           = ISNULL( ( SELECT emgeneric FROM EMISOR WHERE rut_emisor = emrut ) , ' ' )
                     ,      'porcentaje_asignado'  = ISNULL( porcentaje_asignado   , 0  )
                     ,      'porcentaje_adicional' = ISNULL( porcentaje_adicional  , 0  )
                     ,      'porcentaje_utilizado' = ISNULL( porcentaje_utilizado  , 0  )
                     ,      'totalasignado'        = ISNULL( totalasignado         , 0  )
                     ,      'totaladicional'       = ISNULL( totaladicional        , 0  )
                     ,      'totalocupado'         = ISNULL( totalocupado          , 0  )
                     ,      'totaldisponible'      = ISNULL( totaldisponible       , 0  )
                     ,      'totalexceso'          = ISNULL( totalexceso           , 0  )
                     ,      'fecha_proceso'        = @acfecproc
                     ,      'fecha_emision'        = CONVERT( CHAR(10) , GETDATE() ,103 )
                     ,      'Hora'                 = CONVERT( CHAR(10) , GETDATE() ,108 )
                     ,      'Titulo'               = 'MARGEN INSTRUMENTO AL ' + CONVERT(CHAR(10),@acfecproc,103)  
      
                      ,     'acfecprox'            = @acfecprox	
	              ,     'uf_hoy'               = @uf_hoy		
                      ,     'uf_man'               = @uf_man		
                      ,     'ivp_hoy'              = @ivp_hoy	
	              ,     'ivp_man'              = @ivp_man	
	              ,     'do_hoy'               = @do_hoy		
	              ,     'do_man'               = @do_man		
	              ,     'da_hoy'               = @da_hoy		
                      ,     'da_man'               = @da_man         
	              ,     'acnomprop'            = @acnomprop	
	              ,     'rut_empresa'          = @rut_empresa	
	              ,     'hora'                 = @hora		
                      ,     'fecha_busqueda'       = @fecha_busqueda  
                      FROM      MARGEN_INVERSION_INSTRUMENTO
                         ,      MONEDA             M
                         ,      DATOS_GENERALES
                      WHERE     codigo_moneda = M.mncodmon
                                 AND M.ESTADO<>'A'

                      ORDER BY  instrumento
      END ELSE BEGIN
                     SELECT 'rut_cartera'          = 0      
                     ,      'id_sistema'           = ' '
                     ,      'instrumento'          = ' '
		     ,      'codigo_moneda'        = ' '       
                     ,      'rut_emisor'           = 0
                     ,      'porcentaje_asignado'  = 0.0000
                     ,      'porcentaje_adicional' = 0.0000
                     ,      'porcentaje_utilizado' = 0.0000
                     ,      'totalasignado'        = 0.00
                     ,      'totaladicional'       = 0.00
                     ,      'totalocupado'         = 0.00
                     ,      'totaldisponible'      = 0.00
                     ,      'totalexceso'          = 0.00
                     ,      'fecha_proceso'        = @acfecproc
                     ,      'fecha_emision'        = CONVERT( CHAR(10) , GETDATE() ,103 )
                     ,      'Hora'                 = CONVERT( CHAR(10) , GETDATE() ,108 )
                     ,      'Titulo'               = 'MARGEN INSTRUMENTO AL ' + CONVERT(CHAR(10),@acfecproc,103)  
                      ,     'acfecprox'            = @acfecprox	
	              ,     'uf_hoy'               = @uf_hoy		
                      ,     'uf_man'               = @uf_man		
                      ,     'ivp_hoy'              = @ivp_hoy	
	              ,     'ivp_man'              = @ivp_man	
	              ,     'do_hoy'               = @do_hoy		
	              ,     'do_man'               = @do_man		
	              ,     'da_hoy'               = @da_hoy		
                      ,     'da_man'               = @da_man         
	              ,     'acnomprop'            = @acnomprop	
	              ,     'rut_empresa'          = @rut_empresa	
	              ,     'hora'                 = @hora		
                      ,     'fecha_busqueda'       = @fecha_busqueda  
         END
END




GO
