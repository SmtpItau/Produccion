USE [Reportes]
GO
/****** Object:  UserDefinedFunction [dbo].[Fx_Rate_Source]    Script Date: 16-05-2022 10:17:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[Fx_Rate_Source] --fx_homologa_nombreconcepto
	(	@operacion     int
	)	RETURNS varchar(max)	
AS 
BEGIN   
    
    DECLARE @rate_source varchar(max)

    SELECT @rate_source = (CASE WHEN (SELECT top 1 rm.Codigo 
							   FROM BacParamSuda.dbo.REFERENCIA_MERCADO rm 
							   WHERE rm.Codigo = (SELECT top 1  m.cacolmon1 
											  FROM Bacfwdsuda.dbo.mfca m 
											  WHERE m.canumoper = @operacion)) = 1 THEN 'BCCH'
						  WHEN (SELECT top 1 rm.Codigo 
							   FROM BacParamSuda.dbo.REFERENCIA_MERCADO rm 
							   WHERE rm.Codigo = (SELECT top 1  m.cacolmon1 
											  FROM Bacfwdsuda.dbo.mfca m 
											  WHERE m.canumoper = @operacion)) = 3 THEN 'REUTERS'
						  WHEN (SELECT top 1 rm.Codigo 
							   FROM BacParamSuda.dbo.REFERENCIA_MERCADO rm 
							   WHERE rm.Codigo = (SELECT top 1  m.cacolmon1 
											  FROM Bacfwdsuda.dbo.mfca m 
											  WHERE m.canumoper = @operacion)) = 7 THEN 'REUTERS'							  							  
						  WHEN (SELECT top 1 rm.Codigo 
							   FROM BacParamSuda.dbo.REFERENCIA_MERCADO rm 
							   WHERE rm.Codigo = (SELECT top 1  m.cacolmon1 
											  FROM Bacfwdsuda.dbo.mfca m 
											  WHERE m.canumoper = @operacion)) = 17 THEN 'BLOOMBERG' 
						  WHEN (SELECT top 1 rm.Codigo 
							   FROM BacParamSuda.dbo.REFERENCIA_MERCADO rm 
							   WHERE rm.Codigo = (SELECT top 1  m.cacolmon1 
											  FROM Bacfwdsuda.dbo.mfca m 
											  WHERE m.canumoper = @operacion)) = 18 THEN 'BLOOMBERG' 
						  WHEN (SELECT top 1 rm.Codigo 
							   FROM BacParamSuda.dbo.REFERENCIA_MERCADO rm 
							   WHERE rm.Codigo = (SELECT top 1  m.cacolmon1 
											  FROM Bacfwdsuda.dbo.mfca m 
											  WHERE m.canumoper = @operacion)) = 19 THEN 'BLOOMBERG' 
						  WHEN (SELECT top 1 rm.Codigo 
							   FROM BacParamSuda.dbo.REFERENCIA_MERCADO rm 
							   WHERE rm.Codigo = (SELECT top 1  m.cacolmon1 
											  FROM Bacfwdsuda.dbo.mfca m 
											  WHERE m.canumoper = @operacion)) = 20 THEN 'BLOOMBERG'
						  WHEN (SELECT top 1 rm.Codigo 
							   FROM BacParamSuda.dbo.REFERENCIA_MERCADO rm 
							   WHERE rm.Codigo = (SELECT top 1 m.cacolmon1 
											  FROM Bacfwdsuda.dbo.mfca m 
											  WHERE m.canumoper = @operacion)) = 21 THEN 'BLOOMBERG' 
						  WHEN (SELECT top 1 rm.Codigo 
							   FROM BacParamSuda.dbo.REFERENCIA_MERCADO rm 
							   WHERE rm.Codigo = (SELECT top 1  m.cacolmon1 
											  FROM Bacfwdsuda.dbo.mfca m 
											  WHERE m.canumoper = @operacion)) = 22 THEN 'BLOOMBERG' 							  							   							  							  							  							  
						  ELSE 'BCCH' END) 

    RETURN @rate_source

END  
GO
