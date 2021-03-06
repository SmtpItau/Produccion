USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFVOUCHERS_SGRU]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--SP_INFVOUCHERS_SGRU '2015-01-23'
--SP_INFVOUCHERS_SGRU '2016-01-23'


CREATE PROCEDURE [dbo].[SP_INFVOUCHERS_SGRU]
   (   @fecproc DATETIME   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @acnomprop  CHAR(40)
   DECLARE @acrutprop  NUMERIC(10)
   DECLARE @acdvprop   CHAR(1)
   DECLARE @acfecproc  DATETIME
   DECLARE @acfecprox  DATETIME

   SELECT  @acnomprop  = acnomprop 
      ,    @acdvprop   = acdigprop
      ,    @acrutprop  = acrutprop
      ,    @acfecproc  = acfecproc
      ,    @acfecprox  = acfecprox
   FROM    BacTraderSuda..MDAC with(nolock)

   SELECT 'cuenta'        = c.cuenta
   ,      'tipo_monto'    = d.tipo_monto
   ,      'MONTO'         = d.monto
   ,      'tipo_voucher'  = v.tipo_voucher
   ,      'GLOSA'         = CASE WHEN v.tipo_operacion IN ('RV', 'RC', 'RVA', 'RCA')           THEN SUBSTRING(v.glosa,1,45) + ' ' + v.tipo_operacion + ' ' + convert(char(5), v.fpagoentre) + ' ' + convert(char(5),v.condicion_pacto)
                                 WHEN v.tipo_operacion IN ('VI')                               THEN SUBSTRING(v.glosa,1,45) + ' ' + v.tipo_operacion + ' ' + convert(char(10),v.operacion)
                                 WHEN v.tipo_operacion IN ('CI', 'VI', 'DVCI', 'DVVI', 'DVIT') THEN SUBSTRING(v.glosa,1,45) + ' ' + v.tipo_operacion + ' ' + convert(char(5), v.fpago)      + ' ' + convert(char(5),v.condicion_pacto)
                                 WHEN v.tipo_operacion IN ('IB')                               THEN SUBSTRING(v.glosa,1,45) + ' ' + v.tipo_operacion + ' ' + convert(char(5), v.plazo)      + ' ' + v.clasificacion_cliente
                                 WHEN v.Tipo_Operacion IN ('DICO', 'DICA')                     THEN SUBSTRING(v.glosa,1,45) + ' ' + v.tipo_operacion + ' ' + convert(char(5), v.fpago)      + ' ' + v.clasificacion_cliente
                                 WHEN v.tipo_operacion IN ('CP', 'VP')                         THEN SUBSTRING(v.glosa,1,45) + ' ' + v.tipo_operacion + ' ' + v.fpago else  SUBSTRING(v.glosa,1,45) + ' ' + v.tipo_operacion + ' '
                            END
   ,       'descripcion'  = Descripcion
   ,       'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
   INTO    #VOUCHER_1
   FROM    BAC_CNT_VOUCHER                         v with(nolock) 
           INNER JOIN BAC_CNT_DETALLE_VOUCHER      d with(nolock) ON d.numero_voucher = v.numero_voucher
           LEFT  JOIN BacParamSuda..PLAN_DE_CUENTA c with(nolock) ON c.Cuenta         = d.Cuenta
   WHERE   v.Fecha_Ingreso = @fecproc
   
   --IF EXISTS(SELECT * FROM #VOUCHER_1 ) 
   --BEGIN

      SELECT    cuenta
      ,         tipo_monto
      ,         tipo_voucher
      ,         glosa
      ,         descripcion
      ,         'MONTO' = SUM(monto)
	  ,         'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
      INTO      #VOUCHER
      FROM      #VOUCHER_1 
      GROUP BY  cuenta, tipo_monto, tipo_voucher, glosa, Descripcion 

--end

  SELECT 'ACFECPROC'   = CONVERT(CHAR(10), @acfecproc, 103)
      ,      'ACFECPROX'   = CONVERT(CHAR(10), @acfecprox, 103)
      ,      'uf_hoy'        = 0.0 --> #PARAMETROS.uf_hoy
      ,      'uf_man'        = 0.0 --> #PARAMETROS.uf_man
      ,      'ivp_hoy'       = 0.0 --> #PARAMETROS.ivp_hoy
      ,      'ivp_man'       = 0.0 --> #PARAMETROS.ivp_man
      ,      'do_hoy'        = 0.0 --> #PARAMETROS.do_hoy
      ,      'do_man'        = 0.0 --> #PARAMETROS.do_man
      ,      'da_hoy'        = 0.0 --> #PARAMETROS.da_hoy
      ,      'da_man'        = 0.0 --> #PARAMETROS.da_man
      ,      'acnomprop'     = @acnomprop
      ,      'rut_empresa'   = @acrutprop
      ,      'HORA'        = CONVERT(varchar(10), GETDATE(), 108)
      ,      'RUT'         = @acrutprop
      ,      'DV'          = @acdvprop
      ,      'NOM'         = @acnomprop
      ,      'cuenta' = cuenta
      ,      'tipo_monto' = tipo_monto
      ,      'monto' = monto
      ,      'tipo_voucher' = tipo_voucher
      ,      'GLOSA' = GLOSA
      ,      'Descripcion' = Descripcion
      ,      'GLOSITA'   = SUBSTRING(glosa,1,50) 
      ,      'NUMERO_VOUCHER'   = ''
      ,      'CORRELATIVO'      = ''
      ,      'TIPO_OPERACION'   = ''
      ,      'OPERACION'        = ''
	  ,      'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
      FROM   #VOUCHER 
      ORDER BY GLOSA

   END
   
   --ELSE 
   --BEGIN
   --   --SELECT 'ACFECPROC'   = CONVERT(CHAR(10), @acfecproc, 103)
   --   --,      'ACFECPROX'   = CONVERT(CHAR(10), @acfecprox, 103)
   --   --,      uf_hoy             = 0.0 --> uf_hoy
   --   --,      uf_man             = 0.0 --> uf_man
   --   --,      ivp_hoy            = 0.0 --> ivp_hoy
   --   --,      ivp_man            = 0.0 --> ivp_man
   --   --,      do_hoy             = 0.0 --> do_hoy
   --   --,      do_man             = 0.0 --> do_man
   --   --,      da_hoy             = 0.0 --> da_hoy
   --   --,      da_man             = 0.0 --> da_man
   --   --,      acnomprop          = @acnomprop
   --   --,      rut_empresa        = @acrutprop
   --   --,      'HORA'             = CONVERT(VARCHAR(10), GETDATE(), 108)
   --   --,      'NUMERO_VOUCHER'   = ''
   --   --,      'CORRELATIVO'      = ''
   --   --,      'CUENTA'           = ''
   --   --,      'TIPO_MONTO'       = ''
   --   --,      'MONTO'            = ''
   --   --,      'TIPO_VOUCHER'     = ''
   --   --,      'TIPO_OPERACION'   = ''
   --   --,      'OPERACION'        = ''
   --   --,      'GLOSA_OPERACION'  = ''
   --   --,      'RUT'              = ''
   --   --,      'DV'               = ''
   --   --,      'NOM'              = ''
   --   --,      'DESCRIPCION'      = ''
   --   --,      'glosita'          = ' '


	  -- SELECT 'ACFECPROC'   = CONVERT(CHAR(10), @acfecproc, 103)
   --   ,      'ACFECPROX'   = CONVERT(CHAR(10), @acfecprox, 103)
   --   ,      'uf_hoy'        = 0.0 --> #PARAMETROS.uf_hoy
   --   ,      'uf_man'        = 0.0 --> #PARAMETROS.uf_man
   --   ,      'ivp_hoy'       = 0.0 --> #PARAMETROS.ivp_hoy
   --   ,      'ivp_man'       = 0.0 --> #PARAMETROS.ivp_man
   --   ,      'do_hoy'        = 0.0 --> #PARAMETROS.do_hoy
   --   ,      'do_man'        = 0.0 --> #PARAMETROS.do_man
   --   ,      'da_hoy'        = 0.0 --> #PARAMETROS.da_hoy
   --   ,      'da_man'        = 0.0 --> #PARAMETROS.da_man
   --   ,      'acnomprop'     = @acnomprop
   --   ,      'rut_empresa'   = @acrutprop
   --   ,      'HORA'        = CONVERT(varchar(10), GETDATE(), 108)
   --   ,      'RUT'         = ''
   --   ,      'DV'          = ''
   --   ,      'NOM'         = ''
   --   ,      'cuenta' = ''
   --   ,      'tipo_monto' = ''
   --   ,      'monto' = ''
   --   ,      'tipo_voucher' = ''
   --   ,      'GLOSA' = '																						'
   --   ,      'Descripcion' = ''
   --   ,      'GLOSITA'   = '																						'

   --   ,      'NUMERO_VOUCHER'   = ''
   --   ,      'CORRELATIVO'      = ''
   --   ,      'TIPO_OPERACION'   = ''
   --   ,      'OPERACION'        = ''

   --END

--END

GO
