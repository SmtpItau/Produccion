USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Listado_Traspaso_Lineas]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO







CREATE PROCEDURE [dbo].[Sp_Listado_Traspaso_Lineas]
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



IF EXISTS (SELECT * FROM   LINEA_TRASPASO T,
			   CLIENTE        C,
			   SISTEMA_CNT 	  R,
			   SISTEMA_CNT	  A

	   	    WHERE  t.rut_cliente    = c.clrut
	   	    and	   t.codigo_cliente = c.clcodigo
		    and    t.id_sistema=r.id_sistema
		    and    t.sistemarecibio=a.id_sistema
		    	
		   )

BEGIN

   	SELECT 
		 'Rut Cliente'   	= c.clrut      	    
	        ,'DV'            	= c.cldv           
      		,'Nombre Cliente'	= c.clnombre    
		,'NumeroTraspaso'	= t.numerotraspaso
		,'SistemaTraspaso'	= r.nombre_sistema
		,'MontoTraspaso'	= t.montotraspasado
		,'SistemaRecibido'	= a.nombre_sistema
		,'FechaTraspaso'	= t.fechainicio
		,'HoraTraspaso'		= t.hora_traspaso
		,'UsuarioResponsable'	= t.usuarioautorizo
		,'FechaVencimiento'	= t.fechavencimiento
		,'Operador'		= t.operador


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

	FROM 
		LINEA_TRASPASO  T,		
		CLIENTE        C,
     		SISTEMA_CNT R,
		SISTEMA_CNT A

	WHERE
		t.rut_cliente	= c.clrut
	and	t.codigo_cliente= c.clcodigo
        and     t.id_sistema=r.id_sistema	
	and     t.sistemarecibio=a.id_sistema

END
ELSE
BEGIN
	SELECT 
		 'Rut Cliente'   	= 0      	    
	        ,'DV'            	= ''           
      		,'Nombre Cliente'	= ''    
		,'NumeroTraspaso'	= 0
		,'SistemaTraspaso'	= ''
		,'MontoTraspaso'	= 0
		,'SistemaRecibido'	= ''
		,'FechaTraspaso'	= ''
		,'HoraTraspaso'		= ''
		,'UsuarioResponsable'	= ''
		,'FechaVencimiento'	= ''
		,'Operador'		= ''

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
	
END
END


-- Sp_Listado_Traspaso_Lineas 'ADMINISTRA'






GO
