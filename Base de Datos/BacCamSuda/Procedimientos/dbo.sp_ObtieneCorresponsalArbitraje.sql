USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[sp_ObtieneCorresponsalArbitraje]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[sp_ObtieneCorresponsalArbitraje]
		  ( @cod_corresponsal			int )
		  
as
begin

	select codigo_corres 
	  from bacParamSuda..Corresponsal 
	 where cod_corresponsal = @cod_corresponsal

end
GO
