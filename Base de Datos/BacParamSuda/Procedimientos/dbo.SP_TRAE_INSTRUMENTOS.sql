USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAE_INSTRUMENTOS]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[SP_TRAE_INSTRUMENTOS]
   (   @xSerie   CHAR(12)   )
AS
BEGIN
   SET NOCOUNT ON

   SELECT  /*001*/ inserie
   ,       /*002*/ inglosa
   ,       /*003*/ incodigo
   ,       /*004*/ inprog
   ,       /*005*/ inrefnomi
   ,       /*006*/ inrutemi
   ,       /*007*/ inmonemi
   ,       /*008*/ inbasemi
   ,       /*009*/ intasest
   ,       /*010*/ intipo
   ,       /*011*/ inmdse
   ,       /*012*/ inmdpr
   ,       /*013*/ inmdtd
   ,       /*014*/ intipfec
   ,       /*015*/ inemision
   ,       /*016*/ ineleg
   ,       /*017*/ incontab
   ,       /*018*/ insecuritytype
   ,       /*019*/ intotalemitido
   ,       /*020*/ insecuritytype2
   ,       /*021*/ intiporig
   ,       /*022*/ incoddcv
   ,       /*023*/ InCodSVS -->REQ.6010
   ,       /*024*/ InUnidadTiempoTasaRef -->REQ.6010
   ,       /*025*/ InEstrucPlazoTasaRef -->REQ.6010
   ,	   /*026*/ 'acRutBCCH' = (SELECT acRutBCCH FROM BacTraderSuda.dbo.MDAC)-->REQ.6010
   ,       /*027*/ intabla69 -->LDCOR035
   ,       /*028*/ cod_clasificacion -->LDCOR035
   ,       /*029*/ intabla68 -->LDCOR035
   ,       /*030*/ incodrend -->LDCOR035
   FROM    INSTRUMENTO
   WHERE   inserie  = @xserie

END

GO
