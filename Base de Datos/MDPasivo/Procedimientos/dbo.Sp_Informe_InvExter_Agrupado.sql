USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Informe_InvExter_Agrupado]    Script Date: 16-05-2022 11:18:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Sp_Informe_InvExter_Agrupado]
   (
       @USUARIO     VARCHAR(15) 
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
   IF EXISTS( SELECT 1 FROM   INVERSION_EXTERIOR
                       ,      CLIENTE         A
                       ,      DATOS_GENERALES
                       WHERE  rut_cliente = A.clrut )
   BEGIN

      SELECT  'rut_cliente'        =   ISNULL( rut_cliente        , 0  )
        ,     'DV_CLIENTE'         =   ISNULL( A.cldv             , 0  )
        ,     'codigo_cliente'     =   ISNULL( codigo_cliente     , 0  )
	,     'nombre'             =   ISNULL( nombre             , ' ')
	,     'plazo'              =   ISNULL( plazo              , 0  )
	,     'arbspo_total'       =   ISNULL( arbspo_total       , 0  )
	,     'arbspo_ocupado'     =   ISNULL( arbspo_ocupado     , 0  )
	,     'arbspo_disponible'  =   ISNULL( arbspo_disponible  , 0  )
	,     'arbspo_exceso'      =   ISNULL( arbspo_exceso      , 0  )
	,     'arbfwd_total'       =   ISNULL( arbfwd_total       , 0  )
	,     'arbfwd_ocupado'     =   ISNULL( arbfwd_ocupado     , 0  )
	,     'arbfwd_disponible'  =   ISNULL( arbfwd_disponible  , 0  )
	,     'arbfwd_exceso'      =   ISNULL( arbfwd_exceso      , 0  )
	,     'invext_total'       =   ISNULL( I.invext_total       , 0  )
	,     'invext_ocupado'     =   ISNULL( I.invext_ocupado     , 0  )
	,     'invext_disponible'  =   ISNULL( I.invext_disponible  , 0  )
	,     'arbext_exceso'      =   ISNULL( arbext_exceso      , 0  )
	,     'fecha_vencimiento'  =   ISNULL( fecha_vencimiento  , ' ')
	,     'fecha_fin_contrato' =   ISNULL( fecha_fin_contrato , ' ')
        ,     'fecha_proceso'      =   CONVERT( CHAR(10) , fecha_proceso  , 103 )
        ,     'fecha_emision'      =   CONVERT( CHAR(10) , GETDATE() , 103 )
        ,     'hora'               =   CONVERT( CHAR(10) , GETDATE() , 108 )

	,     'acfecprox'         = @acfecprox	
	,     'uf_hoy'            = @uf_hoy		
        ,     'uf_man'            = @uf_man		
        ,     'ivp_hoy'           = @ivp_hoy	
	,     'ivp_man'           = @ivp_man	
	,     'do_hoy'            = @do_hoy		
	,     'do_man'            = @do_man		
	,     'da_hoy'            = @da_hoy		
        ,     'da_man'            = @da_man         

        ,     'sistema'            =   @USUARIO  + ' ' + ' / MARGENES'
        ,     'TITULO'             =   'INVERSION EN EL  EXTERIOR AL ' + CONVERT( CHAR(10) , fecha_proceso  , 103 )       FROM    INVERSION_EXTERIOR   I
       ,      CLIENTE         A
       ,      DATOS_GENERALES
      WHERE   rut_cliente = A.clrut


   END ELSE
   BEGIN

      SELECT  'rut_cliente'        =   0
        ,     'DV_CLIENTE'         =   0
        ,     'codigo_cliente'     =   0
	,     'nombre'             =   ' '
	,     'plazo'              =   0   
	,     'arbspo_total'       =   0
	,     'arbspo_ocupado'     =   0
	,     'arbspo_disponible'  =   0
	,     'arbspo_exceso'      =   0
	,     'arbfwd_total'       =   0
	,     'arbfwd_ocupado'     =   0
	,     'arbfwd_disponible'  =   0   
	,     'arbfwd_exceso'      =   0
	,     'invext_total'       =   0 
	,     'invext_ocupado'     =   0
	,     'invext_disponible'  = 0
	,     'arbext_exceso'      =   0 
	,     'fecha_vencimiento'  =   ' ' 
	,     'fecha_fin_contrato' =   ' ' 
        ,     'fecha_proceso'      =   CONVERT( CHAR(10) , fecha_proceso  , 103 )
        ,     'fecha_emision'      =   CONVERT( CHAR(10) , GETDATE() , 103 )
        ,     'hora'               =   CONVERT( CHAR(10) , GETDATE() , 108 )

	,     'acfecprox'         = @acfecprox	
	,     'uf_hoy'            = @uf_hoy		
        ,     'uf_man'            = @uf_man		
        ,     'ivp_hoy'           = @ivp_hoy	
	,     'ivp_man'           = @ivp_man	
	,     'do_hoy'            = @do_hoy		
	,     'do_man'            = @do_man		
	,     'da_hoy'            = @da_hoy		
        ,     'da_man'            = @da_man         

        ,     'sistema'            =   @USUARIO  + ' ' + ' / MARGENES'
        ,     'TITULO'             =   'INVERSION EN EL  EXTERIOR AL ' + CONVERT( CHAR(10) , fecha_proceso  , 103 )       FROM    DATOS_GENERALES

   END
SET NOCOUNT OFF
END

GO
