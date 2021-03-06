USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_InformeInterfazSerie]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Sp_InformeInterfazSerie]
                  ( @Terminal   CHAR(20) )
AS BEGIN
SET DATEFORMAT dmy
SET NOCOUNT ON

	DECLARE	@acfecproc	CHAR   (10)
	,	@acfecprox	CHAR   (10)
	,	@uf_hoy		NUMERIC(21,04)
	,	@uf_man		NUMERIC(21,04)
	,	@ivp_hoy	NUMERIC(21,04)
	,	@ivp_man	NUMERIC(21,04)
	,	@do_hoy		NUMERIC(21,04)
	,	@do_man		NUMERIC(21,04)
	,	@da_hoy		NUMERIC(21,04)
	,	@da_man		NUMERIC(21,04)
	,	@nRutemp	NUMERIC(09,00)
	,	@acnomprop	CHAR   (40)
	,	@rut_empresa	CHAR   (12)
	,	@hora		CHAR   (08)
	,	@paso		CHAR   (01)
        ,       @fecha_busqueda DATETIME       

        SELECT @fecha_busqueda= Fecha_Proceso FROM DATOS_GENERALES


         EXECUTE Sp_Base_Del_Informe
              @acfecproc	  OUTPUT
         ,    @acfecprox	  OUTPUT
         ,    @uf_hoy	          OUTPUT
         ,    @uf_man	          OUTPUT
         ,    @ivp_hoy	          OUTPUT
         ,    @ivp_man	          OUTPUT
         ,    @do_hoy	          OUTPUT
         ,    @do_man	          OUTPUT
         ,    @da_hoy	          OUTPUT
         ,    @da_man	          OUTPUT
         ,    @acnomprop	  OUTPUT
         ,    @rut_empresa        OUTPUT
         ,    @hora               OUTPUT
         ,    @fecha_busqueda
      

         IF EXISTS ( SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'U' AND NAME = 'CARGA_INTERFAZ_SERIE' ) AND EXISTS ( SELECT 1 FROM CARGA_INTERFAZ_SERIE WHERE Terminal = @Terminal ) BEGIN

            SELECT Serie        
            ,      emisor      
            ,      'fecha_emision' = CONVERT(CHAR(10),fecha_emision,103)
            ,      tasa_emision 
            ,      tasa_real    
            ,      UM         
            ,      BASE    
            ,      Numero_Cupones 
            ,      Perido_Pago 
            ,      Estado     
            ,      'fecha_Informe' = CONVERT(CHAR(10),GETDATE(),103)
/*
            ,      'acfecproc'     = @acfecproc	  
            ,      'acfecprox'     = @acfecprox
            ,      'uf_hoy'        = @uf_hoy	
            ,      'uf_man'        = @uf_man	
            ,      'ivp_hoy'       = @ivp_hoy
            ,      'ivp_man'       = @ivp_man
            ,      'do_hoy'        = @do_hoy	
            ,      'do_man'        = @do_man	
            ,      'da_hoy'        = @da_hoy	
            ,      'da_man'        = @da_man	
            ,      'acnomprop'     = @acnomprop
            ,      'rut_empresa'   = @rut_empresa
            ,      'hora'          = @hora       
            ,      'fecha_busqueda'= @fecha_busqueda
*/
            ,      'Titulo'            = CASE WHEN Estado = 'OK' THEN 'INFORME DE SERIES CARGADAS EL DIA ' + @acfecproc
                                              ELSE 'INFORME DE SERIES CON PROBLEMAS EN LA CARGA EL DIA ' + @acfecproc
                                              END
            ,      'Existe'        = SPACE(50)


              FROM CARGA_INTERFAZ_SERIE
             WHERE Terminal = @Terminal
             ORDER BY   
                   Estado


         END ELSE BEGIN

            SELECT Serie           = ' '
            ,      emisor          = ' '
            ,      'fecha_emision' = ' '
            ,      tasa_emision    = ' '
            ,      tasa_real       = ' '
            ,      UM              = ' '
            ,      BASE            = ' '
            ,      Numero_Cupones  = ' '
            ,      Perido_Pago     = ' '
            ,      Estado          = ' '
            ,      'fecha_Informe' = CONVERT(CHAR(10),GETDATE(),103)
/*
            ,      'acfecproc'     = @acfecproc	  
            ,      'acfecprox'     = @acfecprox
            ,      'uf_hoy'        = @uf_hoy	
            ,      'uf_man'        = @uf_man	
            ,      'ivp_hoy'       = @ivp_hoy
            ,      'ivp_man'       = @ivp_man
            ,      'do_hoy'        = @do_hoy	
            ,      'do_man'        = @do_man	
            ,      'da_hoy'        = @da_hoy	
            ,      'da_man'        = @da_man	
            ,      'acnomprop'     = @acnomprop
            ,      'rut_empresa'   = @rut_empresa
            ,      'hora'          = @hora       
            ,      'fecha_busqueda'= @fecha_busqueda
*/
            ,      'Titulo'            = 'INFORME DE SERIES CARGADAS EL DIA ' + @acfecproc
            ,      'Existe'        = 'NO EXISTE INFORMACION'

         END

SET NOCOUNT OFF
END

GO
