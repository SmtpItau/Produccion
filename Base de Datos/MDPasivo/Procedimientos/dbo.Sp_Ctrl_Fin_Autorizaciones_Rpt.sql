USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Ctrl_Fin_Autorizaciones_Rpt]    Script Date: 16-05-2022 11:18:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Ctrl_Fin_Autorizaciones_Rpt]

		(@FECHA     CHAR(8)='X'   ,
                 @USUARIO   CHAR(15)='X'  )
                 
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
        IF EXISTS (SELECT 1 FROM LINEA_AUTORIZACION)
	      BEGIN
   	      SELECT   'hora_reporte'         = CONVERT(CHAR(10),GETDATE(),108   )   
		      ,'fecha_reporte'        = CONVERT(CHAR(10),GETDATE(),103   ) 
                      ,'fecha_proceso'        = @acfecproc
                      ,'titulo'               = 'INFORME DE AUTORIZACIONES AL ' + CONVERT(CHAR(10),@fecha_busqueda,103)  
                      ,'Rut_Cliente'   	      = B.clrut      	    
	              ,'DV_Cli'               = B.cldv           
      		      ,'Nombre_Cliente'	      = B.clnombre  
                      ,'Operador'	      = A.Operador
                      ,'UsuarioAutorizo'      = A.UsuarioAutorizo
                      ,'NumeroOperacion'      = A.NumeroOperacion
                      ,'MontoAutorizo'        = A.MontoAutorizo
                      ,'Total_Sobre_Giro'     = A.MontoAutorizo
		      ,'Hora_Autorizacion'    = A.Hora_Autorizacion
                      ,'FechaAutorizo'        = A.FechaAutorizo
		
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

                     INTO #TEMP

	               FROM   LINEA_AUTORIZACION   A,
                              CLIENTE              B,
                              USUARIO              C
	               WHERE                                  
		               (C.usuario        = @USUARIO OR @USUARIO = 'X')
	                  AND  (A.rut_cliente    = B.clrut                 )
	                  AND  (A.codigo_cliente = B.clcodigo              )
	                  AND  (A.FechaAutorizo  = @FECHA OR @FECHA='X'     )

               
           IF NOT EXISTS (SELECT 1 FROM #TEMP)
	         BEGIN
	      SELECT  'hora_reporte'          = CONVERT(CHAR(10),GETDATE(),108   )   
		      ,'fecha_reporte'        = CONVERT(CHAR(10),GETDATE(),103   ) 
                      ,'fecha_proceso'        = @acfecproc
                      ,'titulo'               = 'INFORME DE AUTORIZACIONES AL ' + CONVERT(CHAR(10),@fecha_busqueda,103)  
                      ,'Rut_Cliente'   	      = ' '
	              ,'DV_Cli'               = ' '        
      		      ,'Nombre_Cliente'	      = ' '
  ,'Operador'	      = ' '
                      ,'UsuarioAutorizo'      = ' '
                      ,'NumeroOperacion'      = ' '
                      ,'MontoAutorizo'        = ' '
                      ,'Total_Sobre_Giro'     = ' '
		      ,'Hora_Autorizacion'    = ' '
                      ,'FechaAutorizo'        = ' '
		
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
	
            END ELSE BEGIN
               SELECT * FROM #TEMP
          END


	
        END ELSE BEGIN

	      SELECT  'hora_reporte'          = CONVERT(CHAR(10),GETDATE(),108   )   
		      ,'fecha_reporte'        = CONVERT(CHAR(10),GETDATE(),103   ) 
                      ,'fecha_proceso'        = @acfecproc
                      ,'titulo'               = 'INFORME DE AUTORIZACIONES AL ' + CONVERT(CHAR(10),@fecha_busqueda,103)  
                      ,'Rut_Cliente'   	      = ' '
	              ,'DV_Cli'               = ' '        
      		      ,'Nombre_Cliente'	      = ' '
                      ,'Operador'	      = ' '
                      ,'UsuarioAutorizo'      = ' '
                      ,'NumeroOperacion'      = ' '
                      ,'MontoAutorizo'        = ' '
                      ,'Total_Sobre_Giro'     = ' '
		      ,'Hora_Autorizacion'    = ' '
                      ,'FechaAutorizo'        = ' '
		
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
