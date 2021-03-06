USE [BacBonosExtSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[Fx_SVC_FMU_DIF_D30]    Script Date: 11-05-2022 16:40:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create function [dbo].[Fx_SVC_FMU_DIF_D30] 
   (
			@fecini		DATETIME,
			@fecvto		DATETIME,			
			@Tipo       Varchar(2) = 'P' -- 'P' => Método Europeo 'PA' => Americano
			)
returns numeric(5)
AS BEGIN
    -- Ejemplo de uso:
    -- select BacBonosExtSuda.dbo.Fx_SVC_FMU_DIF_D30( '20160729', '20170731', 'P' )
	-- select BacBonosExtSuda.dbo.Fx_SVC_FMU_DIF_D30( '20160729', '20170731', 'PA' )
	-- select BacBonosExtSuda.dbo.Fx_SVC_FMU_DIF_D30( '20150827' , '20160229', 'PA' )
	-- select BacBonosExtSuda.dbo.Fx_SVC_FMU_DIF_D30( '20150827' , '20160229', 'P' )
	-- set nocount on; Select  BacBonosExtSuda.dbo.Fx_SVC_FMU_DIF_D30( '20150827', '20160229', 'PA' )
    declare @DIFDIAS	numeric(5) --INTEGER	, --OUTPUT,
	declare @Metodo  bit


    if @Tipo = 'PA'
	   Set @Metodo = 0
    else
	   Set @Metodo = 1
	
	Set @difdias = dbo.Fx_DATEDIFF360( @fecini, @fecvto, @Metodo )
    
	return @difdias

	
END
GO
