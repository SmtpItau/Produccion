USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PARAMETROS_ACTUALES]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_PARAMETROS_ACTUALES]
                 (
                  @xMercado    CHAR(4),
                  @xpreini     NUMERIC(10,4)  OUTPUT,  --ACPREINI
                  @xposinic    NUMERIC(15,2)  OUTPUT,  --ACPOSINI
                  @xposic      NUMERIC(15,2)  OUTPUT,  --ACPOSIC
                  @xpmeco      NUMERIC(10,4)  OUTPUT,  --ACPMECO
                  @xpmeve      NUMERIC(10,4)  OUTPUT,  --ACPMEVE
                  @xtotco      NUMERIC(15,2)  OUTPUT,  --ACTOTCO
                  @xtotve      NUMERIC(15,2)  OUTPUT,  --actotve
                  @xtotcop     NUMERIC(15,2)  OUTPUT,  --AC_TOTCOP
                  @xtotvep     NUMERIC(15,2)  OUTPUT,  --AC_TOTVEP
                  @xpmecore    NUMERIC(19,4)  OUTPUT,  --AC_PMECORE
                  @xpmevere    NUMERIC(19,4)  OUTPUT,  --AC_PMEVERE
                  @xtotcore    NUMERIC(19,4)  OUTPUT,  --AC_TOTCORE
                  @xtotvere    NUMERIC(19,4)  OUTPUT,  --AC_TOTVERE
                  @xtotcopre   NUMERIC(19,4)  OUTPUT,  --ACTOTCOPRE
                  @xtotvepre   NUMERIC(19,4)  OUTPUT,  --ACTOTVEPRE
                  @xutili      NUMERIC(15,2)  OUTPUT,  --ACUTILI
                  @xprecie     NUMERIC(10,4)  OUTPUT,  --ACPRECIE
                  @xPrHeIni    NUMERIC(15,4)  OUTPUT,  --ACHEDGEPRECIOINICIAL
                  @xPoHeFui    NUMERIC(15,4)  OUTPUT,  --ACHEDGEINICIALFUTURO
                  @xPoHeSpi    NUMERIC(19,4)  OUTPUT,  --ACHEDGEINICIALSPOT
                  @xPoHeFut    NUMERIC(19,4)  OUTPUT,  --ACHEDGEACTUALFUTURO
                  @xPoHeSpt    NUMERIC(19,4)  OUTPUT,  --ACHEDGEACTUALSPOT
                  @xuhedge     NUMERIC(19,2)  OUTPUT,  --ACHEDGEUTILIDAD
                  @xtotcocp    NUMERIC(19,4)  OUTPUT,  --CP_TOTCO
                  @xtotvecp    NUMERIC(19,4)  OUTPUT,  --CP_TOTVE
                  @xtotcopcp   NUMERIC(19,2)  OUTPUT,  --CP_TOTCOP
                  @xtotvepcp   NUMERIC(19,2)  OUTPUT,  --CP_TOTVEP
                  @xutilicp    NUMERIC(19,2)  OUTPUT,  --CP_UTILI
                  @xpmecocp    NUMERIC(15,4)  OUTPUT,  --CP_PMECO
                  @xpmevecp    NUMERIC(15,4)  OUTPUT,  --CP_PMEVE
                  @xpmecocpci  NUMERIC(15,4)  OUTPUT,  --CP_PMECOCI
                  @xpmevecpci  NUMERIC(15,4)  OUTPUT,  --CP_PMEVECI
                  @xuticocp    NUMERIC(15,2)  OUTPUT,  --CP_UTICO
                  @xutivecp    NUMERIC(15,2)  OUTPUT,  --CP_UTIVE

                  @xAcumDia    NUMERIC(19,4)  OUTPUT,  --ACACTUALDIA
                  @xAcumMes    NUMERIC(19,4)  OUTPUT,  --ACACTUALMES
                  @xFicAcumDia NUMERIC(19,4)  OUTPUT,  --ACACTUALDIA
		  @xAcTotCoSin NUMERIC(15,2)  OUTPUT,  --ACTOTCOSIN
		  @xAcTotVeSin NUMERIC(15,2)  OUTPUT,  --ACTOTVESIN
		  @xAcPesCoSin NUMERIC(15,2)  OUTPUT,  --ACPESCOSIN
		  @xAcPesVeSin NUMERIC(15,2)  OUTPUT,  --ACPESVESIN
                  @xtotcopo    NUMERIC(15,2)  OUTPUT,  --ACTOTCOPO
                  @xtotvepo    NUMERIC(15,2)  OUTPUT   --ACTOTVEPO

                 )
