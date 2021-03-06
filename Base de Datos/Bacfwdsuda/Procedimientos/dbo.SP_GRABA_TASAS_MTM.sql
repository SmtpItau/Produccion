USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_TASAS_MTM]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [dbo].[SP_GRABA_TASAS_MTM]( 		@Borrar    	CHAR(1)   ,
                                					@Moneda	NUMERIC(3),
                                					@Plazo_Fin 	NUMERIC(9),
                                					@Tasa		FLOAT     ,
		     					@fSpotCom  	FLOAT     ,
		     					@fSpotVen  	FLOAT     ,
							@fSpread	FLOAT )
AS
BEGIN

IF @Borrar = 'S'
   DELETE MF_TASAS_MTM WHERE Moneda = @Moneda

INSERT MF_TASAS_MTM(
			Moneda	,
			Plazo_Fin	,
			Tasa		,
			fSpotCom	,
			fSpotVen	,
			Spread 		)
VALUES( 	@Moneda	,
		@Plazo_Fin	,
		@Tasa		,
		@fSpotCom	,
		@fSpotVen	,
		@fSpread)

END


-- SP_HELPTEXT SP_BUSCA_TASAS_MTM


-- SP_BUSCA_TASAS_MTM 999

-- SP_GRABA_TASAS_MTM 'S', 998,  7, 0.5614, 0, 0.0336, 0.0336

-- SP_GRABA_TASAS_MTM 'N', 998, 1, 7, 0.5614, 0, 0.0336, 0.0336


GO
