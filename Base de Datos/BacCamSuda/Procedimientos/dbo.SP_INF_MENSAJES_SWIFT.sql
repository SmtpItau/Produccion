USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INF_MENSAJES_SWIFT]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INF_MENSAJES_SWIFT]
      (
          @OPERADOR      CHAR(15)
        , @TITULO        VARCHAR(100)
        , @COD_SWIFT     VARCHAR(15)
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
           @hora        char(8)
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
           @hora        OUTPUT
   SELECT DISTINCT
        'CODIGO_SWIFT'  = C.CODIGO_SWIFT 
      , 'CLIENTE'       = CL.CLNOMBRE
      , 'CODIGO_MONEDA' = MO.MNNEMO
      , 'FECHA_EMISION' = CONVERT ( CHAR(10), GETDATE(), 103 )
      , 'FECHA_PROCESO' = CONVERT ( CHAR(10), ME.acfecpro ,103 )
      , 'HORA'          = CONVERT ( CHAR(8) , GETDATE(), 108 )
      , 'USUARIO' = RTRIM(@OPERADOR) + ' / BAC - CAMBIO'
      , 'TITULO' = @TITULO
      , 'COD_SWIFT' = 'SWIFT ' + @COD_SWIFT
      , 'HECHO_POR' = 'HECHO POR'
      , 'AUTORIZADO' = 'AUTORIZADO'
      , 'CONTROL' = 'CONTROL'
      , 'REVISADO' = 'REVISADO'
      , 'APODERADO_1' = CA.apnombre
      , 'APODERADO_2' = CA.apnombre
      , 'NUM_OPERA'     = '0000'
      ,'uf_hoy'        =@uf_hoy
      ,'uf_man'        =@uf_man
      ,'ivp_hoy' =@ivp_hoy
      ,'ivp_man' =@ivp_man
      ,'do_hoy'  =@do_hoy
      ,'do_man'  =@do_man
      ,'da_hoy'  =@da_hoy
      ,'da_man'  =@da_man
   FROM VIEW_CORRESPONSAL        C
      , SWIFT_MOVIMIENTO         M
      , VIEW_CLIENTE             CL
      , VIEW_MONEDA              MO
      , MEAC                     ME
      , VIEW_CLIENTE_APODERADO   CA
   WHERE C.RUT_CLIENTE       = M.RUT_CLIENTE
     AND C.RUT_CLIENTE       = CLRUT 
     AND CLRUT               = M.RUT_CLIENTE 
     AND C.CODIGO_MONEDA     = MO.MNCODMON
     AND C.RUT_CLIENTE       = C.RUT_CLIENTE
     AND CA.aprutcli         = C.RUT_CLIENTE
END
GO