AS
BEGIN
   SET NOCOUNT ON
   IF @xMercado = 'INFO' BEGIN
      SELECT      @xpreini   = 0,
                  @xposinic  = 0,
                  @xposic    = info_posic,
                  @xpmeco    = info_pmeco,
                  @xpmeve    = info_pmeve,
                  @xtotco    = info_totco,
                  @xtotve    = info_totve,
                  @xtotcop   = info_totcop,
                  @xtotvep   = info_totvep,
                  @xpmecore  = 0,
                  @xpmevere  = 0,
                  @xtotcore  = 0,
                  @xtotvere  = 0,
                  @xtotcopre = 0,
                  @xtotvepre = 0,
                  @xutili    = info_utili,
                  @xprecie   = info_pmerc,
                  @xPrHeIni  = 0,
                  @xPoHeFui  = 0,
                  @xPoHeSpi  = 0,
                  @xPoHeFut  = 0,
                  @xPoHeSpt  = 0,
                  @xuhedge   = 0,

		  @xAcumDia  = 0,
                  @xAcumMes  = 0,
		  @xFicAcumDia = 0,
		  @xAcTotCoSin = 0,
		  @xAcTotVeSin = 0,
		  @xAcPesCoSin = 0,
		  @xAcPesVeSin = 0,
                  @xtotcopo    = 0,
                  @xtotvepo    = 0
             FROM meac
   END ELSE IF @xMercado <> 'EMPR' BEGIN
      SELECT      @xpreini   = acpreini,
                  @xposinic  = acposini,
                  @xposic    = acposic,
                  @xpmeco    = acpmeco,
                  @xpmeve    = acpmeve,
                  @xtotco    = actotco,
                  @xtotve    = actotve,
                  @xtotcop   = ac_totcop,
                  @xtotvep   = ac_totvep,
                  @xpmecore  = ac_pmecore,
                  @xpmevere  = ac_pmevere,
                  @xtotcore  = ac_totcore,
                  @xtotvere  = ac_totvere,
                  @xtotcopre = actotcopre,
                  @xtotvepre = actotvepre,
                  @xutili    = acutili,
                  @xprecie   = acprecie,
                  @xPrHeIni  = achedgeprecioinicial,
                  @xPoHeFui  = achedgeinicialfuturo,
                  @xPoHeSpi  = achedgeinicialspot,
                  @xPoHeFut  = achedgeactualfuturo,
                  @xPoHeSpt  = achedgeactualspot,
                  @xuhedge   = achedgeutilidad,

		  @xAcumDia  = acacumdia,
                  @xAcumMes  = acacummes,
		  @xFicAcumDia = actradingficticio,
		  @xAcTotCoSin = actotcosin,
		  @xAcTotVeSin = actotvesin,
		  @xAcPesCoSin = acpescosin,
		  @xAcPesVeSin = acpesvesin,
                  @xtotcopo    = actotcopo ,
                  @xtotvepo    = actotvepo

             FROM meac
   END ELSE BEGIN    
      SELECT      @xpreini    = acpreini,
                  @xposinic   = acposini,
                  @xposic     = acposic,
                  @xpmeco     = acpmeco,
                  @xpmeve     = acpmeve,
                  @xtotco     = actotco,
                  @xtotve     = actotve,
                  @xtotcop    = ac_totcop,
                  @xtotvep    = ac_totvep,
                  @xpmecore   = ac_pmecore,
                  @xpmevere   = ac_pmevere,
                  @xtotcore   = ac_totcore,
                  @xtotvere   = ac_totvere,
                  @xtotcopre  = actotcopre,
                  @xtotvepre  = actotvepre,
                  @xutili     = acutili,
                  @xprecie    = acprecie,
                  @xPrHeIni   = achedgeprecioinicial,
                  @xPoHeFui   = achedgeinicialfuturo,
                  @xPoHeSpi   = achedgeinicialspot,
                  @xPoHeFut   = achedgeactualfuturo,
                  @xPoHeSpt   = achedgeactualspot,
                  @xuhedge    = achedgeutilidad,
                  @xtotcocp   = cp_totco,
                  @xtotvecp   = cp_totve,
                  @xtotcopcp  = cp_totcop,
                  @xtotvepcp  = cp_totvep,
                  @xutilicp   = cp_utili,
                  @xpmecocp   = cp_pmeco,
                  @xpmevecp   = cp_pmeve,
                  @xpmecocpci = cp_pmecoci,
                  @xpmevecpci = cp_pmeveci,
                  @xuticocp   = cp_utico,
                  @xutivecp   = cp_utive,

		  @xAcumDia   = acacumdia,
                  @xAcumMes   = acacummes,
		  @xFicAcumDia = actradingficticio,
		  @xAcTotCoSin = actotcosin,
		  @xAcTotVeSin = actotvesin,
		  @xAcPesCoSin = acpescosin,
		  @xAcPesVeSin = acpesvesin,
                  @xtotcopo    = actotcopo ,
                  @xtotvepo    = actotvepo

             FROM meac
   END
END



GO
