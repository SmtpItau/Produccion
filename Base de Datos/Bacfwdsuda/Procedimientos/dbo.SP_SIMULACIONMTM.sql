USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SIMULACIONMTM]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_SIMULACIONMTM] (@nValorUF NUMERIC(12,04),@nValorUF_Ant NUMERIC(12,04))
AS
BEGIN
SET NOCOUNT ON
DECLARE @nNumOper         NUMERIC(10,00)  , -- N£mero de Operaci¢n
   @nCarter         NUMERIC(02,00)  , -- Tipo de Cartera
  @nPlazoVto    NUMERIC(04,00) , -- Plazo al Vencimiento
  @moneda2     NUMERIC(3) ,
  @moneda1     NUMERIC(3) ,
   @nMtoMex         NUMERIC(21,04)  , -- Monto Origen
     @dFecVto         DATETIME        , -- Fecha Vencimiento
   @cTipOpe         CHAR(01)        , -- Tipo de Operaci¢n
  @nPreFut    FLOAT  , -- Precio Futuro
  @monto_moneda2    NUMERIC(21,4) ,
  @nMtoComp    NUMERIC(21,04)  , -- Monto a Compensar
        @dFecPro         DATETIME        ,
        @dFecProAnt        DATETIME        ,
  @dFecIni         DATETIME        , -- Fecha Inicio
  @nPlazoVtoanterior    NUMERIC(4,0) ,
  @cModal     CHAR ( 1 ) ,
  @nMarktomarket   NUMERIC(21,04)  , -- Monto del Mark To Market
  @nmonto_mtm_usd   NUMERIC(21,04) , -- MTM Moneda USD
  @nmonto_mtm_cnv   NUMERIC(21,04) , -- MTM Moneda Conversión
  @nmonto_var_usd   NUMERIC(21,04) , -- VAR Moneda USD
  @nmonto_var_cnv   NUMERIC(21,04) , -- VAR Moneda CNV
  @ntasausd_mtm    NUMERIC(10,04) , -- Tasa MTM USD
  @ntasacnv_mtm    NUMERIC(10,04) , -- Tasa MTM CNV
  @ntasausd_var    NUMERIC(10,04) , -- Tasa VAR USD
  @ntasacnv_var    NUMERIC(10,04) ,-- Tasa VAR CNV
  @nefecto_cambiario_mon1 NUMERIC(21,00) ,
  @nefecto_cambiario_mon2 NUMERIC(21,00) ,
  @ndevengo_tasa_mon1  NUMERIC(21,00) ,
  @ndevengo_tasa_mon2  NUMERIC(21,00) ,
  @ncambio_tasa_mon1  NUMERIC(21,00) ,
  @ncambio_tasa_mon2  NUMERIC(21,00) ,
  @nresiduo    NUMERIC(21,00) ,
  @nmonto_mtm_mon1_ayer  NUMERIC(21,00) ,
  @nmonto_mtm_mon2_ayer  NUMERIC(21,00) ,
        @cProducto              CHAR(60)        ,
        @cCodMon                CHAR(3)   ,
        @cCodCnv                CHAR(3)   ,
  @plazo_uso_moneda1  NUMERIC(05,00) ,
  @plazo_uso_moneda2  NUMERIC(05,00) ,
  @nmtoini1    NUMERIC(21,04)
 DECLARE @nregs         INT
 DECLARE @ncont         INT
