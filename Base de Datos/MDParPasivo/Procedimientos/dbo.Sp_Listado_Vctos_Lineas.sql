USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Listado_Vctos_Lineas]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Listado_Vctos_Lineas]
                  (    @fecha_DesdeX     CHAR(10)
                  ,    @fecha_hastaX     CHAR(10)
                  )
              
AS
BEGIN

   SET NOCOUNT OFF
   SET DATEFORMAT dmy

   DECLARE      @acfecproc	CHAR	(10)	
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
	,	@hora		CHAR	(8)	
        ,       @fecha_busqueda DATETIME
        ,       @fecha_proceso  DATETIME
        ,       @fecha_desde    DATETIME
        ,       @fecha_hasta    DATETIME
        ,       @titulo         CHAR    (100)        
	,	@Moneda		NUMERIC(3)

        SELECT @fecha_proceso   = Fecha_Proceso
             , @fecha_busqueda  = Fecha_Proceso
             , @fecha_desde     = @fecha_DesdeX
             , @fecha_hasta     = @fecha_HastaX

          FROM DATOS_GENERALES

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
   SET NOCOUNT OFF



   SET @titulo = 'VENCIMIENTOS DE LINEAS ' +  CASE WHEN @fecha_desde <> @fecha_hasta THEN 'DESDE EL ' +  CONVERT(CHAR(10),@fecha_desde,103)  + ' '
                                                 ELSE ' '
                                                 END + 'AL ' + CONVERT(CHAR(10),@fecha_hasta,103)   


	   
   SELECT @Moneda  = (SELECT MONEDA_CONTROL FROM DATOS_GENERALES)

   IF EXISTS (SELECT 1 FROM LINEA_GENERAL  g,		
			    CLIENTE        C

	   	    WHERE  g.rut_cliente    	= c.clrut
	   	    and	   g.codigo_cliente 	= c.clcodigo
		    and    g.fechavencimiento	>= @fecha_desde
                    and    g.fechavencimiento	<= @fecha_hasta
		   )

   BEGIN
   	SELECT   'hora_reporte'         = CONVERT(CHAR(10),GETDATE(),108   )   
		,'fecha_reporte'        = CONVERT(CHAR(10),GETDATE(),103   ) 
                ,'fecha_proceso'        = @acfecproc
                ,'titulo'               = @titulo 
		,'Rut Cliente'   	= CONVERT(FLOAT,c.clrut)
	        ,'DV'            	= '- ' + c.cldv           
      		,'Nombre Cliente'	= c.clnombre    
		,'TotalLinea'		= g.totalasignado
		,'TotalOcupado'		= g.totalocupado
		,'TotalDisponible'  	= g.totaldisponible
		,'TotalExceso'		= g.totalexceso
		,'FechaVencimiento'	= g.fechavencimiento
		
		/*RESCATA INFORMACION DE VALORES MONEDAS EXTERNA*/
 
	      	,'acfecprox'            = @acfecprox	
	        ,'uf_hoy'               = @uf_hoy		
                ,'uf_man'               = @uf_man		
                ,'ivp_hoy'              = @ivp_hoy	
	        ,'ivp_man'              = @ivp_man	
	        ,'do_hoy'               = @do_hoy		
	        ,'do_man'               = @do_man		
	        ,'da_hoy'               = @da_hoy		
                ,'da_man'               = @da_man         
	        ,'acnomprop'            = @acnomprop	
	        ,'rut_empresa'          = @rut_empresa	
	        ,'hora'                 = @hora		
                ,'fecha_busqueda'       = @fecha_busqueda   
                ,'total'                = CONVERT(CHAR(30),'TOTAL') 
		,'Moneda'		= @Moneda
		,'NombreMoneda'		= (SELECT MNNEMO FROM MONEDA WHERE MNCODMON = @moneda)

	FROM 
		LINEA_GENERAL  g,		
		CLIENTE        C

	WHERE
		g.rut_cliente		= c.clrut
	and	g.codigo_cliente	= c.clcodigo
	and     g.fechavencimiento	>= @fecha_desde
	and     g.fechavencimiento	<= @fecha_hasta
	

   END ELSE BEGIN
            
       SELECT   'hora_reporte'          = CONVERT(CHAR(10),GETDATE(),108   )   
		,'fecha_reporte'        = CONVERT(CHAR(10),GETDATE(),103   ) 
                ,'fecha_proceso'        = @acfecproc
                ,'titulo'               = @titulo 
                ,'Rut Cliente'   	= CONVERT(FLOAT,0)	   
	        ,'DV'            	= ' '           
      		,'Nombre Cliente'	= ' '    
		,'TotalLinea'		= 0.0
		,'TotalOcupado'		= 0.0
		,'TotalDisponible'  	= 0.0
		,'TotalExceso'		= 0.0
		,'FechaVencimiento'	= CONVERT(DATETIME,' ')
		
		/*RESCATA INFORMACION DE VALORES MONEDAS EXTERNA*/

	      	,'acfecprox'            = @acfecprox	
	        ,'uf_hoy'               = @uf_hoy		
                ,'uf_man'               = @uf_man		
                ,'ivp_hoy'              = @ivp_hoy	
	        ,'ivp_man'              = @ivp_man	
	        ,'do_hoy'               = @do_hoy		
	        ,'do_man'               = @do_man		
	        ,'da_hoy'               = @da_hoy		
                ,'da_man'               = @da_man         
                ,'acnomprop'            = @acnomprop	
	        ,'rut_empresa'          = @rut_empresa	
	        ,'hora'                 = @hora
                ,'fecha_busqueda'       = @fecha_busqueda   
                ,'total'                = CONVERT(CHAR(30),'NO EXISTE INFORMACION')     
		,'Moneda'		= @Moneda
		,'NombreMoneda'		= (SELECT MNNEMO FROM MONEDA WHERE MNCODMON = @moneda)
	
   END

END


GO
