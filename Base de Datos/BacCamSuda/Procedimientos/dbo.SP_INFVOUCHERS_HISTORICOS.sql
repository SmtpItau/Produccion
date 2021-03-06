USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFVOUCHERS_HISTORICOS]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INFVOUCHERS_HISTORICOS]
   (   @dFecha   DATETIME   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @Proceso     DATETIME
       SET @Proceso     = (SELECT acfecpro FROM MEAC with(nolock) )

   SELECT 'acfecproc'   = acfecpro
   ,      'acfecprox'   = acfecprx
   ,      'UF_Hoy'      = CONVERT(FLOAT, 0)
   ,      'UF_Man'      = CONVERT(FLOAT, 0)
   ,      'IVP_Hoy'     = CONVERT(FLOAT, 0)
   ,      'IVP_Man'     = CONVERT(FLOAT, 0)
   ,      'DO_Hoy'      = CONVERT(FLOAT, 0)
   ,      'DO_Man'      = CONVERT(FLOAT, 0)
   ,      'DA_Hoy'      = CONVERT(FLOAT, 0)
   ,      'DA_Man'      = CONVERT(FLOAT, 0)
   ,      'acnomprop'   = acnombre
   ,      'rut_empresa' = RTRIM(CONVERT(CHAR(10),acrut)) + '-' + acdv
   INTO    #Parametros
   FROM    MEAC         with(nolock)
   
   IF @dFecha < @Proceso
   BEGIN
      DELETE FROM #Parametros

      INSERT INTO #Parametros
      SELECT 'acfecproc'   = acfecpro
      ,      'acfecprox'   = acfecprx
      ,      'UF_Hoy'      = CONVERT(FLOAT, 0)
      ,      'UF_Man'      = CONVERT(FLOAT, 0)
      ,      'IVP_Hoy'     = CONVERT(FLOAT, 0)
      ,      'IVP_Man'     = CONVERT(FLOAT, 0)
      ,      'DO_Hoy'      = CONVERT(FLOAT, 0)
      ,      'DO_Man'      = CONVERT(FLOAT, 0)
      ,      'DA_Hoy'      = CONVERT(FLOAT, 0)
      ,      'DA_Man'      = CONVERT(FLOAT, 0)
      ,      'acnomprop'   = acnombre
      ,      'rut_empresa' = RTRIM(CONVERT(CHAR(10),acrut)) + '-' + acdv
      FROM    MEACH        with(nolock)
      WHERE   acfecpro     = @dFecha
   END


   DECLARE @nRutBanco   NUMERIC(10)
   DECLARE @cDevBanco   CHAR(1)
   DECLARE @cNombanco   VARCHAR(50)

    SELECT @nRutBanco   = acrut
      ,    @cDevBanco   = acdv
      ,    @cNombanco   = acnombre
      FROM MEAC         with(nolock)

   -- RESCATA VALOR DE UF -------------------------------------------------------------- 
   UPDATE #Parametros SET UF_Hoy  = ISNULL(vmvalor, 0.0) FROM BacParamSuda.dbo.VALOR_MONEDA WHERE vmfecha = acfecproc AND vmcodigo = 998
   UPDATE #Parametros SET UF_Man  = ISNULL(vmvalor, 0.0) FROM BacParamSuda.dbo.VALOR_MONEDA WHERE vmfecha = acfecprox AND vmcodigo = 998
   --RESCATA VALOR DE IVP -------------------------------------------------------------- 
   UPDATE #Parametros SET IVP_Hoy = ISNULL(vmvalor, 0.0) FROM BacParamSuda.dbo.VALOR_MONEDA WHERE vmfecha = acfecproc AND vmcodigo = 997
   UPDATE #Parametros SET IVP_Man = ISNULL(vmvalor, 0.0) FROM BacParamSuda.dbo.VALOR_MONEDA WHERE vmfecha = acfecprox AND vmcodigo = 997
   --RESCATA VALOR DE DO  -------------------------------------------------------------- 
   UPDATE #Parametros SET DO_Hoy  = ISNULL(vmvalor, 0.0) FROM BacParamSuda.dbo.VALOR_MONEDA WHERE vmfecha = acfecproc AND vmcodigo = 994
   UPDATE #Parametros SET DO_Man  = ISNULL(vmvalor, 0.0) FROM BacParamSuda.dbo.VALOR_MONEDA WHERE vmfecha = acfecprox AND vmcodigo = 994
   --RESCATA VALOR DE DA  -------------------------------------------------------------- 
   UPDATE #Parametros SET DA_Hoy  = ISNULL(vmvalor, 0.0) FROM BacParamSuda.dbo.VALOR_MONEDA WHERE vmfecha = acfecproc AND vmcodigo = 995
   UPDATE #Parametros SET DA_Man  = ISNULL(vmvalor, 0.0) FROM BacParamSuda.dbo.VALOR_MONEDA WHERE vmfecha = acfecprox AND vmcodigo = 995

   IF @dFecha < @Proceso
   BEGIN

      SELECT acfecproc            = CONVERT(CHAR(10), par.acfecproc, 103)
         ,   acfecprox            = CONVERT(CHAR(10), par.acfecprox, 103)
         ,   uf_hoy               = par.uf_hoy
         ,   uf_man               = par.uf_man
         ,   ivp_hoy              = par.ivp_hoy
         ,   ivp_man              = par.ivp_man
         ,   do_hoy               = par.do_hoy
         ,   do_man               = par.do_man
         ,   da_hoy               = par.da_hoy
         ,   da_man               = par.da_man
         ,   acnomprop            = par.acnomprop
         ,   rut_empresa          = par.rut_empresa
         ,   hora                 = CONVERT(VARCHAR(10), GETDATE(), 108)

         ,   Numero_Voucher       = det.Numero_Voucher
         ,   Correlativo          = det.Correlativo
         ,   Cuenta               = det.Cuenta
         ,   Tipo_Monto           = det.Tipo_Monto
         ,   Monto                = det.Monto
         ,   glosa                = vou.glosa
         ,   Tipo_Voucher         = vou.Tipo_Voucher
         ,   Tipo_Operacion       = vou.Tipo_Operacion
         ,   Operacion            = vou.Operacion
         ,   glosi                = SUBSTRING( vou.Glosa,1, 43) + ' ' + CASE WHEN LEFT( vou.Tipo_Operacion,1) = 'D' THEN  ' ' ELSE ' ' END  
         ,   Rut                  = @nRutBanco
         ,   Dv                   = @cDevBanco
         ,   Nom                  = @cNombanco
         ,   Descripcion          = cta.Descripcion
         ,   Valor_Campo          = det.Valor_Campo
         ,   Cod_Corresponsal     = RIGHT( '00000000' + CONVERT( VARCHAR(08) , det.Codigo_Corresponsal ) , 8 )
         ,   morutcli             = ope.morutcli
         ,   monomcli             = ope.monomcli
         ,   cldv                 = cli.cldv
         ,   moticam              = ope.moticam 
         ,   vmorden              = ISNULL((SELECT vmorden FROM view_valor_moneda, view_moneda,meac WHERE vmfecha = acfecpro AND vmcodigo = mncodmon AND mnnemo = Valor_Campo),0)
      FROM   BacCamSuda.dbo.BAC_CNT_DETALLE_VOUCHER      det with(nolock)
             INNER JOIN BacCamSuda.dbo.BAC_CNT_VOUCHER   vou with(nolock) ON vou.numero_voucher = det.numero_voucher AND vou.tipo_operacion = det.tipo_operacion
             LEFT  JOIN BacParamSuda.dbo.PLAN_DE_CUENTA  cta with(nolock) ON cta.cuenta         = det.cuenta
             LEFT  JOIN BacCamSuda.dbo.MEMOH             ope with(nolock) ON ope.monumope       = vou.Operacion
             LEFT  JOIN BacParamSuda.dbo.CLIENTE         cli with(nolock) ON cli.clrut          = ope.morutcli and cli.clcodigo = ope.mocodcli
             LEFT  JOIN #Parametros                      par with(nolock) ON par.acfecproc      = vou.fecha_contable
      WHERE  vou.fecha_contable   = @dFecha
    ORDER BY vou.Numero_Voucher, det.Correlativo

   END ELSE
   BEGIN

      SELECT acfecproc            = CONVERT(CHAR(10), par.acfecproc, 103)
         ,   acfecprox            = CONVERT(CHAR(10), par.acfecprox, 103)
         ,   uf_hoy               = par.uf_hoy
         ,   uf_man               = par.uf_man
         ,   ivp_hoy              = par.ivp_hoy
         ,   ivp_man              = par.ivp_man
         ,   do_hoy               = par.do_hoy
         ,   do_man               = par.do_man
         ,   da_hoy               = par.da_hoy
         ,   da_man               = par.da_man
         ,   acnomprop            = par.acnomprop
         ,   rut_empresa          = par.rut_empresa
         ,   hora                 = CONVERT(VARCHAR(10), GETDATE(), 108)

         ,   Numero_Voucher       = det.Numero_Voucher
         ,   Correlativo          = det.Correlativo
         ,   Cuenta               = det.Cuenta
         ,   Tipo_Monto           = det.Tipo_Monto
         ,   Monto                = det.Monto
         ,   glosa                = vou.glosa
         ,   Tipo_Voucher         = vou.Tipo_Voucher
         ,   Tipo_Operacion       = vou.Tipo_Operacion
         ,   Operacion            = vou.Operacion
         ,   glosi                = SUBSTRING( vou.Glosa,1, 43) + ' ' + CASE WHEN LEFT( vou.Tipo_Operacion,1) = 'D' THEN  ' ' ELSE ' ' END  
         ,   Rut                  = @nRutBanco
         ,   Dv                   = @cDevBanco
         ,   Nom                  = @cNombanco
         ,   Descripcion          = cta.Descripcion
         ,   Valor_Campo          = det.Valor_Campo
         ,   Cod_Corresponsal     = RIGHT( '00000000' + CONVERT( VARCHAR(08) , det.Codigo_Corresponsal ) , 8 )
         ,   morutcli             = ope.morutcli
         ,   monomcli             = ope.monomcli
         ,   cldv                 = cli.cldv
         ,   moticam              = ope.moticam 
         ,   vmorden              = ISNULL((SELECT vmorden FROM view_valor_moneda, view_moneda,meac WHERE vmfecha = acfecpro AND vmcodigo = mncodmon AND mnnemo = Valor_Campo),0)
      FROM   BacCamSuda.dbo.BAC_CNT_DETALLE_VOUCHER      det with(nolock)
             INNER JOIN BacCamSuda.dbo.BAC_CNT_VOUCHER   vou with(nolock) ON vou.numero_voucher = det.numero_voucher AND vou.tipo_operacion = det.tipo_operacion
             LEFT  JOIN BacParamSuda.dbo.PLAN_DE_CUENTA  cta with(nolock) ON cta.cuenta         = det.cuenta
             LEFT  JOIN BacCamSuda.dbo.MEMO              ope with(nolock) ON ope.monumope       = vou.Operacion
             LEFT  JOIN BacParamSuda.dbo.CLIENTE         cli with(nolock) ON cli.clrut          = ope.morutcli and cli.clcodigo = ope.mocodcli
             LEFT  JOIN #Parametros                      par with(nolock) ON par.acfecproc      = vou.fecha_contable
      WHERE  vou.fecha_contable   = @dFecha
    ORDER BY vou.Numero_Voucher, det.Correlativo
   END


END
GO
