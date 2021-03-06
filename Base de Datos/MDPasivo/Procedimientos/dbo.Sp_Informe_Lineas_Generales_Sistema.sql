USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Informe_Lineas_Generales_Sistema]    Script Date: 16-05-2022 11:18:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Informe_Lineas_Generales_Sistema]
      (   @fecha_a_buscar   CHAR( 10 )
      )
AS
BEGIN
    
   SET DATEFORMAT DMY
   SET NOCOUNT ON 

   DECLARE @acfecproc	   CHAR   ( 10 )
      ,    @acfecprox	   CHAR   ( 10 )
      ,    @uf_hoy         NUMERIC( 21,4 )  
      ,    @uf_man         NUMERIC( 21,4 )   
      ,    @ivp_hoy        NUMERIC( 21,4 )   
      ,    @ivp_man        NUMERIC( 21,4 )   
      ,    @do_hoy	   NUMERIC( 21,4 )   
      ,    @do_man	   NUMERIC( 21,4 )   
      ,    @da_hoy	   NUMERIC( 21,4 ) 
      ,    @da_man         NUMERIC( 21,4 )  
      ,    @acnomprop	   CHAR   ( 40 )	
      ,    @rut_empresa    CHAR   ( 12 )	
      ,    @hora	   CHAR   ( 08 )	
      ,    @fecha_busqueda DATETIME


   SELECT @fecha_busqueda = CONVERT( DATETIME, @fecha_a_buscar )

   SET NOCOUNT ON

   EXECUTE Sp_Base_Del_Informe
           @acfecproc	   OUTPUT
      ,    @acfecprox	   OUTPUT
      ,    @uf_hoy	   OUTPUT
      ,    @uf_man	   OUTPUT
      ,    @ivp_hoy	   OUTPUT
      ,    @ivp_man	   OUTPUT
      ,    @do_hoy	   OUTPUT 
      ,    @do_man	   OUTPUT 
      ,    @da_hoy	   OUTPUT
      ,    @da_man         OUTPUT
      ,    @acnomprop	   OUTPUT
      ,    @rut_empresa	   OUTPUT
      ,    @hora	   OUTPUT
      ,    @fecha_busqueda 
   
   IF NOT EXISTS( SELECT 1 FROM LINEA_SISTEMA L, CLIENTE C
                  WHERE  L.rut_cliente    = C.clrut
                    AND  L.codigo_cliente = C.clcodigo )
   BEGIN

      GOTO VALORES_POR_DEFECTO

   END

   SET NOCOUNT OFF

   SELECT 'linea_credito'    = clnombre
      ,   'nombre_sistema'   = descripcion
      ,   'linea_asignada'   = totalasignado
      ,   'total_ocupado'    = totalocupado
      ,   'total_disponible' = totaldisponible
      ,   'total_exceso'     = totalexceso
      ,   'transferido'      = totaltraspaso
      ,   'recibido'         = totalrecibido
      ,   'bloqueado'        = CASE L.bloqueado WHEN 'S' THEN 'BLOQUEADO' ELSE ' ' END
      ,   'fecha_busqueda'   = CONVERT( CHAR( 10 ), @fecha_busqueda, 103 )
      ,   'fecha_proceso'    = CONVERT( CHAR( 10 ), @acfecproc     , 103 )
      ,   'fecha_emision'    = CONVERT( CHAR( 10 ), GETDATE()      , 103 )
      ,   'hora_emision'     = @hora
      ,   'do_hoy'           = @do_hoy
      ,   'uf_hoy'           = @uf_hoy
      ,   'ivp_hoy'          = @ivp_hoy
      ,   'do_cie'           = @do_man
      ,   'uf_cie'           = @uf_man
   FROM   LINEA_SISTEMA L
      ,   CLIENTE       C
      ,   GRUPO_PRODUCTO   S
   WHERE  L.rut_cliente    = C.clrut  
     AND  L.codigo_cliente = C.clcodigo
     AND  L.codigo_grupo   = S.codigo_grupo
   ORDER BY clnombre
   RETURN

VALORES_POR_DEFECTO:

   SET NOCOUNT OFF

   SELECT 'linea_credito'    = 'NO EXISTE INFORMACION.'
      ,   'nombre_sistema'   = ' '
      ,   'linea_asignada'   = ' '
      ,   'total_ocupado'    = ' '
      ,   'total_disponible' = ' '
      ,   'total_exceso'     = ' '
      ,   'transferido'      = ' '
      ,   'recibido'         = ' '
      ,   'bloqueado'        = ' '
      ,   'fecha_busqueda'   = CONVERT( CHAR( 10 ), @fecha_busqueda, 103 )
      ,   'fecha_proceso'    = CONVERT( CHAR( 10 ), @acfecproc     , 103 )
      ,   'fecha_emision'    = CONVERT( CHAR( 10 ), GETDATE()      , 103 )
      ,   'hora_emision'     = @hora
      ,   'do_hoy'           = @do_hoy
      ,   'uf_hoy'           = @uf_hoy
      ,   'ivp_hoy'          = @ivp_hoy
      ,   'do_cie'           = @do_man
      ,   'uf_cie'           = @uf_man

END






GO
