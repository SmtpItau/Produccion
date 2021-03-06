USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INF_POSICION_Y_PRECIOS_DE_MONEDAS]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INF_POSICION_Y_PRECIOS_DE_MONEDAS] (
       @usuario CHAR(40)
             )
AS
BEGIN
  DECLARE  @acfecproc   CHAR(10),
           @acfecprox   CHAR(10),
           @uf_hoy      float,
           @uf_man      float,
           @ivp_hoy     float,
           @ivp_man     float,
           @do_hoy      float,
           @do_man      float,
           @da_hoy      float,
           @da_man      float,
           @acnomprop   char(40),
           @rut_empresa char(12),
           @hora        char(8),
    @OMA  CHAR(3)
   EXECUTE Sp_Base_Del_Informe
           @acfecproc   OUTPUT,
           @acfecprox   OUTPUT,
           @uf_hoy      OUTPUT,
           @uf_man      OUTPUT,
           @ivp_hoy     OUTPUT,
           @ivp_man     OUTPUT,
           @do_hoy      OUTPUT,
           @do_man      OUTPUT,
           @da_hoy      OUTPUT,
           @da_man      OUTPUT,
           @acnomprop   OUTPUT,
           @rut_empresa OUTPUT,
           @hora        OUTPUT,
           @oMa         OUTPUT
 SELECT  'Codigo_Moneda'  = vmcodigo  ,
  'Descripcion'  = mnglosa  ,
  'Posicion_Anterior' = ROUND(vmposini,2)     ,
  'Paridad_Anterior' = ROUND(vmparmes,4) ,
  'Monto_Anterior' = ( CASE vmparmes WHEN 0 THEN 0 ELSE (ISNULL(ROUND(vmposini,2) / ROUND( vmparmes , 4), 0)) END ),
  'Posicion_Actual' = ROUND(vmposic,2) ,
  'Paridad_Actual' = ROUND(vmparmes,4) ,
  'Monto_Actual'  = ( CASE vmparmes WHEN 0 THEN 0 ELSE (ISNULL(ROUND(vmposic,2) / ROUND(vmparmes,4), 0)) END ), 
  'Fecha_Proceso'  = CONVERT( CHAR(10) ,(SELECT acfecpro FROM meac), 103),
  'Hora'   = @Hora,
  'fecha_SERV'         = CONVERT( CHAR(10) , GETDATE(), 103),
  'acfecproc'        = CONVERT( CHAR(10) ,(SELECT acfecpro FROM meac), 103), 
  'acfecprox'         = CONVERT( CHAR(10) ,(SELECT acfecprx FROM meac), 103), 
  'uf_hoy'        =@uf_hoy,
  'uf_man'        =@uf_man,
  'ivp_hoy'        =@ivp_hoy,
  'ivp_man'        =@ivp_man,
  'do_hoy'        =@do_hoy,
  'do_man'        =@do_man,
  'da_hoy'        =@da_hoy,
  'da_man'        =@da_man,
  'pmnomprop'        =@acnomprop,
  'rut_empresa'        =@rut_empresa,
  'usuario'  =@usuario
 FROM  view_posicion_spt ,
  view_moneda  ,
  MEAC
 WHERE  vmfecha = ACFECPRO
  AND   vmcodigo = mnnemo
 ORDER BY vmcodigo
END

GO
