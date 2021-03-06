USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Listado_Bancos_Plazo]    Script Date: 16-05-2022 11:18:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Listado_Bancos_Plazo]
		(@INSTITUCION	NUMERIC(5))
AS
BEGIN
   
   SET DATEFORMAT dmy

  	DECLARE @acfecproc		CHAR	(10)
	,	@acfecprox		CHAR	(10)
	,	@uf_hoy			NUMERIC(21,4)
        ,	@uf_man			NUMERIC(21,4)
        ,	@ivp_hoy		NUMERIC(21,4)
	,	@ivp_man		NUMERIC(21,4)
	,	@do_hoy		NUMERIC(21,4)
	,	@do_man		NUMERIC(21,4)
	,	@da_hoy		NUMERIC(21,4)
        ,       @da_man         NUMERIC(21,4)
	,	@acnomprop	CHAR	(40)
	,	@rut_empresa	CHAR	(12)
	,	@hora		CHAR	(08)
	,	@monedacontrol	NUMERIC	(03)
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


	SELECT @monedacontrol = (SELECT moneda_control FROM DATOS_GENERALES)

IF EXISTS (SELECT * FROM   LINEA_POR_PLAZO  p,
			   CLIENTE          c,
			   GRUPO_PRODUCTO   d
	   	    WHERE  p.rut_cliente    = c.clrut
	   	    and	   p.codigo_cliente = c.clcodigo
		    and	   p.codigo_grupo   = d.codigo_grupo
		    and    (c.cltipcli	    = @Institucion or @Institucion=0)
		   )

BEGIN

   	SELECT   'hora_reporte'         = CONVERT(CHAR(10),GETDATE(),108   )
		,'fecha_reporte'        = CONVERT(CHAR(10),GETDATE(),103   )
                ,'fecha_proceso'        = @acfecproc
                ,'titulo'               = 'LINEAS DE CREDITO DE BANCOS E INST.FINANCIERAS POR PLAZO AL ' + CONVERT(CHAR(10),@acfecproc,103)
                ,'Rut Cliente'   	= c.clrut
	        ,'DV'            	= c.cldv
      		,'Nombre Cliente'	= c.clnombre
		,'TotalLinea'		= p.totalasignado
		,'TotalOcupado'		= p.totalocupado
		,'TotalDisponible'  	= p.totaldisponible
		,'TotalExceso'		= p.totalexceso
		,'PlazoDesde'		= p.plazodesde
		,'PlazoHasta'		= p.plazohasta
		,'codigo_grupo'		= p.codigo_grupo
		,'desccripcion'		= d.descripcion
	    	,'acfecprox'           = @acfecprox
	        ,'uf_hoy'               = @uf_hoy
                ,'uf_man'               = @uf_man
                ,'ivp_hoy'              = @ivp_hoy
	        ,'ivp_man'              = @ivp_man
	        ,'do_hoy'               = @do_hoy
	        ,'do_man'               = @do_man
	        ,'da_hoy'               = @da_hoy
                ,'da_man'               = @da_man
	        ,'acnomprop'    	= @acnomprop
	        ,'rut_empresa'          = @rut_empresa
	        ,'hora'                 = @hora
                ,'fecha_busqueda'       = @fecha_busqueda
                ,'total'                = CONVERT(CHAR(30),'TOTAL')
		,'monedacontrol'	= @monedacontrol
		,'nombremoneda'		= (SELECT mnnemo FROM MONEDA WHERE mncodmon = @monedacontrol)
	FROM
		LINEA_POR_PLAZO  p,
		CLIENTE          c,
		GRUPO_PRODUCTO	 d

	WHERE
		p.rut_cliente=	c.clrut
	and	p.codigo_cliente =c.clcodigo
	and	p.codigo_grupo = d.codigo_grupo
	and    (c.cltipcli	    = @Institucion or @Institucion=0)
        ORDER BY
                [Nombre Cliente]


END
ELSE
BEGIN
	SELECT
		 'hora_reporte'         = CONVERT(CHAR(10),GETDATE(),108   )
		,'fecha_reporte'        = CONVERT(CHAR(10),GETDATE(),103   )
                ,'fecha_proceso'        = @acfecproc
                ,'titulo'               = 'LINEAS DE CREDITO DE BANCOS E INST.FINANCIERAS POR PLAZO AL ' + CONVERT(CHAR(10),@acfecproc,103)
                ,'Rut Cliente'   	= ' '
	        ,'DV'            	= ' '
      		,'Nombre Cliente'	= ' '
		,'TotalLinea'		= ' '
		,'TotalOcupado'		= ' '
		,'TotalDisponible'  	= ' '
		,'TotalExceso'		= ' '
		,'PlazoDesde'		= ' '
		,'PlazoHasta'		= ' '
		,'codigo_grupo'		= ' '
		,'desccripcion'		= ' '
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
                ,'total'                = 'NO EXISTE INFORMACION'
		,'monedacontrol'	= @monedacontrol
		,'nombremoneda'		= (SELECT mnnemo FROM MONEDA WHERE mncodmon = @monedacontrol)
	
END
END


-- select * from LINEA_POR_PLAZO
/*
select * from cliente where clnombre like '%citi%'
select * from LINEA_POR_PLAZO where rut_cliente = 970080009*/





GO
