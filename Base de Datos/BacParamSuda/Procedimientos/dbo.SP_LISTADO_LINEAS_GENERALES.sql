USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTADO_LINEAS_GENERALES]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LISTADO_LINEAS_GENERALES] 
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
 IF EXISTS ( SELECT  * 
   FROM    LINEA_SISTEMA  S,  
    CLIENTE        C
   WHERE   s.rut_cliente    = c.clrut
    and    s.codigo_cliente = c.clcodigo     
     )
  BEGIN
   SELECT 'Rut Cliente'     = c.clrut             ,
    'DV'              = c.cldv             ,
    'Nombre Cliente'  = c.clnombre      ,
    'TotalLinea'    = a.totalasignado/1000000 ,
    'TotalOcupado'   = a.totalocupado/1000000 ,
    'TotalDisponible'    = a.totaldisponible/1000000 ,
    'TotalExceso'    = a.totalexceso/1000000  ,
    'SinLinea'    = ISNULL( ( SELECT sinriesgoasignado/1000000  FROM LINEA_SISTEMA WHERE rut_cliente = c.clrut and codigo_cliente = c.clcodigo and id_sistema ='BTR' ) , 0 ) ,
    'SinOcupado'    = ISNULL( ( SELECT sinriesgoocupado/1000000   FROM LINEA_SISTEMA WHERE rut_cliente = c.clrut and codigo_cliente = c.clcodigo and id_sistema ='BTR' ) , 0 ) ,
    'SinDisponible'  = ISNULL( ( SELECT sinriesgodisponible/1000000 FROM LINEA_SISTEMA WHERE rut_cliente = c.clrut and codigo_cliente = c.clcodigo and id_sistema ='BTR' ) , 0 ) ,
    'SinExceso'    = ISNULL( ( SELECT sinriesgoexceso/1000000 FROM LINEA_SISTEMA WHERE rut_cliente = c.clrut and codigo_cliente = c.clcodigo and id_sistema ='BTR' ) , 0 ) ,
    'ConLinea'    = ISNULL( ( SELECT conriesgoasignado/1000000 FROM LINEA_SISTEMA WHERE rut_cliente = c.clrut and codigo_cliente = c.clcodigo and id_sistema ='BTR' ) , 0 ) ,
    'ConOcupado'    = ISNULL( ( SELECT conriesgoocupado/1000000 FROM LINEA_SISTEMA WHERE rut_cliente = c.clrut and codigo_cliente = c.clcodigo and id_sistema ='BTR' ) , 0 ) ,
    'ConDisponible'  = ISNULL( ( SELECT conriesgodisponible/1000000 FROM LINEA_SISTEMA WHERE rut_cliente = c.clrut and codigo_cliente = c.clcodigo and id_sistema ='BTR' ) , 0 ) ,
    'ConExceso'    = ISNULL( ( SELECT conriesgoexceso/1000000 FROM LINEA_SISTEMA WHERE rut_cliente = c.clrut and codigo_cliente = c.clcodigo and id_sistema ='BTR' ) , 0 ) ,
    'FechaVencimiento'  = a.fechavencimiento  ,
    'LineaTrader'    = ISNULL( ( SELECT TotalAsignado/1000000  FROM LINEA_SISTEMA WHERE rut_cliente = c.clrut and codigo_cliente = c.clcodigo and id_sistema ='BTR' ) , 0 ) ,
    'OcupadoTrader'  = ISNULL( ( SELECT TotalOcupado/1000000   FROM LINEA_SISTEMA WHERE rut_cliente = c.clrut and codigo_cliente = c.clcodigo and id_sistema ='BTR' ) , 0 ) ,
    'DisponibleTrader'  = ISNULL( ( SELECT TotalDisponible/1000000 FROM LINEA_SISTEMA WHERE rut_cliente = c.clrut and codigo_cliente = c.clcodigo and id_sistema ='BTR' ) , 0 ) ,
    'ExcesoTrader'   = ISNULL( ( SELECT TotalExceso/1000000  FROM LINEA_SISTEMA WHERE rut_cliente = c.clrut and codigo_cliente = c.clcodigo and id_sistema ='BTR' ) , 0 ) ,
    'LineaSpot'    = ISNULL( ( SELECT TotalAsignado/1000000  FROM LINEA_SISTEMA WHERE rut_cliente = c.clrut and codigo_cliente = c.clcodigo and id_sistema ='BCC' ) , 0 ) ,
    'OcupadoSpot'  = ISNULL( ( SELECT TotalOcupado/1000000   FROM LINEA_SISTEMA WHERE rut_cliente = c.clrut and codigo_cliente = c.clcodigo and id_sistema ='BCC' ) , 0 ) ,
    'DisponibleSpot'  = ISNULL( ( SELECT TotalDisponible/1000000 FROM LINEA_SISTEMA WHERE rut_cliente = c.clrut and codigo_cliente = c.clcodigo and id_sistema ='BCC' ) , 0 ) ,
    'ExcesoSpot'   = ISNULL( ( SELECT TotalExceso/1000000  FROM LINEA_SISTEMA WHERE rut_cliente = c.clrut and codigo_cliente = c.clcodigo and id_sistema ='BCC' ) , 0 ) ,
    'LineaFwd'    = ISNULL( ( SELECT TotalAsignado/1000000  FROM LINEA_SISTEMA WHERE rut_cliente = c.clrut and codigo_cliente = c.clcodigo and id_sistema ='BFW' ) , 0 ) ,
    'OcupadoFwd'  = ISNULL( ( SELECT TotalOcupado/1000000   FROM LINEA_SISTEMA WHERE rut_cliente = c.clrut and codigo_cliente = c.clcodigo and id_sistema ='BFW' ) , 0 ) ,
    'DisponibleFwd'  = ISNULL( ( SELECT TotalDisponible/1000000 FROM LINEA_SISTEMA WHERE rut_cliente = c.clrut and codigo_cliente = c.clcodigo and id_sistema ='BFW' ) , 0 ) ,
    'ExcesoFwd'   = ISNULL( ( SELECT TotalExceso/1000000  FROM LINEA_SISTEMA WHERE rut_cliente = c.clrut and codigo_cliente = c.clcodigo and id_sistema ='BFW' ) , 0 ) ,
