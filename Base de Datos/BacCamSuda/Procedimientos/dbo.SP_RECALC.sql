USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RECALC]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_RECALC]
                (
                 @codmon  CHAR(3) ,
                 @mercado CHAR(4) ,
                 @tipope  CHAR(1) ,
                 @ticam   FLOAT   ,
                 @ussme   FLOAT   ,
                 @moterm  CHAR(12)
                )
AS
BEGIN
   SET NOCOUNT ON
   ----<< Para recalcular posicion
   DECLARE @xpreini     NUMERIC(10,4) --ACPREINI
   DECLARE @xposinic    NUMERIC(15,2) --ACPOSINI
   DECLARE @xposic      NUMERIC(15,2) --ACPOSIC
   DECLARE @xpmeco      NUMERIC(10,4) --ACPMECO
   DECLARE @xpmeve      NUMERIC(10,4) --ACPMEVE
   DECLARE @xtotco      NUMERIC(15,2) --ACTOTCO
   DECLARE @xtotve      NUMERIC(15,2) --actotve
   DECLARE @xtotcop     NUMERIC(15,2) --AC_TOTCOP
   DECLARE @xtotvep     NUMERIC(15,2) --AC_TOTVEP
   DECLARE @xpmecore    NUMERIC(19,4) --AC_PMECORE
   DECLARE @xpmevere    NUMERIC(19,4) --AC_PMEVERE
   DECLARE @xtotcore    NUMERIC(19,4) --AC_TOTCORE
   DECLARE @xtotvere    NUMERIC(19,4) --AC_TOTVERE
   DECLARE @xtotcopre   NUMERIC(19,4) --ACTOTCOPRE
   DECLARE @xtotvepre   NUMERIC(19,4) --ACTOTVEPRE
   DECLARE @xutili      NUMERIC(15,2) --ACUTILI
   DECLARE @xprecie     NUMERIC(10,4) --ACPRECIE
   DECLARE @xPrHeIni    NUMERIC(15,4) --ACHEDGEPRECIOINICIAL
   DECLARE @xPoHeFui    NUMERIC(15,4) --ACHEDGEINICIALFUTURO
   DECLARE @xPoHeSpi    NUMERIC(19,4) --ACHEDGEINICIALSPOT
   DECLARE @xPoHeFut    NUMERIC(19,4) --ACHEDGEACTUALFUTURO
   DECLARE @xPoHeSpt    NUMERIC(19,4) --ACHEDGEACTUALSPOT
   DECLARE @xuhedge     NUMERIC(19,2) --ACHEDGEUTILIDAD
   DECLARE @xtotcocp    NUMERIC(19,4) --CP_TOTCO
   DECLARE @xtotvecp    NUMERIC(19,4) --CP_TOTVE
   DECLARE @xtotcopcp   NUMERIC(19,2) --CP_TOTCOP
   DECLARE @xtotvepcp   NUMERIC(19,2) --CP_TOTVEP
   DECLARE @xutilicp    NUMERIC(19,2)  --CP_UTILI
   DECLARE @xpmecocp    NUMERIC(15,4) --CP_PMECO
   DECLARE @xpmevecp    NUMERIC(15,4) --CP_PMEVE
   DECLARE @xpmecocpci  NUMERIC(15,4) --CP_PMECOCI
   DECLARE @xpmevecpci  NUMERIC(15,4) --CP_PMEVECI
   DECLARE @xuticocp    NUMERIC(15,2) --CP_UTICO
   DECLARE @xutivecp    NUMERIC(15,2) --CP_UTIVE 
   DECLARE @xpohedge    NUMERIC(19,2)
   DECLARE @xPosini     NUMERIC(15,2) 

   DECLARE @xAcumDia    NUMERIC(19,4) --ACACUMDIA
   DECLARE @xAcumMes    NUMERIC(19,4) --ACACUMMES
   DECLARE @xFecAnt	CHAR(08)
   DECLARE @xFecHoy	CHAR(08)
   DECLARE @xAcumAnt    NUMERIC(19,4)
   DECLARE @xFicAcumDia NUMERIC(19,4) --ACTRADINGFICTICIO
   DECLARE @xAcTotCoSin NUMERIC(15,2) --ACTOTCOSIN
   DECLARE @xAcTotVeSin NUMERIC(15,2) --ACTOTVESIN
   DECLARE @xAcPesCoSin NUMERIC(15,2) --ACPESCOSIN
   DECLARE @xAcPesVeSin NUMERIC(15,2) --ACPESVESIN
   DECLARE @xtotcopo    NUMERIC(15,2) --ACTOTCOPO
   DECLARE @xtotvepo    NUMERIC(15,2) --ACTOTVEPO



   SELECT @xpmeco     = 0
   SELECT @xpmeve     = 0
   SELECT @xtotco     = 0
   SELECT @xtotve     = 0
   SELECT @xtotcop    = 0
   SELECT @xtotvep    = 0
   SELECT @xpmecore   = 0
   SELECT @xpmevere   = 0
   SELECT @xtotcore   = 0
   SELECT @xtotvere   = 0
   SELECT @xtotcopre  = 0
   SELECT @xtotvepre  = 0
   SELECT @xutili     = 0
   SELECT @xprecie    = 0
   SELECT @xuhedge    = 0
   SELECT @xtotcocp   = 0
   SELECT @xtotvecp   = 0
   SELECT @xtotcopcp  = 0
   SELECT @xtotvepcp  = 0
   SELECT @xutilicp   = 0
   SELECT @xpmecocp   = 0
   SELECT @xpmevecp   = 0
   SELECT @xpmecocpci = 0
   SELECT @xpmevecpci = 0
   SELECT @xuticocp   = 0
   SELECT @xutivecp   = 0
   SELECT @xpreini    = 0
   SELECT @xposini    = 0
   SELECT @xposic     = 0
   SELECT @xPrHeIni   = 0
   SELECT @xPoHeFui   = 0
   SELECT @xPoHeSpi   = 0
   SELECT @xPoHeFut   = 0
   SELECT @xPoHeSpt   = 0

   SELECT @xAcumDia     = 0
   SELECT @xAcumMes     = 0
   SELECT @xAcumAnt     = 0
   SELECT @xFicAcumDia  = 0
   SELECT @xAcTotCoSin  = 0
   SELECT @xAcTotVeSin  = 0
   SELECT @xAcPesCoSin  = 0
   SELECT @xAcPesVeSin  = 0
   SELECT @xtotcopo     = 0 
   SELECT @xtotvepo     = 0

   SELECT @xFecAnt  = CONVERT(CHAR(8),acfecant,112)  
         ,@xFecHoy  = CONVERT(CHAR(8),acfecpro,112)  
   FROM meac

   IF MONTH(@xFecHoy) = MONTH(@xFecAnt) BEGIN 
      SELECT  @xAcumAnt	= acacummes 
        FROM    meach 
       WHERE   acfecpro = @xFecAnt
   END

   ----<< 
