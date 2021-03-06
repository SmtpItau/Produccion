USE [Reportes]
GO
/****** Object:  UserDefinedFunction [dbo].[fx_leer_curva_swap]    Script Date: 16-05-2022 10:17:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE function [dbo].[fx_leer_curva_swap]
	(	@id_producto	varchar(5)
	,	@id_moneda		numeric(3)
	,	@id_Indicador	numeric(3)
	,   @Colateral      varchar(5)
	)	returns			varchar(30)
as
begin

	declare @curva			varchar(30)
	set		@curva			= ''
	declare @CurvaLocal		Varchar(1)
    set     @CurvaLocal		= case when @Colateral = 'USD' then 'N' else 'S' end

	set		@id_producto	= case	when @id_producto = '1' then 'ST'
									when @id_producto = '2' then 'SM'
									when @id_producto = '3' then 'FR' 
									when @id_producto = '4' then 'SP'
									else @id_producto 
								end
/*	
	set		@curva			=	isnull((	select	top 1 codigocurva
	   		      			 	        	from	bacparamsuda.dbo.curvas_producto with(nolock)
											where	Modulo		= 'pcs' 
											and		Producto	= @id_producto
											and		moneda		= @id_moneda
											and		Indicador	= @id_Indicador
											and		TipoTasa	= case when @id_Indicador = 0 then 'F' else 'V' end
										), '')
*/										
	set		@curva			=	isnull((	select	top 1 DF.codigocurva
											from	bacparamsuda.dbo.curvas_producto cp with(nolock) 
											Left join BacParamSuda.dbo.DEFINICION_CURVAS DF with(nolock) on DF.COdigoCurva = CP.CodigoCurva
											where	Modulo		= 'PCS' 
											and		Producto	= @id_producto
											and		moneda		= @id_moneda
											and		Indicador	= @id_Indicador
											and		TipoTasa	= (case when @id_Indicador = 0 then 'F' else 'V' end) 
											and		CurvaLocal  = @CurvaLocal   
										), '')

	return @curva
	
end
GO
