USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Listado_Bancos_Plazo]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE PROCEDURE [dbo].[Sp_Listado_Bancos_Plazo]( @institucion	INT )
AS
BEGIN

	DECLARE @acfecpro    CHAR(10)
	DECLARE @acfecprx    CHAR(10)
	DECLARE @uf_hoy      FLOAT   
	DECLARE @uf_man      FLOAT   
	DECLARE @ivp_hoy     FLOAT   
	DECLARE @ivp_man     FLOAT   
	DECLARE @do_hoy      FLOAT   
	DECLARE @do_man      FLOAT   
	DECLARE @da_hoy      FLOAT   
	DECLARE @da_man      FLOAT   
	DECLARE @acnombre    CHAR(40)
	DECLARE @rut_empresa CHAR(12)
	DECLARE @hora        CHAR(8) 

	EXECUTE Sp_Base_Del_Informe
		@acfecpro    OUTPUT
		,   @acfecprx    OUTPUT
		,   @uf_hoy      OUTPUT
		,   @uf_man      OUTPUT
		,   @ivp_hoy     OUTPUT
		,   @ivp_man     OUTPUT
		,   @do_hoy      OUTPUT
		,   @do_man      OUTPUT
		,   @da_hoy      OUTPUT
		,   @da_man      OUTPUT
		,   @acnombre    OUTPUT
		,   @rut_empresa OUTPUT
		,   @hora        OUTPUT

	IF EXISTS(SELECT * FROM   
			linea_producto_por_plazo  p,		
			cliente        c
		   WHERE  p.rut_cliente    = c.clrut	and
			  p.codigo_cliente = c.clcodigo	and
			  (c.cltipcli	   = @Institucion or @Institucion=0)	
		   )
		BEGIN

			SELECT	'Rut Cliente'   	= c.clrut      	    
				,'DV'            	= c.cldv           
				,'Nombre Cliente'	= c.clnombre    
				,'TotalLinea'		= p.totalasignado
				,'TotalOcupado'		= p.totalocupado
				,'TotalDisponible'  	= p.totaldisponible
				,'TotalExceso'		= p.totalexceso
				,'PlazoDesde'		= p.plazodesde
				,'PlazoHasta'		= p.plazohasta
				,'Fecha Proc'       	= @acfecpro
				,'Fecha Prox'       	= @acfecprx
				,'UF Hoy'           	= @uf_hoy
				,'UF Mañana'        	= @uf_man
				,'IVP Hoy'          	= @ivp_hoy
				,'IVP Mañana'       	= @ivp_man
				,'DolObs Hoy'       	= @do_hoy
				,'DolObs Mañana'    	= @do_man
				,'DolCie Hoy'       	= @da_hoy
				,'DolCie Mañana'    	= @da_man
				,'Nombre Empresa'   	= @acnombre
				,'Rut Empresa'      	= @rut_empresa
				,'Hora'             	= @hora
				,'sistema_producto' 	= RTRIM( e.nombre_sistema ) + " - " + d.descripcion
			FROM	linea_producto_por_plazo	p,		
				cliente          		c,
				producto	 		d,
				sistema_cnt	 		e
			WHERE	p.rut_cliente	 = c.clrut				AND
				p.codigo_cliente = c.clcodigo				AND
				(c.cltipcli	 = @Institucion or @Institucion=0)	AND
				p.codigo_producto = d.codigo_producto			AND
				e.id_sistema	  = d.id_sistema			AND
				e.id_sistema	  = p.id_sistema
	
		END
	ELSE
		BEGIN
			SELECT	'Rut Cliente'   	= 0      	    
				,'DV'            	= ''           
				,'Nombre Cliente'	= ''    
				,'TotalLinea'		= 0
				,'TotalOcupado'		= 0
				,'TotalDisponible'  	= 0
				,'TotalExceso'		= 0
				,'PlazoDesde'		= 0
				,'PlazoHasta'		= 0
				,'Fecha Proc'       	= @acfecpro
				,'Fecha Prox'       	= @acfecprx
				,'UF Hoy'           	= @uf_hoy
				,'UF Mañana'        	= @uf_man
				,'IVP Hoy'          	= @ivp_hoy
				,'IVP Mañana'       	= @ivp_man
				,'DolObs Hoy'       	= @do_hoy
				,'DolObs Mañana'    	= @do_man
				,'DolCie Hoy'       	= @da_hoy
				,'DolCie Mañana'    	= @da_man
				,'Nombre Empresa'   	= @acnombre
				,'Rut Empresa'      	= @rut_empresa
				,'Hora'             	= @hora
				,'sistema_producto' 	= ''
	
		END

END

/*

 select * from producto
 select * from sistema_cnt

 Sp_Listado_Bancos_Plazo 1

 sp_autoriza_ejecutar 'bacuser'

*/





GO
