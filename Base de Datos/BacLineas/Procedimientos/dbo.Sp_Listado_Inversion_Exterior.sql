USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Listado_Inversion_Exterior]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO










-- sp_helptext sp_listado_inversion_exterior
CREATE PROCEDURE [dbo].[Sp_Listado_Inversion_Exterior]
    
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
IF EXISTS (SELECT * FROM   INVERSION_EXTERIOR I,
      CLIENTE        C
         WHERE  i.rut_cliente    = c.clrut
         and    i.codigo_cliente = c.clcodigo
      
     )
BEGIN
    SELECT 
   'Rut Cliente'    = c.clrut           
         ,'DV'             = c.cldv           
        ,'Nombre Cliente' = c.clnombre    
  ,'ArbitrajeSpot' = i.arbspo_total
  ,'ArbiOcupado'  = i.arbspo_ocupado
  ,'ArbiDisponible' = i.ArbSpo_Disponible 
  ,'ArbitrajeForward' = i.ArbFwd_Total  
  ,'ForwOcupado'  = i.ArbFwd_Ocupado 
  ,'ForwDisponible' = i.ArbFwd_Disponible 
  ,'InversionesExt' = i.InvExt_Total  
  ,'InverOcupado'  = i.InvExt_Ocupado
  ,'InverDisponible' = i.InvExt_Disponible
  ,'Plazo'  = i.plazo
  ,'FechaVencimiento' = i.fecha_vencimiento
  ,'FechaFinContrato' = i.fecha_fin_contrato
  
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
  INVERSION_EXTERIOR I,
      CLIENTE        C
 WHERE  i.rut_cliente    = c.clrut
  and   i.codigo_cliente = c.clcodigo
ORDER BY 'NOMBRE CLIENTE' ASC
END
ELSE
BEGIN
 SELECT 
   'Rut Cliente'    = 0           
         ,'DV'             = ''           
        ,'Nombre Cliente' = ''    
  ,'ArbitrajeSpot' = 0
  ,'ArbiOcupado'  = 0
  ,'ArbiDisponible' = 0
  ,'ArbitrajeForward' = 0
  ,'ForwOcupado'  = 0
  ,'ForwDisponible' = 0
  ,'InversionesExt' = 0
  ,'InverOcupado'  = 0
  ,'InverDisponible' = 0
  ,'Plazo'  = 0
  ,'FechaVencimiento' = ''
  ,'FechaFinContrato' = ''
  
  
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







GO
