USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORME_LIMITES_GLOBALES]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_INFORME_LIMITES_GLOBALES]
   (   @Fecha     DATETIME   
   ,   @Usuario   VARCHAR(15) = 'ADMINISTRA'
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @dFechaProceso  DATETIME
   ,       @Historico      INTEGER

   SELECT  @dFechaProceso  = acfecproc
   FROM    VIEW_MDAC

   SELECT @Historico = 0 
   IF @dFechaProceso  > @Fecha
      SELECT @Historico = 1 

   CREATE TABLE #RetonoInforme
   (   Sistema            CHAR(3)         NOT NULL DEFAULT('')
   ,   Documento          NUMERIC(9)      NOT NULL DEFAULT(0)
   ,   Operacion          NUMERIC(9)      NOT NULL DEFAULT(0)
   ,   Correlativo        NUMERIC(9)      NOT NULL DEFAULT(0)
   ,   Serie              VARCHAR(20)     NOT NULL DEFAULT('')
   ,   Codigo             NUMERIC(9)      NOT NULL DEFAULT(0)
   ,   Mascar             VARCHAR(20)     NOT NULL DEFAULT('')
   ,   RutCliente         NUMERIC(10)     NOT NULL DEFAULT(0)
   ,   CodCliente         NUMERIC(9)      NOT NULL DEFAULT(0)
   ,   RutEmisor          NUMERIC(10)     NOT NULL DEFAULT(0)
   ,   FechaVencimiiento  DATETIME        NOT NULL DEFAULT('')
   ,   TasaEmision        NUMERIC(21,4)   NOT NULL DEFAULT(0.0)
   ,   Base               NUMERIC(9)      NOT NULL DEFAULT(0)
   ,   Moneda             NUMERIC(5)      NOT NULL DEFAULT(0)
   ,   Nominales          NUMERIC(21,4)   NOT NULL DEFAULT(0.0)
   ,   Tir                NUMERIC(21,4)   NOT NULL DEFAULT(0.0)
   ,   TirCompra          NUMERIC(21,4)   NOT NULL DEFAULT(0.0)
   ,   PorcValorPar       NUMERIC(21,4)   NOT NULL DEFAULT(0.0)
   ,   ValorPresente      NUMERIC(21,4)   NOT NULL DEFAULT(0.0)
   ,   ValorVenta         NUMERIC(21,4)   NOT NULL DEFAULT(0.0)
   ,   Utilidad           NUMERIC(21,4)   NOT NULL DEFAULT(0.0)
   ,   Perdida            NUMERIC(21,4)   NOT NULL DEFAULT(0.0)
   ,   FormaPago          NUMERIC(9)      NOT NULL DEFAULT(0)
   ,   PrimaDescuento     NUMERIC(21,4)   NOT NULL DEFAULT(0.0)
   ,   NomEmisor          VARCHAR(50)     NOT NULL DEFAULT('')
   ,   infFechaProceso    DATETIME        NOT NULL DEFAULT('')
   ,   infFechaEmision    DATETIME        NOT NULL DEFAULT('')
   ,   infUsuario         VARCHAR(15)     NOT NULL DEFAULT('')
   )

   IF @Historico = 0
   BEGIN

      INSERT INTO #RetonoInforme
      SELECT 'Sistema'            = 'BTR'
      ,      'Documento'          = monumdocu
      ,      'Operacion'          = monumoper
      ,      'Correlativo'        = mocorrela
      ,      'Serie'              = moinstser
      ,      'Codigo'             = mocodigo
      ,      'Mascar'             = momascara
      ,      'RutCliente'         = morutcli
      ,      'CodCliente'         = mocodcli
      ,      'RutEmisor'          = morutemi
      ,      'FechaVencimiiento'  = mofecven
      ,      'TasaEmision'        = motasemi
      ,      'Base'               = mobasemi
      ,      'Moneda'             = momonemi
      ,      'Nominales'          = monominal
      ,      'Tir'                = motir
      ,      'TirCompra'          = tir_compra_original
      ,      'PorcValorPar'       = mopvp
      ,      'ValorPresente'      = movpresen
      ,      'ValorVenta'         = movalven
      ,      'Utilidad'           = moutilidad
      ,      'Perdida'            = moperdida
      ,      'FormaPago'          = moforpagi
      ,      'PrimaDescuento'     = moprimadesc
      ,      'NomEmisor'          = emnombre
      ,      'infFechaProceso'    = @dFechaProceso
      ,      'infFechaEmision'    = @Fecha
      ,      'infUsuario'         = @Usuario
      FROM   bactradersuda..MDMO
      ,      VIEW_EMISOR
      WHERE  motipoper            = 'VP' 
      AND    codigo_carterasuper  = 'P'
      AND    morutemi             = emrut  

   END ELSE
   BEGIN

      INSERT INTO #RetonoInforme
      SELECT 'Sistema'            = 'BTR'
      ,      'Documento'          = monumdocu
      ,      'Operacion'          = monumoper
      ,      'Correlativo'        = mocorrela
      ,      'Serie'              = moinstser
      ,      'Codigo'             = mocodigo
      ,      'Mascar'             = momascara
      ,      'RutCliente'         = morutcli
      ,      'CodCliente'         = mocodcli
      ,      'RutEmisor'          = morutemi
      ,      'FechaVencimiiento'  = mofecven
      ,      'TasaEmision'        = motasemi
      ,      'Base'               = mobasemi
      ,      'Moneda'             = momonemi
      ,      'Nominales'          = monominal
      ,      'Tir'                = motir
      ,      'TirCompra'          = tir_compra_original
      ,      'PorcValorPar'       = mopvp
      ,      'ValorPresente'      = movpresen
      ,      'ValorVenta'         = movalven
      ,      'Utilidad'           = moutilidad
      ,      'Perdida'            = moperdida
      ,      'FormaPago'          = moforpagi
      ,      'PrimaDescuento'     = moprimadesc
      ,      'NomEmisor'          = emnombre
      ,      'infFechaProceso'    = @dFechaProceso
      ,      'infFechaEmision'    = @Fecha
      ,      'infUsuario'         = @Usuario
      FROM   bactradersuda..MDMH
      ,      VIEW_EMISOR
      WHERE  mofecpro             = @Fecha
      AND    motipoper            = 'VP' 
      AND    codigo_carterasuper  = 'P'
      AND    morutemi             = emrut  

   END

      INSERT INTO #RetonoInforme
      SELECT 'Sistema'            = 'BEX'
      ,      'Documento'          = monumdocu
      ,      'Operacion'          = monumoper
      ,      'Correlativo'        = mocorrelativo
      ,      'Serie'              = cod_nemo
      ,      'Codigo'             = cod_familia
      ,      'Mascar'             = id_instrum
      ,      'RutCliente'         = morutcli
      ,      'CodCliente'         = mocodcli
      ,      'RutEmisor'          = morutemi
      ,      'FechaVencimiiento'  = mofecven
      ,      'TasaEmision'        = motasemi
      ,      'Base'               = mobasemi
      ,      'Moneda'             = momonemi
      ,      'Nominales'          = monominal
      ,      'Tir'                = motir --> No se como opera, asi que le envio como tasa de Venta la misma tasa de Compra
      ,      'TirCompra'          = motir
      ,      'PorcValorPar'       = mopvp
      ,      'ValorPresente'      = movpresen
      ,      'ValorVenta'         = movalven
      ,      'Utilidad'           = moutilidad
      ,      'Perdida'            = moperdida
      ,      'FormaPago'          = forma_pago
      ,      'PrimaDescuento'     = 0.0
      ,      'NomEmisor'          = nom_emi
      ,      'infFechaProceso'    = @dFechaProceso
      ,      'infFechaEmision'    = @Fecha
      ,      'infUsuario'         = @Usuario
      FROM   bacbonosextsuda..TEXT_MVT_DRI
      ,      bacbonosextsuda..text_emi_itl
      WHERE  mofecpro             = @Fecha
      AND    motipoper            = 'VP' 
      AND    codigo_carterasuper  = 'P'
      AND    morutemi             = rut_emi

      SELECT Sistema
      ,      Documento
      ,      Operacion
      ,      Correlativo
      ,      Serie
      ,      #RetonoInforme.Codigo
      ,      Mascar
      ,      RutCliente
      ,      CodCliente
      ,      RutEmisor
      ,      FechaVencimiiento
      ,      TasaEmision
      ,      Base
      ,      Moneda
      ,      Nominales
      ,      Tir
      ,      TirCompra
      ,      PorcValorPar
      ,      ValorPresente
      ,      ValorVenta
      ,      Utilidad
      ,      Perdida
      ,      FormaPago
      ,      PrimaDescuento
      ,      'NombreCliente'   = substring(ltrim(rtrim(clnombre)),1,50)
      ,      'GlosaSistema'    = CASE WHEN Sistema = 'BTR' THEN 'RENTA FIJA'
                                      WHEN Sistema = 'BEX' THEN 'INVERSION AL EXTERIOR'
                                 END
      ,      NomEmisor 
      ,      'GlsMon'          = substring(ltrim(rtrim(mnnemo)),1,5)
      ,      'GlsFPag'         = substring(ltrim(rtrim(glosa)),1,25)
      ,      infFechaProceso
      ,      infFechaEmision
      ,      infUsuario
      FROM   #RetonoInforme 
      ,      VIEW_CLIENTE 
      ,      VIEW_MONEDA
      ,      VIEW_FORMA_DE_PAGO
      WHERE  RutCliente = clrut
      AND    CodCliente = clcodigo
      AND    Moneda     = mncodmon
      AND    FormaPago  = VIEW_FORMA_DE_PAGO.codigo
    ORDER BY Sistema 
    ,        RutCliente 
    ,        #RetonoInforme.Codigo 
    ,        Serie

END
GO
