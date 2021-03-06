USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LIS_FAMILIAS_VP_TICKET]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE 
[dbo].[SP_LIS_FAMILIAS_VP_TICKET]
	(   	@iCodigoMesa		SMALLINT = 0
	,	@iCodigoCartera		SMALLINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON	;
	SELECT DISTINCT inserie as Series
	  FROM tbl_carticketrtafija 
	 INNER 
          JOIN VIEW_INSTRUMENTO
	    ON CodigoInstrumento =incodigo
	 WHERE valor_nominal > 0 
	   AND CodCarteraOrigen  = @iCodigoCartera
	   AND CodMesaOrigen     = @iCodigoMesa
      ORDER BY Series
END

GO
