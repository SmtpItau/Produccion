USE [BacLineas]
GO
/****** Object:  UserDefinedFunction [dbo].[fxlineas_calcula_mitigacion]    Script Date: 13-05-2022 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fxlineas_calcula_mitigacion]( @numdocu NUMERIC(10), @correla NUMERIC(3) )
RETURNS FLOAT
AS 
BEGIN
	
	DECLARE @valor NUMERIC(18,4)
		SET @valor =0 ;
	
	SELECT  @valor = (C.civptirci* (ISNULL(tm.fPorcentaje,100)/100.0) ) 
	  FROM bactradersuda.dbo.mdci c 
	 INNER 
	  JOIN bacparamsuda.dbo.INSTRUMENTO i
	    ON i.incodigo = c.cicodigo
	  LEFT JOIN BacTraderSuda.dbo.tblMitigacion tm ON tm.codFamilia = i.inserie 
		AND datediff(day, cifecinip,cifecvenp) BETWEEN tm.iPlazoIni AND tm.iPlazoFin
--		AND (c.cifecvenp-c.cifecinip) BETWEEN tm.iPlazoIni AND tm.iPlazoFin
	 WHERE c.cinumdocu = @numdocu
	   AND c.cicorrela = @correla   
	  
	
	RETURN @valor 
END
GO
