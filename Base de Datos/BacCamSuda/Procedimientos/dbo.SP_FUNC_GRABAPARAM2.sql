USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FUNC_GRABAPARAM2]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_FUNC_GRABAPARAM2]
                 (
                  @xMercado   CHAR(5),
                  @xpreini    NUMERIC(10,4),  --ACPREINI
                  @xposinic   NUMERIC(15,2),  --ACPOSINI
                  @xposic     NUMERIC(15,2),  --ACPOSIC
                  @xpmeco     NUMERIC(10,4),  --ACPMECO
                  @xpmeve     NUMERIC(10,4),  --ACPMEVE
                  @xtotco     NUMERIC(15,2),  --ACTOTCO
                  @xtotve     NUMERIC(15,2),  --actotve
                  @xtotcop    NUMERIC(15,2),  --AC_TOTCOP
                  @xtotvep    NUMERIC(15,2),  --AC_TOTVEP
                  @xpmecore   NUMERIC(19,4),  --AC_PMECORE
                  @xpmevere   NUMERIC(19,4),  --AC_PMEVERE
                  @xtotcore   NUMERIC(19,4),  --AC_TOTCORE
                  @xtotvere   NUMERIC(19,4),  --AC_TOTVERE
                  @xtotcopre  NUMERIC(19,4),  --ACTOTCOPRE
                  @xtotvepre  NUMERIC(19,4),  --ACTOTVEPRE
                  @xutili     NUMERIC(15,2),  --ACUTILI
                  @xprecie    NUMERIC(10,4),  --ACPRECIE
                  @xPoHeFui   NUMERIC(15,4),  --ACHEDGEPRECIOINICIAL
                  @xPoHeSpi   NUMERIC(19,4),  --ACHEDGEINICIALSPOT
                  @xPoHeFut   NUMERIC(19,4),  --ACHEDGEACTUALFUTURO
                  @xPoHeSpt   NUMERIC(19,4),  --ACHEDGEACTUALSPOT
                  @xuhedge    NUMERIC(19,2),  --ACHEDGEUTILIDAD

                  @xAcumDia   NUMERIC(19,2),  --ACACUMDIA
                  @xAcumMes   NUMERIC(19,2),  --ACACUMMES
		  @xFicAcumDia NUMERIC(19,4),
		  @xAcTotCoSin NUMERIC(15,2), --ACTOTCOSIN
		  @xAcTotVeSin NUMERIC(15,2), --ACTOTVESIN
		  @xAcPesCoSin NUMERIC(15,2), --ACPESCOSIN
		  @xAcPesVeSin NUMERIC(15,2), --ACPESVESIN
                  @xtotcopo    NUMERIC(15,2), --ACTOTCOPO
                  @xtotvepo    NUMERIC(15,2)  --ACTOTVEPO

                 )
AS
BEGIN
   SET NOCOUNT ON
   IF @xMercado = 'INFO' BEGIN
      UPDATE     meac 
             SET info_posic  = @xposic,
                 info_pmeco  = @xpmeco,
                 info_pmeve  = @xpmeve,
                 info_totco  = @xtotco,
                 info_totve  = @xtotve,
                 info_totcop = @xtotcop,
                 info_totvep = @xtotvep,
                 info_pmerc  = @xpreini,
                 acfindia    = 'F'
      UPDATE       meac
             SET   info_utili  = ( SELECT       SUM( ( CASE WHEN motipope = 'C' THEN (motctra - moticam) 
                                                                                ELSE (moticam - motctra) 
                                                       END) * momonmo )
                                          FROM  memo
                                          WHERE motipmer    = 'INFO')
   END ELSE BEGIN
      UPDATE     meac 
             SET acpreini            = @xpreini,
                 acposic             = @xposic,
                 acpmeco             = @xpmeco,
                 acpmeve             = @xpmeve,
                 actotco             = @xtotco,
                 actotve             = @xtotve,
                 ac_totcop           = @xtotcop,
                 ac_totvep           = @xtotvep,
                 ac_pmecore          = @xpmecore,
                 ac_pmevere          = @xpmevere,
                 ac_totcore          = @xtotcore,
                 ac_totvere          = @xtotvere,
                 actotcopre          = @xtotcopre,
                 actotvepre          = @xtotvepre,
                 acutili             = @xutili,
                 acprecie            = @xprecie, 
                 achedgeactualfuturo = @xPoHeFut,
                 achedgeactualspot   = @xPoHeSpt,
                 achedgeutilidad     = @xuhedge,
                 acfindia            = 'F'     ,

		 acacumdia	     = @xAcumDia,
		 acacummes	     = @xAcumMes,
		 AcTradingFicticio   = @xFicAcumDia, 
		 AcTotCoSin 	     = @xAcTotCoSin,
		 AcTotVeSin          = @xAcTotVeSin,
		 AcPesCoSin          = @xAcPesCoSin,
		 AcPesVeSin          = @xAcPesVeSin,
                 actotcopo           = @xtotcopo,
                 actotvepo           = @xtotvepo
  

 
  END
END

GO
