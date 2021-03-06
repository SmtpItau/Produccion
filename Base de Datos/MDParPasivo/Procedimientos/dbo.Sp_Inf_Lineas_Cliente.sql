USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Inf_Lineas_Cliente]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Sp_Inf_Lineas_Cliente]
      (
             @RUT_CLIENTE    NUMERIC(9)
        ,    @USUARIO        VARCHAR(15)
	,    @codigo	     NUMERIC(9)
      )
AS BEGIN
SET DATEFORMAT dmy
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
          
	SELECT @fecha_busqueda= (SELECT Fecha_Proceso FROM DATOS_GENERALES)

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

   IF EXISTS(SELECT 1 FROM LINEA_SISTEMA WHERE rut_cliente = @RUT_CLIENTE) 
      BEGIN
      SELECT  'SUPERRUT'             = STR(c.clrut) + '-' + c.cldv
      ,	      'clnombre'           = c.clnombre
      ,	      'rut_cliente'        = a.rut_cliente
      ,	      'codigo_cliente'     = a.codigo_cliente
      ,	      'fechaasignacion'    = b.fechaasignacion
      ,	      'fechavencimiento'   = b.fechavencimiento
      ,	      'fechafincontrato'   = b.fechafincontrato
      ,	      'bloqueado'          = b.bloqueado
      ,	      'totalasignado'      = b.totalasignado
      ,	      'totalocupado'       = b.totalocupado
      ,	      'totaldisponible'    = b.totaldisponible
      ,	      'totalexceso'        = b.totalexceso
      ,	      'totaltraspaso'      = b.totaltraspaso
      ,       'totalrecibido'      = b.totalrecibido
      ,	      'rutcasamatriz'      = b.rutcasamatriz
      ,	      'codigocasamatriz'   = b.codigocasamatriz
      ,	      'nombre_sistema'     = s.descripcion
      ,	      'fechaasignacion'    = a.fechaasignacion
      ,       'fechavencimiento'   = a.fechavencimiento
      ,	      'fechafincontrato'   = a.fechafincontrato
      ,	      'realizatraspaso'    = a.realizatraspaso
      ,	      'bloqueado'          = a.bloqueado
      ,	      'compartido'         = a.compartido
      ,	      'controlaplazo'      = a.controlaplazo
      ,	      'stotalasignado'      = a.totalasignado
      ,	      'stotalocupado'       = a.totalocupado
      ,	      'stotaldisponible'    = a.totaldisponible
      ,       'stotalexceso'        = a.totalexceso
      ,	      'stotaltraspaso'      = a.totaltraspaso
      ,	      'stotalrecibido'      = a.totalrecibido
      ,	      'ssinriesgoasignado'  = a.sinriesgoasignado
      ,	      'ssinriesgoocupado'   = a.sinriesgoocupado
      ,	      'ssinriesgodisponible'= a.sinriesgodisponible
      ,       'ssinriesgoexceso'    = a.sinriesgoexceso
      ,	      'sconriesgoasignado'  = a.conriesgoasignado
      ,	      'sconriesgoocupado'   = a.conriesgoocupado
      ,	      'sconriesgodisponible'= a.conriesgodisponible 
      ,	      'sconriesgoexceso'    = a.conriesgoexceso 
      ,       'FECHA_EMI' = CONVERT(CHAR(10) , GETDATE() , 103)
      ,       'HORA'      = CONVERT(CHAR(10) , GETDATE() , 108)
      ,       'FECHA_PRO' = @acfecproc
      ,       'TITULO'    = 'LINEAS GENERALES'

      ,     'acfecprox'            = @acfecprox	
      ,     'uf_hoy'               = @uf_hoy		
      ,     'uf_man'               = @uf_man		
      ,     'ivp_hoy'              = @ivp_hoy	
      ,     'ivp_man'              = @ivp_man	  
      ,     'do_hoy'               = @do_hoy		    
      ,     'do_man'               = @do_man		
      ,     'da_hoy'               = @da_hoy		
      ,     'da_man'  		   = @da_man         
      ,     'acnomprop'            = @acnomprop	
      ,  'rut_empresa'          = @rut_empresa	
      ,     'hora'                 = @hora		
      ,     'fecha_busqueda'       = @fecha_busqueda
      FROM    LINEA_SISTEMA a
      ,       LINEA_GENERAL b
      ,       CLIENTE       c
      ,       GRUPO_PRODUCTO   s
      ,       DATOS_GENERALES
      WHERE   a.rut_cliente = b.rut_cliente 
      AND     a.rut_cliente = c.clrut 
      AND     a.rut_cliente = @RUT_CLIENTE 
      AND     c.clrut       = @RUT_CLIENTE 
      AND     c.clcodigo    = @codigo
      AND     a.codigo_grupo  = s.codigo_grupo

   END ELSE BEGIN

      SELECT  'SUPERRUT'           = ' '
      ,	      'clnombre'           = ' '
      ,	      'rut_cliente'        = ' '
      ,	      'codigo_cliente'     = ' '
      ,	      'fechaasignacion'    = ' '
      ,	      'fechavencimiento'   = ' '
      ,	      'fechafincontrato'   = ' '
      ,	      'bloqueado'          = ' '
      ,	      'totalasignado'      = ' '
      ,	      'totalocupado'       = ' '
      ,	      'totaldisponible'    = ' '
      ,	      'totalexceso'        = ' '
      ,	      'totaltraspaso'      = ' '
      ,       'totalrecibido'      = ' '
      ,	      'rutcasamatriz'      = ' '
      ,	      'codigocasamatriz'   = ' '
      ,	      'nombre_sistema'     = ' '
      ,	      'fechaasignacion'    = ' '
      ,       'fechavencimiento'   = ' '
      ,	      'fechafincontrato'   = ' '
      ,	      'realizatraspaso'    = ' '
      ,	      'bloqueado'          = ' '
      ,	      'compartido'         = ' '
      ,	      'controlaplazo'      = ' '
      ,	      'stotalasignado'      = ' '
      ,	      'stotalocupado'       = ' '
      ,	      'stotaldisponible'    = ' '
      ,       'stotalexceso'        = ' '
      ,	      'stotaltraspaso'      = ' '
      ,	      'stotalrecibido'      = ' '
      ,	      'ssinriesgoasignado'  =' '
      ,	      'ssinriesgoocupado'   = ' '
      ,	      'ssinriesgodisponible'= ' '
      ,       'ssinriesgoexceso'    = ' '
      ,	      'sconriesgoasignado'  = ' '
      ,	      'sconriesgoocupado'   = ' '
      ,	      'sconriesgodisponible'= ' '
      ,	      'sconriesgoexceso'    = ' '
      ,       'FECHA_EMI' = CONVERT(CHAR(10) , GETDATE() , 103)
      ,       'HORA'      = CONVERT(CHAR(10) , GETDATE() , 108)
      ,       'FECHA_PRO' = @acfecproc
      ,       'TITULO'    = 'LINEAS GENERALES'

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

SET NOCOUNT OFF

END


-- SP_BACLinCreGen_BUSCA_TODOS_CASAMatriz

GO
