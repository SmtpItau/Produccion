USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTROLA_HEDGE]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CONTROLA_HEDGE]
(
           @tipope    CHAR(1)         ,
           @ussme    NUMERIC(19,4)   ,
           @ticam    NUMERIC(15,04)  ,
           @tipmer    CHAR(4)  ,
           @ussme_old NUMERIC(19,4)   
    )
AS BEGIN
SET NOCOUNT ON
DECLARE @hedgeactual  NUMERIC(21,04) ,
 @minimohedge NUMERIC(21,04) ,
 @maximohedge NUMERIC(21,04) ,
 @minimo  INTEGER  ,
 @maximo  INTEGER  
DECLARE  @xpreini     Numeric(10,4) --ACPREINI
        ,@xposinic    Numeric(15,2) --ACPOSINI
        ,@xposic      Numeric(15,2) --ACPOSIC
        ,@xpmeco      Numeric(10,4) --ACPMECO
        ,@xpmeve      Numeric(10,4) --ACPMEVE
        ,@xtotco      Numeric(15,2) --ACTOTCO
        ,@xtotve      Numeric(15,2) --actotve
        ,@xtotcop     Numeric(15,2) --AC_TOTCOP
        ,@xtotvep     Numeric(15,2) --AC_TOTVEP
        ,@xpmecore    Numeric(19,4) --AC_PMECORE
        ,@xpmevere    Numeric(19,4) --AC_PMEVERE
        ,@xtotcore    Numeric(19,4) --AC_TOTCORE
        ,@xtotvere    Numeric(19,4) --AC_TOTVERE
        ,@xtotcopre   Numeric(19,4) --ACTOTCOPRE
        ,@xtotvepre   Numeric(19,4) --ACTOTVEPRE
        ,@xutili      Numeric(15,2) --ACUTILI
        ,@xprecie     Numeric(10,4) --ACPRECIE
        ,@xPrHeIni    Numeric(15,4) --ACHEDGEPRECIOINICIAL
        ,@xPoHeFui    Numeric(15,4) --ACHEDGEINICIALFUTURO
        ,@xPoHeSpi    Numeric(19,4) --ACHEDGEINICIALSPOT
        ,@xPoHeFut    Numeric(19,4) --ACHEDGEACTUALFUTURO
        ,@xPoHeSpt    Numeric(19,4) --ACHEDGEACTUALSPOT
        ,@xuhedge     Numeric(19,2) --ACHEDGEUTILIDAD
        ,@xtotcocp    Numeric(19,4) --CP_TOTCO
        ,@xtotvecp    Numeric(19,4) --CP_TOTVE
        ,@xtotcopcp   Numeric(19,2) --CP_TOTCOP
        ,@xtotvepcp   Numeric(19,2) --CP_TOTVEP
        ,@xutilicp    Numeric(19,2)  --CP_UTILI
        ,@xpmecocp    Numeric(15,4) --CP_PMECO
        ,@xpmevecp    Numeric(15,4) --CP_PMEVE
        ,@xpmecocpci  Numeric(15,4) --CP_PMECOCI
        ,@xpmevecpci  Numeric(15,4) --CP_PMEVECI
        ,@xuticocp    Numeric(15,2) --CP_UTICO
        ,@xutivecp    Numeric(15,2) --CP_UTIVE 
        ,@xpohedge    Numeric(19,2)
        ,@xPosini     Numeric(15,2) 
        ,@xAcumDia    Numeric(19,4) --ACACUMDIA
        ,@xAcumMes    Numeric(19,4) --ACACUMMES
        ,@xFicAcumDia Numeric(19,4) --ACFICTICIOTRADING
	,@xAcTotCoSin NUMERIC(15,2) --ACTOTCOSIN
	,@xAcTotVeSin NUMERIC(15,2) --ACTOTVESIN
	,@xAcPesCoSin NUMERIC(15,2) --ACPESCOSIN
	,@xAcPesVeSin NUMERIC(15,2) --ACPESVESIN
        ,@xtotcopo    Numeric(15,2) --ACTOTCOPO
        ,@xtotvepo    Numeric(15,2) --ACTOTVEPO

