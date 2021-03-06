USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INF_LIMITES_POSICION]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INF_LIMITES_POSICION] (
      @USUARIO CHAR(40)
      )
AS
BEGIN
  DECLARE  @acfecproc   char(10),
           @acfecprox   char(10),
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
    @oma  char(3)
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
    @oma  OUTPUT
 DECLARE @Fecha_Proceso  DATETIME
 SELECT @Fecha_Proceso  = acfecpro FROM meac
 SELECT  'Codigo_Moneda'  = vmcodigo,
  'Glosa_Moneda'  = mnglosa,
  'Limite_Posicion' = vmlimite,
  'Posicion_Actual' = vmposic,
  'Disponible'  = (vmlimite - vmposic) ,
  'Fecha_Proceso'  = CONVERT(CHAR(10),@Fecha_Proceso,103),
  'Hora'   = @Hora,
  'fecha_SERV'         = CONVERT( CHAR(10) , GETDATE(), 103),
  'acfecproc'        =@acfecproc,
    'acfecprox'         =@acfecprox,
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
  FROM  view_posicion_spt,
   view_moneda
  WHERE vmfecha = @Fecha_Proceso
  AND   vmcodigo = mnnemo
  ORDER BY vmcodigo
END

GO
