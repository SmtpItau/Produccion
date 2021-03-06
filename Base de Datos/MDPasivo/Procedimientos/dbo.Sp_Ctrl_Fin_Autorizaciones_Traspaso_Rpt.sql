USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Ctrl_Fin_Autorizaciones_Traspaso_Rpt]    Script Date: 16-05-2022 11:18:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Ctrl_Fin_Autorizaciones_Traspaso_Rpt]
		(@FECHA     CHAR(8)='X'   ,
                 @USUARIO   CHAR(15)='X'
                 )
                 
AS               
BEGIN

  SET DATEFORMAT dmy

  DECLARE       @acfecproc	CHAR	(10)	
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

        SELECT @fecha_busqueda= @FECHA

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
        IF EXISTS (SELECT 1 FROM LINEA_AUTORIZACION       A
	                  WHERE (A.UsuarioAutorizo = @USUARIO OR @USUARIO  = 'X')
	                    AND  A.FechaAutorizo   = @fecha_busqueda)
	      BEGIN
   	      SELECT   'hora_reporte'         = CONVERT(CHAR(10),GETDATE(),108   )   
		      ,'fecha_reporte'        = CONVERT(CHAR(10),GETDATE(),103   ) 
                      ,'fecha_proceso'        = @acfecproc
                      ,'titulo'               = 'INFORME DE EXCEPCIONES AL ' + CONVERT(CHAR(10),@fecha_busqueda,103)
                      ,'Rut_Cliente'   	      = A.Rut_Cliente
	              ,'DV_Cli'               = (SELECT cldv FROM CLIENTE WHERE clrut = rut_cliente AND clcodigo = A.codigo_Cliente)           
      		      ,'Nombre_Cliente'	      = (SELECT clnombre FROM CLIENTE WHERE clrut = rut_cliente AND clcodigo = A.codigo_Cliente)           
                      ,'Operador'	      = A.Operador
                      ,'NumeroOperacion'      = A.NumeroOperacion
                      ,'NumeroTraspaso'       = A.NumeroTraspaso
                      ,'MontoTraspasado'      = CONVERT(FLOAT,A.MontoAutorizo)
                      ,'FechaTraspaso'        = CONVERT(CHAR(10),A.FechaAutorizo ,103)
                      ,'Hora_Traspaso'        = A.Hora_Autorizacion
                      ,'UsuarioAutorizo'      = A.UsuarioAutorizo
                      ,'Codigo_Excepcion'     = A.Codigo_Excepcion
                      ,'descrip_excepcion'    = ISNULL((SELECT descripcion FROM EXCEPCION WHERE codigo_excepcion = A.codigo_excepcion),' ')
                      		
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
      
	               FROM   LINEA_AUTORIZACION       A
                              
	               WHERE (A.UsuarioAutorizo  = @USUARIO OR @USUARIO  = 'X')
	                  AND A.FechaAutorizo  = @fecha_busqueda
        END ELSE BEGIN

	      SELECT   'hora_reporte'         = CONVERT(CHAR(10),GETDATE(),108   )   
		      ,'fecha_reporte'        = CONVERT(CHAR(10),GETDATE(),103   ) 
                      ,'fecha_proceso'        = @acfecproc
                      ,'titulo'              = 'INFORME DE EXCEPCIONES AL ' + CONVERT(CHAR(10),@fecha_busqueda,103)
                      ,'Rut_Cliente'   	      = ' '
	              ,'DV_Cli'               = ' '        
      		      ,'Nombre_Cliente'	      = ' '
                      ,'Operador'	      = ' '
                      ,'NumeroOperacion'      = ' '
                      ,'NumeroTraspaso'       = ' '
                      ,'MontoTraspasado'      = ' '
                      ,'FechaTraspaso'        = ' '
                      ,'Hora_Traspaso'        = ' '
                      ,'UsuarioAutorizo'      = ' '
                      ,'Codigo_Excepcion'     = ' '
                      ,'descrip_excepcion'    = ' '
                      		
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
	
          END
SET NOCOUNT OFF
END









GO
