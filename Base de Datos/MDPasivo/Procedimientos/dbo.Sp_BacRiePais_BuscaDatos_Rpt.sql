USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_BacRiePais_BuscaDatos_Rpt]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_BacRiePais_BuscaDatos_Rpt] 
AS
BEGIN
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
          
	--SELECT @fecha_busqueda= '20010101'

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

   SET NOCOUNT ON
   SET DATEFORMAT dmy

           IF EXISTS(SELECT 1 FROM RIESGO_PAIS) 
                BEGIN
		SELECT 	'hora_reporte'      = CONVERT(CHAR(10),GETDATE(),108   )   
		       ,'fecha_reporte'     = CONVERT(CHAR(10),GETDATE(),103   ) 
                       ,'fecha_proceso'     = @acfecproc
                       ,'titulo'            = 'RIESGO PAIS AL ' + CONVERT(CHAR(10),@acfecproc,103)  
		       ,'codigo_pais'       = codigo_pais
		       ,'nombre'            = nombre
		       ,'porcentaje'        = porcentaje
		       ,'totalasignado'     = totalasignado
		       ,'totalocupado'      = totalocupado
		       ,'totaldisponible'   = totaldisponible
		       ,'totalexceso'       = totalexceso
                       
	               ,'acfecprox'         = @acfecprox	
	               ,'uf_hoy'            = @uf_hoy		
                       ,'uf_man'            = @uf_man		
                       ,'ivp_hoy'           = @ivp_hoy	
	               ,'ivp_man'           = @ivp_man	
	               ,'do_hoy'            = @do_hoy		
	               ,'do_man'            = @do_man		
	               ,'da_hoy'            = @da_hoy		
                       ,'da_man'            = @da_man         
	               ,'acnomprop'         = @acnomprop	
	               ,'rut_empresa'       = @rut_empresa	
	               ,'hora'              = @hora		
                       ,'fecha_busqueda'    = @fecha_busqueda 

		FROM RIESGO_PAIS 
            END ELSE BEGIN
                SELECT  'hora_reporte'      = CONVERT(CHAR(10),GETDATE(),108   )   
		       ,'fecha_reporte'     = CONVERT(CHAR(10),GETDATE(),103   ) 
                       ,'fecha_proceso'     = @acfecproc
                       ,'titulo'            = 'RIESGO PAIS AL ' + CONVERT(CHAR(10),@acfecproc,103)  
		       ,'codigo_pais'       = ' '
		       ,'nombre'            = ' '
		       ,'porcentaje'        = 0.0000
		       ,'totalasignado'     = 0
		       ,'totalocupado'      = 0
		       ,'totaldisponible'   = 0
		       ,'totalexceso'       = 0
                       
	               ,'acfecprox'         = @acfecprox	
	               ,'uf_hoy'            = @uf_hoy		
                       ,'uf_man'            = @uf_man		
                       ,'ivp_hoy'           = @ivp_hoy	
	               ,'ivp_man'           = @ivp_man	
	               ,'do_hoy'            = @do_hoy		
	               ,'do_man'            = @do_man		
	               ,'da_hoy'            = @da_hoy		
                       ,'da_man'            = @da_man         
	               ,'acnomprop'         = @acnomprop	
	               ,'rut_empresa'       = @rut_empresa	
	               ,'hora'              = @hora		
                       ,'fecha_busqueda'    = @fecha_busqueda 
            
         END
	
	SET NOCOUNT OFF

END

















GO
