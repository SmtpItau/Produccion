USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[QRY_CONSULTA_RESULTADO_MESA]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[QRY_CONSULTA_RESULTADO_MESA]
   (   @dFechaProceso   DATETIME = ''  )
AS
BEGIN

if @dFechaProceso='' 
  set @dFechaProceso   = getdate()

   SET NOCOUNT ON

CREATE TABLE #TMP_RESULTADO_MESA
   (   Modulo            CHAR(3)         DEFAULT('')
   ,   Fecha             DATETIME        DEFAULT('')
   ,   Documento         NUMERIC(9)      DEFAULT(0)
   ,   Correlativo       NUMERIC(9)      DEFAULT(0)
   ,   Operacion         NUMERIC(9)      DEFAULT(0)
   ,   Producto          VARCHAR(25)     DEFAULT('')
   ,   TipoOperacion     VARCHAR(10)     DEFAULT('')
   ,   Cliente           VARCHAR(50)     DEFAULT('')
   ,   Serie             VARCHAR(20)     DEFAULT('')
   ,   Nominal           NUMERIC(21,4)   DEFAULT(0.0)
   ,   Tasa              NUMERIC(21,4)   DEFAULT(0.0)
   ,   vPresente         NUMERIC(21,4)   DEFAULT(0.0)
   ,   TasaTransferencia NUMERIC(21,4)   DEFAULT(0.0)
   ,   vPresentetTrans   NUMERIC(21,4)   DEFAULT(0.0)
   ,   Resultado         NUMERIC(21,4)   DEFAULT(0.0)
   ,   Resultado_Pesos   NUMERIC(21,4)   DEFAULT(0.0)
   ,   Financiera        VARCHAR(50)     DEFAULT('')
   ,   Normativa         VARCHAR(50)     DEFAULT('')
   )

   DECLARE @dFechaRentaFija DATETIME
       SET @dFechaRentaFija = (SELECT acfecproc FROM BacTraderSuda.dbo.MDAC with(nolock) )

   IF @dFechaProceso = @dFechaRentaFija
   BEGIN
      INSERT INTO #TMP_RESULTADO_MESA 
      SELECT Modulo            = 'BTR'
      ,      Fecha             = mofecpro
      ,      Documento         = monumdocu
      ,      Correlativo       = mocorrela
      ,      Operacion         = monumoper
      ,      Producto          = CASE WHEN motipoper = 'VP' THEN 'VENTA DEFINITIVA'
                                      WHEN motipoper = 'VI' THEN 'VENTA c/ PACTO'
                                      WHEN motipoper = 'CP' THEN 'COMPRA DEFINITIVA'
                                      WHEN motipoper = 'CI' THEN 'COMPRA c/ PACTO'
                                      ELSE motipoper
                                 END
      ,      TipoOperacion     = motipoper
      ,      Cliente           = SUBSTRING(clnombre, 1, 50)
      ,      Serie             = moinstser
      ,      Nominal           = monominal
      ,      Tasa              = motir
      ,      vPresente         = movpresen
      ,      TasaTransferencia = moTirTran
      ,      vPresentetTrans   = moVPTran
      ,      Resultado         = moDifTran_MO
      ,      Resultado_Pesos   = moDifTran_CLP
      ,      Financiera        = Fin.tbglosa
      ,      Normativa         = Nor.tbglosa
      FROM   BacTraderSuda.dbo.MDMO mov                           with(nolock)
             LEFT JOIN BacParamSuda.dbo.CLIENTE               cli with(nolock) ON cli.clrut = morutcli and cli.clcodigo = mocodcli
             LEFT JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE Fin with(nolock) ON Fin.tbcateg = 204  and Fin.tbcodigo1 = Tipo_Cartera_Financiera
             LEFT JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE Nor with(nolock) ON Nor.tbcateg = 1111 and Nor.tbcodigo1 = codigo_carterasuper
      WHERE  mostatreg         = ''
         AND motipoper        <> 'TM'
      ORDER BY mofecpro, monumdocu, mocorrela

   END ELSE
   BEGIN
      INSERT INTO #TMP_RESULTADO_MESA 
      SELECT Modulo            = 'BTR'
      ,      Fecha             = mofecpro
      ,      Documento         = monumdocu
      ,      Correlativo       = mocorrela
      ,      Operacion         = monumoper
      ,      Producto          = CASE WHEN motipoper = 'VP' THEN 'VENTA DEFINITIVA'
                                      WHEN motipoper = 'VI' THEN 'VENTA c/ PACTO'
                                      WHEN motipoper = 'CP' THEN 'COMPRA DEFINITIVA'
                                      WHEN motipoper = 'CI' THEN 'COMPRA c/ PACTO'
                                      ELSE motipoper
                                 END
      ,      TipoOperacion     = motipoper
      ,      Cliente           = SUBSTRING(clnombre, 1, 50)
      ,      Serie             = moinstser
      ,      Nominal           = monominal
      ,      Tasa              = motir
      ,      vPresente         = movpresen
      ,      TasaTransferencia = moTirTran
      ,      vPresentetTrans   = moVPTran
      ,      Resultado         = moDifTran_MO
      ,      Resultado_Pesos   = moDifTran_CLP
      ,      Financiera        = Fin.tbglosa
      ,      Normativa         = Nor.tbglosa
      FROM   BacTraderSuda.dbo.MDMH mov                           with(nolock)
             LEFT JOIN BacParamSuda.dbo.CLIENTE               cli with(nolock) ON cli.clrut = morutcli and cli.clcodigo = mocodcli
             LEFT JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE Fin with(nolock) ON Fin.tbcateg = 204    and Fin.tbcodigo1 = Tipo_Cartera_Financiera
             LEFT JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE Nor with(nolock) ON Nor.tbcateg = 1111   and Nor.tbcodigo1 = codigo_carterasuper
      WHERE  mofecpro          = @dFechaProceso
         AND mostatreg         = ''
         AND motipoper        <> 'TM' 
      ORDER BY mofecpro, monumdocu, mocorrela

   END

   DECLARE @dFechaSpot       DATETIME
       SET @dFechaSpot       = (SELECT acfecpro FROM BacCamSuda.dbo.MEAC with(nolock) )

   IF @dFechaProceso = @dFechaSpot
   BEGIN
      INSERT INTO #TMP_RESULTADO_MESA 
      SELECT Modulo            = 'BCC'
      ,      Fecha             = mofech
      ,      Documento         = 0
      ,      Correlativo       = 0
      ,      Operacion         = monumope
      ,      Producto          = CASE WHEN motipmer = 'EMPR' THEN 'EMPRESA'
                                      WHEN motipmer = 'PTAS' THEN 'INTERBANCARIO'
                                      WHEN motipmer = 'ARBI' THEN 'ARBITRAJES'
                                      ELSE motipmer
                                 END
      ,      TipoOperacion     = motipope
      ,      Cliente           = SUBSTRING(clnombre, 1, 50)
      ,      Serie             = ''
      ,      Nominal           = momonmo
      ,      Tasa              = moticam
      ,      vPresente         = momonpe
      ,      TasaTransferencia = moTcTra 
      ,      vPresentetTrans   = 0
      ,      Resultado         = modiftran_mo
      ,      Resultado_Pesos   = modiftran_clp
      ,      Financiera        = ''
      ,      Normativa         = ''
      FROM   BacCamSuda.dbo.MEMO
             LEFT JOIN BacParamSuda.dbo.CLIENTE ON clrut = morutcli and clcodigo = mocodcli
      WHERE  moestatus         = ''
   END ELSE
   BEGIN
      INSERT INTO #TMP_RESULTADO_MESA 
      SELECT Modulo            = 'BCC'
      ,      Fecha             = mofech
      ,      Documento         = 0
      ,      Correlativo       = 0
      ,      Operacion         = monumope
      ,      Producto          = CASE WHEN motipmer = 'EMPR' THEN 'EMPRESA'
                                      WHEN motipmer = 'PTAS' THEN 'INTERBANCARIO'
                                      WHEN motipmer = 'ARBI' THEN 'ARBITRAJES'
                                      ELSE motipmer
                                 END
      ,      TipoOperacion     = motipope
      ,      Cliente           = SUBSTRING(clnombre, 1, 50)
      ,      Serie             = ''
      ,      Nominal           = momonmo
      ,      Tasa              = moticam
      ,      vPresente         = momonpe
      ,      TasaTransferencia = moTcTra 
      ,      vPresentetTrans   = 0
      ,      Resultado         = modiftran_mo
      ,      Resultado_Pesos   = modiftran_clp
      ,      Financiera        = ''
      ,      Normativa         = ''
      FROM   BacCamSuda.dbo.MEMOH
             LEFT JOIN BacParamSuda.dbo.CLIENTE ON clrut = morutcli and clcodigo = mocodcli
      WHERE  mofech            = @dFechaProceso
      AND    moestatus         = ''
   END


   DECLARE @dFechaForward      DATETIME
  SET @dFechaForward      = (SELECT acfecproc FROM BacFwdSuda.dbo.MFAC with(nolock) )

   IF @dFechaProceso = @dFechaForward
   BEGIN
      INSERT INTO #TMP_RESULTADO_MESA
      SELECT Modulo            = 'BFW'
      ,      Fecha             = cafecha
      ,      Documento         = 0
      ,      Correlativo       = 0
      ,      Operacion         = canumoper
      ,      Producto          = CASE WHEN cacodpos1 = 1  THEN 'SEGURO CAMBIO'
                                      WHEN cacodpos1 = 2  THEN 'ARBITRAJE'
                                      WHEN cacodpos1 = 3  THEN 'SEGURO INFLACION'
                                      WHEN cacodpos1 = 10 THEN 'FORWARD B. TRADES'
                                      WHEN cacodpos1 = 11 THEN 'FORWARD T-LOCK'
                                      WHEN cacodpos1 = 12 THEN 'ARB. MX CLP'
                                      WHEN cacodpos1 = 13 THEN 'SEG. INF. HIPOTECARIO'
                                 END
      ,      TipoOperacion     = catipoper
      ,      Cliente           = SUBSTRING(clnombre, 1, 50)
      ,      Serie             = ''
      ,      Nominal           = camtomon1
      ,      Tasa              = catipcam
      ,      vPresente         = caequmon1
      ,      TasaTransferencia = CASE WHEN cacodpos1 = 1  THEN capreciopunta
                                      WHEN cacodpos1 = 2  THEN caparmon1
                                      WHEN cacodpos1 = 3  THEN capreciopunta
                                      WHEN cacodpos1 = 10 THEN precio_spot
                                 END
      ,      vPresentetTrans   = 0
      ,      Resultado         = caspread
      ,      Resultado_Pesos   = 0
      ,      Financiera        = Fin.tbglosa
      ,      Normativa         = Nor.tbglosa
      FROM   BacFwdSuda.dbo.MFCA with(nolock)
             LEFT JOIN BacParamSuda.dbo.CLIENTE ON clrut = cacodigo and clcodigo = cacodcli
             LEFT JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE Fin with(nolock) ON Fin.tbcateg = 204    and Fin.tbcodigo1 = cacodcart
             LEFT JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE Nor with(nolock) ON Nor.tbcateg = 1111   and Nor.tbcodigo1 = cacartera_normativa --> casubcartera_normativa
      WHERE  caestado          = ''

   END ELSE
   BEGIN
      INSERT INTO #TMP_RESULTADO_MESA
      SELECT Modulo            = 'BFW'
      ,      Fecha             = cafecha
      ,      Documento         = 0
      ,      Correlativo       = 0
      ,      Operacion         = canumoper
      ,      Producto          = CASE WHEN cacodpos1 = 1  THEN 'SEGURO CAMBIO'
                                      WHEN cacodpos1 = 2  THEN 'ARBITRAJE'
                                      WHEN cacodpos1 = 3  THEN 'SEGURO INFLACION'
                                      WHEN cacodpos1 = 10 THEN 'FORWARD B. TRADES'
                                      WHEN cacodpos1 = 11 THEN 'FORWARD T-LOCK'
                                      WHEN cacodpos1 = 12 THEN 'ARB. MX CLP'
                                      WHEN cacodpos1 = 13 THEN 'SEG. INF. HIPOTECARIO'
                                 END
      ,      TipoOperacion     = catipoper
      ,      Cliente           = SUBSTRING(clnombre, 1, 50)
      ,      Serie             = ''
      ,      Nominal           = camtomon1
      ,      Tasa              = catipcam
      ,      vPresente         = caequmon1
      ,      TasaTransferencia = CASE WHEN cacodpos1 = 1  THEN capreciopunta
                                      WHEN cacodpos1 = 2  THEN caparmon1
                                      WHEN cacodpos1 = 3  THEN capreciopunta
                                      WHEN cacodpos1 = 10 THEN precio_spot
                                 END
      ,      vPresentetTrans   = 0
      ,      Resultado         = caspread
      ,      Resultado_Pesos   = 0
      ,      Financiera        = Fin.tbglosa
      ,      Normativa         = Nor.tbglosa
      FROM   BacFwdSuda.dbo.MFCARES with(nolock)
             LEFT JOIN BacParamSuda.dbo.CLIENTE ON clrut = cacodigo and clcodigo = cacodcli
             LEFT JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE Fin with(nolock) ON Fin.tbcateg = 204    and Fin.tbcodigo1 = cacodcart
             LEFT JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE Nor with(nolock) ON Nor.tbcateg = 1111   and Nor.tbcodigo1 = cacartera_normativa --> casubcartera_normativa
      WHERE  CaFechaProceso    = @dFechaProceso
      AND    caestado          = ''

   END
   
   SELECT Modulo
   ,      Fecha
   ,      Documento
   ,      Correlativo
   ,      Operacion
   ,      Producto
   ,      TipoOperacion
   ,      Cliente
   ,      Serie
   ,      Nominal
   ,      Tasa
   ,      vPresente
   ,      TasaTransferencia
   ,      vPresentetTrans
   ,      Resultado
   ,      Resultado_Pesos
   ,      Financiera
   ,      Normativa
   FROM  #TMP_RESULTADO_MESA
   ORDER BY Modulo, Cliente, TipoOperacion

END

GO
