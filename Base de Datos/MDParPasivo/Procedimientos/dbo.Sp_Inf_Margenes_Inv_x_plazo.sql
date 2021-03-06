USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Inf_Margenes_Inv_x_plazo]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_Inf_Margenes_Inv_x_plazo] 
   (   @cUsuario   VARCHAR(15)   )
AS BEGIN



   	SET DATEFORMAT DMY
	SET NOCOUNT ON
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
	,	@hora		CHAR	(08)	
        ,       @fecha_busqueda DATETIME

        SELECT @fecha_busqueda = Fecha_Proceso
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

   SELECT    seriado
         ,   plazo_desde
         ,   plazo_hasta
         ,   porcentaje_asignado
         ,   TotalAsignado
         ,   TotalOcupado
         ,   TotalDisponible
         ,   TotalExceso
         ,   'Fecha'          = convert(char(10),@fecha_busqueda,103)
         ,   'Fecha_Proceso'  = @acfecproc
         ,   'Fecha_Emision'  = convert(char(10), getdate(),103)
         ,   'Hora'           = convert(char(8),  getdate(),108)
         ,   'Sistema'        = @cUsuario + ' / BAC-PARAMETROS'
         ,   'CodigoProducto' = (select descripcion from PRODUCTO where codigo_producto = a.codigo_producto)
         ,   'do_hoy'         = @do_hoy
         ,   'ivp_hoy'        = @ivp_hoy
         ,   'uf_hoy'         = @uf_hoy
         ,   'do_man'         = @do_man
         ,   'uf_man'         = @uf_man

   FROM      MARGEN_INVERSION_GLOBAL A
   GROUP BY  seriado
         ,   plazo_desde
         ,   plazo_hasta
         ,   porcentaje_asignado
         ,   totalasignado
         ,   totalocupado
         ,   totaldisponible
         ,   totalexceso
         ,   codigo_producto
END




GO
