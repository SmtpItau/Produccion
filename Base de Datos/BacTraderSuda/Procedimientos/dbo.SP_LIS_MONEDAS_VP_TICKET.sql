USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LIS_MONEDAS_VP_TICKET]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE 
[dbo].[SP_LIS_MONEDAS_VP_TICKET]
	(   	@iCodigoMesa		SMALLINT = 0
	,	@iCodigoCartera		SMALLINT = 0
	)
AS
BEGIN

	SET NOCOUNT ON	;

	SELECT DISTINCT mnnemo AS Monedas
	  FROM tbl_carticketrtafija 
	 INNER 
          JOIN VIEW_MONEDA  
	    ON mncodmon = moneda  
	 WHERE valor_nominal > 0 
	   AND CodCarteraOrigen  = @iCodigoCartera
	   AND CodMesaOrigen     = @iCodigoMesa
      ORDER BY Monedas;

END


GO
