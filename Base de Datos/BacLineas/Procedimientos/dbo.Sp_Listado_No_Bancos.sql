USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Listado_No_Bancos]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO







CREATE PROCEDURE [dbo].[Sp_Listado_No_Bancos]
			
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



IF EXISTS (SELECT * FROM   LINEA_GENERAL  S,		
			   CLIENTE        C
	   	    WHERE  s.rut_cliente    = c.clrut
	   	    and	   s.codigo_cliente = c.clcodigo
		    and    s.bloqueado	    = 'N'
---		    and    s.id_sistema	    = 'BTR'
		    and    c.cltipcli	    <>1
		   )

BEGIN

   	SELECT 
		 'Rut Cliente'   	= c.clrut      	    
	        ,'DV'            	= c.cldv           
      		,'Nombre Cliente'	= c.clnombre    
		,'TotalLinea'		= s.totalasignado
		,'TotalOcupado'		= s.totalocupado
		,'TotalDisponible'  	= s.totaldisponible
		,'TotalExceso'		= s.totalexceso
		,'FechaVencimiento'	= CONVERT( CHAR(10) , s.fechavencimiento , 103 )
		,'remuneracion_linea'   = s.remuneracion_linea

		
		/*RESCATA INFORMACION DE VALORES MONEDAS EXTERNA*/

	    	,'Fecha Proc'       = @acfecpro
		,'Fecha Prox'       = @acfecprx
      		,'UF Hoy'           = @uf_hoy
		,'UF Mañana'        = @uf_man
      		,'IVP Hoy'          = @ivp_hoy
      		,'IVP Mañana'       = @ivp_man
      		,'DolObs Hoy'       = @do_hoy
     		,'DolObs Mañana'    = @do_man
      		,'DolCie Hoy'       = @da_hoy
      		,'DolCie Mañana'    = @da_man
      		,'Nombre Empresa'   = @acnombre
      		,'Rut Empresa'      = @rut_empresa
      		,'Hora'             = @hora

	FROM 	LINEA_general  s,		
		CLIENTE        C
	WHERE	s.rut_cliente    = c.clrut
	 and	s.codigo_cliente = c.clcodigo
	 and    s.bloqueado	    = 'N'
--	 and    s.id_sistema	    = 'BTR'
	 and    c.cltipcli	    <>1
	 AND    ( s.totalocupado > 0 OR s.totalasignado > 0 )

ORDER BY 'NOMBRE CLIENTE' ASC
END
ELSE
BEGIN
	SELECT 
		 'Rut Cliente'   	= 0      	    
	        ,'DV'            	= ''           
      		,'Nombre Cliente'	= ''    
		,'TotalLinea'		= 0
		,'TotalOcupado'		= 0
		,'TotalDisponible'  	= 0
		,'TotalExceso'		= 0
		,'FechaVencimiento'	= ''
		,'remuneracion_linea'   = 0
		/*RESCATA INFORMACION DE VALORES MONEDAS EXTERNA*/

	    	,'Fecha Proc'       = @acfecpro
		,'Fecha Prox'       = @acfecprx
      		,'UF Hoy'           = @uf_hoy
		,'UF Mañana'        = @uf_man
      		,'IVP Hoy'          = @ivp_hoy
      		,'IVP Mañana'       = @ivp_man
      		,'DolObs Hoy'       = @do_hoy
     		,'DolObs Mañana'    = @do_man
      		,'DolCie Hoy'       = @da_hoy
      		,'DolCie Mañana'    = @da_man
      		,'Nombre Empresa'   = @acnombre
      		,'Rut Empresa'      = @rut_empresa
      		,'Hora'        = @hora
	
END
END



-- SELECT * FROM LINEA_GENERAL










GO