--   IF @mercado <> 'ARBI' BEGIN
      EXECUTE Sp_Parametros_Actuales @mercado,
                                     @xpreini     OUTPUT, --ACPREINI
                                     @xposini     OUTPUT, --ACPOSINI
                                     @xposic      OUTPUT, --ACPOSIC
                                     @xpmeco      OUTPUT, --ACPMECO
                                     @xpmeve      OUTPUT, --ACPMEVE
                                     @xtotco      OUTPUT, --ACTOTCO
                                     @xtotve      OUTPUT, --actotve
                                     @xtotcop     OUTPUT, --AC_TOTCOP
                                     @xtotvep     OUTPUT, --AC_TOTVEP
                                     @xpmecore    OUTPUT, --AC_PMECORE
                                     @xpmevere    OUTPUT, --AC_PMEVERE
                                     @xtotcore   OUTPUT, --AC_TOTCORE
                                     @xtotvere    OUTPUT, --AC_TOTVERE
                                     @xtotcopre   OUTPUT, --ACTOTCOPRE
                                     @xtotvepre   OUTPUT, --ACTOTVEPRE
                                     @xutili      OUTPUT, --ACUTILI
                                     @xprecie     OUTPUT, --ACPRECIE
                                     @xPrHeIni    OUTPUT, --ACHEDGEPRECIOINICIAL
                                     @xPoHeFui    OUTPUT, --ACHEDGEINICIALFUTURO
                                     @xPoHeSpi    OUTPUT, --ACHEDGEINICIALSPOT
                                     @xPoHeFut    OUTPUT, --ACHEDGEACTUALFUTURO
                                     @xPoHeSpt    OUTPUT, --ACHEDGEACTUALSPOT
                                     @xuhedge     OUTPUT, --ACHEDGEUTILIDAD
                                     @xtotcocp    OUTPUT, --CP_TOTCO
                                     @xtotvecp    OUTPUT, --CP_TOTVE
                                     @xtotcopcp   OUTPUT, --CP_TOTCOP
                                     @xtotvepcp   OUTPUT, --CP_TOTVEP
                                     @xutilicp    OUTPUT, --CP_UTILI
                                     @xpmecocp    OUTPUT, --CP_PMECO
                                     @xpmevecp    OUTPUT, --CP_PMEVE
                                     @xpmecocpci  OUTPUT, --CP_PMECOCI
                                     @xpmevecpci  OUTPUT, --CP_PMEVECI
                                     @xuticocp    OUTPUT, --CP_UTICO
                                     @xutivecp    OUTPUT,  --CP_UTIVE
                                     @xAcumDia    OUTPUT,
				     @xAcumMes    OUTPUT,
				     @xFicAcumDia OUTPUT,
				     @xAcTotCoSin OUTPUT,
				     @xAcTotVeSin OUTPUT,				
				     @xAcPesCoSin OUTPUT,
				     @xAcPesVeSin OUTPUT,
                                     @xtotcopo    OUTPUT, --ACTOTCOPO
                                     @xtotvepo    OUTPUT  --ACTOTVEPO

   

      SELECT @xpohedge = @xPoHeFut + @xPoHeSpt
      EXECUTE Sp_Func_MxRecalcPr @mercado,
                                 @tipope,
                                 @ticam,
                                 @ussme,
                                 @xPoHeFui,
                                 @xPoHeSpi,
                                 @moterm  , 
                                 @xtotco     OUTPUT,
                                 @xtotcop    OUTPUT,
                                 @xpmeco     OUTPUT,
                                 @xtotve     OUTPUT,
                                 @xtotvep    OUTPUT,
                                 @xpmeve     OUTPUT,
                                 @xtotcore   OUTPUT,
  @xtotcopre  OUTPUT,
                   @xpmecore   OUTPUT,
             @xpmevere   OUTPUT,
                                 @xposic     OUTPUT,
                                 @xpohedge   OUTPUT,
                                 @xpohefut   OUTPUT,
                                 @xpohespt   OUTPUT,
                                 @xtotvere   OUTPUT,
                                 @xtotvepre  OUTPUT,
                                 @xpreini    OUTPUT,
                                 @xPosini    OUTPUT,
                                 @xprecie    OUTPUT,
                                 @xutili     OUTPUT,
                                 @xprheini   OUTPUT,
                                 @xuhedge    OUTPUT,
                                 @xFicAcumDia OUTPUT	,
				 @xAcTotCoSin OUTPUT	,
				 @xAcTotVeSin OUTPUT	,
				 @xAcPesCoSin OUTPUT	,
				 @xAcPesVeSin OUTPUT    ,
                                 @xtotcopo    OUTPUT    ,
                                 @xtotvepo    OUTPUT     




      SELECT @xAcumDia     = @xutili + @xuhedge --+ @xFicAcumDia


      SELECT @xAcumMes     = @xAcumAnt + @xAcumDia


      EXECUTE sp_Func_GrabaParam2 @mercado,
                                  @xpreini,
                                  @xposinic,
                                  @xposic,
                                  @xpmeco,
                                  @xpmeve,
                                  @xtotco,
                                  @xtotve,
                                  @xtotcop,
                                  @xtotvep,
                                  @xpmecore,
                                  @xpmevere,
                                  @xtotcore,
                                  @xtotvere,
                                  @xtotcopre,
                                  @xtotvepre,
                                  @xutili,
                                  @xprecie,
                                  @xPoHeFui,
                                  @xPoHeSpi,
                                  @xPoHeFut,
                                  @xPoHeSpt,
                                  @xuhedge ,
                                  @xAcumDia     ,
				  @xAcumMes     ,
				  @xFicAcumDia	,
				  @xAcTotCoSin	,
				  @xAcTotVeSin	, 
				  @xAcPesCoSin 	,
				  @xAcPesVeSin  ,
                                  @xtotcopo     ,
                                  @xtotvepo    

END
GO
