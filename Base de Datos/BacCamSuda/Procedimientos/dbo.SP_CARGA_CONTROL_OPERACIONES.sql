USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_CONTROL_OPERACIONES]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[SP_CARGA_CONTROL_OPERACIONES]
   (   @CodGerencia      NUMERIC(3)  = 0
   ,   @CodSubGerencia   NUMERIC(3)  = 0
   ,   @CodAgente        NUMERIC(3)  = 0
   ,   @Producto         CHAR(3)     = '' 
   ,   @SubProducto      VARCHAR(5)  = ''
   ,   @RutCliente       NUMERIC(10) = 0
   ,   @CodCliente       NUMERIC(9)  = 0
   ,   @FechaInicio      DATETIME    = '' 
   ,   @FechaTermino     DATETIME    = '' 
   ,   @Trader           VARCHAR(15) = ''
   ,   @Operador         VARCHAR(15) = ''
   )
AS
BEGIN

   SET NOCOUNT ON

   DELETE OPERACIONES_CTRL_TRADERS

   IF @Producto = 'BCC' or LEN(@Producto) = 0
   BEGIN
      -- ********************************************************** --
      -- ****   Operaciones PUENTE del Banco en la Corredora   **** --
      -- ********************************************************** --
      INSERT INTO OPERACIONES_CTRL_TRADERS
      SELECT 'FechaCarga'     = CONVERT(CHAR(10),GETDATE(),112)
      ,      'Modulo'         = 'BCC'
      ,      'Producto'       = motipmer
      ,      'RutCliente'     = morutcli
      ,      'CodCliente'     = mocodcli
      ,      'NumOperacion'   = monumope
      ,      'NumDocumento'   = 0
      ,      'NumCorrelativo' = 0
      ,      'TipoOperacion'  = motipope
      ,      'FechaInicio'    = mofech
      ,      'FechaTermino'   = case when motipope = 'C' then movaluta1 else movaluta2   end
      ,      'MontoInicial'   = momonmo
      ,      'Moneda'         = Mon.mncodmon
      ,      'MonedaCnv'      = Cnv.mncodmon
      ,      'Tasa'           = moticam
      ,      'ValorFinal'     = moussme    -- momonmo
      ,      'Operador'       = mooper
      ,      'HoraInicio'     = mohora
      ,      'CodGerencia'    = 0          -- @CodGerencia
      ,      'CodSubGerencia' = 0          -- @CodSubGerencia
      ,      'CodAgente'      = 0          -- @CodAgente
      ,      'TraderAsignado' = ''         -- @Trader
      ,      'Utilidad'       = CASE WHEN motipmer = 'EMPR' and mocodcnv  = 'USD' and mocodmon <> 'USD' and motipope = 'C' and Mon.mnrrda = 'M' THEN    (((moparme  -    mopartr)  * momonmo) * Obs.vmvalor)
                                     WHEN motipmer = 'EMPR' and mocodcnv  = 'USD' and mocodmon <> 'USD' and motipope = 'C' and Mon.mnrrda = 'D' THEN ((((1/moparme) - (1/mopartr)) * momonmo) * Obs.vmvalor)
                                     WHEN motipmer = 'EMPR' and mocodcnv  = 'USD' and mocodmon <> 'USD' and motipope = 'V' and Mon.mnrrda = 'M' THEN    (((mopartr  -    moparme)  * momonmo) * Obs.vmvalor)
                                     WHEN motipmer = 'EMPR' and mocodcnv  = 'USD' and mocodmon <> 'USD' and motipope = 'V' and Mon.mnrrda = 'D' THEN ((((1/mopartr) - (1/moparme)) * momonmo) * Obs.vmvalor)
                                     ELSE CASE WHEN                                   mocodmon  = 'USD' and motipope = 'C'                      THEN      (motctra  - moticam)     * momonmo
                                               WHEN                                   mocodmon  = 'USD' and motipope = 'V'                      THEN      (moticam  - motctra)     * momonmo
                                               WHEN                                   mocodmon <> 'USD' and motipope = 'C'                      THEN      (mopartr  - moparme)     *(momonmo  * Obs.vmvalor)
                                               WHEN                                   mocodmon <> 'USD' and motipope = 'V'                      THEN      (moparme  - mopartr)     *(momonmo  * Obs.vmvalor)
                                          END
                                END
      ,      'Margen'         = CASE WHEN motipmer = 'EMPR' and mocodcnv = 'USD' and mocodmon <> 'USD' and motipope = 'C' and Mon.mnrrda = 'M' THEN    (((moparme  -    mopartr)  * momonmo) * Obs.vmvalor)
                                     WHEN motipmer = 'EMPR' and mocodcnv = 'USD' and mocodmon <> 'USD' and motipope = 'C' and Mon.mnrrda = 'D' THEN ((((1/moparme) - (1/mopartr)) * momonmo) * Obs.vmvalor)
                                     WHEN motipmer = 'EMPR' and mocodcnv = 'USD' and mocodmon <> 'USD' and motipope = 'V' and Mon.mnrrda = 'M' THEN    (((mopartr  -    moparme)  * momonmo) * Obs.vmvalor)
                                     WHEN motipmer = 'EMPR' and mocodcnv = 'USD' and mocodmon <> 'USD' and motipope = 'V' and Mon.mnrrda = 'D' THEN ((((1/mopartr) - (1/moparme)) * momonmo) * Obs.vmvalor)
                                     ELSE CASE WHEN                                  mocodmon  = 'USD' and motipope = 'C'                      THEN      (motctra  - moticam)     * momonmo
                                               WHEN                                  mocodmon  = 'USD' and motipope = 'V'                      THEN      (moticam  - motctra)     * momonmo
                                               WHEN                                  mocodmon <> 'USD' and motipope = 'C'                      THEN      (mopartr  - moparme)     *(momonmo  * Obs.vmvalor)
                                               WHEN                                  mocodmon <> 'USD' and motipope = 'V'                      THEN      (moparme  - mopartr)     *(momonmo  * Obs.vmvalor)
                                          END
                                END
                              / moussme
      ,      'Codigo'         = 0
      ,      'ActEconomica'   = ISNULL(ae.Descripción,'SIN ACTIVIDAD ECONIMICA')
      ,      'Rubro'          = ISNULL(rb.Descripción,'SIN RUBRO')
      FROM   BacCamSuda..MEMO_PUENTE
                     LEFT JOIN bacparamsuda..MONEDA        Mon ON Mon.mnnemo        = mocodmon
                     LEFT JOIN bacparamsuda..MONEDA        Cnv ON Cnv.mnnemo        = mocodcnv
                     LEFT JOIN CLIENTE_ACTIVIDAD_ECONOMICA cac ON morutcli          = cac.RutCliente and mocodcli = cac.CodCliente
                     LEFT JOIN ACTIVIDAD_ECONOMICA         ae  ON cac.ActEconomica  = ae.CodActividad
                     LEFT JOIN RUBRO_ACTIVIDAD_ECONOMICA   rae ON cac.ActEconomica  = rae.CodActividad
                     LEFT JOIN RUBROS                      rb  ON rb.CodRubro       = rae.CodRubro
      ,      BacParamSuda..VALOR_MONEDA                    Obs
      WHERE  mofech       BETWEEN @FechaInicio AND @FechaTermino
      and    moestatus    = ''
      and    Obs.vmfecha  = mofech
      and    Obs.vmcodigo = 994
      and  ((morutcli     = @RutCliente  or @RutCliente  = 0)
        and (mocodcli     = @CodCliente  or @CodCliente  = 0))
      and   (motipmer     = @SubProducto or @SubProducto = '')
      and   (mooper       = @Operador    or @Operador    = '')
      and    UPPER(moterm)      NOT LIKE '%FORWARD%'
      and    UPPER(observacion) NOT LIKE '%PUENTE%'
      and    UPPER(observacion) NOT LIKE '%SWAP%'
      -- ********************************************************** --
      -- ****   Operaciones PUENTE del Banco en la Corredora   **** --
      -- ********************************************************** --

      -- Operaciones Normales de Spot, Excluyendo las Operaciones provenientes de Foward o que sean de Puente o Swap.
      INSERT INTO OPERACIONES_CTRL_TRADERS
      SELECT 'FechaCarga'     = CONVERT(CHAR(10),GETDATE(),112)
      ,      'Modulo'         = 'BCC'
      ,      'Producto'       = motipmer
      ,      'RutCliente'     = morutcli
      ,      'CodCliente'     = mocodcli
      ,      'NumOperacion'   = monumope
      ,      'NumDocumento'   = 0
      ,      'NumCorrelativo' = 0
      ,      'TipoOperacion'  = motipope
      ,      'FechaInicio'    = mofech
      ,      'FechaTermino'   = case when motipope = 'C' then movaluta1 else movaluta2   end
      ,      'MontoInicial'   = momonmo
      ,      'Moneda'         = Mon.mncodmon
      ,      'MonedaCnv'      = Cnv.mncodmon
      ,      'Tasa'           = moticam
      ,      'ValorFinal'     = moussme    -- momonmo
      ,      'Operador'       = mooper
      ,      'HoraInicio'     = mohora
      ,      'CodGerencia'    = 0          -- @CodGerencia
      ,      'CodSubGerencia' = 0          -- @CodSubGerencia
      ,      'CodAgente'      = 0          -- @CodAgente
      ,      'TraderAsignado' = ''         -- @Trader
      ,      'Utilidad'       = CASE WHEN motipmer = 'EMPR' and mocodcnv  = 'USD' and mocodmon <> 'USD' and motipope = 'C' and Mon.mnrrda = 'M' THEN    (((moparme  -    mopartr)  * momonmo) * Obs.vmvalor)
                                     WHEN motipmer = 'EMPR' and mocodcnv  = 'USD' and mocodmon <> 'USD' and motipope = 'C' and Mon.mnrrda = 'D' THEN ((((1/moparme) - (1/mopartr)) * momonmo) * Obs.vmvalor)
                                     WHEN motipmer = 'EMPR' and mocodcnv  = 'USD' and mocodmon <> 'USD' and motipope = 'V' and Mon.mnrrda = 'M' THEN    (((mopartr  -    moparme)  * momonmo) * Obs.vmvalor)
                                     WHEN motipmer = 'EMPR' and mocodcnv  = 'USD' and mocodmon <> 'USD' and motipope = 'V' and Mon.mnrrda = 'D' THEN ((((1/mopartr) - (1/moparme)) * momonmo) * Obs.vmvalor)
                                     ELSE CASE WHEN                                   mocodmon  = 'USD' and motipope = 'C'                      THEN      (motctra  - moticam)     * momonmo
                                               WHEN                                   mocodmon  = 'USD' and motipope = 'V'                      THEN      (moticam  - motctra)     * momonmo
                                               WHEN                                   mocodmon <> 'USD' and motipope = 'C'                      THEN      (mopartr  - moparme)     *(momonmo  * Obs.vmvalor)
                                               WHEN                                   mocodmon <> 'USD' and motipope = 'V'                      THEN      (moparme  - mopartr)     *(momonmo  * Obs.vmvalor)
                                          END
                                END
      ,      'Margen'         = CASE WHEN motipmer = 'EMPR' and mocodcnv = 'USD' and mocodmon <> 'USD' and motipope = 'C' and Mon.mnrrda = 'M' THEN    (((moparme  -    mopartr)  * momonmo) * Obs.vmvalor)
                                     WHEN motipmer = 'EMPR' and mocodcnv = 'USD' and mocodmon <> 'USD' and motipope = 'C' and Mon.mnrrda = 'D' THEN ((((1/moparme) - (1/mopartr)) * momonmo) * Obs.vmvalor)
                                     WHEN motipmer = 'EMPR' and mocodcnv = 'USD' and mocodmon <> 'USD' and motipope = 'V' and Mon.mnrrda = 'M' THEN    (((mopartr  -    moparme)  * momonmo) * Obs.vmvalor)
                                     WHEN motipmer = 'EMPR' and mocodcnv = 'USD' and mocodmon <> 'USD' and motipope = 'V' and Mon.mnrrda = 'D' THEN ((((1/mopartr) - (1/moparme)) * momonmo) * Obs.vmvalor)
                                     ELSE CASE WHEN                                  mocodmon  = 'USD' and motipope = 'C'                      THEN      (motctra  - moticam)     * momonmo
                                               WHEN                                  mocodmon  = 'USD' and motipope = 'V'                      THEN      (moticam  - motctra)     * momonmo
                                               WHEN                                  mocodmon <> 'USD' and motipope = 'C'                      THEN      (mopartr  - moparme)     *(momonmo  * Obs.vmvalor)
                                               WHEN                                  mocodmon <> 'USD' and motipope = 'V'                      THEN      (moparme  - mopartr)     *(momonmo  * Obs.vmvalor)
                                          END
                                END
                              / moussme
      ,      'Codigo'         = 0
      ,      'ActEconomica'   = ISNULL(ae.Descripción,'SIN ACTIVIDAD ECONIMICA')
      ,      'Rubro'          = ISNULL(rb.Descripción,'SIN RUBRO')
      FROM   BacCamSuda..MEMO
                     LEFT JOIN bacparamsuda..MONEDA        Mon ON Mon.mnnemo        = mocodmon
                     LEFT JOIN bacparamsuda..MONEDA        Cnv ON Cnv.mnnemo        = mocodcnv
                     LEFT JOIN CLIENTE_ACTIVIDAD_ECONOMICA cac ON morutcli          = cac.RutCliente and mocodcli = cac.CodCliente
                     LEFT JOIN ACTIVIDAD_ECONOMICA         ae  ON cac.ActEconomica  = ae.CodActividad
                     LEFT JOIN RUBRO_ACTIVIDAD_ECONOMICA   rae ON cac.ActEconomica  = rae.CodActividad
                     LEFT JOIN RUBROS                      rb  ON rb.CodRubro       = rae.CodRubro
      ,      BacParamSuda..VALOR_MONEDA                    Obs
      WHERE  mofech       BETWEEN @FechaInicio AND @FechaTermino
      and    moestatus    = ''
      and    Obs.vmfecha  = mofech
      and    Obs.vmcodigo = 994
      and  ((morutcli     = @RutCliente  or @RutCliente  = 0)
        and (mocodcli     = @CodCliente  or @CodCliente  = 0))
      and   (motipmer     = @SubProducto or @SubProducto = '')
      and   (mooper       = @Operador    or @Operador    = '')
      and    UPPER(moterm)      NOT LIKE '%FORWARD%'
      and    UPPER(observacion) NOT LIKE '%PUENTE%'
      and    UPPER(observacion) NOT LIKE '%SWAP%'

      INSERT INTO OPERACIONES_CTRL_TRADERS
      SELECT 'FechaCarga'     = CONVERT(CHAR(10),GETDATE(),112)
      ,      'Modulo'         = 'BCC'
      ,      'Producto'       = motipmer
      ,      'RutCliente'     = morutcli
      ,      'CodCliente'     = mocodcli
      ,      'NumOperacion'   = monumope
      ,      'NumDocumento'   = 0
      ,      'NumCorrelativo' = 0
      ,      'TipoOperacion'  = motipope
      ,      'FechaInicio'    = mofech
      ,      'FechaTermino'   = case when motipope = 'C' then movaluta1 else movaluta2 end
      ,      'MontoInicial'   = momonmo
      ,      'Moneda'         = Mon.mncodmon
      ,      'MonedaCnv'      = Cnv.mncodmon
      ,      'Tasa'           = moticam
      ,      'ValorFinal'     = moussme    -- momonmo 
      ,      'Operador'       = mooper
      ,      'HoraInicio'     = mohora
      ,      'CodGerencia'    = 0  -- @CodGerencia
      ,      'CodSubGerencia' = 0  -- @CodSubGerencia
      ,      'CodAgente'      = 0  -- @CodAgente
      ,      'TraderAsignado' = '' -- @Trader
      ,      'Utilidad'       = CASE WHEN motipmer = 'EMPR' and mocodcnv  = 'USD' and mocodmon <> 'USD' and motipope = 'C' and Mon.mnrrda = 'M' THEN    (((moparme  -    mopartr)  * momonmo) * Obs.vmvalor)
                                     WHEN motipmer = 'EMPR' and mocodcnv  = 'USD' and mocodmon <> 'USD' and motipope = 'C' and Mon.mnrrda = 'D' THEN ((((1/moparme) - (1/mopartr)) * momonmo) * Obs.vmvalor)
                                     WHEN motipmer = 'EMPR' and mocodcnv  = 'USD' and mocodmon <> 'USD' and motipope = 'V' and Mon.mnrrda = 'M' THEN    (((mopartr  -    moparme)  * momonmo) * Obs.vmvalor)
                                     WHEN motipmer = 'EMPR' and mocodcnv  = 'USD' and mocodmon <> 'USD' and motipope = 'V' and Mon.mnrrda = 'D' THEN ((((1/mopartr) - (1/moparme)) * momonmo) * Obs.vmvalor)
                                     ELSE CASE WHEN                                   mocodmon  = 'USD' and motipope = 'C'                      THEN      (motctra  - moticam)     * momonmo
                                               WHEN                                   mocodmon  = 'USD' and motipope = 'V'                      THEN      (moticam  - motctra)     * momonmo
                                               WHEN                                   mocodmon <> 'USD' and motipope = 'C'                      THEN      (mopartr  - moparme)     *(momonmo  * Obs.vmvalor)
                                               WHEN                                   mocodmon <> 'USD' and motipope = 'V'                      THEN      (moparme  - mopartr)     *(momonmo  * Obs.vmvalor)
                 END
                                END
      ,      'Margen'         = CASE WHEN motipmer = 'EMPR' and mocodcnv = 'USD' and mocodmon <> 'USD' and motipope = 'C' and Mon.mnrrda = 'M' THEN    (((moparme  -    mopartr)  * momonmo) * Obs.vmvalor)
                                     WHEN motipmer = 'EMPR' and mocodcnv = 'USD' and mocodmon <> 'USD' and motipope = 'C' and Mon.mnrrda = 'D' THEN ((((1/moparme) - (1/mopartr)) * momonmo) * Obs.vmvalor)
                                     WHEN motipmer = 'EMPR' and mocodcnv = 'USD' and mocodmon <> 'USD' and motipope = 'V' and Mon.mnrrda = 'M' THEN    (((mopartr  -    moparme)  * momonmo) * Obs.vmvalor)
                                     WHEN motipmer = 'EMPR' and mocodcnv = 'USD' and mocodmon <> 'USD' and motipope = 'V' and Mon.mnrrda = 'D' THEN ((((1/mopartr) - (1/moparme)) * momonmo) * Obs.vmvalor)
                                     ELSE CASE WHEN                                  mocodmon  = 'USD' and motipope = 'C'                      THEN      (motctra  - moticam)     * momonmo
                                               WHEN                                  mocodmon  = 'USD' and motipope = 'V'                      THEN      (moticam  - motctra)     * momonmo
                                               WHEN                                  mocodmon <> 'USD' and motipope = 'C'                      THEN      (mopartr  - moparme)     *(momonmo  * Obs.vmvalor)
                                               WHEN                                  mocodmon <> 'USD' and motipope = 'V'                      THEN      (moparme  - mopartr)     *(momonmo  * Obs.vmvalor)
                                          END
                                END
                              / moussme
      ,      'Codigo'         = 0
      ,      'ActEconomica'   = isnull(ae.Descripción,'SIN ACTIVIDAD ECONIMICA')
      ,      'Rubro'          = isnull(rb.Descripción,'SIN RUBRO')
      FROM   BacCamSuda..MEMOH
                     LEFT JOIN bacparamsuda..MONEDA Mon        ON Mon.mnnemo = mocodmon
                     LEFT JOIN bacparamsuda..MONEDA Cnv        ON Cnv.mnnemo = mocodcnv
                     LEFT JOIN CLIENTE_ACTIVIDAD_ECONOMICA cac ON morutcli          = cac.RutCliente and mocodcli = cac.CodCliente
                     LEFT JOIN ACTIVIDAD_ECONOMICA         ae  ON cac.ActEconomica  = ae.CodActividad
                     LEFT JOIN RUBRO_ACTIVIDAD_ECONOMICA   rae ON cac.ActEconomica  = rae.CodActividad
                     LEFT JOIN RUBROS                      rb  ON rb.CodRubro       = rae.CodRubro
      ,      BacParamSuda..VALOR_MONEDA                    Obs
      WHERE  mofech      between @FechaInicio and @FechaTermino
      and    moestatus    = ''
      and    Obs.vmfecha  = mofech
      and    Obs.vmcodigo = 994
      and  ((morutcli     = @RutCliente  or @RutCliente  = 0)
        and (mocodcli     = @CodCliente  or @CodCliente  = 0))
      and   (motipmer     = @SubProducto or @SubProducto = '')
      and   (mooper       = @Operador    or @Operador    = '')
      and    UPPER(moterm)      NOT LIKE '%FORWARD%'
      and    UPPER(observacion) NOT LIKE '%PUENTE%' 
      and    UPPER(observacion) NOT LIKE '%SWAP%'
      -- Operaciones Normales de Spot, Excluyendo las Operaciones provenientes de Foward o que sean de Puente o Swap.
   END

   IF @Producto = 'BTR' or LEN(@Producto) = 0
   BEGIN

      INSERT INTO OPERACIONES_CTRL_TRADERS
      SELECT 'FechaCarga'     = CONVERT(CHAR(10),GETDATE(),112)
      ,      'Modulo'         = 'BTR'
      ,      'Producto'       = motipoper
      ,      'RutCliente'     = morutcli
      ,      'CodCliente'     = mocodcli
      ,      'NumOperacion'   = monumoper
      ,      'NumDocumento'   = monumdocu
      ,      'NumCorrelativo' = mocorrela
      ,      'TipoOperacion'  = CASE WHEN motipoper = 'IB' THEN momascara ELSE motipoper END
      ,      'FechaInicio'    = CASE WHEN motipoper = 'CP' THEN mofecemi
                                     WHEN motipoper = 'VP' THEN mofecemi
                                     WHEN motipoper = 'RC' THEN mofecemi
                                     WHEN motipoper = 'RV' THEN mofecinip
                                     WHEN motipoper = 'IB' THEN mofecinip
                                     WHEN motipoper = 'CI' THEN mofecinip
                                     ELSE                       mofecemi
                                END
      ,      'FechaTermino'   = CASE WHEN motipoper = 'CP' THEN mofecven
                                     WHEN motipoper = 'VP' THEN mofecpro
                                     WHEN motipoper = 'RC' THEN mofecven
                                     WHEN motipoper = 'RV' THEN mofecpro
                                     WHEN motipoper = 'IB' THEN mofecvenp
                                     WHEN motipoper = 'CI' THEN mofecvenp
                                     ELSE                       mofecven
                                END
      ,      'MontoInicial'   = movpresen
      ,      'Moneda'         = CASE WHEN motipoper = 'CP' THEN momonemi
                                     WHEN motipoper = 'VP' THEN momonemi
                                     WHEN motipoper = 'RC' THEN momonpact
                                     WHEN motipoper = 'RV' THEN momonpact
                                     WHEN motipoper = 'IB' THEN momonpact
                                     WHEN motipoper = 'CI' THEN momonpact
                                     ELSE                       momonemi
                                END
      ,      'MonedaCnv'      = 0
      ,      'Tasa'           = CASE WHEN motipoper = 'CP' THEN motir
                                     WHEN motipoper = 'VP' THEN motir
                                     WHEN motipoper = 'RC' THEN motaspact
                                     WHEN motipoper = 'RV' THEN motaspact
                                     WHEN motipoper = 'IB' THEN motaspact
                                     WHEN motipoper = 'CI' THEN motaspact
                                     ELSE                       motir
                                END
      ,      'ValorFinal'     = CASE WHEN motipoper = 'CP' THEN movpresen
                                     WHEN motipoper = 'VP' THEN movalven
                                     WHEN motipoper = 'RC' THEN movpresen
                                     WHEN motipoper = 'RV' THEN movpresen
                                     WHEN motipoper = 'IB' THEN movalvenp
                                     WHEN motipoper = 'CI' THEN movalvenp
                                     ELSE                       movpresen
                                END
      ,      'Operador'       = mousuario
      ,      'HoraInicio'     = SUBSTRING(mohora,1,8) 
      ,      'CodGerencia'    = 0 -- @CodGerencia
      ,      'CodSubGerencia' = 0 -- @CodSubGerencia
      ,      'CodAgente'      = 0 -- @CodAgente
      ,      'TraderAsignado' = '' -- @Trader
      ,      'Utilidad'       = moutilidad
      ,      'Margen'         = ISNULL(moutilidad / 
                                CASE WHEN motipoper = 'CP' THEN movpresen
                                     WHEN motipoper = 'VP' THEN movalven
                                     WHEN motipoper = 'RC' THEN movpresen
                                     WHEN motipoper = 'RV' THEN movpresen
                                     WHEN motipoper = 'IB' THEN movalvenp
                                     WHEN motipoper = 'CI' THEN movalvenp
                                     ELSE                       movpresen
                                END,0.0)
      ,      'Codigo'         = mocodigo
      ,      'ActEconomica'   = isnull(ae.Descripción,'SIN ACTIVIDAD ECONIMICA')
      ,      'Rubro'          = isnull(rb.Descripción,'SIN RUBRO')
      FROM   BacTraderSuda..MDMO
                     LEFT JOIN CLIENTE_ACTIVIDAD_ECONOMICA cac ON morutcli    = cac.RutCliente and mocodcli = cac.CodCliente
                     LEFT JOIN ACTIVIDAD_ECONOMICA         ae  ON cac.ActEconomica  = ae.CodActividad
                     LEFT JOIN RUBRO_ACTIVIDAD_ECONOMICA   rae ON cac.ActEconomica  = rae.CodActividad
                     LEFT JOIN RUBROS                      rb  ON rb.CodRubro       = rae.CodRubro
      WHERE  mofecpro  between @FechaInicio and @FechaTermino
      AND    motipoper NOT IN('TM')
      AND    mostatreg = ''
      AND   (motipoper = @SubProducto or @SubProducto = '')
      AND  ((morutcli  = @RutCliente  or @RutCliente  = 0)
        and (mocodcli  = @CodCliente  or @CodCliente  = 0))
      and   (mousuario = @Operador    or @Operador    = '')


      INSERT INTO OPERACIONES_CTRL_TRADERS
      SELECT 'FechaCarga'     = CONVERT(CHAR(10),GETDATE(),112)
      ,      'Modulo'         = 'BTR'
      ,      'Producto'       = motipoper
      ,      'RutCliente'     = morutcli
      ,      'CodCliente'     = mocodcli
      ,      'NumOperacion'   = monumoper
      ,      'NumDocumento'   = monumdocu
      ,      'NumCorrelativo' = mocorrela
      ,      'TipoOperacion'  = CASE WHEN motipoper = 'IB' THEN momascara ELSE motipoper END
      ,      'FechaInicio'    = CASE WHEN motipoper = 'CP' THEN mofecemi
                                     WHEN motipoper = 'VP' THEN mofecemi
                                     WHEN motipoper = 'RC' THEN mofecemi
                                     WHEN motipoper = 'RV' THEN mofecinip
                                     WHEN motipoper = 'IB' THEN mofecinip
                                     WHEN motipoper = 'CI' THEN mofecinip
                                     ELSE                       mofecemi
                                END
      ,      'FechaTermino'   = CASE WHEN motipoper = 'CP' THEN mofecven
                                     WHEN motipoper = 'VP' THEN mofecpro
                                     WHEN motipoper = 'RC' THEN mofecven
                                     WHEN motipoper = 'RV' THEN mofecpro
                                     WHEN motipoper = 'IB' THEN mofecvenp
                                     WHEN motipoper = 'CI' THEN mofecvenp
                                     ELSE                       mofecven
                                END
      ,      'MontoInicial'   = movpresen
      ,      'Moneda'         = CASE WHEN motipoper = 'CP' THEN momonemi
                                     WHEN motipoper = 'VP' THEN momonemi
                                     WHEN motipoper = 'RC' THEN momonpact
                                     WHEN motipoper = 'RV' THEN momonpact
                                     WHEN motipoper = 'IB' THEN momonpact
                                     WHEN motipoper = 'CI' THEN momonpact
                                     ELSE                       momonemi
                                END
      ,      'MonedaCnv'      = 0
      ,      'Tasa'           = CASE WHEN motipoper = 'CP' THEN motir
                                     WHEN motipoper = 'VP' THEN motir
                                     WHEN motipoper = 'RC' THEN motaspact
                                     WHEN motipoper = 'RV' THEN motaspact
                                     WHEN motipoper = 'IB' THEN motaspact
                                     WHEN motipoper = 'CI' THEN motaspact
                                     ELSE                       motir
                                END
      ,      'ValorFinal'     = CASE WHEN motipoper = 'CP' THEN movpresen
                                     WHEN motipoper = 'VP' THEN movalven
                                     WHEN motipoper = 'RC' THEN movpresen
                                     WHEN motipoper = 'RV' THEN movpresen
                                     WHEN motipoper = 'IB' THEN movalvenp
                                     WHEN motipoper = 'CI' THEN movalvenp
                    ELSE                       movpresen
                                END
      ,      'Operador'       = mousuario
      ,      'HoraInicio'     = SUBSTRING(mohora,1,8) 
      ,      'CodGerencia'    = 0  -- @CodGerencia
      ,      'CodSubGerencia' = 0  -- @CodSubGerencia
      ,      'CodAgente'      = 0  -- @CodAgente
      ,      'TraderAsignado' = '' -- @Trader
      ,      'Utilidad'       = moutilidad
      ,      'Margen'         = ISNULL(moutilidad / 
                                CASE WHEN motipoper = 'CP' THEN movpresen
                                     WHEN motipoper = 'VP' THEN movalven
                                     WHEN motipoper = 'RC' THEN movpresen
                                     WHEN motipoper = 'RV' THEN movpresen
                                     WHEN motipoper = 'IB' THEN movalvenp
                                     WHEN motipoper = 'CI' THEN movalvenp
                                     ELSE                       movpresen
                                END,0.0)
      ,      'Codigo'         = mocodigo
      ,      'ActEconomica'   = isnull(ae.Descripción,'SIN ACTIVIDAD ECONIMICA')
      ,      'Rubro'          = isnull(rb.Descripción,'SIN RUBRO')
      FROM   BacTraderSuda..MDMH
                     LEFT JOIN CLIENTE_ACTIVIDAD_ECONOMICA cac ON morutcli          = cac.RutCliente and mocodcli = cac.CodCliente
                     LEFT JOIN ACTIVIDAD_ECONOMICA         ae  ON cac.ActEconomica  = ae.CodActividad
                     LEFT JOIN RUBRO_ACTIVIDAD_ECONOMICA   rae ON cac.ActEconomica  = rae.CodActividad
                     LEFT JOIN RUBROS                      rb  ON rb.CodRubro       = rae.CodRubro
  WHERE  mofecpro  between @FechaInicio and @FechaTermino
      AND    motipoper NOT IN('TM')
      AND    mostatreg = ''
      AND   (motipoper = @SubProducto or @SubProducto = '')
      AND  ((morutcli  = @RutCliente  or @RutCliente  = 0)
        and (mocodcli  = @CodCliente  or @CodCliente  = 0))
      and   (mousuario = @Operador    or @Operador    = '')

   END

   IF @Producto = 'BFW' or LEN(@Producto) = 0
   BEGIN

      INSERT INTO OPERACIONES_CTRL_TRADERS
      SELECT 'FechaCarga'     = CONVERT(CHAR(10),GETDATE(),112)
      ,      'Modulo'         = 'BFW'
      ,      'Producto'       = CONVERT(VARCHAR(5),cacodpos1)
      ,      'RutCliente'     = cacodigo
      ,      'CodCliente'     = cacodcli
      ,      'NumOperacion'   = canumoper
      ,      'NumDocumento'   = 0
      ,      'NumCorrelativo' = 0
      ,      'TipoOperacion'  = catipoper
      ,      'FechaInicio'    = cafecha
      ,      'FechaTermino'   = cafecvcto
      ,      'MontoInicial'   = camtomon1
      ,      'Moneda'         = cacodmon1
      ,      'MonedaCnv'      = cacodmon2
      ,      'Tasa'           = catipcam
      ,      'ValorFinal'     = CASE WHEN cacodpos1 = 2 THEN camtomon2
                                     ELSE                    caequusd1
                                END
      ,      'Operador'       = caoperador
      ,      'HoraInicio'     = cahora
      ,      'CodGerencia'    = 0  -- @CodGerencia
      ,      'CodSubGerencia' = 0  -- @CodSubGerencia
      ,      'CodAgente'      = 0  -- @CodAgente
      ,      'TraderAsignado' = '' -- @Trader
      ,      'Utilidad'       = CASE WHEN cacodpos1 in (1,7,3)                               THEN caspread
                                     WHEN cacodpos1 = 2 AND mnrrda = 'M' AND catipoper = 'C' THEN      (caparmon1 * camtomon1 * Obs.vmvalor) -      (catipcam  * camtomon1 * Obs.vmvalor)
                                     WHEN cacodpos1 = 2 AND mnrrda = 'D' AND catipoper = 'C' THEN ((1 / caparmon1)* camtomon1 * Obs.vmvalor) - ((1 / catipcam) * camtomon1 * Obs.vmvalor)
                                     WHEN cacodpos1 = 2 AND mnrrda = 'M' AND catipoper = 'V' THEN      (catipcam  * camtomon1 * Obs.vmvalor) -      (caparmon1 * camtomon1 * Obs.vmvalor)
                                     WHEN cacodpos1 = 2 AND mnrrda = 'D' AND catipoper = 'V' THEN ((1 / catipcam) * camtomon1 * Obs.vmvalor) - ((1 / caparmon1)* camtomon1 * Obs.vmvalor)
                                END
      ,      'Margen'         = CASE WHEN cacodpos1 in(1,7,3)                                THEN caspread 
                                     WHEN cacodpos1 = 2 AND mnrrda = 'M' AND catipoper = 'C' THEN      (caparmon1 * camtomon1 * Obs.vmvalor) -      (catipcam  * camtomon1 * Obs.vmvalor)
                                     WHEN cacodpos1 = 2 AND mnrrda = 'D' AND catipoper = 'C' THEN ((1 / caparmon1)* camtomon1 * Obs.vmvalor) - ((1 / catipcam) * camtomon1 * Obs.vmvalor)
                                     WHEN cacodpos1 = 2 AND mnrrda = 'M' AND catipoper = 'V' THEN      (catipcam  * camtomon1 * Obs.vmvalor) -      (caparmon1 * camtomon1 * Obs.vmvalor)
                                     WHEN cacodpos1 = 2 AND mnrrda = 'D' AND catipoper = 'V' THEN ((1 / catipcam) * camtomon1 * Obs.vmvalor) - ((1 / caparmon1)* camtomon1 * Obs.vmvalor)
                                END
                              / CASE WHEN cacodpos1 = 2 THEN camtomon2 ELSE caequusd1 END
      ,      'Codigo'         = 0 
      ,      'ActEconomica'   = isnull(ae.Descripción,'SIN ACTIVIDAD ECONIMICA')
      ,      'Rubro'          = isnull(rb.Descripción,'SIN RUBRO')
      FROM   BacFwdSuda..MFCA
             LEFT JOIN CLIENTE_ACTIVIDAD_ECONOMICA cac ON cacodigo          = cac.RutCliente AND cacodcli = cac.CodCliente
             LEFT JOIN ACTIVIDAD_ECONOMICA         ae  ON cac.ActEconomica  = ae.CodActividad
             LEFT JOIN RUBRO_ACTIVIDAD_ECONOMICA   rae ON cac.ActEconomica  = rae.CodActividad
             LEFT JOIN RUBROS                      rb  ON rb.CodRubro       = rae.CodRubro
             LEFT JOIN BacParamSuda..MONEDA        Mon ON cacodmon1         = mncodmon
      ,      BacParamSuda..VALOR_MONEDA            Obs
      WHERE  cafecha                 between @FechaInicio and @FechaTermino
      AND    caestado                      = ''
      AND    Obs.vmcodigo                  = 994
      AND    Obs.vmfecha                   = cafecha
      AND   (CONVERT(VARCHAR(5),cacodpos1) = @SubProducto or @SubProducto = '')
      AND  ((cacodigo                      = @RutCliente  or @RutCliente  = 0)
        AND (cacodcli                      = @CodCliente  or @CodCliente  = 0))
      AND   (caoperador                    = @Operador    or @Operador    = '')

      INSERT INTO OPERACIONES_CTRL_TRADERS
      SELECT 'FechaCarga'     = CONVERT(CHAR(10),GETDATE(),112)
      ,      'Modulo'         = 'BFW'
      ,      'Producto'       = CONVERT(VARCHAR(5),cacodpos1)
      ,      'RutCliente'     = cacodigo
      ,      'CodCliente'     = cacodcli
      ,      'NumOperacion'   = canumoper
      ,      'NumDocumento'   = 0
      ,      'NumCorrelativo' = 0
      ,      'TipoOperacion'  = catipoper
      ,      'FechaInicio'    = cafecha
      ,      'FechaTermino'   = cafecvcto
      ,      'MontoInicial'   = camtomon1
      ,      'Moneda'         = cacodmon1
      ,      'MonedaCnv'      = cacodmon2
      ,      'Tasa'           = catipcam
      ,      'ValorFinal'     = CASE WHEN cacodpos1 = 2 THEN camtomon2
                                     ELSE                    caequusd1
                                END
      ,      'Operador'       = caoperador
      ,      'HoraInicio'     = cahora
      ,      'CodGerencia'    = 0  -- @CodGerencia
      ,      'CodSubGerencia' = 0  -- @CodSubGerencia
      ,      'CodAgente'      = 0  -- @CodAgente
      ,      'TraderAsignado' = '' -- @Trader
      ,      'Utilidad'       = CASE WHEN cacodpos1 in (1,7,3)                               THEN caspread
                                     WHEN cacodpos1 = 2 AND mnrrda = 'M' AND catipoper = 'C' THEN      (caparmon1 * camtomon1 * Obs.vmvalor) -      (catipcam  * camtomon1 * Obs.vmvalor)
                                     WHEN cacodpos1 = 2 AND mnrrda = 'D' AND catipoper = 'C' THEN ((1 / caparmon1)* camtomon1 * Obs.vmvalor) - ((1 / catipcam) * camtomon1 * Obs.vmvalor)
                                     WHEN cacodpos1 = 2 AND mnrrda = 'M' AND catipoper = 'V' THEN      (catipcam  * camtomon1 * Obs.vmvalor) -      (caparmon1 * camtomon1 * Obs.vmvalor)
                                     WHEN cacodpos1 = 2 AND mnrrda = 'D' AND catipoper = 'V' THEN ((1 / catipcam) * camtomon1 * Obs.vmvalor) - ((1 / caparmon1)* camtomon1 * Obs.vmvalor)
                                END
      ,      'Margen'         = CASE WHEN cacodpos1 in(1,7,3)                                THEN caspread 
                                     WHEN cacodpos1 = 2 AND mnrrda = 'M' AND catipoper = 'C' THEN      (caparmon1 * camtomon1 * Obs.vmvalor) -      (catipcam  * camtomon1 * Obs.vmvalor)
                                     WHEN cacodpos1 = 2 AND mnrrda = 'D' AND catipoper = 'C' THEN ((1 / caparmon1)* camtomon1 * Obs.vmvalor) - ((1 / catipcam) * camtomon1 * Obs.vmvalor)
                                     WHEN cacodpos1 = 2 AND mnrrda = 'M' AND catipoper = 'V' THEN      (catipcam  * camtomon1 * Obs.vmvalor) -      (caparmon1 * camtomon1 * Obs.vmvalor)
                                     WHEN cacodpos1 = 2 AND mnrrda = 'D' AND catipoper = 'V' THEN ((1 / catipcam) * camtomon1 * Obs.vmvalor) - ((1 / caparmon1)* camtomon1 * Obs.vmvalor)
                                END
                              / CASE WHEN cacodpos1 = 2 THEN camtomon2 ELSE caequusd1 END
      ,      'Codigo'         = 0 
      ,      'ActEconomica'   = isnull(ae.Descripción,'SIN ACTIVIDAD ECONIMICA')
      ,      'Rubro'          = isnull(rb.Descripción,'SIN RUBRO')
      FROM   BacFwdSuda..MFCAH
             LEFT JOIN CLIENTE_ACTIVIDAD_ECONOMICA cac ON cacodigo          = cac.RutCliente AND cacodcli = cac.CodCliente
             LEFT JOIN ACTIVIDAD_ECONOMICA         ae  ON cac.ActEconomica  = ae.CodActividad
             LEFT JOIN RUBRO_ACTIVIDAD_ECONOMICA   rae ON cac.ActEconomica  = rae.CodActividad
             LEFT JOIN RUBROS                      rb  ON rb.CodRubro       = rae.CodRubro
             LEFT JOIN BacParamSuda..MONEDA        Mon ON cacodmon1         = mncodmon
      ,      BacParamSuda..VALOR_MONEDA            Obs
      WHERE  cafecha                 between @FechaInicio and @FechaTermino
      AND    caestado                      = ''
      AND    Obs.vmcodigo                  = 994
      AND    Obs.vmfecha                   = cafecha
      AND   (CONVERT(VARCHAR(5),cacodpos1) = @SubProducto or @SubProducto = '')
      AND  ((cacodigo                      = @RutCliente  or @RutCliente  = 0)
        AND (cacodcli                      = @CodCliente  or @CodCliente  = 0))
      AND   (caoperador                    = @Operador    or @Operador    = '')

   END

   IF @Producto = 'BEX' or LEN(@Producto) = 0
   BEGIN

      INSERT INTO OPERACIONES_CTRL_TRADERS
      SELECT 'FechaCarga'     = CONVERT(CHAR(10),GETDATE(),112)
      ,      'Modulo'         = 'BEX'
      ,      'Producto'       = motipoper
      ,      'RutCliente'     = morutcli
      ,      'CodCliente'     = mocodcli
      ,      'NumOperacion'   = monumoper
      ,      'NumDocumento'   = monumdocu
      ,      'NumCorrelativo' = mocorrelativo
      ,      'TipoOperacion'  = motipoper
      ,      'FechaInicio'    = mofecneg
      ,      'FechaTermino'   = mofecven
      ,      'MontoInicial'   = momontoemi
      ,      'Moneda'         = momonemi
      ,      'MonedaCnv'      = momonpag
      ,      'Tasa'           = motasemi
      ,      'ValorFinal'     = movalvenc
      ,      'Operador'       = SUBSTRING(mousuario,1,15)
      ,      'HoraInicio'     = CONVERT(CHAR(8),mohoraop,108)
      ,      'CodGerencia'    = 0 -- @CodGerencia
      ,      'CodSubGerencia' = 0 -- @CodSubGerencia
      ,      'CodAgente'      = 0 -- @CodAgente
      ,      'TraderAsignado' = '' -- @Trader
      ,      'Utilidad'       = moutilidad
      ,      'Margen'         = ISNULL(moutilidad / ISNULL(movalvenc,1) ,0.0)
      ,      'Codigo'         = cod_familia
      ,      'ActEconomica'   = isnull(ae.Descripción,'SIN ACTIVIDAD ECONIMICA')
      ,      'Rubro'          = isnull(rb.Descripción,'SIN RUBRO')
      FROM   BacBonosExtSuda..TEXT_MVT_DRI
                     LEFT JOIN CLIENTE_ACTIVIDAD_ECONOMICA cac ON morutcli          = cac.RutCliente and mocodcli = cac.CodCliente
                     LEFT JOIN ACTIVIDAD_ECONOMICA         ae  ON cac.ActEconomica  = ae.CodActividad
                     LEFT JOIN RUBRO_ACTIVIDAD_ECONOMICA   rae ON cac.ActEconomica  = rae.CodActividad
                     LEFT JOIN RUBROS                      rb  ON rb.CodRubro       = rae.CodRubro
      WHERE  mofecpro         between @FechaInicio and @FechaTermino
      AND    mostatreg        = ''
      AND   (motipoper        = @SubProducto or @SubProducto = '')
      AND  ((morutcli         = @RutCliente  or @RutCliente  = 0)
        and (mocodcli         = @CodCliente  or @CodCliente  = 0))
      and   (mousuario        = @Operador    or @Operador    = '')

   END


   DELETE OPERACIONES_CTRL_TRADERS
   FROM   OPERACIONES_CTRL_TRADERS 
   ,      bacparamsuda..CLIENTE 
   WHERE  RutCliente = clrut 
   AND    CodCliente = clcodigo
   AND    cltipcli   IN(1,2,3,4,5)


   --------------------------------------------------------------------------------
   --> Caraga de Codigo de Agente Segun tabla Agentes Relacionados (Cliente-Agente)
   UPDATE OPERACIONES_CTRL_TRADERS
   SET    CodAgente  = AgeCodigo
   FROM   AGENTES_RELACIONADOS
   WHERE (RutCliente = AgeRutCliente
   AND    CodCliente = AgeCodigoCliente)

   --> Borra los Agentes No Filtrados (Requeridos Seleccion distinto << TODOS >>)
   IF @CodAgente <> 0
      DELETE OPERACIONES_CTRL_TRADERS
       WHERE CodAgente <> @CodAgente
   --------------------------------------------------------------------------------


   --------------------------------------------------------------------------------
   --> Carga las Sub Gerencias
   UPDATE OPERACIONES_CTRL_TRADERS
   SET    CodSubGerencia = SGerCodigo
   FROM   AGENTES
   WHERE  AgeCodigo      = CodAgente

   IF @CodSubGerencia <> 0
      DELETE OPERACIONES_CTRL_TRADERS
      WHERE  CodSubGerencia <> @CodSubGerencia
   --------------------------------------------------------------------------------

   --------------------------------------------------------------------------------
   --> Carga las Gerencias
   UPDATE OPERACIONES_CTRL_TRADERS
   SET    CodGerencia    = GerCodigo
   FROM   SUB_GERENCIAS
   WHERE  CodSubGerencia = SGerCodigo

   IF @CodGerencia <> 0
      DELETE OPERACIONES_CTRL_TRADERS
      WHERE  CodGerencia <> @CodGerencia
   --------------------------------------------------------------------------------


   --------------------------------------------------------------------------------
   --> Caraga los Traders o Usuarios Relacionados (Cliente-Trader)
   UPDATE OPERACIONES_CTRL_TRADERS
   SET    TraderAsignado = TraUsuario
   FROM   TRADERS_RELACIONADOS
   WHERE (RutCliente     = TraRutCliente
   AND    CodCliente     = TraCodigoCliente)

   --> Borra los Traders No Filtrados (Requeridos Seleccion distinto << TODOS >>)
   IF @Trader <> ''
      DELETE OPERACIONES_CTRL_TRADERS
      WHERE  TraderAsignado <> @Trader
   --------------------------------------------------------------------------------


   SELECT FechaCarga                      AS FechaCarga
   ,      Modulo                          AS Modulo
   ,      Producto                        AS Producto
   ,      RutCliente                      AS RutCliente
   ,      CodCliente                      AS CodCliente 
   ,      (NumOperacion)                  AS NumOperacion
   ,      MIN(NumDocumento)               AS NumDocumento
   ,      MIN(NumCorrelativo)             AS NumCorrelativo
   ,      TipoOperacion                   AS TipoOperacion
   ,      MIN(FechaInicio)                AS FechaInicio
   ,      MAX(FechaTermino)               AS FechaTermino
   ,      SUM(MontoInicial)               AS MontoInicial
   ,      Moneda                          AS Moneda
   ,      MonedaCnv                       AS MonedaCnv
   ,      AVG(Tasa)                       AS Tasa
   ,      SUM(ValorFinal)                 AS ValorFinal
   ,      Operador                        AS Operador
   ,      MIN(HoraInicio)                 AS HoraInicio
   ,      CodGerencia                     AS CodGerencia
   ,      CodSubGerencia                  AS CodSubGerencia
   ,      CodAgente                       AS CodAgente
   ,      TraderAsignado                  AS TraderAsignado
   ,      SUM(Utilidad)                   AS Utilidad
   ,      SUM(Utilidad) / SUM(ValorFinal) AS Margen
   ,      Codigo                          AS Codigo
   ,      MIN(Actividad)                  AS ActEconomica
   ,      MIN(Rubro)                      AS Rubro
   INTO   #OPERACIONES_CTRL_TRADERS_AGRUPADA
   FROM   OPERACIONES_CTRL_TRADERS
   GROUP BY FechaCarga
   ,        Modulo
   ,        Producto
   ,        NumOperacion
   ,        Codigo
   ,        RutCliente
   ,        CodCliente
   ,        TipoOperacion
   ,        Moneda
   ,        MonedaCnv
   ,        Operador
   ,        CodGerencia
   ,        CodSubGerencia
   ,        CodAgente
   ,        TraderAsignado

   DECLARE @Puntero   NUMERIC(9)

   SELECT  @Puntero   = COUNT(1) 
   FROM    #OPERACIONES_CTRL_TRADERS_AGRUPADA

   --> Retorno Completo de la Generación (Carga)
   SELECT /*001*/ o.FechaCarga                       as FechaCarga
   ,      /*002*/ y.nombre_sistema                   as Modulo
   ,      /*003*/ isnull(P.descripcion,o.Producto)   as Producto
   ,      /*004*/ o.RutCliente                       as RutCliente
   ,      /*005*/ o.CodCliente                       as CodCliente
   ,      /*006*/ o.NumOperacion                     as NumOperacion
   ,      /*007*/ o.NumDocumento                     as NumDocumento
   ,      /*008*/ o.NumCorrelativo                   as NumCorrelativo
   ,      /*009*/ o.TipoOperacion                    as TipoOperacion
   ,      /*010*/ o.FechaInicio                      as FechaInicio
   ,      /*011*/ o.FechaTermino                     as FechaTermino
   ,      /*012*/ o.MontoInicial                     as MontoInicial
   ,      /*013*/ o.Moneda                           as Moneda
   ,      /*014*/ o.MonedaCnv                        as MonedaCnv
   ,      /*015*/ o.Tasa                             as Tasa
   ,      /*016*/ o.ValorFinal                       as ValorFinal
   ,      /*017*/ o.Operador                         as Operador
   ,      /*018*/ o.HoraInicio                       as HoraInicio
   ,      /*019*/ o.CodGerencia                      as CodGerencia
   ,      /*020*/ o.CodSubGerencia                   as CodSubGerencia
   ,      /*021*/ o.CodAgente                        as CodAgente
   ,      /*022*/ o.TraderAsignado                   as TraderAsignado
   ,      /*023*/ isnull(c.clnombre,'')              as Cliente
   ,      /*024*/ isnull(a.AgeNombre,'')             as Agente
   ,      /*025*/ isnull(s.SGerSubGerencia,'')       as SubGerencia
   ,      /*026*/ isnull(s.SGerNombre,'')            as SubGerente
   ,      /*027*/ isnull(g.GerGerencia,'')           as Gerencia
   ,      /*028*/ isnull(g.GerNombre,'')             as Gerente
   ,      /*029*/ isnull(n.mnnemo,'')                as NemoMoneda
   ,      /*030*/ isnull(v.mnnemo,'')                as NemoMonedaCnv
   ,      /*031*/ o.Utilidad                         as Utilidad
   ,      /*032*/ o.Margen                           as Margen
   ,      /*033*/ o.Codigo                           as Codigo
   ,      /*034*/ o.ActEconomica                     as ActEconomica
   ,      /*035*/ o.Rubro                            as Rubro
   ,      /*036*/ @Puntero                           as Puntero
   FROM   #OPERACIONES_CTRL_TRADERS_AGRUPADA  o
          LEFT JOIN BacParamSuda..CLIENTE     c  ON o.RutCliente      = c.clrut AND o.CodCliente = c.clcodigo
          LEFT JOIN AGENTES                   a  ON o.CodAgente       = a.AgeCodigo
          LEFT JOIN SUB_GERENCIAS             s  ON o.CodSubGerencia  = s.SGerCodigo
          LEFT JOIN GERENCIAS                 g  ON o.CodGerencia     = g.GerCodigo
          LEFT JOIN BacParamSuda..MONEDA      n  ON o.moneda          = n.mncodmon
          LEFT JOIN BacParamSuda..MONEDA      v  ON o.MonedaCnv       = v.mncodmon
          LEFT JOIN BacParamSuda..SISTEMA_CNT y  ON o.Modulo          = y.id_sistema
          LEFT JOIN BacParamSuda..PRODUCTO    p  ON p.id_sistema      = o.Modulo
                                                AND p.codigo_producto = (case when o.Modulo = 'BEX' then convert(char(2),o.Producto) + 'X' else o.Producto end)
   ORDER BY o.Modulo , o.Producto , o.NumOperacion , o.RutCliente , o.CodCliente

END



GO
