USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Grabar_TablaDesarrollo]    Script Date: 16-05-2022 11:18:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Sp_Grabar_TablaDesarrollo]
                                                      ( 	@tdmascara1  		CHAR      (12)		,
	                         				@tdcupon1    		NUMERIC (03,0)		, 
                                 				@tdfecven1   		DATETIME		,
                                			 	@tdinteres1		NUMERIC (19,10)		,
                                 				@tdamort1		NUMERIC (19,10)		,
                                 				@tdflujo1    		NUMERIC (19,10)		,
                                 				@tdsaldo1    		NUMERIC (19,10)		,
								@nSpread_tasa_variable	NUMERIC (08,04)		)
AS
BEGIN

     SET NOCOUNT ON
     SET DATEFORMAT dmy
                
     INSERT INTO TABLA_DESARROLLO   (   tdmascara,   tdcupon,   tdfecven,   tdinteres,   tdamort,   tdflujo,   tdsaldo, spread_tasa_variable )
                     VALUES ( @tdmascara1, @tdcupon1, @tdfecven1, @tdinteres1, @tdamort1, @tdflujo1, @tdsaldo1, @nSpread_tasa_variable )

IF @@error <> 0 BEGIN
  SET NOCOUNT OFF
  SELECT "NO"
  RETURN
END
SET NOCOUNT OFF
SELECT "SI"
END



GO
