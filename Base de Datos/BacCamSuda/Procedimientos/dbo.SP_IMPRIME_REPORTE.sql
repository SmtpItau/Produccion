USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_IMPRIME_REPORTE]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_IMPRIME_REPORTE] 
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
           @ParaQue     char(3)
   execute Sp_Base_Del_Informe
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
           @ParaQue     OUTPUT
 SELECT  Numero_Operacion  ,
  Mercado    ,
  Tipo_Operacion   ,
  Estado_Operacion  ,
  Nombre_Cliente   ,
  Monto    ,
  Monto_Pesos   ,
  Moneda    ,
  Moneda_Conversion  ,
  Tipo_Cambio_Cierre  ,
  Tipo_Cambio_Costo  ,
  Paridad_Cierre   ,
  Paridad_Costo   ,
  FP_Pagamos   ,
  FP_Recibimos   ,
  Fecha    ,
  Hora    ,
  Usuario    ,
  Terminal   ,
  'fecha_Proceso'  = (SELECT CONVERT (CHAR(10), acfecpro ,103) FROM MEAC),
  'FechaServ'      = CONVERT (CHAR(10), GETDATE(),103),
  'Hora_Impresion' = CONVERT(CHAR(08),GETDATE(),108),
  'acfecproc'   =@acfecproc,
    'acfecprox'          =@acfecprox,
    'uf_hoy'         =@uf_hoy,
    'uf_man'         =@uf_man,
    'ivp_hoy'         =@ivp_hoy,
    'ivp_man'                =@ivp_man,
    'do_hoy'         =@do_hoy,
    'do_man'         =@do_man,
    'da_hoy'         =@da_hoy,
    'da_man'         =@da_man,
    'pmnomprop'         =@acnomprop,
    'rut_empresa'                 =@rut_empresa
 FROM MOVIMIENTOS_IMPRESION
END

GO
