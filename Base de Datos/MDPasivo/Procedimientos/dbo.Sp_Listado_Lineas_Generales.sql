USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Listado_Lineas_Generales]    Script Date: 16-05-2022 11:18:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Listado_Lineas_Generales]
AS BEGIN
SET DATEFORMAT dmy
SET NOCOUNT ON
        DECLARE @acfecproc	CHAR	(10)	
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


IF EXISTS (SELECT * FROM   LINEA_SISTEMA  S,		
			   CLIENTE        C

	   	    WHERE  s.rut_cliente    = c.clrut
	   	    and	   s.codigo_cliente = c.clcodigo
--		    and    (s.id_sistema = 'BFW' or s.id_sistema = 'BFW') 
		    
		   )

BEGIN

   	SELECT 
		 'RutCliente'   	= c.clrut      	    
	        ,'DV'            	= c.cldv           
      		,'NombreCliente'	= c.clnombre    
		,'TotalLinea'		= s.totalasignado
		,'TotalOcupado'		= s.totalocupado
		,'TotalDisponible'  	= s.totaldisponible
		,'TotalExceso'		= s.totalexceso
		,'SinLinea'		= s.sinriesgoasignado
		,'SinOcupado'		= s.sinriesgoocupado
		,'SinDisponible'	= s.sinriesgodisponible
		,'SinExceso'		= s.sinriesgoexceso
		,'ConLinea'		= s.conriesgoasignado
		,'ConOcupado'		= s.conriesgoocupado
		,'ConDisponible'	= s.conriesgodisponible
		,'ConExceso'		= s.conriesgoexceso
		,'FechaVencimiento'	= s.fechavencimiento
		,'IdSistema'		= s.codigo_grupo
                ,'Titulo'               = 'INFORME DE LINEAS DE CREDITO GENERALES AL ' + CONVERT(CHAR(10),@acfecproc,103) + ' EN MM$'

		/*RESCATA INFORMACION DE VALORES MONEDAS EXTERNA*/

	    	,'FechaProc'       = CONVERT(CHAR(10),@acfecproc,103)
		,'FechaProx'       = CONVERT(CHAR(10),@acfecprox,103)
      		,'UFHoy'           = @uf_hoy
		,'UFMañana'        = @uf_man
      		,'IVPHoy'          = @ivp_hoy
      		,'DolObsHoy'       = @do_hoy
     		,'DolObsMañana'    = @do_man
      		,'Hora'             = @hora

	FROM 	LINEA_SISTEMA  S,		
		CLIENTE        C
	WHERE
		s.rut_cliente    = c.clrut
	 and	s.codigo_cliente = c.clcodigo
--  	 and    (s.id_sistema = 'BFW' or s.id_sistema = 'BFW')  
END
ELSE
BEGIN
	SELECT 
		 'RutCliente'   	= 0      	    
	        ,'DV'            	= ' '           
      		,'NombreCliente'	= ' '    
		,'TotalLinea'		= 0
		,'TotalOcupado'		= 0
		,'TotalDisponible'  	= 0
		,'TotalExceso'		= 0
		,'SinLinea'		= 0
		,'SinOcupado'		= 0
		,'SinDisponible'	= 0
		,'SinExceso'		= 0
		,'ConLinea'		= 0
		,'ConOcupado'		= 0
		,'ConDisponible'	= 0
		,'ConExceso'		= 0
		,'FechaVencmiento'	= ' '
		,'IdSistema'		= ' '
                ,'Titulo'               = 'INFORME DE LINEAS DE CREDITO GENERALES AL ' + CONVERT(CHAR(10),@acfecproc,103) + ' EN MM$'

		/*RESCATA INFORMACION DE VALORES MONEDAS EXTERNA*/

	    	,'FechaProc'       = @acfecproc
		,'FechaProx'       = @acfecprox
      		,'UFHoy'           = @uf_hoy
		,'UFMañana'        = @uf_man
      		,'IVPHoy'          = @ivp_hoy
      		,'DolObsHoy'       = @do_hoy
     		,'DolObsMañana'    = @do_man
      		,'Hora'             = @hora
	
END
SET NOCOUNT OFF
END

GO
