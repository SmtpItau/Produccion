USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Graba_Familia]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO




CREATE PROCEDURE [dbo].[Sp_Graba_Familia]
                                       (@xSerie			CHAR(12)	,
					@xGlosa			CHAR(40)	,
					@xCodigo		NUMERIC(3)	,
					@xProg			CHAR(8)		,
					@xRefNom		CHAR(1)		,
					@xRutemi		NUMERIC(9)	,
					@xMonemi		NUMERIC(3)	,
					@xBasemi		NUMERIC(3)	,
					@xTasaEst		NUMERIC(3)	,
					@xTipo			CHAR(3)		,
					@xMdSe			CHAR(1)		,
					@xMdPr			CHAR(1)		,
					@xMdTd			CHAR(1)		,
					@XTipoFec		NUMERIC(1)	,
					@xEmision		CHAR(3)		,
					@xEleg			CHAR(1)		,
					@xContab		CHAR(1)		,
					@xTotalEmitido  	FLOAT           ,
--					@xTotalEmitido  	VARCHAR         ,
					@xSecurityType  	CHAR(2)         ,
					@xintiporig     	CHAR(3)  	,
					@xcodigo_inversion	CHAR(05)	,
					@xcodigo_producto	CHAR(03)	,
					@xTipIrfEsp 		NUMERIC(2)	,
					@Disponible_FLI		CHAR(1)
) 
AS
BEGIN

      SET NOCOUNT ON
      SET DATEFORMAT dmy


  IF EXISTS(SELECT 1 FROM INSTRUMENTO WHERE incodigo = @xCodigo and inserie <> @xserie)
  BEGIN
		SELECT "NO"
   		RETURN
  END

  IF EXISTS(SELECT 1 FROM INSTRUMENTO WHERE TipIrfEsp 	= 	@xTipIrfEsp 
					and @xTipIrfEsp <> 	0 
					and incodigo 	<> 	@xCodigo)
  BEGIN
		SELECT "CR"
   		RETURN
  END



  IF EXISTS(SELECT 1 FROM INSTRUMENTO WHERE inserie = @xSerie)
                      UPDATE instrumento SET	
				inglosa		=	@xGlosa		,
				incodigo	=	@xCodigo	,
				inprog		=	@xProg		,
				inrefnomi	=	@xRefNom	,
				inrutemi	= 	@xRutemi	,
				inmonemi	=	@xMonemi	,
				inbasemi	=	@xBasemi	,
				intasest	=	@xTasaEst	,
				intipo		=	@xTipo		,
				inmdse		=	@xMdSe		,
				inmdpr		=	@xMdPr		,
				inmdtd		=	@xMdTd		,
				intipfec	=	@xTipoFec	,
				inemision	=	@xEmision	,
				ineleg		=	@xEleg		,
				incontab	=	@xContab        ,
				intotalemitido  =       @xTotalEmitido  ,
				insecuritytype  =       @xSecurityType  ,
				intiporig       =       @xintiporig	,
				codigo_inversion =	@xcodigo_inversion,
				codigo_producto =	@xcodigo_producto,
				TipIrfEsp	=	@xTipIrfEsp 	,
				Disponible_FLI	=	@Disponible_FLI
 
 
				WHERE inserie	=	@xSerie

  ELSE
            INSERT INTO INSTRUMENTO	(	
				inserie						,
				inglosa						,
				incodigo					,
				inprog						,
				inrefnomi					,
				inrutemi					,
				inmonemi					,
				inbasemi					,
				intasest					,
				intipo						,
				inmdse						,
				inmdpr						,
				inmdtd						,
				intipfec					,
				inemision					,
				ineleg						,
				incontab					,
				intotalemitido                                  ,
				insecuritytype                                  ,
				intiporig					,
				codigo_inversion				,
				codigo_producto					,
				TipIrfEsp 					,
				Disponible_FLI	
			)
	VALUES		(	@xSerie						,
				@xGlosa						,
				@xCodigo					,
				@xProg						,
				@xRefNom					,
				@xRutemi					,
				@xMonemi					,
				@xBasemi					,
				@xTasaEst					,
				@xTipo						,
				@xMdSe						,
				@xMdPr						,
				@xMdTd						,
				@xTipoFec					,
				@xEmision					,
				@xEleg						,
				@xContab					,
				@xTotalEmitido                                  ,
				@xSecurityType                                 	,
				@xintiporig					,
				@xcodigo_inversion				,
				@xcodigo_producto				,
				@xTipIrfEsp 					,
				@Disponible_FLI
			)

IF @@error <> 0 BEGIN
  SET NOCOUNT OFF
  SELECT "NO"
  RETURN
END


SET NOCOUNT OFF
SELECT "SI"
END


GO
