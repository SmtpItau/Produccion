USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_RETORNA_ENVIO]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SVC_RETORNA_ENVIO]
   (   @xOperacion   NUMERIC(9)
   ,   @xModulo      CHAR(3)
   )
AS
BEGIN

   SET NOCOUNT ON 

   IF @xModulo = 'BFW' --> BacForward
   BEGIN

      SELECT  mov.mofecha
           ,  mov.monumoper
           ,  mov.mocodpos1
           ,  mov.motipoper
           ,  mov.mocodigo
           ,  mov.mocodcli
           ,  mov.mofecvcto
           ,  mov.motipmoda
           ,  mov.momtomon1
           ,  mov.mocodmon1
           ,  mov.mocodmon2
           ,  mov.motipcam
           ,  mov.mofpagomn
           ,  mov.moestado
        INTO  #TMP_OPERACIONES
        FROM  BacFwdsuda.dbo.MFMO mov
       WHERE  monumoper    = @xOperacion
       UNION
      SELECT  mov.mofecha
           ,  mov.monumoper
           ,  mov.mocodpos1
           ,  mov.motipoper
           ,  mov.mocodigo
           ,  mov.mocodcli
           ,  mov.mofecvcto
           ,  mov.motipmoda
           ,  mov.momtomon1
           ,  mov.mocodmon1
           ,  mov.mocodmon2
           ,  mov.motipcam
           ,  mov.mofpagomn
           ,  mov.moestado
        FROM  BacFwdsuda.dbo.MFMOH mov
       WHERE  monumoper    = @xOperacion

      

      DECLARE @dFechaProceso   DATETIME
          SET @dFechaProceso   = (SELECT acfecproc FROM BacFwdsuda.dbo.MFAC with(nolock) )

      SELECT  'Fecha'             = mov.mofecha
         ,    'Tipo_Registro'     = 2
         ,    'Nivel_Registro'    = 1
         ,    'Descripcion'       = 'INGRESO'
         ,    'Folio_Contrato'    = mov.monumoper
         ,    'Fecha_Cierre'      = mov.mofecha
         ,    'Tipo_Operacion'    = 'Forward ' + LTRIM(RTRIM( mon2.mnnemo )) + '/' + LTRIM(RTRIM( mon1.mnnemo ))
         ,    'Tipo_Transaccion'  = CASE WHEN mov.mocodpos1 = 1 and mov.motipoper = 'C' THEN 'COM'
                                         WHEN mov.mocodpos1 = 1 and mov.motipoper = 'V' THEN 'VEN'
                                         WHEN mov.mocodpos1 = 3 and mov.motipoper = 'C' THEN 'PVP'
                                         WHEN mov.mocodpos1 = 3 and mov.motipoper = 'V' THEN 'PVR'
                                    END
         ,    'Rut_Contraparte'   = CONVERT(CHAR(10), SUBSTRING( LTRIM(RTRIM( mov.mocodigo )),1,10) + LTRIM(RTRIM( cli.cldv )))
         ,    'Codigo_Cliente'    = ISNULL(cof.clnumsinacofi, 0)
         ,    'Codigo_Suscripcion'= 1   -->   2 = No se suscribe el mismo día
         ,    'Fecha_Vencimiento' = mov.mofecvcto
         ,    'Modalidad'         = CASE WHEN mov.mocodpos1 = 1 and mov.motipmoda = 'C' THEN 1
                                         WHEN mov.mocodpos1 = 1 and mov.motipmoda = 'E' THEN 2
                                         WHEN mov.mocodpos1 = 3                         THEN 1
                                    END
         ,    'Monto_Nocional'    = mov.momtomon1
         ,    'Precio_Forward'    = CASE WHEN mov.mocodpos1 = 1 and mov.mocodmon1 = 13 and mov.mocodmon2 = 999 THEN CONVERT(NUMERIC(21,10), mov.motipcam)
                                         WHEN mov.mocodpos1 = 1 and mov.mocodmon1 = 13 and mov.mocodmon2 = 998 THEN CONVERT(NUMERIC(21,10), mov.motipcam)
                                         WHEN mov.mocodpos1 = 3                                                THEN CONVERT(NUMERIC(21,10), mov.motipcam)
                                    END
         ,    'Precio_Pactado'    = CASE WHEN mov.mocodpos1 = 1 and mov.mocodmon1 = 13 and mov.mocodmon2 = 999 THEN ROUND( mov.momtomon1 * mov.motipcam, 0)
                                         WHEN mov.mocodpos1 = 1 and mov.mocodmon1 = 13 and mov.mocodmon2 = 998 THEN ROUND( mov.momtomon1 * mov.motipcam, 4)
                                         WHEN mov.mocodpos1 = 3                                                THEN ROUND( mov.momtomon1 * mov.motipcam, 2)
                                    END
         ,    'Fecha_Pago'        = 1 --> mov.mofecvcto --> [1 = se paga el mismo deia del Vcto], [2 = Dia habil siguiente al vcto]
         ,    'Forma_Pago'        = pdcv.nCodigo
         ,    'Moneda_Comp'       = CASE WHEN mov.mocodpos1 = 1 and mov.mocodmon1 = 13 and mov.mocodmon2 = 999 AND mov.motipmoda = 'C' THEN 'USD'
                                         WHEN mov.mocodpos1 = 1 and mov.mocodmon1 = 13 and mov.mocodmon2 = 998 AND mov.motipmoda = 'C' THEN 'USD'
                                         ELSE                                                                                               ''
                                    END
         ,    'Tipo_Cambio'       = CASE WHEN mov.mocodpos1 = 1 THEN '01'
                                         WHEN mov.mocodpos1 = 3 THEN '02'
                                    END
      FROM    #TMP_OPERACIONES                              mov with(nolock)
              LEFT  JOIN BacParamSuda.dbo.CLIENTE           cli with(nolock) ON cli.clrut     = mov.mocodigo AND cli.clcodigo = mov.mocodcli
              LEFT  JOIN BacParamSuda.dbo.SINACOFI          cof with(nolock) ON cof.clrut     = cli.clrut    AND cof.clcodigo = cli.clcodigo
              LEFT  JOIN BacParamSuda.dbo.MONEDA           mon1 with(nolock) ON mon1.mncodmon = mov.mocodmon1
              LEFT  JOIN BacParamSuda.dbo.MONEDA           mon2 with(nolock) ON mon2.mncodmon = mov.mocodmon2
              LEFT  JOIN BacParamSuda.dbo.FPAGO_CODIGO_DCV pdcv with(nolock) ON pdcv.fPago    = mov.mofpagomn
      WHERE  ( (mov.mocodpos1     = 1) 
         OR    (mov.mocodpos1     = 3 AND mov.motipmoda = 'C')
             )
         AND (mov.moestado        = '')
         AND (mov.monumoper       = @xOperacion)

      UNION

      SELECT  'Fecha'             = mmod.cafecha
         ,    'Tipo_Registro'     = 3
         ,    'Nivel_Registro'    = 1
         ,    'Descripcion'       = 'MODIFICACIONES'
         ,    'Folio_Contrato'    = mmod.canumoper
         ,    'Fecha_Cierre'      = mmod.cafecha
         ,    'Tipo_Operacion'    = 'Forward ' + LTRIM(RTRIM( mon2.mnnemo )) + '/' + LTRIM(RTRIM( mon1.mnnemo ))
         ,    'Tipo_Transaccion'  = CASE WHEN mmod.cacodpos1 = 1 and mmod.catipoper = 'C' THEN 'COM'
                                         WHEN mmod.cacodpos1 = 1 and mmod.catipoper = 'V' THEN 'VEN'
                                         WHEN mmod.cacodpos1 = 3 and mmod.catipoper = 'C' THEN 'PVP'
                                         WHEN mmod.cacodpos1 = 3 and mmod.catipoper = 'V' THEN 'PVR'
                                    END
         ,    'Rut_Contraparte'   = CONVERT(CHAR(10), SUBSTRING( LTRIM(RTRIM( mmod.cacodigo )),1,10) + LTRIM(RTRIM( cli.cldv )))
         ,    'Codigo_Cliente'    = ISNULL(cof.clnumsinacofi, 0)
         ,    'Codigo_Suscripcion'= 1   -->   2 = No se suscribe el mismo día
         ,    'Fecha_Vencimiento' = mmod.cafecvcto
         ,    'Modalidad'         = CASE WHEN mmod.cacodpos1 = 1 and mmod.catipmoda = 'C' THEN 1
                                         WHEN mmod.cacodpos1 = 1 and mmod.catipmoda = 'E' THEN 2
                                         WHEN mmod.cacodpos1 = 3                          THEN 1
                                    END
         ,   'Monto_Nocional'     = mmod.camtomon1
         ,   'Precio_Forward'     = CASE WHEN mmod.cacodpos1 = 1 and mmod.cacodmon1 = 13 and mmod.cacodmon2 = 999 THEN CONVERT(NUMERIC(21,10), mmod.catipcam)
                                         WHEN mmod.cacodpos1 = 1 and mmod.cacodmon1 = 13 and mmod.cacodmon2 = 998 THEN CONVERT(NUMERIC(21,10), mmod.catipcam)
                                         WHEN mmod.cacodpos1 = 3                                                  THEN CONVERT(NUMERIC(21,10), mmod.catipcam)
                                    END
         ,   'Precio_Pactado'     = CASE WHEN mmod.cacodpos1 = 1 and mmod.cacodmon1 = 13 and mmod.cacodmon2 = 999 THEN ROUND( mmod.camtomon1 * mmod.catipcam, 0)
                                         WHEN mmod.cacodpos1 = 1 and mmod.cacodmon1 = 13 and mmod.cacodmon2 = 998 THEN ROUND( mmod.camtomon1 * mmod.catipcam, 4)
                                         WHEN mmod.cacodpos1 = 3                                                  THEN ROUND( mmod.camtomon1 * mmod.catipcam, 2)
                                    END
         ,   'Fecha_Pago'         = 1 --> mmod.cafecvcto --> [1 = se paga el mismo deia del Vcto], [2 = Dia habil siguiente al vcto]
         ,   'Forma_Pago'         = pdcv.nCodigo
         ,   'Moneda_Comp'        = CASE WHEN mmod.cacodpos1 = 1 and mmod.cacodmon1 = 13 and mmod.cacodmon2 = 999 AND mmod.catipmoda = 'C' THEN 'USD'
                                         WHEN mmod.cacodpos1 = 1 and mmod.cacodmon1 = 13 and mmod.cacodmon2 = 998 AND mmod.catipmoda = 'C' THEN 'USD'
                                         ELSE                                                                                               ''
                                    END
         ,   'Tipo_Cambio'        = CASE WHEN mmod.cacodpos1 = 1 THEN '01'
                                         WHEN mmod.cacodpos1 = 3 THEN '02'
                                    END
      FROM   BacFwdSuda.dbo.MFCA_LOG                      mmod with(nolock)
             INNER JOIN BacFwdSuda.dbo.MFCA               mcar with(nolock) ON mcar.canumoper = mmod.canumoper 
             INNER JOIN BacParamSuda.dbo.CLIENTE           cli with(nolock) ON cli.clrut      = mmod.cacodigo  AND cli.clcodigo = mmod.cacodcli
             LEFT  JOIN BacParamSuda.dbo.SINACOFI          cof with(nolock) ON cof.clrut      = cli.clrut      AND cof.clcodigo = cli.clcodigo
             INNER JOIN BacParamSuda.dbo.MONEDA           mon1 with(nolock) ON mon1.mncodmon  = mmod.cacodmon1
             INNER JOIN BacParamSuda.dbo.MONEDA           mon2 with(nolock) ON mon2.mncodmon  = mmod.cacodmon2
             INNER JOIN BacParamSuda.dbo.FPAGO_CODIGO_DCV pdcv with(nolock) ON pdcv.fPago     = mmod.cafpagomn
      WHERE  mmod.cafecmod       = @dFechaProceso
       and   mmod.canumoper      = @xOperacion

   END --> BFW --> BacForward


END

GO
