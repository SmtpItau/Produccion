USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_FAMILIA]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[SP_GRABA_FAMILIA]
   (   @xSerie         CHAR(12)
   ,   @xGlosa         CHAR(40)
   ,   @xCodigo        NUMERIC(3)
   ,   @xProg          CHAR(8)
   ,   @xRefNom        CHAR(1)
   ,   @xRutemi        NUMERIC(9)
   ,   @xMonemi        NUMERIC(3)
   ,   @xBasemi        NUMERIC(3)
   ,   @xTasaEst       NUMERIC(3)
   ,   @xTipo          CHAR(3)
   ,   @xMdSe          CHAR(1)
   ,   @xMdPr          CHAR(1)
   ,   @xMdTd          CHAR(1)
   ,   @XTipoFec       NUMERIC(1)
   ,   @xEmision       CHAR(3)
   ,   @xEleg          CHAR(1)
   ,   @xContab        CHAR(1)
   ,   @xTotalEmitido  FLOAT
   ,   @xSecurityType  CHAR(2)
   ,   @xintiporig     CHAR(3)
   ,   @xInCodDcv      CHAR(2) = '00'
   ,   @xInCodSVS      		CHAR(12) = '00' -->REQ.6010
   ,   @xInUnidadTiempoTasaRef  CHAR(3)  = 'DIA'-->REQ.6010
   ,   @xInEstrucPlazoTasaRef   CHAR(12) = 'PT' -->REQ.6010
-----FUSIÓN-------
   ,   @xintabla68			NUMERIC(3)
   ,   @xincodrend			NUMERIC(3)
   ,   @xintabla69			VARCHAR(7)
   ,   @ClasiInstrumento	NUMERIC(1) =2
-----FUSIÓN-------
   ) 
AS
BEGIN

   SET NOCOUNT ON

   IF EXISTS(SELECT 1 FROM INSTRUMENTO WHERE inserie = @xSerie) 

      UPDATE INSTRUMENTO
      SET    inglosa        = @xGlosa
      ,      incodigo       = @xCodigo
      ,      inprog         = @xProg
      ,      inrefnomi      = @xRefNom
      ,      inrutemi       = @xRutemi
      ,      inmonemi       = @xMonemi
      ,      inbasemi       = @xBasemi
      ,      intasest       = @xTasaEst
      ,      intipo         = @xTipo
      ,      inmdse         = @xMdSe
      ,      inmdpr         = @xMdPr
      ,      inmdtd         = @xMdTd
      ,      intipfec       = @xTipoFec
      ,      inemision      = @xEmision
      ,      ineleg         = @xEleg
      ,      incontab       = @xContab
      ,      intotalemitido = @xTotalEmitido
      ,      insecuritytype = @xSecurityType
      ,      intiporig      = @xintiporig
      ,      InCodDcv       = @xInCodDcv
      ,	     InCodSVS	    		= @xInCodSVS 		  -->REQ.6010
      ,	     InUnidadTiempoTasaRef	= @xInUnidadTiempoTasaRef -->REQ.6010
      ,	     InEstrucPlazoTasaRef	= @xInEstrucPlazoTasaRef  -->REQ.6010
-----FUSIÓN-------
	  ,      intabla68       = @xintabla68
	  ,		 incodrend       = @xincodrend
	  ,		 intabla69       = @xintabla69
	  ,		 cod_clasificacion= @ClasiInstrumento
-----FUSIÓN-------
      WHERE  inserie        = @xSerie

   ELSE
      INSERT INTO INSTRUMENTO 
      (   inserie
      ,   inglosa
      ,   incodigo
      ,   inprog
      ,   inrefnomi
      ,   inrutemi
      ,   inmonemi
      ,   inbasemi
      ,   intasest
      ,   intipo
      ,   inmdse
      ,   inmdpr
      ,   inmdtd
      ,   intipfec
      ,   inemision
      ,   ineleg
      ,   incontab
      ,   intotalemitido
      ,   insecuritytype
      ,   intiporig
      ,   InCodDcv
      ,	  InCodSVS		 -->req.6010
      ,	  InUnidadTiempoTasaRef  -->req.6010
      ,   InEstrucPlazoTasaRef   -->req.6010
-----FUSIÓN-------
        , intabla68 
        , incodrend 
        , intabla69 
        , cod_clasificacion
-----FUSIÓN-------
      )
      VALUES
      (   @xSerie
      ,   @xGlosa
      ,   @xCodigo
      ,   @xProg
      ,   @xRefNom
      ,   @xRutemi
      ,   @xMonemi
      ,   @xBasemi
      ,   @xTasaEst
      ,   @xTipo
      ,   @xMdSe
      ,   @xMdPr
      ,   @xMdTd
      ,   @xTipoFec
      ,   @xEmision
      ,   @xEleg
      ,   @xContab
      ,   @xTotalEmitido
      ,   @xSecurityType
      ,   @xintiporig
      ,   @xInCodDcv
      ,   @xInCodSVS		 	-->req.6010
      ,	  @xInUnidadTiempoTasaRef  	-->req.6010
      ,   @xInEstrucPlazoTasaRef   	-->req.6010
-----FUSIÓN-------
		, @xintabla68
		, @xincodrend
		, @xintabla69 
		,@ClasiInstrumento
-----FUSIÓN-------
      )

   IF @@error <> 0 
   BEGIN
      SET NOCOUNT OFF
      SELECT 'NO'
      RETURN
   END

   SET NOCOUNT OFF
   SELECT 'SI'

END

GO
