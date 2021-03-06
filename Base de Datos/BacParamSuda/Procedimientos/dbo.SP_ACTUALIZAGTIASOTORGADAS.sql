USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTUALIZAGTIASOTORGADAS]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ACTUALIZAGTIASOTORGADAS]( @iFolio NUMERIC(10))
AS 
BEGIN

	DECLARE @FtotalPte	NUMERIC(21)
	,	@FtotalMer	NUMERIC(21)	;

	    SET @FtotalPte = 0
	    SET @FtotalMer = 0

	SELECT 	@FtotalPte	= SUM(ISNULL(ValorPresente,0))
	,	@FtotalMer	= SUM(ISNULL(ValorMercado,0))
	  FROM  Bacparamsuda..tbl_Garantias_Otorgadas_detalle

	IF @FtotalPte = 0 
	BEGIN 
		DELETE FROM Bacparamsuda..tbl_Garantias_Otorgadas
		WHERE Folio = @iFolio
	END

END
GO
