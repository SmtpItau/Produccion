USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Trae_Precios_Divisas_Cmx]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[Sp_Trae_Precios_Divisas_Cmx]
	(	
		@FechaProceso	datetime		--> Fecha de Proceso
	)
as
begin

	/*
		Fecha de Creacion	:	Lunes 03 de Octubre del 2016
		Proposito			:	Lectura de precios de monedas desde 

		Version				:	Version creada para obtencion de precios para cmx
								Esta version, solo desplegara el precio, libre de Spread comerciales y de Trading
								en su primer retorno

		NOTA				:	Se desplegaran todos los campos originales, con los cuales se realizan los controles en el ingreso,
								sin embargo no son parte de la solicitud original y se describira su uso a continuacion

		Resultados			:	[Precio_cmx]		: Retono Solicitado para cmx ... solo el precio
	*/

	set nocount on

	select	Precio_cmx	= isnull((	
								select	top 1 
										Precio		= max( costo_venta  )
								from	BacCamSuda.dbo.COSTOS_COMEX with(nolock)
								where	Fecha		= @FechaProceso
								and		CodMoneda	= 13
								group
								by		Fecha
									,	CodMoneda
							), 0.0)

end
GO