SELECT  'nNumoper'     =@nNumoper      ,   
 'nCarter'    =@nCarter   ,
 'cProducto'    =@cProducto   ,
 'nPlazoVto'    =@nPlazoVto  ,
 'moneda2'    =@moneda2  ,
 'moneda1'    =@moneda1  ,
 'nValorUF'    =@nValorUF  ,
 'nValorUF_Ant'   =@nValorUF_Ant  ,
 'nMtoMex'     =@nMtoMex  ,
  'dFecVto'    =@dFecVto  ,
  'cTipOpe'    =@cTipOpe  ,
  'nPreFut'         =@nPreFut   ,
  'monto_moneda2'   =@monto_moneda2 ,
  'nMtoComp'    =@nMtoComp  ,
  'dfecpro'    =@dfecpro  ,
  'dfecproant'    =@dfecproant  ,
  'dfecini'    =@dfecini  ,
  'nPlazoVtoanterior'  =@nPlazoVtoanterior,
  'cModal'        =@cModal ,
  'nMarkToMarket'   =isnull(@nMarkToMarket,0),
  'nmonto_mtm_usd'  =isnull(@nmonto_mtm_usd,0),  --21
  'nmonto_mtm_cnv'  =isnull(@nmonto_mtm_cnv,0),
  'nmonto_var_usd'  =@nmonto_var_usd,
  'nmonto_var_cnv'  =@nmonto_var_cnv,
  'ntasausd_mtm'    =@ntasausd_mtm ,
  'ntasacnv_mtm'    =@ntasacnv_mtm ,
  'ntasausd_var'    =@ntasausd_var ,
  'ntasacnv_var'    =@ntasacnv_var ,
  'nefecto_cambiario_mon1'=@nefecto_cambiario_mon1,
  'nefecto_cambiario_mon2'=@nefecto_cambiario_mon2,
  'ndevengo_tasa_mon1'    =@ndevengo_tasa_mon1,
  'ndevengo_tasa_mon2'    =@ndevengo_tasa_mon2,
  'ncambio_tasa_mon1'     =@ncambio_tasa_mon1,
  'ncambio_tasa_mon2'     =@ncambio_tasa_mon2,
  'nresiduo'    =@nresiduo ,
  'nmonto_mtm_mon1_ayer'  =@nmonto_mtm_mon1_ayer,
  'nmonto_mtm_mon2_ayer'  =@nmonto_mtm_mon2_ayer,
  'cCodMon'               =@cCodMon ,
  'cCodCnv'               =@cCodCnv
INTO   #TmpMtm
FROM  mfac
DELETE  #TmpMtm
SELECT  'canumoper'      =canumoper , 
        'caplazovto'   =caplazo ,
  'cacodmon2'   =cacodmon2 ,
  'cacodmon1'   =cacodmon1 ,
  'camtomon1'   =camtomon1 ,
  'cafecvcto'   =cafecvcto ,
  'catipoper'   =catipoper ,
  'catipcam'   =catipcam ,
  'camtomon2'   =camtomon2 ,
  'camtocomp'   =0  ,
  'acfecproc'   =b.acfecproc ,
  'acfecante'   =b.acfecante ,
  'cafecha'   =cafecha ,
  'nPlazoVtoanterior'  = DATEDIFF( dd , b.acfecante ,cafecvcto ),
  'catipmoda'   =catipmoda     ,
        'cacodpos1'      =cacodpos1 ,
  'camtomon1ini'   = camtomon1ini  
INTO  #tmpOpeDia     
FROM  mfca ,mfac b
WHERE  CONVERT(CHAR(8),cafecha,112)=CONVERT(CHAR(8),b.acfecproc,112) AND (cacodpos1=1 OR cacodpos1=4 OR cacodpos1=5 OR cacodpos1=6 OR cacodpos1 = 7 )
SELECT @nregs = COUNT(*) FROM #tmpOpeDia        
SELECT @ncont = 1
WHILE @ncont <= @nregs   BEGIN  
     SET ROWCOUNT @ncont
SELECT  @nPlazoVto    =caplazovto ,
 @moneda2           =cacodmon2 ,
 @moneda1           =cacodmon1 ,
 @nMtoMex     =camtomon1 ,
 @dFecVto    =cafecvcto ,
 @cTipOpe    =catipoper ,
 @nPreFut           =catipcam ,
 @monto_moneda2    =camtomon2 ,
 @nMtoComp    =0  ,
 @dfecpro    =acfecproc ,
 @dfecproant    =acfecante ,
 @dfecini    =cafecha ,
 @nPlazoVtoanterior =nPlazoVtoanterior,
 @cModal            =catipmoda ,
        @nNumoper          =canumoper   ,
        @nCarter    =cacodpos1   ,
        @cproducto         =isnull((select descripcion from view_producto where codigo_producto=cacodpos1 and id_sistema='BFW'),''),
        @cCodMon           =(select mnnemo  from view_moneda where mncodmon=cacodmon1),
        @cCodCnv    =(select mnnemo  from view_moneda where mncodmon=cacodmon2),
 @nmtoini1    = camtomon1ini  
FROM  #tmpOpeDia 
   SET ROWCOUNT 0
   SELECT @ncont = @ncont + 1
