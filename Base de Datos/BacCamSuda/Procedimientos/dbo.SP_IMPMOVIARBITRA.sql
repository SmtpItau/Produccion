USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_IMPMOVIARBITRA]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_IMPMOVIARBITRA] --1,'ADMINISTRA'
      (
         @ENTIDAD    NUMERIC(10)
        ,@OPERADOR   CHAR(30)
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
           @Codigo_Oma  Char(3) 
           
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
           @Codigo_Oma  OUTPUT
  DECLARE @XNOMPROP CHAR(50)
  DECLARE @XRUTPROP NUMERIC(09)
  DECLARE @XDIGPROP CHAR(01)
  SELECT @XNOMPROP = acnomprop,
         @XRUTPROP = acrutprop,
         @XDIGPROP = acdigprop
    FROM VIEW_MDAC
 IF @ENTIDAD > 0
 SELECT  'arbnumope'     = monumope,
  'arbtipope' = motipope,
  'arbfecha' = CASE  motipope  WHEN  'C'  THEN movaluta1
      ELSE  movaluta2 END ,
  'tipooperacion' = CASE  motipope  WHEN  'C'  THEN morecib
      ELSE  moentre END ,
  'arbnomcli' = monomcli,
  'arbcodmon' = mocodmon,
  'arbmtomex' = momonmo,
  'arbparida' = moparme,
  'arbticamx' = moticam,
  'arbmtomus' = moussme,
  'XRUTPROP' = @XRUTPROP,
  'XDIGPROP' = @XDIGPROP,
  'XNOMPROP' = @XNOMPROP, 
  'rcnombre' = rcnombre,
  'Usuario'  = @OPERADOR,
  'acfecproc' = @acfecproc,
  'acfecprox' = @acfecprox,
  'uf_hoy' = @uf_hoy,
  'uf_man' = @uf_man,
  'ivp_hoy' = @ivp_hoy,
  'ivp_man' = @ivp_man,
  'do_hoy' = @do_hoy,
  'do_man' = @do_man,
  'da_hoy' = @da_hoy,
  'da_man' = @da_man,
  'hora'  = @hora,
         'fecha_SERV'    =CONVERT( CHAR(10) , GETDATE(), 103) 
       
 FROM memo,VIEW_ENTIDAD
 WHERE moentidad = @ENTIDAD AND 
              moentidad = rccodcar AND 
              motipmer  = 'ARBI'   AND
             (moestatus = ' ' OR moestatus = 'M')
 ORDER BY morutcli
                ,mocodcli
                ,motipope
            
 END
  
 If @ENTIDAD = 0 BEGIN
 SELECT 'arbnumope'     = monumope,
  'arbtipope' = motipope,
  'arbfecha' = mofech,
  'tipooperacion' = CASE   motipope  WHEN  'C'  THEN morecib
      ELSE  moentre   END     ,
  'arbnomcli' = monomcli, 
  'arbcodmon' = mocodmon,
  'arbmtomex' = momonmo,
  'arbparida' = moparme,
  'arbticamx' = moticam,
  'arbmtomus' = moussme,
  'XRUTPROP'  = @XRUTPROP,
  'XDIGPROP' = @XDIGPROP,
  'XNOMPROP' = @XNOMPROP, 
  'rcnombre' = rcnombre,
  'Usuario' = @OPERADOR,
  'acfecproc' = @acfecproc,
  'acfecprox' = @acfecprox,
  'uf_hoy' = @uf_hoy,
  'uf_man' = @uf_man,
  'ivp_hoy' = @ivp_hoy,
  'ivp_man' = @ivp_man,
  'do_hoy' = @do_hoy,
  'do_man' = @do_man,
  'da_hoy' = @da_hoy,
  'da_man' = @da_man,
  'hora'  = @hora,
  'fecha_SERV' = CONVERT( CHAR(10) , GETDATE(), 103) 
 
 FROM memo ,VIEW_ENTIDAD-- BacTrader..mdrc
 WHERE  moentidad = rccodcar AND
              motipmer   = 'ARBI'   AND
             (moestatus  = ' ' OR moestatus = 'M')
 ORDER BY morutcli,mocodcli,motipope
END

GO
