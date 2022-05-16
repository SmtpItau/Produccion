USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[sp_ObtieneComercioOMA]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[sp_ObtieneComercioOMA]
	      ( @codigoOMA	int )
as
begin


	if @codigoOMA <> 140
	   SELECT comercio  
		FROM  tbOmaDelSuda
	   WHERE codi_opera = @codigoOMA
	
	else 
	   select 10052
	   
   
end
GO
