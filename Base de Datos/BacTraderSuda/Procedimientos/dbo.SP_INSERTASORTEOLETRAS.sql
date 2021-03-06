USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INSERTASORTEOLETRAS]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INSERTASORTEOLETRAS]
   (  @nnumoper             NUMERIC (10,0) , -- numero de operaci½n de venta  
      @nrutcart             NUMERIC (09,0) , -- rut de la cartera  
      @ntipcart             NUMERIC (05,0) , -- codigo del tipo de cartera  
      @nnumdocu             NUMERIC (10,0) , -- numero del  documento  
      @ncorrela             NUMERIC (03,0) , -- correlativo de la operaci½n  
      @nmonemi              NUMERIC (03,0) , -- moneda del emISor  
      @nnominal             NUMERIC (19,4) , -- nominales vENDidos  
      @nrutemi              NUMERIC (09,0) , -- rut del emISor  
      @ncodigoF             NUMERIC (05,0) , -- codigo de la familia  
      @cfecpro              DATETIME       , -- fecha de proces o (v)  
      @moid_libro                INTEGER        ,  
      @iEstado                   INTEGER  OUTPUT  
   )  
AS  
BEGIN  
  
   SET NOCOUNT ON  
  
   DECLARE @nestado     INTEGER    
   ,       @fcontrol    DATETIME   
   ,       @dfecvtop    DATETIME   
   ,       @cTipoLchr   CHAR(01)   
   ,       @nRut        NUMERIC (09,0)  
  
   DECLARE @dFecPro    DATETIME  
   ,       @cSistema    CHAR(03)  
   ,       @cProducto    CHAR(05)  
   ,       @nRutcli    NUMERIC(09,0)  
   ,       @nCodigo    NUMERIC(09,0)  
   ,       @nMonto    NUMERIC(19,4)  
   ,       @fTipcambio    NUMERIC(08,4)  
   ,       @dFecvctop    DATETIME  
   ,       @cUsuario    CHAR(15)  
   ,       @nRut_emisor    NUMERIC(9)  
   ,       @nMonedaEmision NUMERIC(3)  
   ,       @dFecvctoInst   DATETIME  
   ,       @nInCodigo    NUMERIC(05)  
   ,       @cSeriado    CHAR(1)  
   ,       @nMonedaOp    NUMERIC(05)  
   ,       @cTipo_Riesgo   CHAR(1)  
   ,       @nCodigo_pais   NUMERIC(05)  
   ,       @cPagoCheque    CHAR(1)  
   ,       @nRutCheque    NUMERIC(09,0)  
   ,       @dFecvctoCehque DATETIME  
   ,       @nFactorVenta   NUMERIC (19,8)  
   ,       @formapago    NUMERIC(3)  
   ,       @nTir    FLOAT  
   ,       @nTasaPact    FLOAT  
   ,       @cInstser    CHAR(12)  
  
  
   UPDATE MDMOPM  
   SET    motipoper  = 'VP'  
   ,      motipopero = 'ST'  
   FROM   MDAC  
   WHERE  mofecpro   = acfecproc  
   AND    SorteoLCHR = 'S'  
   AND    morutcart  = @nrutcart   --   dirutcart  
   AND    monumdocu  = @nnumdocu   --   dinumdocu  
   AND    mocorrela  = @ncorrela   --   dicorrela  
  
   SELECT @dFecPro         = mofecpro  
   ,      @cSistema        = 'BTR'   
   ,      @cProducto       = motipoper  
   ,      @nNumdocu        = monumdocu  
   ,      @nCorrela        = mocorrela  
   ,      @nRutcli         = morutcli  
   ,      @nCodigo         = mocodcli  
   ,      @nMonto          = movalven  
   ,      @fTipcambio      = vmvalor  
   ,      @dFecvctop       = acfecproc  
   ,      @cUsuario        = mousuario  
   ,      @nRut_emisor     = morutemi  
   ,      @nMonedaEmision  = momonemi  
   ,      @dFecvctoInst    = mofecven  
   ,      @nInCodigo       = mocodigo  
   ,      @cSeriado        = moseriado --16  
   ,      @nMonedaOp       = 0  
   ,      @cTipo_Riesgo    = 'C'  
   ,      @nCodigo_pais    = 0  
   ,      @cPagoCheque     = 'N'  
   ,      @nRutCheque      = 0  
   ,      @dFecvctoCehque  = acfecproc  
   ,      @nFactorVenta    = 1  
   ,      @formapago       = 0  
   ,      @nTir            = motir  
   ,      @nTasaPact       = 0  
   ,      @cInstser        = moinstser  
   FROM   MDMOPM   
   ,      MDAC   
   ,      bacparamsuda..VALOR_MONEDA  
   WHERE  mofecpro         = acfecproc  
   AND    SorteoLCHR       = 'S'  
   AND    morutcart        = @nrutcart   --   dirutcart  
   AND    monumdocu        = @nnumdocu   --   dinumdocu  
   AND    mocorrela        = @ncorrela   --   dicorrela  
   AND    vmfecha          = acfecproc  
   AND    vmcodigo         = 994  
  
   EXECUTE baclineas..Sp_Lineas_ChequearGrabar   
                    @dFecPro  
            ,       @cSistema  
            ,       @cProducto  
            ,       @nNumoper  
            ,       @nNumdocu  
            ,       @nCorrela  
            ,       @nRutcli  
            ,       @nCodigo  
            ,       @nMonto  
            ,       @fTipcambio  
            ,       @dFecvctop  
            ,       @cUsuario  
            ,       @nRut_emisor  
            ,       @nMonedaEmision  
            ,       @dFecvctoInst  
            ,       @nInCodigo  
            ,       @cSeriado  
            ,       @nMonedaOp  
            ,       @cTipo_Riesgo  
            ,       @nCodigo_pais  
            ,       @cPagoCheque  
            ,       @nRutCheque  
            ,       @dFecvctoCehque  
            ,       @nFactorVenta  
            ,       @formapago  
            ,       @nTir  
            ,       @nTasaPact  
            ,       @cInstser  
  
   IF @@ERROR <> 0   
   BEGIN  
      SET @iEstado = -1  
      RETURN  
   END  
  
   EXECUTE baclineas..Sp_Lineas_Chequear        @cSistema, @cProducto, @nNumoper, ' ', ' ', ' '  
  
   IF @@ERROR <> 0   
   BEGIN  
      SET @iEstado = -2  
      RETURN  
   END  
  
   /*  
   **************************************************************  
   */  
  
   DECLARE   @A01_nnumoper                 NUMERIC(10,0)  
   ,         @A01_nrutcart               NUMERIC(09,0)  
   ,         @A01_ntipcart               NUMERIC(05,0)  
   ,         @A01_nnumdocu               NUMERIC(10,0)  
   ,         @A01_@ncorrela               NUMERIC(03,0)  
   ,         @A01_nnominal               NUMERIC(19,4)  
   ,         @A01_ntir                   NUMERIC(19,4)  
   ,         @A01_npvp                   NUMERIC(19,2)  
   ,         @A01_nvpar                  NUMERIC(19,8)  
   ,         @A01_nvptirv                FLOAT  
   ,         @A01_nnumucup               NUMERIC(03,0)  
   ,         @A01_nrutcli                NUMERIC(09,0)  
   ,         @A01_ncodcli                NUMERIC(09,0)  
   ,         @A01_cfecpro                DATETIME  
   ,         @A01_ntasest                NUMERIC(09,4)  
   ,         @A01_nmonemi                NUMERIC(03,0)  
   ,         @A01_nrutemi                NUMERIC(09,0)  
   ,         @A01_ntasemi                NUMERIC(09,4)  
   ,         @A01_nbasemi                NUMERIC(03,0)  
   ,         @A01_ctipcust               CHAR(01)  
   ,         @A01_nforpagi               NUMERIC(05,0)  
   ,         @A01_cretiro                CHAR(01)  
   ,         @A01_cusuario               CHAR(12)  
   ,         @A01_cterminal              CHAR(12)  
   ,         @A01_cmascara               CHAR(12)  
   ,         @A01_cinstser               CHAR(12)  
   ,         @A01_cgenemi               CHAR(10)  
   ,         @A01_cnemomon               CHAR(05)  
   ,         @A01_cfecemi               DATETIME  
   ,         @A01_cfecven               DATETIME  
   ,         @A01_ncodigo               NUMERIC(05,0)  
   ,         @A01_ncorrvent                INTEGER  
   ,         @A01_clave_dcv                CHAR(10)  
   ,         @A01_codigo_carterasuper      CHAR(01)  
   ,         @A01_tipo_cartera_financiera  CHAR(05)		-->	CAMBIO LARGO DE 1 A 5 CARACTERES
   ,         @A01_mercado               CHAR(01)  
   ,         @A01_sucursal               VARCHAR(05)  
   ,         @A01_id_sIStema               CHAR(03)  
   ,         @A01_fecha_pagomañana         DATETIME  
   ,         @A01_laminas               CHAR(01)  
   ,         @A01_tipo_inversion           CHAR(01)  
   ,         @A01_observ                CHAR(70)  
  
   SELECT    @A01_nnumoper                 = monumoper  
   ,         @A01_nrutcart               = morutcart  
   ,         @A01_ntipcart               = motipcart  
   ,         @A01_nnumdocu               = monumdocu   
   ,         @A01_@ncorrela               = mocorrela   
   ,         @A01_nnominal               = monominal   
   ,         @A01_ntir                   = motir   
   ,         @A01_npvp                   = mopvp   
   ,         @A01_nvpar                  = movpar   
   ,         @A01_nvptirv                = movalven -- movpresen   
   ,         @A01_nnumucup               = monumucup   
   ,         @A01_nrutcli                = morutcli   
   ,         @A01_ncodcli                = mocodcli   
   ,         @A01_cfecpro              = mofecpro   
   ,         @A01_ntasest              = motasest   
   ,         @A01_nmonemi                = momonemi   
   ,         @A01_nrutemi                = morutemi   
   ,         @A01_ntasemi                = motasemi   
   ,         @A01_nbasemi                = mobasemi   
   ,         @A01_ctipcust               = modcv   
   ,         @A01_nforpagi               = moforpagi   
   ,         @A01_cretiro                = motipret   
   ,         @A01_cusuario               = mousuario   
   ,         @A01_cterminal              = moterminal   
   ,         @A01_cmascara               = momascara   
   ,         @A01_cinstser               = moinstser   
   ,         @A01_cgenemi               = emgeneric   
   ,         @A01_cnemomon               = mnnemo   
   ,         @A01_cfecemi               = mofecemi   
   ,         @A01_cfecven               = mofecven   
   ,         @A01_ncodigo               = mocodigo   
   ,         @A01_ncorrvent                = mocorvent   
   ,         @A01_clave_dcv                = modcv   
   ,         @A01_codigo_carterasuper      = codigo_carterasuper   
   ,         @A01_tipo_cartera_financiera  = Tipo_Cartera_Financiera   
   ,         @A01_mercado               = Mercado   
   ,         @A01_sucursal               = Sucursal   
   ,         @A01_id_sIStema               = Id_Sistema   
   ,         @A01_fecha_pagomañana         = Fecha_PagoMañana   
   ,         @A01_laminas               = Laminas   
   ,         @A01_tipo_inversion           = Tipo_Inversion   
   ,         @A01_observ                = moobserv  
   ,         @moid_libro                   = moid_libro   
   FROM   MDMOPM    LEFT JOIN bacparamsuda..EMISOR ON morutemi = emrut  
                    LEFT JOIN bacparamsuda..MONEDA ON momonemi = mncodmon  
   ,      MDAC  
   WHERE  mofecpro   = acfecproc  
   AND    SorteoLCHR = 'S'  
   AND    morutcart  = @nrutcart   --   dirutcart  
   AND    monumdocu  = @nnumdocu   --   dinumdocu  
   AND    mocorrela  = @ncorrela   --   dicorrela  
  
  
   EXECUTE   Sp_Grabarvp  
             @A01_nnumoper  
   ,         @A01_nrutcart  
   ,         @A01_ntipcart  
   ,         @A01_nnumdocu  
   ,         @A01_@ncorrela  
   ,         @A01_nnominal  
   ,         @A01_ntir  
   ,         @A01_npvp  
   ,         @A01_nvpar  
   ,         @A01_nvptirv  
   ,         @A01_nnumucup  
   ,         @A01_nrutcli  
   ,         @A01_ncodcli  
   ,         @A01_cfecpro  
   ,         @A01_ntasest  
   ,         @A01_nmonemi  
   ,         @A01_nrutemi  
   ,         @A01_ntasemi  
   ,         @A01_nbasemi  
   ,         @A01_ctipcust  
   ,         @A01_nforpagi  
   ,         @A01_cretiro  
   ,         @A01_cusuario  
   ,         @A01_cterminal  
   ,         @A01_cmascara  
   ,         @A01_cinstser  
   ,         @A01_cgenemi  
   ,         @A01_cnemomon  
   ,         @A01_cfecemi  
   ,         @A01_cfecven  
   ,         @A01_ncodigo  
   ,         @A01_ncorrvent  
   ,         @A01_clave_dcv  
   ,         @A01_codigo_carterasuper  
   ,         @A01_tipo_cartera_financiera  
   ,         @A01_mercado  
   ,         @A01_sucursal  
   ,         @A01_id_sIStema  
   ,         @A01_fecha_pagomañana  
   ,         @A01_laminas  
   ,         @A01_tipo_inversion  
   ,         @A01_observ  
   ,         'S'  
   ,         @moid_libro  
  
   IF @@ERROR <> 0   
   BEGIN  
      SET @iEstado = -3  
      RETURN  
   END  
  
   /*  
   **************************************************************  
   */  
  
  
   EXECUTE baclineas..Sp_Lineas_GrbOperacion    @cSistema, @cProducto, @nNumoper, @nNumoper, ' ', ' ', ' '  
   IF @@ERROR <> 0   
   BEGIN  
      SET @iEstado = -4  
      RETURN  
   END   
  
   EXECUTE baclineas..Sp_Lineas_GrabarError     @cSistema, @nNumoper  
   IF @@ERROR <> 0   
   BEGIN  
      SET @iEstado = -5  
      RETURN  
   END   
  
   EXECUTE baclineas..Sp_Limites_ChequearError  @cSistema, @nNumoper  
   IF @@ERROR <> 0   
   BEGIN  
      SET @iEstado = -6  
      RETURN  
   END   
  
   SET @iEstado = 0  
  
END  
GO
