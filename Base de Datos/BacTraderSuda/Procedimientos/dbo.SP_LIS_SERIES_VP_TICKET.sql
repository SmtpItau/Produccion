USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LIS_SERIES_VP_TICKET]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE 
[dbo].[SP_LIS_SERIES_VP_TICKET] 
	(	@Cadena_Familia		VARCHAR(500)
	,	@Cadena_Moneda		VARCHAR(500)
	,   	@iCodigoMesa		SMALLINT = 0
	,	@iCodigoCartera		SMALLINT = 0
	)
AS
BEGIN
	SET NOCOUNT ON
        DECLARE @dFechaPro   DATETIME
		
	SELECT DISTINCT Nemotecnico AS Nemotecnico ,
		codigoinstrumento 
	  FROM tbl_carticketrtafija 
	 INNER 
          JOIN VIEW_MONEDA  
	    ON mncodmon = moneda 
          JOIN VIEW_INSTRUMENTO
	    ON CodigoInstrumento =incodigo
	 WHERE valor_nominal > 0 
	   AND (CHARINDEX(RTRIM(LTRIM(mnnemo)) ,@Cadena_Moneda ) > 0 OR @Cadena_Moneda='' )
	   AND	CHARINDEX(RTRIM(LTRIM(inserie))  ,@Cadena_Familia) > 0
	   AND CodCarteraOrigen  = @iCodigoCartera
	   AND CodMesaOrigen     = @iCodigoMesa
      ORDER BY Nemotecnico


	SET NOCOUNT OFF

END


GO