---- Lee MEAC
SELECT @xpohedge = 0
EXECUTE Sp_Parametros_Actuales  @tipmer
    ,@xpreini     out --ACPREINI
    ,@xposini     out --ACPOSINI
    ,@xposic      out --ACPOSIC
    ,@xpmeco      out --ACPMECO
    ,@xpmeve      out --ACPMEVE
    ,@xtotco      out --ACTOTCO
    ,@xtotve      out --actotve
    ,@xtotcop     out --AC_TOTCOP
    ,@xtotvep     out --AC_TOTVEP
    ,@xpmecore    out --AC_PMECORE
    ,@xpmevere    out --AC_PMEVERE
    ,@xtotcore    out --AC_TOTCORE
    ,@xtotvere    out --AC_TOTVERE
    ,@xtotcopre   out --ACTOTCOPRE
    ,@xtotvepre   out --ACTOTVEPRE
    ,@xutili      out --ACUTILI
    ,@xprecie     out --ACPRECIE
    ,@xPrHeIni    out --ACHEDGEPRECIOINICIAL
    ,@xPoHeFui    out --ACHEDGEINICIALFUTURO
    ,@xPoHeSpi    out --ACHEDGEINICIALSPOT
    ,@xPoHeFut    out --ACHEDGEACTUALFUTURO
    ,@xPoHeSpt    out --ACHEDGEACTUALSPOT
    ,@xuhedge     out --ACHEDGEUTILIDAD
    ,@xtotcocp    out --CP_TOTCO
    ,@xtotvecp    out --CP_TOTVE
    ,@xtotcopcp   out --CP_TOTCOP
    ,@xtotvepcp   out --CP_TOTVEP
    ,@xutilicp    out --CP_UTILI
    ,@xpmecocp    out --CP_PMECO
    ,@xpmevecp    out --CP_PMEVE
    ,@xpmecocpci  out --CP_PMECOCI
    ,@xpmevecpci  out --CP_PMEVECI
    ,@xuticocp    out --CP_UTICO
    ,@xutivecp    out --CP_UTIVE
    ,@xAcumDia    out --ACACUMDIA
    ,@xAcumMes    out --ACACUMMES
    ,@xFicAcumDia out
    ,@xAcTotCoSin out --ACTOTCOSIN
    ,@xAcTotVeSin out --ACTOTVESIN
    ,@xAcPesCoSin out --ACPESCOSIN
    ,@xAcPesVeSin out --ACPESVESIN
    ,@xtotcopo    out --ACTOTCOPO
    ,@xtotvepo    out --ACTOTVEPO



EXECUTE Sp_Func_MxRecalcPr   @tipmer
    ,@tipope
    ,@ticam
    ,@ussme
    ,@xPoHeFui
    ,@xPoHeSpi    
    ,''
    ,@xtotco     Out
    ,@xtotcop    Out
    ,@xpmeco     Out
    ,@xtotve     Out
    ,@xtotvep    Out
    ,@xpmeve     Out
    ,@xtotcore   Out
    ,@xtotcopre  Out
    ,@xpmecore   Out
    ,@xpmevere   Out
    ,@xposic     Out
    ,@xpohedge   Out
    ,@xpohefut   Out
    ,@xpohespt   Out
    ,@xtotvere   Out
    ,@xtotvepre  Out
    ,@xpreini    Out
    ,@xPosini    Out
    ,@xprecie   Out
    ,@xutili     out
    ,@xprheini   out
    ,@xuhedge    OUT
    ,@xFicAcumDia out
    ,@xAcTotCoSin out 
    ,@xAcTotVeSin out 
    ,@xAcPesCoSin out 
    ,@xAcPesVeSin out 
    ,@xtotcopo    out
    ,@xtotvepo    out


IF @tipope = 'V' 
   SELECT @ussme_old = @ussme_old * -1
SELECT @hedgeactual  = ( @xpohefut + @xpohespt ) - @ussme_old ,
 @minimohedge = acminintraday   ,
 @maximohedge = acmaxintraday     
FROM meac
-- Compras Controlan Mínimo
IF @hedgeactual < @minimohedge and @tipope = 'V'  
 SELECT @minimo = 1
-- Compras Controlan Mánimo
IF @hedgeactual > @maximohedge and @tipope = 'C'  
 SELECT @maximo = 2 
SELECT	ISNULL(@minimo,0)	AS	minimo
,		ISNULL(@maximo,0)	AS	maximo 
,		@minimohedge 		AS	minimohedge 
,		@maximohedge		AS	maximohedge
,		@hedgeactual		AS	hedgeactual
SET NOCOUNT OFF
END

GO
