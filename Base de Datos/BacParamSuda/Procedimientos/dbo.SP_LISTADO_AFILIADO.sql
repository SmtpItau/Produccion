USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTADO_AFILIADO]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LISTADO_AFILIADO]
   
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
   EXECUTE SP_BASE_DEL_INFORME
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
IF EXISTS (SELECT * FROM   LINEA_AFILIADO  A,  
      CLIENTE        C
         WHERE  a.rutcasamatriz    = c.clrut
         and    a.codigocasamatriz = c.clcodigo
      
     )
BEGIN
    SELECT 
   'Rut Cliente'    = c.clrut           
         ,'DV'             = c.cldv           
        ,'Nombre Cliente' = c.clnombre    
  ,'TotalLinea'  = a.totalasignado
  ,'TotalOcupado'  = a.totalocupado
  ,'TotalDisponible'   = a.totaldisponible
  ,'TotalExceso'  = a.totalexceso
  ,'SinLinea'  = a.sinriesgoasignado
  ,'SinOcupado'  = a.sinriesgoocupado
  ,'SinDisponible' = a.sinriesgodisponible
  ,'SinExceso'  = a.sinriesgoexceso
  ,'ConLinea'  = a.conriesgoasignado
  ,'ConOcupado'  = a.conriesgoocupado
  ,'ConDisponible' = a.conriesgodisponible
  ,'ConExceso'  = a.conriesgoexceso
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
  LINEA_AFILIADO A,  
  CLIENTE        C
 WHERE
  a.rutcasamatriz    = c.clrut
  and a.codigocasamatriz = c.clcodigo
  
ORDER BY 'NOMBRE CLIENTE' ASC
END
ELSE
BEGIN
 SELECT 
   'Rut Cliente'    = 0           
         ,'DV'             = ''           
        ,'Nombre Cliente' = ''    
  ,'TotalLinea'  = 0
  ,'TotalOcupado'  = 0
  ,'TotalDisponible'   = 0
  ,'TotalExceso'  = 0
  ,'SinLinea'  = 0
  ,'SinOcupado'  = 0
  ,'SinDisponible' = 0
  ,'SinExceso'  = 0
  ,'ConLinea'  = 0
  ,'ConOcupado'  = 0
  ,'ConDisponible' = 0
  ,'ConExceso'  = 0
  
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
 
--ORDER BY NOMBRE CLIENTE ASC
END
END

GO
