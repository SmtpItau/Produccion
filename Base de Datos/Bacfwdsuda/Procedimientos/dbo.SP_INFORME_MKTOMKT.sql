USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORME_MKTOMKT]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_INFORME_MKTOMKT]
       (
         @Fecha                 DATETIME
       , @RutCliente            NUMERIC(10) = 0
       , @Codcliente            INT     = 0
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @dFechaProc         DATETIME
   DECLARE @dFecha             DATETIME
   DECLARE @iFound             INT

   SELECT @dFechaProc = acfecproc
      FROM BacFwdSuda..MFAC WITH (NOLOCK)

      SET @dFecha       = @Fecha --> @dFechaProc

      SET @iFound       = -1
   SELECT @iFound       = 0
     FROM BacParamSuda..VALOR_MONEDA_CONTABLE WITH (NoLock)
    WHERE Fecha         = @dFecha

    IF @iFound = -1
    BEGIN
      SELECT @dFecha = acfecante
        FROM BacFwdSuda..MFAC WITH (NoLock)
    END

    IF @Fecha = @dFechaProc
    BEGIN
        SELECT Contrato       = canumoper
             , Cliente        = SUBSTRING(clnombre,1,50)
             , RutCliente     = cacodigo
             , CodCliente     = cacodcli
             , Producto       = CASE WHEN cacodpos1 = 1 THEN 'SEGURO DE CAMBIO'
                                     WHEN cacodpos1 = 2 THEN 'ARBITRAJE FUTURO'
                                     WHEN cacodpos1 = 3 THEN 'SEGURO DE INFLACION'
                                END
             , TipoOperacion  = CASE WHEN catipoper = 'C' THEN 'COMPRA'       ELSE 'VENTA'          END
             , Modalidad      = CASE WHEN catipmoda = 'C' THEN 'COMPENSACION' ELSE 'ENTREGA FISICA' END
             , MonedaOpe      = Mn.mnnemo --> cacodmon1
             , MonedaCnv      = Mx.mnnemo --> cacodmon2
             , Nocional       = camtomon1
             , NocionalUSD    = caequusd1
             , NocionalCLP    = caequmon1
             , FechaVcto      = cafecvcto
             , PlazoVcto      = caplazo
             , PlazoResidual  = caplazovto
             , TasaFwd        = CaTasaSinteticaM1 * 100.0 -- CaTasaSinteticaM2 * 100.0
             , TasaUSD        = CaTasaSinteticaM2 * 100.0 -- CaTasaSinteticaM1 * 100.0
             , MkMkt          = fRes_Obtenido
             , tcContable     = CASE WHEN cacodmon1 = 999 THEN 1.0
                                     WHEN cacodmon1 = 998 THEN (SELECT vmvalor FROM BacParamSuda..VALOR_MONEDA WHERE vmfecha = @dFecha AND vmcodigo = cacodmon1)
                                                          ELSE                      ISNULL(Tipo_Cambio,1) 
                                END
             , ParidadPreFut  = catipcam --> fVal_Obtenido
             , FechaInicio    = cafecha
             , iProducto      = cacodpos1
             , iMoneda1       = cacodmon1
             , iMoneda2       = cacodmon2
             , FechaDatos     = CONVERT(CHAR(10),@Fecha,103)
             , FechaProceso   = CONVERT(CHAR(10),@dFechaProc,103)
             , FechaEmision   = CONVERT(CHAR(10),GETDATE(),103)
             , HoraEmision    = CONVERT(CHAR(10),GETDATE(),108)
          FROM BacFwdSuda..MFCA WITH (NoLock)
               LEFT JOIN BacParamSuda..VALOR_MONEDA_CONTABLE WITH (NoLock) ON Fecha         = @dFecha
                                                                          AND codigo_moneda = CASE WHEN cacodmon1 = 13 THEN 994 ELSE cacodmon1 END
               LEFT JOIN BacParamSuda..MONEDA Mn             WITH (NoLock) ON Mn.mncodmon   = cacodmon1
               LEFT JOIN BacParamSuda..MONEDA Mx             WITH (NoLock) ON Mx.mncodmon   = cacodmon2
               LEFT JOIN BacParamSuda..CLIENTE               WITH (NoLock) ON cacodigo      = clrut
                                                                          AND cacodcli      = clcodigo
         WHERE caestado     = ''
           AND @RutCliente IN ( cacodigo, 0 )
           AND @Codcliente IN ( cacodcli, 0 )
           AND cacodpos1   IN ( 1, 2, 3 )
         ORDER BY
               cacodpos1
             , cacodigo
             , catipoper
             , catipmoda

    END ELSE
    BEGIN
        SELECT Contrato    = canumoper
             , Cliente        = SUBSTRING(clnombre,1,50)
             , RutCliente     = cacodigo
             , CodCliente     = cacodcli
             , Producto       = CASE WHEN cacodpos1 = 1 THEN 'SEGURO DE CAMBIO'
                                     WHEN cacodpos1 = 2 THEN 'ARBITRAJE FUTURO'
                                     WHEN cacodpos1 = 3 THEN 'SEGURO DE INFLACION'
                                END
             , TipoOperacion  = CASE WHEN catipoper = 'C' THEN 'COMPRA'       ELSE 'VENTA'          END
             , Modalidad      = CASE WHEN catipmoda = 'C' THEN 'COMPENSACION' ELSE 'ENTREGA FISICA' END
             , MonedaOpe      = Mn.mnnemo --> cacodmon1
             , MonedaCnv      = Mx.mnnemo --> cacodmon2
             , Nocional       = camtomon1
             , NocionalUSD    = caequusd1
             , NocionalCLP    = caequmon1
             , FechaVcto      = cafecvcto
             , PlazoVcto      = caplazo
             , PlazoResidual  = caplazovto
             , TasaFwd        = CaTasaSinteticaM1 * 100.0 -- CaTasaSinteticaM2 * 100.0
             , TasaUSD        = CaTasaSinteticaM2 * 100.0 -- CaTasaSinteticaM1 * 100.0
             , MkMkt          = fRes_Obtenido
             , tcContable     = CASE WHEN cacodmon1 = 999 THEN 1.0
                                     WHEN cacodmon1 = 998 THEN (SELECT vmvalor FROM BacParamSuda..VALOR_MONEDA WHERE vmfecha = @dFecha AND vmcodigo = cacodmon1)
                                     ELSE                      ISNULL(Tipo_Cambio,1) 
                                END
             , ParidadPreFut  = catipcam --> fVal_Obtenido
             , FechaInicio    = cafecha
             , iProducto      = cacodpos1
             , iMoneda1       = cacodmon1
             , iMoneda2       = cacodmon2
             , FechaDatos     = CONVERT(CHAR(10),@Fecha,103)
             , FechaProceso   = CONVERT(CHAR(10),@dFechaProc,103)
             , FechaEmision   = CONVERT(CHAR(10),GETDATE(),103)
             , HoraEmision    = CONVERT(CHAR(10),GETDATE(),108)
          FROM BacFwdSuda..MFCARES WITH (NoLock)
               LEFT JOIN BacParamSuda..VALOR_MONEDA_CONTABLE WITH (NoLock) ON Fecha         = @dFecha
                                                                          AND codigo_moneda = CASE WHEN cacodmon1 = 13 THEN 994 ELSE cacodmon1 END
               LEFT JOIN BacParamSuda..MONEDA Mn             WITH (NoLock) ON Mn.mncodmon   = cacodmon1
               LEFT JOIN BacParamSuda..MONEDA Mx             WITH (NoLock) ON Mx.mncodmon   = cacodmon2
               LEFT JOIN BacParamSuda..CLIENTE               WITH (NoLock) ON cacodigo      = clrut
                                                                          AND cacodcli      = clcodigo
         WHERE CaFechaProceso  = @Fecha
           AND caestado        = ''
           AND @RutCliente    IN ( cacodigo, 0 )
           AND @Codcliente    IN ( cacodcli, 0 )
           AND cacodpos1      IN ( 1, 2, 3 )
         ORDER BY
               cacodigo
             , cacodcli
             , cacodpos1
             , catipoper
             , catipmoda
   END

END

GO
