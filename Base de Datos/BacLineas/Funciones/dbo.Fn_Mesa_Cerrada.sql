USE [BacLineas]
GO
/****** Object:  UserDefinedFunction [dbo].[Fn_Mesa_Cerrada]    Script Date: 13-05-2022 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[Fn_Mesa_Cerrada]( @Sistema varchar(5) ) returns varchar(1)
as
Begin
    declare @Respuesta varchar(1)
	Set @Respuesta = 'N'
	if exists( select (1) from bacparamsuda.dbo.SISTEMA_CNT where id_sistema = @Sistema )
	begin
		if @Sistema = 'BFW' 
			if ( select acsw_ciemefwd from bacfwdsuda.dbo.mfac ) = 1
				Set @Respuesta = 'S'
			else
				Set @Respuesta = 'N'
		if @Sistema = 'PCS' 
			if ( select CierreMesa from bacSwapSuda.dbo.swapgeneral ) = 1	
				Set @Respuesta = 'S'
			else
				Set @Respuesta = 'N'
		if @Sistema = 'SNY' 
			if ( select CierreMesa from BacSwapNY.dbo.swapgeneral ) = 1	
				Set @Respuesta = 'S'
			else
				Set @Respuesta = 'N'
		if @Sistema = 'OPT'
			if ( select acsw_ciemefwd from bacfwdsuda.dbo.mfac ) = 1
				Set @Respuesta = 'S'
			else
				Set @Respuesta = 'N'
		if @Sistema = 'BCC'
			if ( select max( substring( aclogdig, 6, 1 ) ) from bacCamSuda.dbo.meac ) = 1
				Set @Respuesta = 'S'
			else
				Set @Respuesta = 'N'

		if @Sistema = 'BNY'
			if ( select acsw_mesa from BacBonosExtNY.dbo.text_arc_ctl_dri ) = 1
				Set @Respuesta = 'S'
			else
				Set @Respuesta = 'N'	
				
		if @Sistema = 'BEX'
			if ( select acsw_mesa from BacBonosExtSuda.dbo.text_arc_ctl_dri ) = 1
				Set @Respuesta = 'S'
			else
				Set @Respuesta = 'N'	
				   
		if @Sistema = 'BTR'
			if ( select acsw_mesa from BacTraderSuda.dbo.MDAC ) = 1
				Set @Respuesta = 'S'
			else
				Set @Respuesta = 'N'
				
					
		if @Sistema not in ( 'BFW' , 'PCS' , 'OPT', 'BCC', 'BEX', 'BTR', 'BNY' , 'SNY'  )				
		   Set @Respuesta = 'S'
	   -- Si es sistema nuevo siempre
	   -- pensará que está con mesa cerrada
	   -- generará proeblamas altiro en 
	   -- pruebas de grabación.
	end
	else
	begin
	   -- Si es sistema nuevo siempre
	   -- pensará que está con mesa cerrada
	   -- generará proeblamas altiro en 
	   -- prubas de grabación.
	   select @Respuesta = 'S'
	end
	return( @respuesta )
End
GO
