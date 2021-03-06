USE [Reportes]
GO
/****** Object:  UserDefinedFunction [dbo].[Fx_Tasas_Moneda]    Script Date: 16-05-2022 10:17:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[Fx_Tasas_Moneda] --fx_homologa_nombreconcepto
	(	@Cod_tasa			INT 
	,	@refercy_current	CHAR(3) 
	)	RETURNS varchar(max)	
AS 
BEGIN   

    DECLARE @indicedetasa_paso varchar(max)
    DECLARE @indicedetasa_final VARCHAR(max)
      
    IF(@Cod_tasa = 10 OR @Cod_tasa = 9 OR @Cod_tasa = 15 OR @Cod_tasa = 8)
	   BEGIN
		  SELECT @indicedetasa_paso = dbo.Fx_Convalida_Tipos(36,1,1,@Cod_tasa,1)
		  SET @indicedetasa_final = @indicedetasa_paso + ' - ' + @refercy_current
	   END
    ELSE 
	   BEGIN
		  SELECT @indicedetasa_paso = dbo.Fx_Convalida_Tipos(36,1,1,@Cod_tasa,1)
		  SET @indicedetasa_final = @indicedetasa_paso  	
	   END	   	
     
    RETURN @indicedetasa_final

END  
GO