EXECUTE Sp_MarkToMarket @nCarter      ,
   @nPlazoVto      ,
       @moneda2      ,
       @nValorUF       ,
       @nValorUF_Ant     ,
        @nMtoMex        ,
       @dFecVto      ,
       @cTipOpe       ,
       @nPreFut              ,
       @monto_moneda2     ,
       @nMtoComp      ,
       @dfecpro      ,
       @dfecproant      ,
       @dfecini      ,
       @nPlazoVtoanterior    ,
       @cModal          , 
       @nNumoper      ,
       @nmtoini1      ,
       @nMarkToMarket    OUTPUT ,
       @nmonto_mtm_usd   OUTPUT ,
       @nmonto_mtm_cnv   OUTPUT ,
       @nmonto_var_usd   OUTPUT ,
       @nmonto_var_cnv   OUTPUT ,
       @ntasausd_mtm    OUTPUT ,
       @ntasacnv_mtm    OUTPUT ,
      @ntasausd_var    OUTPUT ,
       @ntasacnv_var    OUTPUT ,
       @nefecto_cambiario_mon1 OUTPUT ,
       @nefecto_cambiario_mon2 OUTPUT ,
       @ndevengo_tasa_mon1  OUTPUT ,
       @ndevengo_tasa_mon2  OUTPUT ,
       @ncambio_tasa_mon1   OUTPUT ,
       @ncambio_tasa_mon2   OUTPUT ,
       @nresiduo     OUTPUT ,
       @nmonto_mtm_mon1_ayer   OUTPUT ,
       @nmonto_mtm_mon2_ayer   OUTPUT ,
       @plazo_uso_moneda1  OUTPUT ,
       @plazo_uso_moneda2  OUTPUT 
                
  INSERT INTO #tmpMtm
    SELECT           'nNumoper'    = @nNumoper     ,   
        'nCarter'   = @nCarter   ,
                        'cProducto'      = @cProducto    ,
       'nPlazoVto'   = @nPlazoVto  ,
       'moneda2'   = @moneda2 ,
       'moneda1'   = @moneda1  ,
       'nValorUF'   = @nValorUF  ,
       'nValorUF_Ant'   = @nValorUF_Ant ,
        'nMtoMex'    = @nMtoMex  ,
       'dFecVto'   = @dFecVto  ,
       'cTipOpe'   = @cTipOpe  ,
       'nPreFut'        = @nPreFut   ,
       'monto_moneda2'  = @monto_moneda2,
       'nMtoComp'   = @nMtoComp  ,
       'dfecpro'   = @dfecpro  ,
       'dfecproant'   = @dfecproant  ,
       'dfecini'   = @dfecini  ,
       'nPlazoVtoanterior' = @nPlazoVtoanterior,
       'cModal'       = @cModal ,
       'nMarkToMarket'  = isnull(@nMarkToMarket,0),
       'nmonto_mtm_usd' = isnull(@nmonto_mtm_usd,0),
       'nmonto_mtm_cnv' = isnull(@nmonto_mtm_cnv,0),
       'nmonto_var_usd' = @nmonto_var_usd,
       'nmonto_var_cnv' = @nmonto_var_cnv,
       'ntasausd_mtm'   = isnull(@ntasausd_mtm,0),
       'ntasacnv_mtm'   = isnull(@ntasacnv_mtm,0),
       'ntasausd_var'   = isnull(@ntasausd_var,0),
       'ntasacnv_var'   = isnull(@ntasacnv_var,0),
       'nefecto_cambiario_mon1'= isnull(@nefecto_cambiario_mon1,0),
       'nefecto_cambiario_mon2'= isnull(@nefecto_cambiario_mon2,0),
       'ndevengo_tasa_mon1'    = isnull(@ndevengo_tasa_mon1,0),
       'ndevengo_tasa_mon2'    = isnull(@ndevengo_tasa_mon2,0),
       'ncambio_tasa_mon1'     = isnull(@ncambio_tasa_mon1,0),
       'ncambio_tasa_mon2'     = isnull(@ncambio_tasa_mon2,0),
       'nresiduo'         = isnull(@nresiduo,0),
       'nmonto_mtm_mon1_ayer' = isnull(@nmonto_mtm_mon1_ayer,0),
       'nmonto_mtm_mon2_ayer' = isnull(@nmonto_mtm_mon2_ayer,0),
       'cCodMon'   = isnull(@cCodMon,0),
       'cCodCnv'   = isnull(@cCodCnv,0)
 
END
SELECT * FROM #tmpmtm ORDER BY nNumoper
DROP TABLE #tmpmtm
DROP TABLE #tmpOpeDia
SET NOCOUNT OFF
END
-- Sp_SimulacionMtm 15998.07,15995.94
--Sp_SimulacionMtm 15000,15500
-- select * from mfca ,mfac where cafecha=acfecproc

GO
