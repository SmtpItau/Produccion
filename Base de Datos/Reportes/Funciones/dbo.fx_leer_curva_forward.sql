USE [Reportes]
GO
/****** Object:  UserDefinedFunction [dbo].[fx_leer_curva_forward]    Script Date: 16-05-2022 10:17:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE function [dbo].[fx_leer_curva_forward]
	(	@id_producto	varchar(5)
	,	@id_moneda		numeric(3)
	,	@Colateral		varchar(5)	
	)	returns			varchar(30)
as
begin

	declare @curva			varchar(30)
	set		@curva			= ''
	declare @CurvaLocal		Varchar(1)
    set     @CurvaLocal		= case when @Colateral = 'USD' then 'N' else 'S' end

	set		@id_producto	= case	when @id_producto = 13 then 3
									when @id_producto = 14 then 1
									else @id_producto 
								end

	if (@id_producto = 2)
	begin
/*		set		@curva			=	isnull((	select	top 1 codigocurva
		          								from	bacparamsuda.dbo.curvas_producto with(nolock)
												where	Modulo		= 'bfw' 
												and		Producto	= @id_producto
												and		moneda		= @id_moneda
											), '')*/
		set		@curva			=	isnull((	select	top 1 DF.codigocurva
		          								from	bacparamsuda.dbo.curvas_producto CP with(nolock)
												Left join BacParamSuda.dbo.DEFINICION_CURVAS DF with(nolock)  on DF.COdigoCurva = CP.CodigoCurva
												where	Modulo		= 'BFW' 
												and		Producto	= @id_producto
												and		moneda		= @id_moneda
												and CurvaLocal = @CurvaLocal   
											), '')
	end else
	begin
/*		set		@curva			=	isnull((	select	top 1 codigocurva
		          								from	bacparamsuda.dbo.curvas_producto with(nolock)
												where	Modulo		= 'bfw' 
												and		TipoTasa	= 'N'
												and		Producto	= @id_producto
												and		moneda		= @id_moneda
											), '')*/
		set		@curva			=	isnull((	select	top 1 DF.codigocurva
		          								from	bacparamsuda.dbo.curvas_producto CP with(nolock)
												Left join BacParamSuda.dbo.DEFINICION_CURVAS DF with(nolock)  on DF.COdigoCurva = CP.CodigoCurva											
												where	Modulo		= 'BFW' 
												and		TipoTasa	= 'N'
												and		Producto	= @id_producto
												and		moneda		= @id_moneda
												and		CurvaLocal	= @CurvaLocal   
											), '')
	end
	
	return @curva
	
end
GO