--    'IdSistema'    = s.id_sistema   ,
    'Fecha Proc'        = @acfecpro   ,
    'Fecha Prox'        = @acfecprx   ,
    'UF Hoy'            = @uf_hoy   ,
    'UF Mañana'         = @uf_man   ,
    'IVP Hoy'           = @ivp_hoy   ,
    'IVP Mañana'        = @ivp_man   ,
    'DolObs Hoy'        = @do_hoy   ,
    'DolObs Mañana'     = @do_man   ,
    'DolCie Hoy'        = @da_hoy   ,
    'DolCie Mañana'     = @da_man   ,
     'Nombre Empresa'    = @acnombre   ,
    'Rut Empresa'       = @rut_empresa   ,
    'Hora'              = @hora
   FROM LINEA_GENERAL a ,
    CLIENTE         c
   WHERE a.rut_cliente    = c.clrut AND 
    a.codigo_cliente = c.clcodigo   AND
    ( a.totalasignado <> 0   OR 
      a.totalocupado  <> 0 )
   ORDER BY CLNOMBRE ASC
  END
 ELSE
  BEGIN
   SELECT 'Rut Cliente'     = 0            ,
    'DV'              = ''            ,
    'Nombre Cliente'  = ''     ,
    'TotalLinea'    = 0  ,
    'TotalOcupado'   = 0  ,
    'TotalDisponible'    = 0  ,
    'TotalExceso'    = 0  ,
    'SinLinea'    = 0  ,
    'SinOcupado'    = 0  ,
    'SinDisponible'  = 0  ,
    'SinExceso'    = 0  ,
    'ConLinea'    = 0  ,
    'ConOcupado'    = 0  ,
    'ConDisponible'  = 0  ,
    'ConExceso'    = 0  ,
    'FechaVencmiento'  = ''  ,
    'LineaTrader'    = 0  ,
    'OcupadoTrader'  = 0  ,
    'DisponibleTrader'  = 0  ,
    'ExcesoTrader'   = 0  ,
    'LineaSpot'    = 0  ,
    'OcupadoSpot'  = 0  ,
    'DisponibleSpot'  = 0  ,
    'ExcesoSpot'   = 0  ,
    'LineaFwd'    = 0  ,
    'OcupadoFwd'  = 0  ,
    'DisponibleFwd'  = 0  ,
    'ExcesoFwd'   = 0  ,
--    'IdSistema'    = ''  ,
    'Fecha Proc'        = @acfecpro ,
    'Fecha Prox'        = @acfecprx ,
    'UF Hoy'            = @uf_hoy ,
    'UF Mañana'         = @uf_man ,
    'IVP Hoy'           = @ivp_hoy ,
    'IVP Mañana'        = @ivp_man ,
    'DolObs Hoy'        = @do_hoy ,
    'DolObs Mañana'     = @do_man ,
    'DolCie Hoy'        = @da_hoy ,
    'DolCie Mañana'     = @da_man ,
    'Nombre Empresa'    = @acnombre ,
    'Rut Empresa'       = @rut_empresa ,
    'Hora'              = @hora
  END
END
-- select * from linea_general
-- select * from linea_sistema where id_sistema = 'BTR'

GO
